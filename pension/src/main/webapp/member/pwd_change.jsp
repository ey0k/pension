<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="../top.jsp"/>

<style>
	#section{
		width:1100px;
		height:500px;
		margin:auto;
		text-align: center;
	}
	#section form{
		margin-top:100px;
	}
	input[type=submit],input[type=button]{
		color: white;
		background: #FFB366;
		border:0px;		
		border-radius:4px;
		margin: 4px 2px;
		font-size:15px;
		width:120px;
		height:30px;
		cursor:pointer;
	}
	input[type=password]{
		display: inline-block;
		border: none;
		background: #f1f1f1;
		width: 200px;
		height:30px;
	}
</style>
<script>
	var pchk=0;
	function pwd_check(pwd2)
	{
		var pwd=document.pkc.pwd.value;
		
		if(pwd==pwd2)
		{
			document.getElementById("per").innerText="비밀번호가 일치";
			document.getElementById("per").style.color="blue";
		}
		else
		{
			document.getElementById("per").innerText="비밀번호가 불일치";
			document.getElementById("per").style.color="red";
		}
	}
</script>
<div id="section">
	<form name="pkc" method="post" action="pwd_change_ok.jsp">
		<%
			if(request.getParameter("chk") != null)
			{
		%>
			<div style="color:red;font-size:12px">기존 비밀번호가 틀립니다</div><p>
		<%
			}
		%>
		<input type="password" name="old_pwd" placeholder="기존 비밀번호"> <p>
		<input type="password" name="pwd" placeholder="새 비밀번호"> <p>
		<input type="password" name="pwd2" onkeyup="pwd_check(this.value)" placeholder="비밀번호 확인"><p> 
		<span id="per" style="font-size:12px;"></span><p>
		<input type="submit" value="비밀번호 변경">
		<a href="../member/member_info.jsp"><input type="button" value="취소"></a>
	</form>
</div>	
<c:import url="../bottom.jsp"/>



















