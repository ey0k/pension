<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dao.GongjiDao" %>
<%
	GongjiDao gdao=new GongjiDao();
	gdao.list(request);
%>
<!-- 공지 list -->
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
		/* border: 1px solid #FFF0DF; */
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
	}
	#section #gg{
		background: #FFFAF2;
	}
</style>
	<div id="section">
		<table>
		<caption><h2>공 지 사 항</h2></caption>
			<tr>
				<th width="8%"> 글번호 </th>
				<th> 제 목 </th>
				<th> 작성자 </th>                                            
				<th width="14%"> 작성일 </th>
			</tr>
		 <c:forEach items="${list}" var="gdto">
		 	<c:if test="${gdto.gubun ==1 }">
		 	<tr id="gg">
		 		<td>
		 		<!-- 그림은 gubun값이 1일 경우 -->
				  <c:if test="${gdto.gubun == 1}">
				  	<img src="../img/nn.png" width="20">
				  </c:if>
		  		</td>
		 		<td align="left"> <a href="content.jsp?id=${gdto.id}">${gdto.title}</a> </td>
		 		<td> 관리자 </td>
		 		<td> ${gdto.writeday} </td>
		 	</tr>
		 	</c:if>
		 </c:forEach>
		 <c:forEach items="${list}" var="gdto">
			<tr>
				<td> ${gdto.id} </td>
				<td width="300" align="left">
				<a href="content.jsp?id=${gdto.id}">${gdto.title}</a></td>
				<td>관리자</td>
				<td>${gdto.writeday}</td>
			</tr>
		  </c:forEach>
		  <c:if test="${userid == 'admin'}">
		  	<tr>
		  		<td colspan="4" align="right">
		  		<a id="aa" href="write.jsp">글쓰기</a>
		  	</tr>	
		  </c:if>
		</table>	
	</div>
<c:import url="../bottom.jsp" />

<%
	gdao.close();
%>