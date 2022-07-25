<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.BoardDao"%>
<%
	BoardDao bdao=new BoardDao();
	bdao.update_ok(request, response);
%>