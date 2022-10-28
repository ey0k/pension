<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ page import="dao.AdminDao" %>
<%
	AdminDao adao=new AdminDao();
	adao.member_check(request);
%>
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
		width: 80%;
		margin-top: 0px;
		margin: auto;
		text-align:center;
	 	border: 1px solid #FFB366;
		border-collapse:collapse;
	}
	#section tr:first-child th{
		/* border-bottom:2px solid #FFB366; */
	}
	#section tr td{
		border-bottom:1px solid #FFF0DF;
	}
	#section tr:last-child td{
		border-bottom: none;
	}
	#section tr td{
		padding: 8px;
	}
 	#section th{
		/* background: #FFF0DF; */
		height: 30px;
		padding: 8px;
	} 
</style>
	<div id="section">
		<table>
		<caption><h2>회원 관리</h2></caption>
			<tr>
				<th> </th>
				<th> 아이디 </th>
				<th> 이름</th>
				<th> 연락처 </th>
				<th> 이메일 </th>
				<th> 가입일 </th>
				<th> 상태 </th>
			</tr>
			<c:forEach items="${mlist}" var="mdto">
			<tr>
				<td> ${mdto.id} </td>
				<td> ${mdto.userid} </td>
				<td> ${mdto.name} </td>
				<td> ${mdto.phone} </td>
				<td> ${mdto.email} </td>
				<td> ${mdto.writeday} </td>
				<c:if test="${mdto.state == 0}">
					<td style="color:green">정상 회원</td>
				</c:if>
				<c:if test="${mdto.state == 1}">
					<td><a style="color:blue" href="out_ok.jsp?id=${mdto.id}">탈퇴 신청중</a></td>
				</c:if>
				<c:if test="${mdto.state == 2}">
					<td style="color:red">탈퇴 회원</td>
				</c:if>
			</tr>
			</c:forEach>
		</table>
	</div>
<c:import url="../bottom.jsp" />
<%
	adao.close();
%>