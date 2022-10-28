<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.AdminDao"%>
<%
	AdminDao adao=new AdminDao();
	String content=adao.content_view(out, request);
%>
<div style="width:200px;height:100px;border:1px solid #FFB366; background: white">
	<%=content%>
</div>