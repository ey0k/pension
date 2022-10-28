<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dao.TourDao_old" %>
<%
	TourDao_old tdao=new TourDao_old();
	tdao.list(request);
%>
<!-- Board.list -->
<c:import url="../top.jsp" />
<style>
	#section {
		width: 1100px;
		height: 500px;
		margin: auto;
	}
	#section table{
		width: 80%;
		margin: auto;
		margin-top: 10px;
		text-align:center;
		border: 1px solid #FFF0DF;
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
		<caption><h2>여 행 후 기</h2></caption>
			<tr>
				<th width="8%"> 글번호 </th>
				<th> 제 목 </th>
				<th width="8%"> 작성자 </th>
				<th width="12%"> 사 진 </th>
				<th width="8%"> 조회수 </th>
				<th width="14%"> 작성일 </th>
			</tr>
		 <c:forEach items="${list}" var="tdto">
			<tr>
				<td>${tdto.id}</td>
				<td align="left"><a href="readnum.jsp?id=${tdto.id}">${tdto.title}</a></td>
				<td>${tdto.userid}</td>
				<td><img src="img/${tdto.fname}" width="50" height="50"></td>
				<td>${tdto.readnum}</td>
				<td>${tdto.writeday}</td>
			</tr>
		  </c:forEach>
		  <c:if test="${userid != null}">
		  	<tr>
		  		<td colspan="6" align="right">
		  		<a id="aa" href="write.jsp">글쓰기</a>
		  	</tr>	
		  </c:if>
		</table>	
	</div>
<c:import url="../bottom.jsp" />

<%
	tdao.close();
%>