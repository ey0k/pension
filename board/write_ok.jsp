<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.BoardDao"%>
<%
	// 글쓰기 폼에 입력된 값을 dao를 통해 저장한 후 list로 이동
	BoardDao bdao=new BoardDao();
	bdao.write_ok(request, response, session);
%>