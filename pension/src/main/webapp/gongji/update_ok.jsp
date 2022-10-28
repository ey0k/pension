<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.GongjiDao" %>
<%
	GongjiDao gdao=new GongjiDao();
	gdao.update_ok(request, response);
%>