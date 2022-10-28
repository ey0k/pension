<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ page import="dao.ReserveDao" %>
<%
	ReserveDao rdao=new ReserveDao();
	rdao.reserve_admin(request, session);
%>
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
		text-align: center;
		/* border: 1px solid #FFB366;  */
		border-collapse:collapse;
		font-size:  
	}
	#section tr td{
		padding: 8px;
		border-bottom: 1px solid #FFB366;
	}
	#section th{
		border-bottom: 2px solid #FFB366;
		background: #FFF0DF;
	}
</style>
	<div id="section">
		<table>
		<caption><h2>전체 예약</h2></caption>
			<tr>
				<th height="25px"> 방 </th>
				<th> 체크인 </th>
				<th> 체크아웃 </th>
				<th> 숯패키지 </th>
				<th> bbq </th>
				<th> 총결제금액 </th>
				<th> 예약일 </th>
				<th> 예약자 </th>
			</tr>
			<c:forEach items="${rlist}" var="rdto">
			<tr>
				<td> ${rdto.bang} </td>
				<td> ${rdto.inday} </td>
				<td> ${rdto.outday} </td>
				<td> ${rdto.charcoal} </td>
				<td> ${rdto.bbq} </td>
				<td> <fmt:formatNumber value="${rdto.total}"/>원 </td>
				<td> ${rdto.writeday} </td>
				<td> ${rdto.userid} </td>
			</tr>
			</c:forEach>
		</table>
	</div>
<c:import url="../bottom.jsp" />
<%
	rdao.close();
%>