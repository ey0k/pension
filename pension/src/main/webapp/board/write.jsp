<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 자유게시판 write -->
<c:import url="../top.jsp" />
<style>
	#section {
		width: 1100px;
		margin: auto;
		margin-top:0px;
	}
	#section table{
		margin-top:0px;
		margin:auto;
		/* border:1px solid #FFF0DF; */
		width:60%;
	}
	/* #section tr td{
		padding:4px;
	} */
	#section th{
		height:35px;
	}
	input[type=submit],input[type=button]{
		color: white;
		background: #FFB366;
		width: 70px;
		height: 30px;
		border: none;
		margin-top: 18px;
	}
	input[type=text]{
		border: 2px solid #FFF0DF;
		height: 20px;
	}
	input[type=password]{
		border: 2px solid #FFF0DF;
		height: 20px;
	}
	textarea{
		border: 2px solid #FFF0DF;
	}
</style>
	<div id="section">
	<form name="pkc" method="post" action="write_ok.jsp">
		<table>
		<caption><h2>게 시 글 쓰 기</h2></caption>
			<tr>
				<th width="18%"> 제 목 </th>
				<td> <input type="text" name="title" size="60%"> </td>
			</tr>
		<c:if test="${userid == null}">
			<tr>
				<th width="22%"> 비밀번호 </th>
				<td> <input type="password" name="pwd" size="10%"> </td>
			</tr>
		</c:if>
			<tr>
				<th> 내 용 </th>
				<td> <textarea cols="62%" rows="10" name="content"></textarea> </td>
			</tr>
			<tr>
				<td colspan="2" align="center"> 
				<input type="submit" value="글쓰기">
				<a href="../board/list.jsp"><input type="button" value="취소"></a> </td>
			</tr>
		</table>
		</form>
	</div>
<c:import url="../bottom.jsp" />













