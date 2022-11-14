<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>돌려돌려 주사위 </title>
	<%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
	<%-- 부트스트랩 --%>
	<style>
	@keyframes opaAni{
	    to{
	        opacity: 1;
	    }
	}
	.effect{
	    opacity: 0; 
	    animation: opaAni .2s ease-in-out .5s forwards;
	}
	</style>
</head>
<%
String id = (String)session.getAttribute("memId");
if(id== null || id.equals(null) || id.equals("null")) { %>
	<script>
			alert("로그인 후 이용해주세요")
			window.location.href="/project/main/main.jsp";
	</script>
<%} %>
<% int random =(int)(Math.random() * 6)+1;  
	int random2 =(int)(Math.random() * 6)+1;  
	int random3 =(int)(Math.random() * 6)+1;  %>
<body>
<br><br>
<div align="center">
	<h3>3개의 주사위</h3>
	

	버튼을 클릭하면 3개의 주사위가 랜덤으로 돌아갑니다.<br><br>
	
	<img class=effect  style="animation-delay: .5s" src="img/sai_<%=random %>.gif" id="d1">
	<img class=effect  style="animation-delay: 1s" src="img/sai_<%=random2 %>.gif" id="d2">
	<img class=effect  style="animation-delay: 1.5s" src="img/sai_<%=random3 %>.gif" id="d3">
	
	<br><br>
	<button class=effect style="animation-delay: 2s" onclick="window.location='dice2.jsp'">주사위를 굴린다.</button>
</div>


</body>
</html>