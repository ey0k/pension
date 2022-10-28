<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import ="dao.MemberDao" %>
<%
	MemberDao mdao=new MemberDao();
	mdao.member_update(request, session);
%>
<c:import url="../top.jsp"/>
<style>
	#section{
		width:1100px;
		height:500px;
		margin:auto;
	}
	#section table{
		margin-top:80px;
	}
	#section tr td{
		padding: 10px;
	}
	input[type=submit],input[type=button]{
		color: white;
		background: #FFB366;
		border:0px;		
		border-radius:4px;
		font-size:15px;
		width:130px;
		height:30px;
		cursor:pointer;
	}
	input[type=text]
	{
		border: 1px solid #ddd;
		width: 200px;
		height:30px;
	}
</style>
<script>
	function check(my)
	{
		// 이름, 전화번호
		if(my.email.value.trim()=="")
		{
			alert("이메일을 입력하세요")
			return false;
		}
		else if(my.phone.value.trim()=="")
		{
			alert("전화번호를 입력하세요")
			return false;
		}
		else
			return true;
	}
</script>
	<div id="section">
	<form name="pkc" method="post" action="member_update_ok.jsp" onsubmit="return check(this)">
		<table width="500" align="center">
			<tr>
				<th> 아이디 </th>
				<td> ${mdto.userid}</td>
			</tr>
			<tr>
				<th> 이 름 </th>
				<td> ${mdto.name}</td>
			</tr>
			<tr>
				<th> 이메일 </th>
				<td> <input type="text" name="email" value="${mdto.email}"> </td>
			</tr>
			<tr>
				<th> 전화번호 </th>
				<td> <input type="text" name="phone" value="${mdto.phone}"> </td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="수정">
					<a href="../member/member_info.jsp"><input type="button" value="취소"></a>
				</td>
			</tr>
		</table>
	</form>
	</div>
<c:import url="../bottom.jsp"/>