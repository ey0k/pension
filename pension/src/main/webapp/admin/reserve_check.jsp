<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ page import="dao.AdminDao" %>
<%
	AdminDao adao=new AdminDao();
	adao.reserve_check(request);
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
		<caption><h2>전체 예약</h2></caption>
			<tr>
				<th> </th>
				<th height="25px"> 방 </th>
				<th> 체크인 </th>
				<th> 체크아웃 </th>
				<th> 숯패키지 </th>
				<th> bbq </th>
				<th> 총결제금액 </th>
				<th> 예약일 </th>
				<th> 예약자 </th>
				<th> 상태 </th>
			</tr>
			<c:forEach items="${rlist}" var="rdto">
			<tr>
				<td> ${rdto.id} </td>
				<td> ${rdto.bang} </td>
				<td> ${rdto.inday} </td>
				<td> ${rdto.outday} </td>
				<td> ${rdto.charcoal} </td>
				<td> ${rdto.bbq} </td>
				<td> <fmt:formatNumber value="${rdto.total}"/>원 </td>
				<td> ${rdto.writeday} </td>
				<td> ${rdto.userid} </td>
				<c:if test="${rdto.state == 0}">
					<td style="color:green"> 예약완료 </td>
				</c:if>
				<c:if test="${rdto.state == 1}">
					<td> <a style="color:blue" href="reserve_cancel.jsp?id=${rdto.id}">취소요청</a></td>
				</c:if>
				<c:if test="${rdto.state == 2}">
					<td style="color:red"> 취소완료 </td>
				</c:if>
				<c:if test="${rdto.state == 3}">
					<td> 사용완료 </td>
				</c:if>	
			</tr>
			</c:forEach>
		</table>
	</div>
<c:import url="../bottom.jsp" />
<%
	adao.close();
%>