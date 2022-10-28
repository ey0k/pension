<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dao.TourDao_old" %>
<%
	TourDao_old tdao=new TourDao_old();
	tdao.content(request);
%>
<c:import url="../top.jsp" />
<style>
	#section {
		width: 1100px;
		height: 500px;
		margin: auto;
	}
	#section table{
		margin-top: 30px;
		text-align: left;
		border: 1px solid #FFF0DF;	
		border-collapse: collapse;
		width: 80%;
	}
	#section #aa{
		color: #FFB366;
		font-weight: 900;
	}
	#bb{
		height:60px;
	}
	#section input[type=submit]{
		background: #FFB366;
		border: none;
		color: white;
		height: 21px;
	}
	#section input[type=password]{
		border: 1px solid #FFB366;
	}
	
	#del{
		display: none;
	}
</style>
	<div id="section">
		<table border="1" align="center">
			<tr>
				<th> 제 목 </th>
				<td colspan="3">${tdto.title}</td>
			</tr>
			<tr>
				<th> 작성자 </th>
				<td>${tdto.userid}</td>
				<th width="10%" align="right"> 조회수 </th>
				<td>${tdto.readnum}</td>
			</tr>
			<tr>
				<th> 작성일 </th>
				<td>${tdto.writeday}</td>
			</tr>
			<tr height="200">
				<th> 내 용 </th>
				<td colspan="3">
				<img src="img/${tdto.fname}" width=50%> <p>
				${tdto.content}</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<a href="list.jsp"> 목록 </a>
				<c:if test="${userid == tdto.userid}" > <!--본인 글일 경우 -->
					<a href="update.jsp?id=${tdto.id}">수정</a>
					<a href="delete.jsp?id=${tdto.id}&fname${tdto.fname}">삭제</a>
				</c:if>
				</td>
			</tr>
		</table>
	</div>
<c:import url="../bottom.jsp" />

<%
	tdao.close();
%>


















