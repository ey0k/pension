<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="dao.BoardDao" %>
<%@ page import="dao.GongjiDao" %>
<%@ page import="dao.TourDao" %>
<%
	// 공지사항	
	GongjiDao gdao=new GongjiDao();
	gdao.getThree(request);
	
	// 게시판
	BoardDao bdao=new BoardDao();
	bdao.getThree(request);
	
 	// 여행후기
	TourDao tdao=new TourDao();
	tdao.getThree(request);
%>
<c:import url="../top.jsp"/>
	<div id="third"><img src="../img/main.JPG" width="1100" height="400"></div>
	<div id="fourth">
		<div id="gongji"><b>공지사항</b><p>
			<c:forEach items="${glist}" var="gdto">
				<a href="../gongji/content.jsp?id=${gdto.id}">${gdto.title}</a> | ${gdto.writeday} <p>
			</c:forEach>
		</div>
		<div id="tour"><b>여행 후기</b><p>
			<c:forEach items="${tlist}" var="tdto">
				<a href="../tour/readnum.jsp?id=${tdto.id}">${tdto.title}</a> | ${tdto.writeday} <p>
			</c:forEach>
		</div>
		<div id="board"><b>자유게시판</b><p>
			<c:forEach items="${blist}" var="bdto">
				<a href="../board/readnum.jsp?id=${bdto.id}">${bdto.title}</a> | ${bdto.writeday} <p>
			</c:forEach>
		</div>
	</div>
	<div id="fifth">
		<div id="el1">이벤트 1 </div>
		<div id="el2">이벤트 2 </div>
		<div id="el3">이벤트 3 </div>
		<div id="el4">이벤트 4 </div>
		<div id="el5">이벤트 5 </div>
	</div>
<c:import url="../bottom.jsp"/>






























