<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dao.ReserveDao" %>
<%
	ReserveDao rdao=new ReserveDao();
	// 달력 => 1일의 요일, 총일수, 몇주 => dao에서 가져올것
	rdao.getCalendar(request);
	rdao.getRoom(request);
%>
<c:import url="../top.jsp" />
<style>
	#section {
		width: 1100px;
		margin: auto;
		margin-top: 0px;
	}
	#section table{
		width: 80%;
		margin-top: 0px;
		margin: auto;
		text-align:center;
		border: 1px solid #FFB366; 
		border-collapse:collapse;
	}
	#section #trr{
		height: 120px; 
	}
	#section th{
		background: #FFF0DF;
		width: 14.28%;
	}
	#bn{
		font-size:13px;
	}
</style>
	<div id="section">
		<table border="1">
		<caption><h2>예 약</h2></caption>
		<caption><h3>
		<%-- <c:if test="${prev==1}"> --%>
			<a href="reserve.jsp?y=${y-1}&m=${m}">◀</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<c:if test="${m == 1}"> <!-- 1월이면 -->
				<a href="reserve.jsp?y=${y-1}&m=12">◁</a>&nbsp;&nbsp;&nbsp;&nbsp;
			</c:if>
			<c:if test="${m != 1}"> <!-- 1월이 아니면 -->
				<a href="reserve.jsp?y=${y}&m=${m-1}">◁</a>&nbsp;&nbsp;&nbsp;&nbsp;
			</c:if>
		<%-- </c:if> --%>
			${y}년 ${m}월
			<c:if test="${m == 12}"> <!-- 12월이면 -->
				&nbsp;&nbsp;&nbsp;&nbsp;<a href="reserve.jsp?y=${y+1}&m=1">▷</a>
			</c:if>
			<c:if test="${m != 12}"> <!-- 12월이 아니면 -->
				&nbsp;&nbsp;&nbsp;&nbsp;<a href="reserve.jsp?y=${y}&m=${m+1}">▷</a>
			</c:if>
				&nbsp;&nbsp;&nbsp;&nbsp;<a href="reserve.jsp?y=${y+1}&m=${m}">▶</a>
		</h3></caption>
			<tr>
				<th> 일 </th>
				<th> 월 </th>
				<th> 화 </th>
				<th> 수 </th>
				<th> 목 </th>
				<th> 금 </th>
				<th> 토 </th>
			</tr>
		<c:set var="day" value="1"/>
		<c:forEach var="i" begin="1" end="6">  <!-- 행 -->
		  	<tr id="trr">
		  		<c:forEach var="j" begin="0" end="6">  <!-- 열 -->
		  	<!-- yoil은 1일이니까 7월의경우 금욜(5일이고) j가 일~목일땐 0~4이므로 5보다 작아서 빈칸 -->
		  	<!-- 또는 총 일수가 증가값(day)보다 작을때 빈칸-->	
		  			<c:if test="${(j < yoil && i==1) || (chong < day)}"> 
		  				<td> &nbsp; </td>
		  			</c:if>
		  	<!-- j가 1일의 요일보다 크고 첫주일때, 또한 총 일수가 증가값보다 같거나 작을때 날짜 출력 -->
		  			<c:if test="${( (j >= yoil && i==1) || i>1) && (chong >=day)}">
		  				<c:if test="${j != 0 && j != 6 }">
		  				<td> ${day} <p>
		  				</c:if>
		  				<c:if test="${j == 0 }">
		  					<td style='color:red'> ${day}<p>
		  				</c:if>
		  				<c:if test="${j == 6 }">
		  					<td style='color:blue'> ${day}<p>
		  				</c:if>
		  				<!-- 방의 이름을 출력 -->
		  			<!-- td에 출력되는 날짜가 오늘보다 이전이면 안보이게 -->
		  			<%
		  				// 년,월은 request영역, 일은 pageContext영역 => 스크립트릿변수로 변경해야함
	  					// getAttribute는 object니까 toString으로 문자열로 바꾸기
	  					String y=request.getAttribute("y").toString();
	  					String m=request.getAttribute("m").toString();
	  					String d=pageContext.getAttribute("day").toString();
	  					String dday=y+"-"+m+"-"+d;  // YYYY-MM-DD
			  			
			  			rdao.getcheck(y,m,d,request);
		  			%>
		  			<c:if test="${tt == 1}">	
			  			<c:forEach items="${rlist}" var="rdto"><span id="bn">
			  				<!-- 방의 예약 여부를 확인 => Dao메소드의 (년,월,일,방id) -->
			  				<c:set var="bang_id" value="${rdto.id}"/> <!-- 방마다 변경되게 하기위해 변수설정 -->
			  				<%
			  					String bang_id=pageContext.getAttribute("bang_id").toString();
			  					rdao.getEmpty(dday,bang_id,request);
			  				%>
			  				<!-- request영역의 cnt변수 값이 1이면 예약불가, 0이면 예약가능 -->
			  				<c:if test="${cnt == 1 }">
			  					<span style="color:red; text-decoration:line-through">${rdto.bang}</span><br>
			  				</c:if>
			  				<c:if test="${cnt == 0 }">
			  					<a href="reserve_next.jsp?y=${y}&m=${m}&d=${day}&id=${rdto.id}">${rdto.bang}</a><br>
			  				</c:if>
			  			</span></c:forEach> <!-- 방 목록 출력하는 for문 -->
			  		</c:if> 
		  				</td>
		  				<c:set var="day" value="${day+1}"/>  <!-- 날짜값을 1씩 증가 -->
		  			</c:if>
		  		</c:forEach>
			</tr>
		</c:forEach>
		</table>
	</div>
<%
	rdao.close();
%>
<c:import url="../bottom.jsp" />






