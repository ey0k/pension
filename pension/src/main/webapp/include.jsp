<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script>
		$(function()
		{
			$("#pkc").load("imsi.jsp");
		});
	</script>
</head>
<body> <!-- include.jsp -->
	<!-- 현재 문서에 다른 문서의 내용을 포함시키는 방법 -->
	<%@ include file="imsi.jsp" %>
	<hr>
	<c:import url="imsi.jsp"/>
	<hr>
	<jsp:include page="imsi.jsp"></jsp:include>
	<hr>
	<div id="pkc"></div>
</body>
</html>