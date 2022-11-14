<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>돌려돌려 주사위</title>
	<%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
	<meta http-equiv="refresh" content="7; url=/project/memMyPage/memberMypage.jsp">
	
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
	String random = request.getParameter("random");
	String random2 = request.getParameter("random2");
	String random3 = request.getParameter("random3");
	
	int point = 10; // 기본 포인트 
	int x = 1; // 기본 배율 눈 2개가 같으면 2 3개가 같으면 3
	int y = 1; // 기본 배율
	if(random.equals(random2) || random.equals(random3) || random2.equals(random3)){
		x = 2;
	}if(random.equals(random2) && random.equals(random3) && random2.equals(random3)){
		x = 3;
	}if(random.equals(random2) && random.equals(random3) && random2.equals(random3) && random.equals("2")){
		y = 2;
	}if(random.equals(random2) && random.equals(random3) && random2.equals(random3) && random.equals("3")){
		y = 3;
	}if(random.equals(random2) && random.equals(random3) && random2.equals(random3) && random.equals("4")){
		y = 4;
	}if(random.equals(random2) && random.equals(random3) && random2.equals(random3) && random.equals("5")){
		y = 5;
	}if(random.equals(random2) && random.equals(random3) && random2.equals(random3) && random.equals("6")){
		y = 6;
	}
	
	MemDataDAO memdatadao = new MemDataDAO();
%>
<body>
<br><br>
<div align="center">
	<h1>결과</h1>
	<img class=effect src="img/sai_<%=random %>.gif" id="d1" style="animation-delay: .5s">
	<img class=effect src="img/sai_<%=random2 %>.gif" id="d2" style="animation-delay: 1s">
	<img class=effect src="img/sai_<%=random3 %>.gif" id="d3" style="animation-delay: 1.5s">
	<h3 class=effect style="animation-delay: 2s">기본 포인트 : <%=point %>포인트</h3>
	<h2 class=effect style="animation-delay: 2.5s">당첨 배율 : <%=x*y %>배</h2>
	<h1 class=effect style="animation-delay: 3s"><%=point*x*y%>포인트 획득</h1>
	<h1 class=effect style="animation-delay: 4s">잠시 후 전 페이지로 돌아갑니다.</h1>
	<%
	int resultPoint = point*x*y;
	memdatadao.updateRouletteVolTryCount(id,resultPoint); %>

	
</div>

</body>
</html>