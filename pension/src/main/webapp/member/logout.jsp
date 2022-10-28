<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao" %>
<%
	// logout 후에 첫페이지 이동
	MemberDao mdao=new MemberDao();
	mdao.logout(session, response);
%>