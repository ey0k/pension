<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="../top.jsp"/>
<style>
	#section {
		width: 1100px;
		margin: auto;
		margin-top: 0px;
		text-align: center;
	}
	#maint{
		margin-top:100px;
		width:300px;
		height:40px;
		border:1px solid #f2f2f2;
		outline:none;
	}
	#mainp{
		width:300px;
		height:40px;
		border:1px solid #f2f2f2;
		outline:none;
	}
	#mains{
		width:308px;
		height:40px;
		color: white;
		border:none;
		background: #FFB366;
	}
	#search{
		font-size: 12px;
		color: gray;
	}
	#userid_form input[type=text]{
		width:200px;
		height:30px;
		border:1px solid #f2f2f2;
		outline:none;
	}
	#pwd_form input[type=text]{
		width:200px;
		height:30px;
		border:1px solid #f2f2f2;
		outline:none;
	}
	#ss{
		width:206px;
		height:30px;
		color: white;
		border:none;
		background: #FFB366;
	}
	#userid_form, #pwd_form{
		 display: none;
	}
	#msg_print{
		font-size: 12px;
		color: red;
	}
	hr{ color: gray; }
</style>
<script>
	function userid_func()
	{ // 아이디폼은 보이고 비밀번호폼은 숨기기
		document.getElementById("userid_form").style.display="block";
		document.getElementById("pwd_form").style.display="none";
		document.pf.userid.value="";
		document.pf.name.value="";
		document.pf.phone.value="";
		document.getElementById("msg_print").innerText="";
		
	}
	function pwd_func()
	{ // 비밀번호폼은 보이고 아이디폼은 숨기기 
		document.getElementById("pwd_form").style.display="block";
		document.getElementById("userid_form").style.display="none";
		document.uf.name.value="";
		document.uf.phone.value="";
		document.getElementById("msg_print").innerText="";
	}
</script>
	<div id="section">
		<form method="post" action="login_ok.jsp">
		  <input id="maint" type="text" name="userid" placeholder="아이디"> <p>
		  <input id="mainp" type="password" name="pwd" placeholder="비밀번호"> <p>
		  <input id="mains" type="submit" value="로그인"> <p>
		</form>
		<c:if test="${chk == 6 }">
	  		<div id="msg_print">탈퇴하거나 존재하지 않는 회원입니다.</div> <p>
			<% session.removeAttribute("chk"); %>
		</c:if>
		<c:if test="${chk == 5 }">
  			<div id="msg_print">아이디 또는 비밀번호가 일치하지 않습니다. </div> <p>
  		 	<%	session.removeAttribute("chk"); %>
	  	</c:if>	
	<hr>
	<div id="search">
		<span id="btn" onclick="userid_func()">아이디 찾기 | </span>
		<span id="btn" onclick="pwd_func()"> 비밀번호 찾기 </span>
		<br>
		<br>
	  </div>
	  <c:if test="${chk == 1 }">
	 	 <div id="msg_print">아이디는 ${imsiuser}입니다.</div> <p>
	 	 <%
	 	 	session.removeAttribute("imsiuser");
	 	 	session.removeAttribute("chk");
	 	 %>
	  </c:if>					
	  <c:if test="${chk == 2 }">
	 	 <div id="msg_print">이름, 전화번호 정보가 일치하지 않습니다.</div> <p>
	 	 <%	session.removeAttribute("chk"); %>
	  </c:if>
	  <c:if test="${chk == 3 }">
	  	<div id="msg_print">당신의 비밀번호는 ${pwd} 입니다.</div> <p>
	  	<%
	  		session.removeAttribute("pwd");
	 	 	session.removeAttribute("chk");
	 	 %>
	  </c:if>
	  <c:if test="${chk == 4 }">
	 	 <div id="msg_print">이름, 전화번호 정보가 일치하지 않습니다.</div> <p>
	 	 <% session.removeAttribute("chk");	 %>
	  </c:if>
	  <div id="userid_form"> 
		<form name="uf" method="post" action="userid_search.jsp">
		  	<input type="text" placeholder="이 름" name="name"> <p>
		  	<input type="text" placeholder="전화번호" name="phone"> <p>
		  	<input id="ss" type="submit" value="아이디찾기"> <p>
	    </form>
	  </div>
	  <div id="pwd_form"> 
		<form name="pf" method="post" action="pwd_search.jsp">
			<input type="text" placeholder="아이디" name="userid"> <p>
		  	<input type="text" placeholder="이 름" name="name"> <p>
		  	<input type="text" placeholder="전화번호" name="phone"> <p>
		  	<input id="ss" type="submit" value="비밀번호찾기"> <p>
		</form>
	  </div>
	</div>
<c:import url="../bottom.jsp"/>