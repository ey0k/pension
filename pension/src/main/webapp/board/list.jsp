<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dao.BoardDao" %>
<%
	BoardDao bdao=new BoardDao();
	bdao.list(request);
%>
<!-- Board.list -->
<c:import url="../top.jsp" />
<style>
	#section {
		width: 1100px;
		margin: auto;
		margin-top: 0px;
	}
	#section table{
		width: 80%;
		margin-top: 0px;
		margin: auto;
		text-align:center;
	/* 	border: 1px solid #FFF0DF; */
		border-collapse:collapse;
	}
	#section tr:first-child th{
		border-bottom:2px solid #FFB366;
	}
	#section tr td{
		border-bottom:1px solid #FFF0DF;
	}
	#section tr:last-child td{
		border-bottom: none;
	}
	#section #aa{
		color: #FFB366;
		font-weight: 900;
	}
	#section tr td{
		padding: 4px;
	}
	#section th{
		background: #FFF0DF;
		height: 30px;
</style>
	<div id="section">
		<table>
		<caption><h2>자 유 게 시 판</h2></caption>
			<tr>
				<th width="8%"> 글번호 </th>
				<th> 제 목 </th>
				<th> 작성자 </th>
				<th width="8%"> 조회수 </th>
				<th width="14%"> 작성일 </th>
			</tr>
		 <c:forEach items="${list}" var="bdto">
			<tr>
				<td>${bdto.id}</td>
				<td align="left"><a href="readnum.jsp?id=${bdto.id}">${bdto.title}</a></td>
				<td>${bdto.userid}</td>
				<td>${bdto.readnum}</td>
				<td>${bdto.writeday}</td>
			</tr>
		  </c:forEach>
		  	<tr>
		  		<td colspan="5" align="right">
		  		<a id="aa" href="write.jsp">글쓰기</a>
		  	</tr>	
		</table>	
	</div>
<c:import url="../bottom.jsp" />

<%
	bdao.close();
%>