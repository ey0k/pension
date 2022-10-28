<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dao.TourDao" %>
<%
	TourDao tdao=new TourDao();
	tdao.update(request);
%>
<c:import url="../top.jsp" />
<!-- 여행후기 update -->
<style>
	#section {
		width: 1100px;
		margin: auto;
		margin-top: 0px;
	}
	#section table{
		margin-top:0px;
		margin:auto;
		/* border:1px solid #FFF0DF; */
		width: 60%;
		text-align: left;
	}
	#section tr td{
		padding:4px;
	}
	#section th{
		height:35px;
		text-align: left;
	}
	input[type=submit],input[type=button]{
		color: white;
		background: #FFB366;
		width: 70px;
		height: 30px;
		border: none;
	}
	#section #ff {
		background: #FFB366;
		width: 36px;
		height: 22px;
		border: none;
		color: white;
	}
	input[type=text]{
		border: 2px solid #FFF0DF;
		height: 20px;
	}
	textarea{
		border: 2px solid #FFF0DF;
	} 
	#ck{
		font-size: 13px;
	}
</style>
<script>
	var size=1; // id="outer" 안에 있는 type='file'의 갯수, name을 서로 다르게 하기 위해 사용
	function add_file()
	{	
		size++;
		var outer=document.getElementById("outer");
		var inner="<p class='fname'> <input type='file' name='fname"+size+"'> </p>";
		outer.innerHTML=outer.innerHTML+inner;
	}
	function del_file()
	{	
		if(size>1)
		{
			document.getElementsByClassName("fname")[size-1].remove();
			size--;
		}
	}
	function del_add(n,my)
	{
		if(my.checked)
			document.getElementsByClassName("cimg")[n].style.opacity="0.3";
		else
			document.getElementsByClassName("cimg")[n].style.opacity="1";
	}
	function check(upform)
	{
		// checkbox가 체크된 그림파일명과 체크가 안된 그림파일명을 각각 저장
		var chk=document.getElementsByName("chk"); // 요소의 이름을 변수에 전달. 한개만 있어도 가능하게 name썻음. 
		var len=chk.length;// 체크박스의 길이
		var del=""; // 삭제할 파일을 저장
		var str=""; // 삭제하지 않을 파일을 저장
		for(i=0;i<len;i++)
		{
			if(chk[i].checked) // 참 => 삭제할 파일
			{
				del=del+chk[i].value+",";
			}
			else // 거짓 => 삭제하지 않겠다 => 그림파일 저장필요
			{
				str=str+chk[i].value+",";
			}
		}	
		upform.del.value=del; // 삭제파일 목록
		upform.str.value=str; // 보존파일 목록
		//alert(del);
		//alert(str);
		return true;
	}
</script>
	<div id="section">
	  <form method="post" onsubmit="return check(this)" action="update_ok.jsp" enctype="multipart/form-data">
	  <input type="hidden" name="id"  value="${tdto.id}">
	  <input type="hidden" name="del">
	  <input type="hidden" name="str">
		<table>
		<caption><h2>여행후기</h2></caption>
			<tr>
				<th width="18%"> 제 목 </th>
				<td> <input type="text" name="title" size="60%" value="${tdto.title}"></td>
			</tr>
			<tr>
				<th> 내 용 </th>
				<td> <textarea cols="62%" rows="10" name="content">${tdto.content}</textarea></td>
			</tr>
			<tr>
				<th> 사 진 </th>
				<td>
				<span style="color:red;font-size:12px;">삭제하려면 체크하세요</span><p>
				<c:set var="t" value="0"/>
				  <c:forEach items="${tdto.file}" var="img">
				  	<img src="img/${img}" width="50" height="50" class="cimg">
				  	<input type="checkbox" onclick="del_add(${t},this)" name="chk" value="${img}">
				  	<c:set var="t" value="${t+1}"/>
				  </c:forEach> <p>
				</td>
			</tr>
			<tr>
				<th>  </th>
				<td id="outer" align="left">
				<input id="ff" type="button" onclick="add_file()" value="추가"> 
				<input id="ff" type="button" onclick="del_file()" value="삭제"> 
					<p class="fname"> <input type="file" name="fname1"> </p> 
				</td>
			</tr>
			<c:if test="${userid=='admin'}">
			<tr>
				<td></td>
				<td id="ck">
				<input type="checkbox" name="gubun" value="1">
				이 글을 항상 첫페이지에 출력하고자 하면 체크하세요
				</td>
			</tr>
			</c:if>
			<tr>
				<td colspan="2" align="center">
				<input type="submit" value="수정">
				<a href="list.jsp"><input type="button" value="취소"></a>
			</tr>
		</table>
	  </form>
	</div>
<c:import url="../bottom.jsp" />
<%
	tdao.close();
%>