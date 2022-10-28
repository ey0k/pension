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
import javax.servlet.jsp.JspWriter;

import dto.MemberDto;
import dto.ReserveDto;
import dto.RoomDto;

public class AdminDao {
	Connection conn;
	PreparedStatement pstmt;
	
	public AdminDao() throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
	    String db="jdbc:mysql://localhost:3306/pension";
	    conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void room_view(HttpServletRequest request) throws Exception // room테이블의 내용을 읽어와서 출력
	{
		// 쿼리생성
		String sql="select * from room order by id asc";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<RoomDto> rlist=new ArrayList<RoomDto>();
		while(rs.next())
		{
			RoomDto rdto=new RoomDto();
			rdto.setId(rs.getInt("id"));
			rdto.setBang(rs.getString("bang"));
			rdto.setMin(rs.getInt("min"));
			rdto.setMax(rs.getInt("max"));
			rdto.setPrice(rs.getInt("price"));
			rdto.setState(rs.getInt("state"));
			
			rlist.add(rdto);
		}
		
		request.setAttribute("rlist", rlist);
	}
	
	public String content_view(JspWriter out,HttpServletRequest request) throws Exception
	{
		// request
		String id=request.getParameter("id");
		
		// 쿼리생성
		String sql="select content from room where id=?";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();
		rs.next();

		// out.print(rs.getString("content"));
		return rs.getString("content");
	}
	
	public void reserve_check(HttpServletRequest request) throws Exception
	{
		// 쿼리생성
		String sql="select r2.*,r1.bang from room as r1, reserve as r2 where r1.id=r2.bang_id order by inday asc";
		
		// 심부름꾼 생성
		pstmt=conn.prepareStatement(sql);
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<ReserveDto> rlist=new ArrayList<ReserveDto>();
		while(rs.next())
		{		
			String[] imsi=rs.getString("outday").split("-");
			int y=Integer.parseInt(imsi[0]);
			int m=Integer.parseInt(imsi[1]);
			int d=Integer.parseInt(imsi[2]);

			LocalDate today=LocalDate.now();
			LocalDate dday=LocalDate.of(y, m, d);
			
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
	
			if(today.isBefore(dday))
				rdto.setState(rs.getInt("state"));
			else 
				rdto.setState(3);
				
			rlist.add(rdto);
		}
		request.setAttribute("rlist", rlist);
	}
	
	public void reserve_cancel(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// state를 2로 변경
		// request
		String id=request.getParameter("id");
		
		// 쿼리생성
		String sql="update reserve set state=2 where id=?";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		// 쿼리실행
		pstmt.executeUpdate();
		
		// close
		close();
		
		// reserve_check로 이동
		response.sendRedirect("reserve_check.jsp");
	}
	
	public void member_check(HttpServletRequest request) throws Exception
	{
		// 쿼리작성
		String sql="select * from member order by id asc";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<MemberDto> mlist=new ArrayList<MemberDto>();
		while(rs.next())
		{
			MemberDto mdto=new MemberDto();
			mdto.setId(rs.getInt("id"));
			mdto.setUserid(rs.getString("userid"));
			mdto.setName(rs.getString("name"));
			mdto.setPhone(rs.getString("phone"));
			mdto.setEmail(rs.getString("email"));
			mdto.setState(rs.getInt("state"));
			mdto.setWriteday(rs.getString("writeday"));
			
			mlist.add(mdto);
		}
		request.setAttribute("mlist", mlist);
	}
	
	public void out_ok(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// request
		String id=request.getParameter("id");
		
		// 쿼리생성
		String sql="update member set state=2 where id=?";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		// 쿼리실행
		pstmt.executeUpdate();
		
		// close
		close();
		
		// 이동
		response.sendRedirect("member_check.jsp");
	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public void close() throws Exception
	{
		pstmt.close();
		conn.close();
	}
}
