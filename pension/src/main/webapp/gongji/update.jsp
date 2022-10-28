<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dao.GongjiDao" %>
<%
	GongjiDao gdao=new GongjiDao();
	gdao.update(request);
%>
<!-- 공지사항 update -->
<c:if test="${userid != 'admin'}">
	<c:redirect url="../main/index.jsp"/>
</c:if>
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
	#ck{
		font-size: 13px;
	}
</style>
	<div id="section">
	<form type="post" action="update_ok.jsp">
	<input type="hidden" name="id" value="${gdto.id}">
		<table>
		<caption> <h2>공지사항 글쓰기</h2></caption>
			<tr>
				<th width="18%"> 제 목 </th>
				<td> <input type="text" name="title" size="60%" value="${gdto.title}"> </td>
			</tr>
			<tr>
				<th height="100"> 내 용 </th>
				<td> <textarea cols="62%" rows="10" name="content">${gdto.content}</textarea></td>
			</tr>
			<tr>
				<td> </td>
				<td id="ck">
				<c:if test="${gdto.gubun == 1}">
					<c:set var="gu" value="checked"/>
				</c:if>
				<input type="checkbox" name="gubun" value="1" ${gu}>
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

<%
	gdao.close();
%>





























