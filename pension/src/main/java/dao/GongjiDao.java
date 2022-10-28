package dao;

import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.BoardDto;
import dto.GongjiDto;

public class GongjiDao {
	Connection conn;
	PreparedStatement pstmt;
	
	public GongjiDao () throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
	    String db="jdbc:mysql://localhost:3306/pension";
	    conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void write_ok(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// request
		request.setCharacterEncoding("utf-8");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String gubun;
		
		if(request.getParameter("gubun")==null)
			gubun="0";
		else 
			gubun=request.getParameter("gubun");
			
		// 쿼리생성
		String sql="insert into gongji(title,content,gubun,writeday) values(?,?,?,now())";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, gubun);
		
		// 쿼리 실행
		pstmt.executeUpdate();
		
		// close()
		close();
		
		// list로 이동
		response.sendRedirect("list.jsp");		
	}

	public void list(HttpServletRequest request) throws Exception
	{
		// request 현재는 x
		
		// 쿼리 생성
		String sql="select * from gongji order by id desc";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		
		// 쿼리생성
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<GongjiDto> list=new ArrayList<GongjiDto>();
		while(rs.next())
		{
			GongjiDto gdto=new GongjiDto();
			gdto.setId(rs.getInt("id"));
			gdto.setTitle(rs.getString("title"));
			gdto.setWriteday(rs.getString("writeday"));
			gdto.setGubun(rs.getInt("gubun"));
			
			list.add(gdto);
		}
		request.setAttribute("list", list);
	}
	
	public void content(HttpServletRequest request) throws Exception
	{
		// request
		String id=request.getParameter("id");
		
		// 쿼리 생성
		String sql="select * from gongji where id=?";
		
		// 심부름꾼 생성
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		// 쿼리 실행
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		// dto저장
		GongjiDto gdto=new GongjiDto();
		gdto.setId(rs.getInt("id"));
		gdto.setTitle(rs.getString("title"));
		gdto.setContent(rs.getString("content").replace("\r\n","<br>"));
		gdto.setWriteday(rs.getString("writeday"));
		gdto.setGubun(rs.getInt("gubun"));
		
		// dto를 request 영역에 저장
		request.setAttribute("gdto", gdto);
	}
	
	public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// request
		String id=request.getParameter("id");
		
		// 쿼리 생성
		String sql="delete from gongji where id=?";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		// 쿼리 실행
		pstmt.executeUpdate();
		
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
		String sql="select * from gongji where id=?";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		GongjiDto gdto=new GongjiDto();
		gdto.setId(rs.getInt("id"));
		gdto.setTitle(rs.getString("title"));
		gdto.setContent(rs.getString("content"));
		gdto.setWriteday(rs.getString("writeday"));
		gdto.setGubun(rs.getInt("gubun"));
		
		// dto를 request에 저장
		request.setAttribute("gdto", gdto);
	}
	
	public void update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// request
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String gubun;
		if(request.getParameter("gubun")==null)
			gubun="0";
		else
			gubun=request.getParameter("gubun");
		
		// 쿼리생성
		String sql="update gongji set title=?,content=?,gubun=? where id=?";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, gubun);
		pstmt.setString(4, id);
		
		// 쿼리실행
		pstmt.executeUpdate();
		
		// close
		close();
		
		// content로 이동
		response.sendRedirect("content.jsp?id="+id);		
	}
	
	public void getThree(HttpServletRequest request) throws Exception
	{
		// 쿼리생성
		String sql="select * from Gongji order by id desc limit 3";
		
		// 심부름꾼
		pstmt=conn.prepareStatement(sql);
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();
		
		// ArrayList
		ArrayList<GongjiDto> glist=new ArrayList<GongjiDto>();
			
		// rs=> dto => blist
		while(rs.next())
		{
			GongjiDto gdto=new GongjiDto();
			gdto.setId(rs.getInt("id"));
			if(rs.getString("title").length()>18)
				gdto.setTitle(rs.getString("title").substring(0,16)+"··.");
			else
				gdto.setTitle(rs.getString("title"));

			gdto.setWriteday(rs.getString("writeday"));
			
			glist.add(gdto);
		}
		
		request.setAttribute("glist", glist);
	}
	
	
	public void close() throws Exception
	{
		pstmt.close();
		conn.close();
	}
}























