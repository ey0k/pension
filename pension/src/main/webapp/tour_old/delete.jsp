<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.TourDao_old"%>
<%
	TourDao_old tdao=new TourDao_old();
	tdao.delete(request, response);
%>
    