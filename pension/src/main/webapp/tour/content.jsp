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
	#section table {
		margin-top: 0px;
		margin: auto;
		text-align: left;
		/* border: 2px solid #FFF0DF; */
		border-collapse: collapse;
		width: 60%;
		padding-left:2%;
		padding-right:2%;
	}
	#section #bd {
		border-bottom: 1px solid #FFB366;
	}
	#section tr td {
		padding-left: 10px;
	}
	#section #aa {
		color: #FFB366;
		font-weight: 900;
	}
	#del {
		display: none;
	}
	#title {
		font-weight: 800;
	}
	#wd {
		font-size: 14px;
		color: grey;
	}
	#zoom_id {
		position: absolute;
		visibility: hidden;
		top: 200px;
	}
	#mo {
		position: absolute;
		left: 0px;
		top: 0px;
		width: 100%;
		height: 100%;
		visibility: hidden;
		background: rgba(240,240,240,0.6);
	}
</style>
<script>
	function zoom(my) 
	{
		document.getElementById("mo").style.visibility = "visible"; // 회색창 보이기
		document.getElementsByTagName("body")[0].style.overflow = "hidden";
		document.getElementById("zoom_id").style.visibility = "visible";
		document.getElementById("zoom_img").src = my;
		
		center_img();
	}
	function center_img() {
		if (innerWidth > 1000) // 브라우저의 가로가 1000px 이상인 경우에만 동작
		{
			var w = (innerWidth-600) / 2;
			document.getElementById("zoom_id").style.left = w + "px";
			// 그림을 브라우저의 가로기준으로 중앙에 배치
		}
	}
	function hide_img(my) {
		my.style.visibility = "hidden";
		document.getElementById("mo").style.visibility = "hidden"; // 회색창 닫기
		document.getElementsByTagName("body")[0].style.overflow = "auto";
	}
	window.onresize = center_img;
</script>
<div id="mo"> ..<!-- 밖의 회색 부분 -->
<div id="zoom_id" onclick="hide_img(this)"><img style="opacity:1" id="zoom_img" width="600"><span id="dd"></span></div>
</div>
	<div id="section">
		<table>
		<caption> <h2>여 행 후 기</h2></caption>
			<tr>
				<td id="title" colspan="3">${tdto.title}</td>
			</tr>
			<tr id="bd">
				<td width="70%">${tdto.userid}</td>
				<td width="14%" id="wd"> 조회 ${tdto.readnum}</td>
				<td id="wd">${tdto.writeday}</td>
			</tr>
			<tr height="300" ${fn:length(tdto.file)}>
				<td colspan="3">
				<!-- tdto.file => 배열 -->
				<p>
			  <c:if test="${tdto.file != ''}">	
				<c:forEach items="${tdto.file}" var="my">
					<img src="img/${my}" width="180" onclick="zoom(this.src)"> 
				</c:forEach>
				<p>			
			  </c:if>	
				${tdto.content}</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<a id="aa" href="list.jsp"> 목록 </a>
				<c:if test="${userid == tdto.userid}" > <!--본인 글일 경우 -->
					<a id="aa" href="update.jsp?id=${tdto.id}">수정</a>
					<a id="aa" href="delete.jsp?id=${tdto.id}">삭제</a>
				</c:if>
				</td>
			</tr>
		</table>
	</div>
<c:import url="../bottom.jsp" />
<%
	tdao.close();
%>


















