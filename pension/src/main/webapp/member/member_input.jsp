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
	#section th{
		text-align:left;
	}
	input[type=submit],input[type=button]{
		color: white;
		background: #FFB366;
		border:0px;		
		border-radius:4px;
		margin-top:15px;
		font-size:15px;
		width:130px;
		height:30px;
	}
	input[type=text],input[type=password]
	{
		border: none;
		background: #f1f1f1;
		width: 200px;
		height:30px;
		margin-top:6px;
	}
	#err, #perr{
		font-size:12px;
	}
</style>
<script>

	var uchk=0; // 아이디의 중복체크 여부를 확인하는 변수. 0이면 확인 X, 1이면 확인 O.
	function userid_check(userid)
	{
		if(userid.trim()=="")
		{
			alert("아이디를 입력하세요");
			uchk=0; // 사용가능한 아이디인 상태에서 아이디 지웠을 때
			document.getElementById("err").innerText="";
		}
		else
		{
			var chk=new XMLHttpRequest();
			chk.open("get","userid_check.jsp?userid="+userid);
			chk.send();
			
			chk.onreadystatechange=function()
			{
				if(chk.readyState==4)
				{  // 사용가능하면 0, 사용불가능은 1
					if(chk.responseText.trim()=="0")
					{
						document.getElementById("err").innerText=" * 사용 가능한 아이디";
						document.getElementById("err").style.color="blue";
						uchk=1;
					}
					else
					{
						document.getElementById("err").innerText=" * 사용 불가능한 아이디";
						document.getElementById("err").style.color="red";
						uchk=0;
					}
				}
			}
		}
		
	}
	var pchk=0; // 나중에 가입하기 눌렀을때 또 체크하지 않기 위해 변수만들기. 비밀번호의 동일여부 확인 변수.
	function pwd_check(pwd2)
	{
		var pwd=document.pkc.pwd.value;
		
		if(pwd==pwd2)
		{
			document.getElementById("perr").innerText="비밀번호가 일치합니다";
			document.getElementById("perr").style.color="blue";
			pchk=1;
		}
		else
		{
			document.getElementById("perr").innerText="비밀번호가 일치하지 않습니다";
			document.getElementById("perr").style.color="red";
			pchk=0;
		}
	}
	function check(my)
	{
		// 아이디, 비번, 이름, 전화번호
		if(uchk==0)
		{
			alert("아이디 중복체크를 하세요");
			return false;
		}
		else if(pchk==0)
		{
			alert("비밀번호 체크를 하세요");
			return false;
		}
		else if(my.name.value.trim()=="")
		{
			alert("이름을 입력하세요")
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
<!-- 
	1. 회원 아이디 조회
	2. 비밀번호의 일치여부
	3. 필수 입력 (아이디,이름,전화번호)
 -->
	<div id="section">
	<form name="pkc" method="post" action="member_input_ok.jsp" onsubmit="return check(this)">
		<table width="500" align="center">
			<caption><h2>회원 가입</h2></caption>
			<tr>
				<th> 아이디 </th>
				<td> <input type="text" name="userid" onblur="userid_check(this.value)"><br>
				<span id="err"></span></td>
			</tr>
			<tr>
				<th> 이 름 </th>
				<td> <input type="text" name="name"> </td>
			</tr>
			<tr>
				<th> 비밀번호 </th>
				<td> <input type="password" name="pwd"> </td>
			</tr>
			<tr>
				<th> 비밀번호확인 </th>
				<td> <input type="password" name="pwd2" onkeyup="pwd_check(this.value)"><br>
				<span id="perr"></span></td> 
			</tr>
			<tr>
				<th> 이메일 </th>
				<td> <input type="text" name="email"> </td>
			</tr>
			<tr>
				<th> 전화번호 </th>
				<td> <input type="text" name="phone"> </td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="가입"></a>
					<a href="../main/index.jsp"><input type="button" value="취소"></a>
				</td>
			</tr>
		</table>
	</form>
	</div>
<c:import url="../bottom.jsp"/>