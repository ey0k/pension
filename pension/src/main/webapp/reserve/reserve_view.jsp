<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ page import="dao.ReserveDao" %>
<%
	ReserveDao rdao=new ReserveDao();
	// rdao.reserve_view(session, request);
	rdao.reserve_view(session, request);
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
		border: 1px solid #FFB366;    
		border-collapse:collapse; 
	}
	#section tr td{
		padding: 10px;
	}
	#section input[type=button]
	{
		width:70px;
		height:25px;
		color: #FFB366;
		background: white;
		border: 1px solid #FFB366;   
	}
	#section input[type=button]:hover
	{
		background: #FFB366;
		color: white;
	}
	#section tr td{
		padding: 8px;
	}
	/* #section tr:first-child th{
		border-bottom:2px solid #FFB366;
	} */
 	#section th{
		/* background: #FFF0DF; */
		height: 30px;
		padding: 8px;
	} 
</style>
	<div id="section">
		<table>
		<caption><h2>${name}님의 예약내용</h2></caption>
			<tr>
				<th> 방 </th>
				<th> 체크인 </th>
				<th> 체크아웃 </th>
				<th> 숯패키지 </th>
				<th> bbq </th>
				<th> 총결제금액 </th>
				<th> 예약일 </th>
				<th> 상태 </th>
			</tr>
			<c:forEach items="${rlist}" var="rdto">
			<tr>
				<td> ${rdto.bang} </td>
				<td> ${rdto.inday} </td>
				<td> ${rdto.outday} </td>
				<td> ${rdto.charcoal} </td>
				<td> ${rdto.bbq} </td>
				<td> <fmt:formatNumber value="${rdto.total}"/></td>
				<td> ${rdto.writeday} </td>
				
				<c:if test="${rdto.state == 0}">
					<c:set var="state" value="예약완료"/>
				</c:if>
				<c:if test="${rdto.state == 1}">
					<c:set var="state" value="예약취소중"/>
				</c:if>
				<c:if test="${rdto.state == 2}">
					<c:set var="state" value="취소완료"/>
				</c:if>
				<c:if test="${rdto.state == 3}">
					<c:set var="state" value="사용완료"/>
				</c:if>
				<td> ${state} </td>
				<!-- 버튼 만들 td -->
				<!-- 예약완료일 경우 예약취소 버튼 -->
				<c:if test="${rdto.state==0}">
					<td> <input type="button" onclick="location='state_change.jsp?id=${rdto.id}&state=1&ck=${ck}'" value="예약취소"></td>	
				</c:if>
				<!-- 예약취소중일 경우 취소철회 버튼 -->
				<c:if test="${rdto.state==1}">
					<td> <input type="button" onclick="location='state_change.jsp?id=${rdto.id}&state=0&ck=${ck}'" value="취소철회"></td>
				</c:if>
				<c:if test="${ !(rdto.state==0 || rdto.state==1) }">
					<td>&nbsp</td>
				</c:if>
			</tr>
			</c:forEach>
		</table>
	</div>
<c:import url="../bottom.jsp" />
<%
	rdao.close();
%>