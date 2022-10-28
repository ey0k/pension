<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AAA펜션</title>
<style>
	body{
		margin:0px;
	/* 	background: #FFFCFC; */
	}
	#footer {
		margin-top:auto;
	}
	#first{
		width:1100px;
		height:33px;
		margin:auto;
		background: #FFCC66;
		text-align:center;
		color:white;
		padding-top:7px;
	}
	#second{
		width:1100px;
		height:60px;
		margin:auto;
	}
	#second img{
		width: 180px;
		height: 50px;
	}
	#second > #left {
		width:200px;
		height:60px;
	}
	#second > #right {
		width:890px;
		height:60px;
	}
	#second > #left, #second > #right{ /* 2층 왼오를 한줄로 합치기 */
		display:inline-block;
	}
	#second > #right > ul > li{ /* 2층 main 아래에 있는 리스트를 한줄로 */
		list-style-type:none;
		display:inline-block;
		width:140px;
	}
	#second > #right > ul > li:last-child{ /* 마지막 li태그의 길이는 크게 */
		width:200px;
		font-size:12px;
		text-align:right;
	}
	#second #right #main{ /* 주메뉴 */
		position: relative;
		font-weight: 900;
		color: #FFB366;
		margin-top:10px;
	}
	#second #right #main .sub{ /* 부메뉴 ul태그 */
		position: absolute; /* 부메뉴의 기준점을 주메뉴로 하기 위해 */
		padding-left:0;
		visibility:hidden;
		background: #FFFAF2;
		opacity: 80%;
		padding:4px;
		font-wieght:1;
		color: black;
	}
	#second #right #main .sub li{
		list-style-type:none;
		height: 25px;
	}
	a{
		text-decoration:none;
		color: black;
	}
	a:hover{
		color: #FFB366;
	}
	#third{
		width:1100px;
		height:400px;
		margin:auto;
	}
	#fourth{
		width:1100px;
		height:130px;
		margin:auto;
	}
	#fourth > div{
		width:360px;
		height:130px;
		border: none;
		display: inline-block;
		font-size: 13px;
		background: #FFFCFC;
	}
	#fifth{
		width:1100px;
		height:150px;
		margin:auto;
	}
	#fifth div{
		width:212px;
		height:150px;
		border:1px solid red;
		display:inline-block;
	}
	#sixth{
		width:1100px;
		margin:auto;
		background: #4A4B52;
		color:white;
		font-size:12px;
		margin-top:30px;
	}	
	body{
		display: flex;
		flex-direction: column; /* 아이템들의 배치방법 */
		min-height: 100vh; /* 최소길이가 100 view height  */
	}
	/* .navbar{
		border-bottom: 1px solid #BDBDBD;
	} */
</style>
<script src="../etc/pension.js"></script>
<script>
	function view(n)
	{
		document.getElementsByClassName("sub")[n].style.visibility="visible";
	}
	function hide(n)
	{
		document.getElementsByClassName("sub")[n].style.visibility="hidden";
	}
</script>
</head>
<body> <!-- index.jsp -->
<nav class="navbar navbar-expand-sm bg-light navbar-light fixed-top">
	<div id="first"> 펜션 오픈 기념 10박하면 1박 무료 !!! <span id="aa">Ⅹ</span></div>
	<div id="second">
		<div id="left"><a href="../main/index.jsp"> <img src="../img/logo.png"></a></div>
		<div id="right">
			<ul>
				<li id="main" onmouseover="view(0)" onmouseout="hide(0)"> 펜션소개 
					<ul class="sub">
						<li> <a href="../sogae/intro.jsp"> 인사말 </a></li>
						<li> 객실소개 </li>
						<li> 오시는길 </li>
					</ul>
				</li>
				<li id="main" onmouseover="view(1)" onmouseout="hide(1)"> 여행정보 
					<ul class="sub">
						<li> 신비의도로 </li>
						<li> 새별오름 </li>
						<li> 이호해수욕장 </li>
						<li> 헬로키티아일랜드 </li>
					</ul>
				</li>
				<li id="main" onmouseover="view(2)" onmouseout="hide(2)"> 예약관련 
					<ul class="sub">
						<li> 예약안내 </li>
						<li><a href="../reserve/reserve.jsp"> 예약하기 </a></li>
					</ul>
				</li>
				<li id="main" onmouseover="view(3)" onmouseout="hide(3)"> 커뮤니티 
					<ul class="sub">
						<li><a href="../gongji/list.jsp"> 공지사항 </a></li>
						<li><a href="../tour/list.jsp"> 여행후기 </a></li>
						<li><a href="../board/list.jsp"> 자유게시판 </a></li>
					</ul>
				</li>
				<li>
				<!-- 로그인을 하지 않은 경우 -->
				<c:if test="${userid == null}">
					<a href="../member/login.jsp">로그인</a>
					<a href="../member/member_input.jsp">회원가입</a>
				</c:if>
				
				<!-- 로그인을 한 경우 -->
				<c:if test="${userid != null}">
					${name}님 					
					<c:if test="${userid != 'admin'}">
						<a href="../member/member_info.jsp">회원정보</a>
						<a href="../reserve/reserve_view.jsp?ck=1"> 나의예약 </a>
					</c:if>
					<c:if test="${userid == 'admin'}">
						<div id="admin" onmouseover="admin_view()" onmouseout="admin_hide()"> 관리자 메뉴
							<ul id="sub">
								<li><a href="../admin/room_view.jsp">객실관리</a></li>
								<li><a href="../admin/reserve_check.jsp">예약관리</a></li>
								<li><a href="../admin/member_check.jsp">회원관리</a></li>
							</ul>
						</div>
					</c:if> 
					<a href="../member/logout.jsp">로그아웃</a>
				</c:if>
				</li>
			</ul>
			<style>
				#second #admin{
					display: inline-block;
					position: relative;
				}
				#second #admin #sub{
					position: absolute;
					padding-left: 0px;
					background: white;
					padding: 8px;
					opacity: 80%;
					visibility: hidden;
				}
				#second #admin #sub li{
					list-style-type: none;
					height: 25px;
				}
			</style>
			<script>
				function admin_view(n)
				{
					document.querySelector("#second #admin #sub").style.visibility="visible";
					// querySelector는 css의 선택자를 사용할 수 있다. 위에 sub클래스가 있어서 충돌을 피하기 위해 사용.
					// querySelectorAll() 이거는 아이디 sub가 여러개일 때 전부다 접근 가능.
				}
				function admin_hide(n)
				{
					document.querySelector("#second #admin #sub").style.visibility="hidden";
				}
			</script>
		</div>
</nav>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		