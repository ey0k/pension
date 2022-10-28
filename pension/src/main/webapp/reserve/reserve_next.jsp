<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>   
<%@ page import="dao.ReserveDao" %>
<%
	ReserveDao rdao=new ReserveDao();
	rdao.reserve_next(request);
%>

<%
	// 몇박인지 알려주는 getSuk()메소드를 호출
	// 년,월,일,방id가 필요
	// request영역에 위의 값들이 있으므로 가져오기
	rdao.getSuk(request);
%>
<c:import url="../top.jsp" />
<style>
	#section {
		width: 1100px;
		margin: auto;
		margin-top: 0px;
	}
	#section table{
		width: 60%;
		margin-top: 0px;
		margin: auto;
		text-align: left;
	/* 	border: 1px solid #FFB366; */   
		border-collapse:collapse; 
	}
	/* #section table tr{
		height: 40px;
	} */
	#section table tr td{
		padding: 10px;
	}
	#tott{
		border-top: 2px solid #FFB366;
	}
	#section th{
		text-align: center;
	}
	select{
		border: 1px solid #FFB366;
		background: #FFFCFC;
	}
	#rn{
		color: #FFB366;
		font-size: 25px;
		font-weight:300;
	}
	#section input[type=submit]
	{
		width:208px;
		height:40px;
		color: #FFB366;
		background: white;
		border: 1px solid #FFB366;   
	}
	#section input[type=submit]:hover
	{
		background: #FFB366;
		color: white;
	}
</style>
<script>
	function total_price() // 총가격 구하는 함수
	{
		// 숙박, 인원, 숯, bbq의 선택값을 가져와서 각각의 금액을 구한다..
		// 숙박
		var ss=document.reser.suk.value;
		var ssprice=ss*${rdto.price};
		document.getElementById("suk").innerText=new Intl.NumberFormat().format(ssprice);
		
		// 인원
		var ii=document.reser.inwon.value;
		ii=ii-${rdto.min} // 총 인원수 - 기준인원(min 인원)해서 EPF 들어갈거 계산
		var iiprice=ii*20000;
		document.getElementById("inwon").innerText=new Intl.NumberFormat().format(iiprice);
		
		// 숯
		var cc=document.reser.charcoal.value;
		var ccprice=cc*20000;
		document.getElementById("charcoal").innerText=new Intl.NumberFormat().format(ccprice);
		
		// bbq
		var bb=document.reser.bbq.value;
		var bbprice=bb*50000;
		document.getElementById("bbq").innerText=new Intl.NumberFormat().format(bbprice);
		
		// total
		var tt=ssprice+iiprice+ccprice+bbprice;
		document.getElementById("total").innerText=new Intl.NumberFormat().format(tt);
		
		// form태그내에 총금액을 전달
		document.reser.total.value=tt;
	}
</script>
	<div id="section">
	<!-- <body onload="total_price()"> -->
	<!-- <input type="button" onclick="total_price()" value="계산"> -->
	<form name="reser" method="post" action="reserve_ok.jsp">
		<!-- inday,bang_id,total은 값이 아니고 화면에 프린트만 되므로 히든으로 가져가야함 -->
		<input type="hidden" name="inday" value="${ymd}">
		<input type="hidden" name="bang_id" value="${rdto.id}">
		<input type="hidden" name="total" value="${rdto.price}">
		<table>
		<caption><h3>예 약 하 기</h3>
			<span id="rn">${rdto.bang}</span><p>
		</caption>
			<tr> 
				<th> 체크인 </th>
				<td> ${ymd} </td>
				<th> 숙박 일수 </th>
				<td> 
				  <select name="suk" onchange="total_price()">
					<c:forEach begin="1" end="${chk}" var="i">
						<option value="${i}"> ${i}박 </option>
					</c:forEach>
			      </select>
			    </td>
			</tr>
			<tr>
				<th> 기준 인원 </th>
				<td> (${rdto.min}/${rdto.max}) </td>
				<th> 투숙 인원 </th>
				<td> 
				  <select name="inwon" onchange="total_price()">
				  	<c:forEach begin="${rdto.min}" end="${rdto.max}" var="i">
				  		<option value="${i}"> ${i}명</option>
				  	</c:forEach>
				  </select>
				</td>
			</tr>
			<tr>
				<th> 숯패키지 </th>
				<td> 
				  <select name="charcoal" onchange="total_price()">
				  	<option value="0"> 선택안함 </option>
				  	<option value="1"> 1개 </option>
				  	<option value="2"> 2개 </option>
				  	<option value="3"> 3개 </option>
				  	<option value="4"> 4개 </option>
				  	<option value="5"> 5개 </option>
				  </select>
				</td>
				<th> BBQ(삼겹살 및 재료) </th>
				<td> 
				  <select name="bbq" onchange="total_price()">
				  	<option value="0"> 선택안함 </option>
				  	<option value="1"> 1개 </option>
				  	<option value="2"> 2개 </option>
				  	<option value="3"> 3개 </option>
				  	<option value="4"> 4개 </option>
				  	<option value="5"> 5개 </option>
				  </select>
				</td>
			</tr>
			<tr>
				<th> 숙박 가격 </th>
				<td colspan="3"><span id="suk"><fmt:formatNumber value="${rdto.price}" type="number"/></span>원</td>
			</tr>
			<tr>
				<th> 인원 추가 </th>
				<td colspan="3"><span id="inwon">0</span>원</td>
			</tr>
			<tr>
				<th> 숯 패키지 </th>
				<td colspan="3"><span id="charcoal">0</span>원</td>
			</tr>
			<tr>
				<th> bbq 재료 </th>
				<td colspan="3"><span id="bbq">0</span>원</td>
			</tr>
			<tr id="tott">
				<th> 총 가격 </th>
				<td colspan="3"><span id="total"><fmt:formatNumber value="${rdto.price}" type="number"/></span>원</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<input type="submit" value="예약하기">
				</td>
			</tr>
		</table>
	</form>
	</div>
<%
	rdao.close();
%>
<c:import url="../bottom.jsp" />

