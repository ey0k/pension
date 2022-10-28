<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="dao.AdminDao" %>
<%
	AdminDao adao=new AdminDao();
	adao.room_view(request);
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
	/* 	border: 1px solid #FFF0DF; */
		border-collapse:collapse;
	}
	#section tr:first-child th{
		border-bottom:2px solid #FFB366;
	}
	#section tr td{
		border-bottom:1px solid #FFF0DF;
	}
	#section tr:last-child td{
		border-bottom: none;
	}
	#section #aa{
		color: #FFB366;
		font-weight: 900;
	}
	#section tr td{
		padding: 4px;
	}
	#section th{
		background: #FFF0DF;
		height: 30px;
	}
	#section input[type=submit]{
		width:200px;
		height:40px;
		color: #FFB366;
		background: white;
		border: 1px solid #FFB366;   
	}
	#section input[type=submit]:hover{
		background: #FFB366;
		color: white;
	}
	#content_layer{
		position: absolute;
	}
</style>
<script>
	var k=0;
	function content_view(id)
	{ // ajax를 통해 접근
		var top=event.pageY;
		var left=event.pageX;
		var chk=new XMLHttpRequest();
		chk.open("get","content_view.jsp?id="+id);
		chk.send();
		chk.onreadystatechange=function()
		{
			if(chk.readyState==4)
			{
				document.getElementById("content_layer").innerHTML=chk.responseText;
				document.getElementById("content_layer").style.top=top+"px";
				document.getElementById("content_layer").style.left=left+"px";
				k=1;
			}
		}
		if(k==0)
			document.getElementById("content_layer").style.display="block";
	}
	function content_hide()
	{
		if(k==1)
		{
			document.getElementById("content_layer").style.display="none";
			k=0;
		}
	}
</script>
	<div id="content_layer"></div>
	<div id="section">
		<table>
		<caption><h2>객실 관리</h2></caption>
			<tr>
				<th> 방이름 </th>
				<th> 최소인원 </th>
				<th> 최대인원 </th>
				<th> 1박가격 </th>
				<th> 상 태 </th>
				<th></th>
				<th></th>
			</tr>
			
		<c:forEach items="${rlist}" var="rdto">
			<tr>
				<td onmouseover="content_view(${rdto.id})" onmouseout="content_hide()"> ${rdto.bang} </td>
				<td> ${rdto.min} </td>
				<td> ${rdto.max} </td>
				<td> <fmt:formatNumber value="${rdto.price}"/> 원</td>
			<c:if test="${rdto.state == 0}">
				<td> 정상운영 </td>
			</c:if>
			<c:if test="${rdto.state == 1}">
				<td> 공사중 </td>
			</c:if>
				<td> <a href="update.jsp"><img width="20" src="../img/ee.png"></a></td>
				<td> <a href="delete.jsp"><img width="18" src="../img/delete.png"></a> </td>
			</tr>
		</c:forEach>
			<tr>
				<td colspan="7" align="right">
					<a id="aa" href="add.jsp">객실추가</a>
				</td>
			</tr>
		</table>
	</div>
<c:import url="../bottom.jsp" />
<%
	adao.close();
%>










