<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="../top.jsp" />
<style>
	#section {
		width: 1100px;
		height: 500px;
		margin: auto;
	}
	#section table{
		margin-top:60px;
		margin:auto;
		border:1px solid #FFF0DF;
	}
	#section tr td{
		padding:4px;
	}
	#section th{
		height:35px;
	}
	input[type=submit],input[type=button]{
		color: white;
		background: #FFB366;
		width: 70px;
		height: 30px;
		border: none;
	}
	input[type=text]{
		border: 1px solid #FFF0DF;
		width: 290px;
		height: 20px;
	}
	input[type=password]{
		border: 1px solid #FFF0DF;
		width: 100px;
		height: 20px;
	}
	textarea{
		border: 1px solid #FFF0DF;
	}
</style>
	<div id="section">
	  <form method="post" action="write_ok.jsp" enctype="multipart/form-data">
		<table>
		<caption><h2>여행후기</h2></caption>
			<tr>
				<td> 제 목 </td>
				<td> <input type="text" name="title" size="40"></td>
			</tr>
			<tr>
				<td> 내 용 </td>
				<td> <textarea cols="40" rows="6" name="content"></textarea></td>
			</tr>
			<tr>
				<td> 파 일 </td>
				<td> <input type="file" name="fname"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="submit" value="저장">
				<input type="button" value="취소">
			</tr>
		</table>
	  </form>
	</div>
<c:import url="../bottom.jsp" />