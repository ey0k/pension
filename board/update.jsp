<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dao.BoardDao" %>
<%
	BoardDao bdao=new BoardDao();
	bdao.update(request);
%><!-- 자유게시판 update -->
<c:import url="../top.jsp" />
<style>
	#section {
		width: 1100px;
		margin: auto;
		margin-top: 0px;
	}
	#section table{
		margin-top:0px;
		margin:auto;
		/* border:1px solid #FFF0DF; */
		width: 60%;
		text-align: left;
	}
	#section tr td{
		padding:4px;
	}
	#section th{
		height:35px;
		text-align: left;
	}
	input[type=submit],input[type=button]{
		color: white;
		background: #FFB366;
		width: 70px;
		height: 30px;
		border: none;
		border-radius: 4px;
	}
	input[type=text]{
		border: 2px solid #FFF0DF;
		height: 20px;
	}
	input[type=password]{
		border: 2px solid #FFF0DF;
		height: 20px;
	}
	textarea{
		border: 2px solid #FFF0DF;
	}
</style>
	<div id="section">
	<form name="pkc" method="post" action="update_ok.jsp">
		<input type="hidden" name="id" value="${bdto.id}">
		<table>
		<caption><h2>자 유 게 시 판</h2></caption>
			<tr>
				<th width="18%"> 제 목 </th>
				<td> <input type="text" name="title" size="60%" value="${bdto.title}"> </td>
			</tr>
		<c:if test="${userid == null || bdto.userid != userid}">
			<tr>
				<th> 비밀번호 </th>
				<td> <input type="password" name="pwd" size="10%"> </td>
			</tr>
		</c:if>
			<tr>
				<th> 내 용 </th>
				<td> <textarea cols="62%" rows="10" name="content">${bdto.content}</textarea> </td>
			</tr>
			<tr>
				<td colspan="2" align="center"> 
				<input type="submit" value="수정">
				<a href="list.jsp"><input type="button" value="취소"></a> </td>
			</tr>
		</table>
		</form>
	</div>
<c:import url="../bottom.jsp" />

<%
	bdao.close();
%>












