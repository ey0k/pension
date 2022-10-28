<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="../top.jsp"/>
<style>
	body {
		font-family: Arial, Helvetica, sans-serif;
	}
	* {
		box-sizing: border-box
	}
	
	/* Full-width input fields */
	input[type=text], input[type=password] {
		width: 50%;
		padding: 15px;
		margin: 5px 0 22px 0;
		display: inline-block;
		border: none;
		background: #f1f1f1;
	}
	
	input[type=text]:focus, input[type=password]:focus {
		background-color: #ddd;
		outline: none;
	}
	
	hr {
		border: 1px solid #f1f1f1;
		margin-bottom: 25px;
		width: 100%;
	}
	
	/* Set a style for all buttons */
	button {
		background-color: #04AA6D;
		color: white;
		padding: 14px 20px;
		margin: 8px 0;
		border: none;
		cursor: pointer;
		width: 50%;
		opacity: 0.9;
	}
	
	button:hover {
		opacity: 1;
	}
	
	/* Extra styles for the cancel button */
	.cancelbtn {
		padding: 14px 20px;
		background-color: #f44336;
	}
	
	/* Float cancel and signup buttons and add an equal width */
	.cancelbtn, .signupbtn {
		float: center;
		width: 150px;
	}
	
	/* Add padding to container elements */
	#section {
		width: 1100px;
		margin: auto;
	}
	
	/* Clear floats */
	.clearfix::after {
		content: "";
		clear: both;
		display: table;
		text-align:center;
	}
	
	#err {
		color: red;
		font-size: 12px;
	}
</style>
<!-- 
	1. 회원 아이디 조회
	2. 비밀번호의 일치여부
	3. 필수 입력 (아이디,이름,전화번호)
 -->
  <div id="section">
    <h2>회원가입</h2>
    <p>회원가입을 위해 아래 정보를 입력하세요.</p>
    <hr>
 	<label for="userid"><b>아이디</b></label> <p>
    <input type="text" placeholder="Enter Id" name="userid" onblur="userid_check(this.value)"><span id="err"></span> <p>

    <label for="name"><b>이름</b></label> <p>
    <input type="text" placeholder="Enter name" name="name"> <p>

    <label for="pwd"><b>비밀번호</b></label> <p>
    <input type="password" placeholder="Enter Password" name="pwd"> <p>

    <label for="pwd2"><b>비밀번호 확인</b></label> <p>
    <input type="password" placeholder="Repeat Password" name="pwd2"> <p>

    <label for="email"><b>이메일</b></label> <p>
    <input type="text" placeholder="Enter Email" name="email"> <p>

    <label for="phone"><b>전화번호</b></label> <p>
    <input type="text" placeholder="Enter Phone Number" name="phone"> <p>
    
    <div class="clearfix">
      <button type="button" class="cancelbtn">Cancel</button>
      <button type="submit" class="signupbtn">Sign Up</button>
    </div>
  </div>

  
<c:import url="../bottom.jsp"/>