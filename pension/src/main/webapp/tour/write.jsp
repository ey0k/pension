<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="../top.jsp" />
<!-- 여행후기 write -->
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
		width: 34px;
		height: 20px;
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
</script>
	<div id="section">
	  <form method="post" action="write_ok.jsp" enctype="multipart/form-data">
		<table>
		<caption><h2>여행후기</h2></caption>
			<tr>
				<th width="18%"> 제 목 </th>
				<td> <input type="text" name="title" size="60%" ></td>
			</tr>
			<tr>
				<th> 내 용 </th>
				<td> <textarea cols="62%" rows="10" name="content"></textarea></td>
			</tr>
			<tr>
				<th> 파 일 </th>
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
				<input type="submit" value="저장">
				<a href="list.jsp"><input type="button" value="취소"></a>
			</tr>
		</table>
	  </form>
	</div>
<c:import url="../bottom.jsp" />