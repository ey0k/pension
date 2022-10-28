<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.ReserveDao"%>
<%
	ReserveDao rdao=new ReserveDao();
	rdao.reserve_ok(request, session, response);
%>