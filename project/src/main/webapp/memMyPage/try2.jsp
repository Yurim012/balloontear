<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>행운의 브로콜리🎁</title>
	<%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
</head>
<meta http-equiv="refresh" content="5.5; url=/project/memMyPage/memberMypage.jsp">
<script>
    var index = 0;   //이미지에 접근하는 인덱스
    window.onload = function(){
        slideShow();
    }
    
    function slideShow() {
    var i;
    var x = document.getElementsByClassName("slide1");  //slide1에 대한 dom 참조
    for (i = 0; i < x.length; i++) {
       x[i].style.display = "none";   //처음에 전부 display를 none으로 한다.
    }
    index++;
    if (index > x.length) {
        index = 1;  //인덱스가 초과되면 1로 변경
    }   
    x[index-1].style.display = "block";  //해당 인덱스는 block으로
    setTimeout(slideShow, 2000);   //함수를 4초마다 호출
 
}
    function auto_close() {
    	setTimeout('closed()',7000);
    	}
    function closed() {
    	self.close();
    	}
    	auto_close();
</script>
<%
	String id = (String)session.getAttribute("memId");
	MemDataDAO memdatadao = new MemDataDAO();
	memdatadao.getRouletteTryCount(id);
%>

<body>

<div>
  <img class="slide1" src="img/기대.gif" width=50%>
  <img class="slide1" src="img/터짐.gif" width=50%>
  
<%int random = (int)(Math.random()*10);
  if(random >5){
	int point = 10;  
  	System.out.println("*******************"+random);
  	memdatadao.updateRouletteTryCount(id);// 개인 도박횟수 -1 하는 메서드 실행
  	memdatadao.memVisitPointPlus(id, point);%>
  	<img class="slide1" src="img/10pp.png" width=50%>  
<%}else{
	int point = 20; 
  	System.out.println("*******************"+random);
  	memdatadao.updateRouletteTryCount(id);
  	memdatadao.memVisitPointPlus(id, point);%>
  	<img class="slide1" src="img/20pp.jpg" width=50%>
<%} %> 
</div>

</body>
</html>