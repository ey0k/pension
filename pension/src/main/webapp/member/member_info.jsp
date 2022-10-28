<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="../top.jsp"/>
<style>
	#section{
		width:1100px;
		height:500px;
		margin:auto;
	}
	#section table{
		margin-top:60px;
	}
	#section tr td{
		padding:10px;
	}
	#section th{
		text-align:left;
	}
	#section button{
		width: 120px;
		height: 30px;
		color: white;
		border-radius:4px;
		background: #FFB366;
		border:1px solid #FFB366;		
		margin: 4px 2px;
		font-size:15px;
		cursor:pointer;
	}
</style> <!-- member_info.jsp -->
<%@ page import="dao.MemberDao" %>
<%
	MemberDao mdao=new MemberDao();
	mdao.member_info(request, session);
	
	// jsp에 출력할 내용은 request객체영역에 저장을 한다..
	// EL표현식으로 접근, JSTL을 사용
%>
	<div id="section">
	<!-- 아이디, 이름, 이메일, 전화번호 보여주기 -->
		<table width="500" align="center">
			<caption><h2>회원 정보</h2></caption>
			<tr>
				<th> 아이디 </th>
				<td>${mdto.userid}</td>				
			</tr>
			<tr>
				<th> 이 름 </th>
				<td>${mdto.name}</td>
			</tr>
			<tr>
				<th> 이메일 </th>
				<td>${mdto.email}</td>
			</tr>
			<tr>
				<th> 전화번호 </th>
				<td>${mdto.phone}</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="button"><span class="btn" onclick="location='member_update.jsp'"> 정보 수정 </span></button>
					<button type="button"><span class="btn" onclick="location='pwd_change.jsp'"> 비밀번호 변경 </span></button>
					<button type="button"><span class="btn" onclick="location='member_out.jsp'"> 회원탈퇴 </span></button>
				</td>
			</tr>
		</table>
	</div>
<c:import url="../bottom.jsp"/>