package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.ReserveDto;
import dto.RoomDto;

public class ReserveDao {
	
	Connection conn;
	PreparedStatement pstmt;
	
	public ReserveDao() throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
	    String db="jdbc:mysql://localhost:3306/pension";
	    conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void getCalendar(HttpServletRequest request)
	{
		// 1일의 요일, 총일수, 몇주를 구해서 request영역에 저장
		int y,m;

		if(request.getParameter("y")==null) // 처음 부를 땐 y값이 없으므로 null일수 있음
		{
			LocalDate today=LocalDate.now(); // 현재 날짜 정보를 가져온다
			y=today.getYear(); // 년도
			m=today.getMonthValue(); // 월 (getMonth는 Jan, Feb등 영어나옴)
		}
		else
		{
			y=Integer.parseInt(request.getParameter("y"));
			m=Integer.parseInt(request.getParameter("m"));
		}
		
		
		// 해당월의 1일에 대한 날짜객체를 생성
		LocalDate dday=LocalDate.of(y, m, 1);
		
		// 1일의 요일
		int yoil=dday.getDayOfWeek().getValue(); // 1~7까지 (7:일요일)
		if(yoil==7) // 일요일을 7이아닌 0으로 변경
			yoil=0;
		
		// 해당월의 총일수
		int chong=dday.lengthOfMonth(); // 총일수
		
		// 몇주인가
		int ju=(int) Math.ceil((yoil+chong)/7.0); // 올림하느라 Math.ceil 넣음
		
		// request영역으로 3개 값을 올려주기
		request.setAttribute("yoil", yoil);
		request.setAttribute("chong", chong);
		request.setAttribute("ju", ju);
		request.setAttribute("y", y);
		request.setAttribute("m", m);
	}
	
	public void getRoom(HttpServletRequest request) throws Exception
	{
		// 쿼리 작성
		String sql="select * from room order by price asc";
		
		// 심부름꾼 생성
		pstmt=conn.prepareStatement(sql);

		ArrayList<RoomDto> rlist=new ArrayList<RoomDto>();
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();
		while(rs.next())
		{
			RoomDto rdto=new RoomDto();
			rdto.setId(rs.getInt("id"));
			rdto.setBang(rs.getString("bang"));
			rdto.setPrice(rs.getInt("price"));
			
			rlist.add(rdto);
		}
		
		request.setAttribute("rlist", rlist);
	}
	
	public void reserve_next(HttpServletRequest request) throws Exception
	{
		// jsp에 보내줘야 될 내용 => 년,월,일,방의 정보
		int y=Integer.parseInt(request.getParameter("y"));
		int m=Integer.parseInt(request.getParameter("m"));
		int d=Integer.parseInt(request.getParameter("d"));
		String id=request.getParameter("id");
		
		// 체크인(입실일)
		String ymd=y+"-"+m+"-"+d;
		
		// 방의 정보
		String sql="select * from room where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		// dto에 담기
		RoomDto rdto=new RoomDto();
		rdto.setId(rs.getInt("id"));
		rdto.setBang(rs.getString("bang"));
		rdto.setMax(rs.getInt("max"));
		rdto.setMin(rs.getInt("min"));
		rdto.setPrice(rs.getInt("price"));
		rdto.setContent(rs.getString("content"));
		
		// request영역에 필요한 값을 담기
		request.setAttribute("ymd", ymd);
		request.setAttribute("rdto", rdto);		
	}
	
	public void reserve_ok(HttpServletRequest request, HttpSession session,
			HttpServletResponse response) throws Exception
	{
		// request
		String inday=request.getParameter("inday"); // 2022-07-05
		int suk=Integer.parseInt(request.getParameter("suk"));
		String bang_id=request.getParameter("bang_id");
		String total=request.getParameter("total");
		String inwon=request.getParameter("inwon");
		String charcoal=request.getParameter("charcoal");
		String bbq=request.getParameter("bbq");
		String userid=session.getAttribute("userid").toString();
		
		
		// inday를 이용해서 outday를 구한다..
		// LocalDate 변수=LocalDate.now() // 현재 시간 
		// LocalDate.of(int, int, int)// 입력되는 년,월,일로 날짜객체 생성
		// LocalDate.of 형식을 위해 inday를 정수로 변환시킨다..
		String[] imsi=inday.split("-");
		int y=Integer.parseInt(imsi[0]);
		int m=Integer.parseInt(imsi[1]);
		int d=Integer.parseInt(imsi[2]);
		
		// 체크인 날짜 객체 만들기
		LocalDate dday=LocalDate.of(y, m, d); // (dday는 체크인날짜)
		LocalDate outday=dday.plusDays(suk); // 체크인+숙박일 해서 체크아웃날짜 구하기
		
		// 쿼리 생성
		String sql="insert into reserve(inday,outday,userid,bang_id,inwon,charcoal,bbq,total,writeday)" ;
		sql+=" values(?,?,?,?,?,?,?,?,now())";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, inday);
		pstmt.setString(2, outday.toString());
		pstmt.setString(3, userid);
		pstmt.setString(4, bang_id);
		pstmt.setString(5, inwon);
		pstmt.setString(6, charcoal);
		pstmt.setString(7, bbq);
		pstmt.setString(8, total);
		
		// 쿼리 실행
		pstmt.executeUpdate();
		
		// close
		close();
		
		// 이동
		response.sendRedirect("reserve_view.jsp");	
	}
	
/*	최근 한개의 예약건만 보여줄 때 사용. 지금은 여러개 보이게 합칠거라 주석처리했음.
	public void reserve_view2(HttpSession session, HttpServletRequest request) throws Exception
	{
		// 쿼리생성
		String sql="select r2.*,r1.bang from room as r1,reserve as r2 where r2.userid=? ";
		sql+=" and r1.id=r2.bang_id order by id desc limit 1";
		
		// 심부름꾼 생성
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, session.getAttribute("userid").toString());
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		// rs-> Dto
		ReserveDto rdto=new ReserveDto();
		rdto.setId(rs.getInt("id"));
		rdto.setInday(rs.getString("inday"));
		rdto.setOutday(rs.getString("outday"));
		rdto.setBang_id(rs.getInt("bang_id"));
		rdto.setInwon(rs.getInt("inwon"));
		rdto.setCharcoal(rs.getInt("charcoal"));
		rdto.setBbq(rs.getInt("bbq"));
		rdto.setTotal(rs.getInt("total"));
		rdto.setWriteday(rs.getString("writeday"));
		
		// bang의 값을 전달하는 방법
		// 1. ReserveDto에 필드를 추가
		// 2. bang을 request영역에 추가
		request.setAttribute("rdto", rdto);
		request.setAttribute("bang", rs.getString("bang"));
	}
*/
	public void reserve_view(HttpSession session, HttpServletRequest request) throws Exception
	{
		String chuga="";
		if(request.getParameter("ck")==null) // 예약하기에서 reserve_view로 들어올때
			chuga=" limit 1";
		else if(!request.getParameter("ck").equals("1")) // 예약하기에서 예약후 예약취소후 들어올때
			chuga=" limit 1";
		
		// 쿼리생성
		String sql="select r2.*,r1.bang from room as r1,reserve as r2 where r2.userid=? ";
		sql+=" and r1.id=r2.bang_id order by inday desc "+chuga;
		
		// 심부름꾼 생성
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, session.getAttribute("userid").toString());
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();
		
		// rs -> dao
		ArrayList<ReserveDto> rlist=new ArrayList<ReserveDto>();
		while(rs.next())
		{		
			ReserveDto rdto=new ReserveDto();
			rdto.setId(rs.getInt("id"));
			rdto.setInday(rs.getString("inday"));
			rdto.setOutday(rs.getString("outday"));
			rdto.setBang_id(rs.getInt("bang_id"));
			rdto.setInwon(rs.getInt("inwon"));
			rdto.setCharcoal(rs.getInt("charcoal"));
			rdto.setBbq(rs.getInt("bbq"));
			rdto.setTotal(rs.getInt("total"));
			rdto.setWriteday(rs.getString("writeday"));
			rdto.setBang(rs.getString("bang"));
			rdto.setState(rs.getInt("state"));
			
			rlist.add(rdto);
		}
		request.setAttribute("rlist", rlist);
		request.setAttribute("ck", request.getParameter("ck"));
	}
	
	// 방이 비었느냐? 
	public void getEmpty(String dday, String bang_id, HttpServletRequest request) throws Exception
	{
		// 년월일과 bang의 id를 이용하여 예약 가능여부를 확인
		// 쿼리생성
		String sql="select count(*) as cnt from reserve ";
		sql+=" where inday <= ? and ? < outday and bang_id=?";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, dday);
		pstmt.setString(2, dday);
		pstmt.setString(3, bang_id);
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		request.setAttribute("cnt", rs.getString("cnt")); // 0(예약가능) 또는 1(예약불가) 값이 나옴.
	}
	
	public void getcheck(String y, String m, String d, HttpServletRequest request) throws Exception
	{
		int yy=Integer.parseInt(y);
		int mm=Integer.parseInt(m);
		int dd=Integer.parseInt(d);
		LocalDate today=LocalDate.now(); // 오늘 날짜
		LocalDate dday=LocalDate.of(yy, mm, dd);
		
		if(today.isBefore(dday)) // 오늘이 디데이보다 이전
		{
			request.setAttribute("tt", "1");
		}
		else if(today.isEqual(dday)) // 같은날
		{
			request.setAttribute("tt", "1");
		}
		else
		{
			request.setAttribute("tt", "0");
		}
	}
	
	// 몇박이 가능한지 체크하기
	public void getSuk(HttpServletRequest request) throws Exception
	{
		// request
		// reserve_next에 있는 ymd 값은 형식이 YYYY-MM-DD 이므로 변경필요.
		String ymd=request.getAttribute("ymd").toString();
		RoomDto rdto=(RoomDto)request.getAttribute("rdto"); // object인걸 roomDto로 변환
		// System.out.println(ymd);
		// System.out.println(rdto.getId());
		
		// ymd를 LocalDate로 변경
		String[] imsi=ymd.split("-"); // split은 무조건 자동 문자열 배열
		int y=Integer.parseInt(imsi[0]);
		int m=Integer.parseInt(imsi[1]);
		int d=Integer.parseInt(imsi[2]);	// 2022-07-28
		LocalDate dday=LocalDate.of(y, m, d);	// 내가 입실할 날짜의 객체가 생성
		
		int chk=0;
		for(int i=1;i<=5;i++) // 현재 5박이 최대이므로 5번 돌기
		{	
			chk++;
			
			LocalDate xday=dday.plusDays(i);	// 2022-07-29 plusDays해줬기 때문에 하루씩 뒤가 됌
			String sql="select * from reserve where inday<=? and ?<outday and bang_id=?";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, xday.toString());
			pstmt.setString(2, xday.toString());
			pstmt.setInt(3, rdto.getId());
			
			ResultSet rs=pstmt.executeQuery();
			
			if(rs.next()) // 만약 예약되어있다면 스탑
				break;
		}
		
		request.setAttribute("chk", chk);
		
	}
		
	// 관리자계정은 모든 예약건 다보이게
	public void reserve_admin(HttpServletRequest request, HttpSession session) throws Exception
	{
		// 쿼리생성
		String sql="select r2.*,r1.bang from room as r1, reserve as r2 where r1.id=r2.bang_id order by inday desc";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<ReserveDto> rlist=new ArrayList<ReserveDto>();
		while(rs.next())
		{		
			ReserveDto rdto=new ReserveDto();
			rdto.setId(rs.getInt("id"));
			rdto.setInday(rs.getString("inday"));
			rdto.setOutday(rs.getString("outday"));
			rdto.setBang_id(rs.getInt("bang_id"));
			rdto.setInwon(rs.getInt("inwon"));
			rdto.setCharcoal(rs.getInt("charcoal"));
			rdto.setBbq(rs.getInt("bbq"));
			rdto.setTotal(rs.getInt("total"));
			rdto.setWriteday(rs.getString("writeday"));
			rdto.setBang(rs.getString("bang"));
			rdto.setUserid(rs.getString("userid"));
			rdto.setState(rs.getInt("state"));
			rlist.add(rdto);
		}
		request.setAttribute("rlist", rlist);
	}
	
	public void getprev( HttpServletRequest request)
	{
		LocalDate today=LocalDate.now(); //오늘날짜
		int y,m;
		if(request.getParameter("y")==null) // reserve.jsp를 제일 처음 부를때는 null값임
			y=today.getYear();
		else
			y=Integer.parseInt(request.getParameter("y"));

		if(request.getParameter("m")==null)
			m=today.getMonthValue();
		else
			m=Integer.parseInt(request.getParameter("m"));

		LocalDate xday=LocalDate.of(today.getYear(), today.getMonthValue(), 1); // 오늘기준 1일의날짜
		LocalDate dday=LocalDate.of(y, m, 1); // 현재 달력기준 1일의 날짜

		if(xday.isBefore(dday))  // 오늘기준 보다 달력의 기준이 이전일 경우(같을경우도 포함)
		{
			request.setAttribute("prev", "1");
		}
		else 
		{
			request.setAttribute("prev", "0");
		}
	}

	// 예약 취소관련 상태변경
	public void state_change(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		String state=request.getParameter("state");
		
		// 쿼리생성
		String sql="update reserve set state=? where id=?";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, state);
		pstmt.setString(2, id);
		
		// 쿼리실행
		pstmt.executeUpdate();
		
		// close
		close();
		
		// 이동
		response.sendRedirect("reserve_view.jsp?ck="+request.getParameter("ck"));
	}
		   
	public void close() throws Exception
	{
		pstmt.close();
		conn.close();
	}

}






































