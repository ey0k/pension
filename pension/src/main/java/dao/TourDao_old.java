package dao;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.TourDto;

public class TourDao_old {
	Connection conn;
	PreparedStatement pstmt;
    public TourDao_old() throws Exception
    {
    	Class.forName("com.mysql.jdbc.Driver");
        String db="jdbc:mysql://localhost:3306/pension";
        conn=DriverManager.getConnection(db,"root","1234");
    }
    
    public void write_ok(HttpServletRequest request, HttpServletResponse response,
    		HttpSession session) throws Exception
    {
    	// 파일 업로드 객체 생성 
    	String path=request.getRealPath("/tour_old/img");
    	int size=1024*1024*10;
    	MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
    	
    	// request 
    	String title=multi.getParameter("title");
    	String userid=session.getAttribute("userid").toString();
    	String content=multi.getParameter("content");
    	String fname=multi.getFilesystemName("fname");
    	
    	// 쿼리생성
    	String sql="insert into tour(title,userid,content,fname,writeday) ";
    	sql=sql+" values(?,?,?,?,now())";
    	
    	// 심부름꾼
    	pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, title);
    	pstmt.setString(2, userid);
    	pstmt.setString(3, content);
    	pstmt.setString(4, fname);
    	
    	// 쿼리실행
    	pstmt.executeUpdate();
    	
    	// close
    	close();
    	
    	// 이동
    	response.sendRedirect("list.jsp");
    }
    
	public void list(HttpServletRequest request) throws Exception
	{
		// 쿼리 생성
		String sql="select * from tour order by id desc";
		
		// 심부름꾼 생성
		pstmt=conn.prepareStatement(sql);
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();
		
		// ArrayList 생성
		ArrayList<TourDto> list=new ArrayList<TourDto>(); 
		
		// rs=> dto에 담아서 ArrayList에 담기
		while(rs.next())
		{
			TourDto tdto=new TourDto();
			tdto.setId(rs.getInt("id"));
    		tdto.setTitle(rs.getString("title"));
    		tdto.setUserid(rs.getString("userid"));
    		tdto.setFname(rs.getString("fname"));
    		tdto.setReadnum(rs.getInt("readnum"));
    		tdto.setWriteday(rs.getString("writeday"));
    		
    		list.add(tdto);
		}
		
		request.setAttribute("list", list);
	}
	
	public void readnum(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// request
		String id=request.getParameter("id");
		
		// 쿼리생성
		String sql="update tour set readnum=readnum+1 where id=?";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		// 쿼리 실행
		pstmt.executeUpdate();
		
		// close()
		close();
		
		// 이동
		response.sendRedirect("content.jsp?id="+id);
	}
	
	public void content(HttpServletRequest request) throws Exception
	{
		// request
		String id=request.getParameter("id");
		
		// 쿼리생성
		String sql="select * from tour where id=?";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		// dto에 담기
		TourDto tdto=new TourDto();
		tdto.setId(rs.getInt("id"));
		tdto.setTitle(rs.getString("title"));
		tdto.setUserid(rs.getString("userid"));
		tdto.setFname(rs.getString("fname"));
		tdto.setReadnum(rs.getInt("readnum"));
		tdto.setWriteday(rs.getString("writeday"));
		tdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
		
		request.setAttribute("tdto", tdto);
	}
	
	public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// request
		String id=request.getParameter("id");
		String fname=request.getParameter("fname");
		
		// 쿼리생성
		String sql="delete from tour where id=?";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		// 쿼리 실행
		pstmt.executeUpdate();
		
		// 기존 그림을 삭제하기
		String path=request.getRealPath("/tour_old/img"); // 파일이 있는 경로
		File file=new File(path+"/"+fname); // 경로+파일명
		if(file.exists())
			file.delete();
		
		// close
		close();
		
		// list로 이동
		response.sendRedirect("list.jsp");
	}
	
	public void update(HttpServletRequest request) throws Exception
	{
		// request
		String id=request.getParameter("id");
		
		// 쿼리 생성
		String sql="select * from tour where id=?";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		// 쿼리 실행
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		// dto에 담기
    	TourDto tdto=new TourDto();
		tdto.setId(rs.getInt("id"));
		tdto.setTitle(rs.getString("title"));
		tdto.setUserid(rs.getString("userid"));
		tdto.setFname(rs.getString("fname"));
		tdto.setReadnum(rs.getInt("readnum"));
		tdto.setWriteday(rs.getString("writeday"));
		tdto.setContent(rs.getString("content"));
		
		request.setAttribute("tdto", tdto);
	}
    
    public void update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception
    {
    	String path=request.getRealPath("tour_old/img");
    	int size=1024*1024*10;
    	MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
    	
    	String title=multi.getParameter("title");
    	String content=multi.getParameter("content");
    	String fname=multi.getFilesystemName("fname"); // 새로 가져오는 그림파일명
    	String id=multi.getParameter("id");
    	String fname2=multi.getParameter("fname2"); // 기존의 그림파일명
    	
    	if(fname==null) // 기존그림을 그대로 사용
    	{
    		String sql="update tour set title=?, content=? where id=?";
    		pstmt=conn.prepareStatement(sql);
    		pstmt.setString(1, title);
    		pstmt.setString(2, content);
    		pstmt.setString(3, id);
    	}
    	else // 기존의 그림을 변경
    	{
    		String sql="update tour set title=?, content=?, fname=? where id=?";
    		pstmt=conn.prepareStatement(sql);
    		pstmt.setString(1, title);
    		pstmt.setString(2, content);
    		pstmt.setString(3, fname);
    		pstmt.setString(4, id);
    		
    		// 기존 그림 삭제
    		File file=new File(path+"/"+fname2); // fname2는 기존의 파일명
    		if(file.exists())
    			file.delete();
    	}
    	
    	// 쿼리 실행
    	pstmt.executeUpdate();
    	
    	// close
    	close();
    	
    	// list
    	response.sendRedirect("content.jsp?id=?"+id);
    }
        
    public void close() throws Exception
    {
    	pstmt.close();
    	conn.close();
    }
}
