<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dao.GongjiDao" %>
<%
	GongjiDao gdao=new GongjiDao();
	gdao.update(request);
%>
<c:if test="${userid != 'admin'}">
	<c:redirect url="../main/index.jsp"/>
</c:if>
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
		border:1px solid #ddd;
	}
	#section tr td{
		padding:4px;
	}
	#section th{
		height:35px;
	}
	input[type=submit],input[type=button]{
		margin-top: 20px;
		color: white;
		background: #FFB366;
		width: 50px;
		height: 25px;
		border-radius: 4px;
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
	#ck{
		font-size: 13px;
	}
</style>
<script>
	window.onload=function()
	{
		// gubun의 값이 1이면 checkbox를 체크되게한다.
		<c:if test="${gdto.gubun == 1}">
			document.getElementById("gubun").checked=true;
		</c:if>
	};
</script>
	<div id="section">
	<form type="post" action="update_ok.jsp">
	<input type="hidden" name="id" value="${gdto.id}">
		<table width="500" align="center">
		<caption> <h2>공지사항 글쓰기</h2></caption>
			<tr>
				<th width="100"> 제 목 </th>
				<td> <input type="text" name="title" value="${gdto.title}"> </td>
			</tr>
			<tr>
				<th height="100"> 내 용 </th>
				<td> <textarea cols="40" rows="5" name="content">${gdto.content}</textarea></td>
			</tr>
			<tr>
				<td colspan="2" id="ck">
				<input type="checkbox" name="gubun" value="1" id="gubun">
				이 글을 항상 첫페이지에 출력하고자 하면 체크하세요
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="submit" value="수정">
				<a href="list.jsp"><input type="button" value="취소"></a>
				</td>
			</tr>
		</table>
	</form>
	</div>
<c:import url="../bottom.jsp" />





























