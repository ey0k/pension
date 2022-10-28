<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.ReserveDao"%>
<%
	ReserveDao rdao=new ReserveDao();
	rdao.state_change(request, response);
%>