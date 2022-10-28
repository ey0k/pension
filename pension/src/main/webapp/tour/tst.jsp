<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ page import="dao.TourDao" %>
<%
	TourDao tdao=new TourDao();
	tdao.content(request);
%>
<c:import url="../top.jsp" />
<style>
	#section {
		width: 1100px;
		margin: auto;
		margin-top: 0px;
	}
	#section table{
		margin-top: 0px;
		margin: auto;
		text-align: left;
		/* border: 1px solid #FFF0DF;	 */
		border-collapse: collapse;
		width: 60%;
	}
	#section th{
		text-align: center;
	}
	#section tr #th {
		border-right: 2px solid #FFB366;
     }
    #section tr td{
		padding:4px;
		padding-left: 10px;
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
		<table>
		<caption> <h2>여 행 후 기</h2></caption>
			<tr>
				<th width="18%"> 제 목 </th>
				<td colspan="3">${tdto.title}</td>
			</tr>
			<tr>
				<th id="td"> 작성자 </th>
				<td>${tdto.userid}</td>
				<th width="10%" align="right"> 조회수 </th>
				<td>${tdto.readnum}</td>
			</tr>
			<tr>
				<th id="td"> 작성일 </th>
				<td colspan="2">${tdto.writeday}</td>
			</tr>
			<tr height="200" ${fn:length(tdto.file)}>
				<th id="td"> 내 용</th>
				<td colspan="3">
				<!-- tdto.file => 배열 -->
				<c:forEach items="${tdto.file}" var="my">
				<img src="img/${my}" width="150"> 
				</c:forEach>
				<p>				
				${tdto.content}</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<a id="aa" href="list.jsp"> 목록 </a>
				<c:if test="${userid == tdto.userid}" > <!--본인 글일 경우 -->
					<a id="aa" href="update.jsp?id=${tdto.id}">수정</a>
					<a id="aa" href="delete.jsp?id=${tdto.id}&fname${tdto.fname}">삭제</a>
				</c:if>
				</td>
			</tr>
		</table>
	</div>
<c:import url="../bottom.jsp" />

<%
	tdao.close();
%>


















