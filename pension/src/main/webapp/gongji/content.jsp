<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dao.GongjiDao" %>
<%
	GongjiDao gdao=new GongjiDao();
	gdao.content(request);
%>
<!-- 공지 content -->
<c:import url="../top.jsp" />
<style>
	#section {
		width: 1100px;
		margin: auto;
		margin-top:0px;
	}
	#section table{
		margin-top: 0px;
		margin: auto;
		text-align: left;
	/* 	border: 1px solid #FFF0DF; */
		border-collapse: collapse;
		width: 60%;
	}
	#section tr td{
		padding:4px;
	}
	#section #aa{
		color: #FFB366;
		font-weight: 900;
	}
	#title{
		font-weight: 800;
	}
	#wd{
		font-size: 14px;
		color: grey;
	}
	#section #bd {
		border-bottom: 1px solid #FFB366;
	}
</style>
	<div id="section">
		<table>
		<caption> <h2>공 지 사 항</h2></caption>
			<tr id="bd" >
				<td id="title"> ${gdto.title} </td>
				<td id="wd" width="16%"> ${gdto.writeday} </td>
			</tr>
			<tr height="300">
				<td colspan="2"> ${gdto.content} </td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<a id="aa" href="list.jsp">목록</a>
			<c:if test="${userid == 'admin'}">
				<a id="aa" href="update.jsp?id=${gdto.id}">수정</a>
				<a id="aa" href="delete.jsp?id=${gdto.id}">삭제</a>
			</c:if>
				</td>
			</tr>
		</table>
	</div>
<c:import url="../bottom.jsp" />

<%
	gdao.close();
%>



























