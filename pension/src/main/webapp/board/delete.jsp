<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="dao.BoardDao"%>
<%
	// 삭제 한 후 list로 이동
	BoardDao bdao=new BoardDao();
	bdao.delete(request, response);
%>