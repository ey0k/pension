<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dao.TourDao_old" %>
<%
	TourDao_old tdao=new TourDao_old();
	tdao.update(request);
%>
<c:import url="../top.jsp" />
<style>
	#section {
		width: 1100px;
		height: 500px;
		margin: auto;
	}
	#section table{
		margin-top:100px;
		margin:auto;
		width:80%;
		text-align:center;
	}
	#section tr td{
		padding:4px;
	}
	#section th{
		height:35px;
	}
	input[type=submit],input[type=button]{
		color: white;
		background: #FFB366;
		width: 70px;
		height: 30px;
		border: none;
	}
	input[type=text]{
		border: 1px solid #ddd;
		width: 290px;
		height: 20px;
	}
	input[type=password]{
		border: 1px solid #ddd;
		width: 100px;
		height: 20px;
	}
	textarea{
		border: 1px solid #ddd;
	}
	#section #aa{
		color: #FFB366;
		font-weight: 900;
	}
	
</style>
	<div id="section">
	<form method="post" action="update_ok.jsp" enctype="multipart/form-data">
		<input type="hidden" name="id" value="${tdto.id}">
		<input type="hidden" name="fname2" value="${tdto.fname}">
		<table>
		<caption><h2>여 행 후 기 작 성</h2></caption>
			<tr>
				<th> 제 목 </th>
				<td> <input type="text" name="title" value="${tdto.title}"> </td>
			</tr>
			<tr>
				<th> 내 용 </th>
				<td> <textarea cols="40" rows="6" name="content">${tdto.content}</textarea> </td>
			</tr>
			<tr>
				<th> 파 일 </th>
				<td> <input type="file" name="fname">
				<img src="img/${tdto.fname}" width="100"> </td>
			</tr>
			<tr>
				<td colspan="2" align="center"> 
				<input type="submit" value="수정">
				<a id="aa" href="list.jsp"><input type="button" value="취소"></a> </td>
			</tr>
		</table>
		</form>
	</div>

<c:import url="../bottom.jsp" />
<%
	tdao.close();
%>





