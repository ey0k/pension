<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dao.BoardDao" %>
<%
	BoardDao bdao=new BoardDao();
	bdao.content(request);
%>
<!-- 자유게시판 content -->
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
		/* border: 1px solid #FFF0DF; */
		border-collapse: collapse;
		width: 60%;
	}
	#section #aa{
		color: #FFB366;
		font-weight: 900;
	}
	#section tr td{
		padding:10px;
		padding-left: 10px;
	}
	#bb{
		height:60px;
	}
	#section #bd {
		border-bottom: 1px solid #FFB366;
	}
	#del{
		display: none;
	}
	#title{
		font-weight: 800;
	}
	#wd{
		font-size: 14px;
		color: grey;
	}
</style>
	<div id="section">
		<table>
			<caption><h2>자 유 게 시 판</h2></caption>
			<tr>
				<td id="title" colspan="3">${bdto.title}</td>
			</tr>
			<tr id="bd">
				<td width="70%">${bdto.userid}</td>
				<td width="14%" id="wd"> 조회 ${bdto.readnum}</td>
				<td id="wd">${bdto.writeday}</td>
			</tr>
			<tr height="300">
				<td colspan="3">${bdto.content}</td>
			</tr>
			<tr id="bb">
				<td colspan="4" align="center">
					<a id="aa" href="list.jsp">목록</a>
			<!-- 
				보이는 경우
				- board테이블의 userid값이 guest인 경우
				- board테이블의 userid와 세션의 userid가 같은 경우
				
				안보이는 경우
				- board테이블의 userid값이 guest가 아니고 
				- board테이블의 userid와 세션의 userid가 다른 경우
			 -->
			 
			<!-- 보이는 경우 -->
			  <c:if test="${userid == 'admin'}">
			 	 <a id="aa" href="delete.jsp?id=${bdto.id}">삭제</a> 
			 	 <a id="aa" href="update.jsp?id=${bdto.id}">수정</a>
			  </c:if>		 
			  <c:if test="${(bdto.userid == 'guest') && (userid != 'admin') }">
				<a id="aa" href="javascript:del_form()">삭제</a> <!-- guest일 경우 삭제 입력폼이 존재 -->
				<a id="aa" href="update.jsp?id=${bdto.id}">수정</a>
			  </c:if>
			  <c:if test="${bdto.userid == userid && (userid != 'admin')}"> <!-- 로그인을 한 경우 = 자신이 작성한 글-->
				<a id="aa" href="delete.jsp?id=${bdto.id}">삭제</a> 
				<a id="aa" href="update.jsp?id=${bdto.id}">수정</a>
			  </c:if>
		
		<%-- 	
			<c:if test="${( !(bdto.userid == 'guest') || (bdto.userid == userid)) }">
				테스트. 전체조건 not 걸기. !()
			</c:if>
		--%>
			</td>
			</tr>
			<tr id="del"> <!-- 삭제 비밀번호를 입력할 폼 -->
				<td colspan="4" align="center">
					<form method="post" action="delete.jsp">
						<input type="hidden" name="id" value="${bdto.id}">
						<input type="password" name="pwd">
						<input type="submit" value="삭제하기">
					</form>
				</td>
			</tr>
		</table>
		<script>
			function del_form()
			{
				// 삭제폼을 보이게 한다.. 
				document.getElementById("del").style.display="table-row";
			}
		</script>
	</div>
<c:import url="../bottom.jsp" />

<%
	bdao.close();
%>


















