<%@page import="project.memMyPage.model.MemDataDTO"%>
<%@page import="project.memMyPage.model.MemDataDAO"%>

<%@page import="project.quest.model.QuBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>levelCheck</title>
	<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>
</head>
<%	
	/*
	// 아이디값 가져오고
	String id = (String)session.getAttribute("memId");
	// 아이디값에 있는 quresult DB에 있는 퀘스트 클리어 갯수 가져오기 메서드
	QuMemResultDAO quresultdao = new QuMemResultDAO();
	// select count(*) from quMemResult where memId=?; 리턴해와야함
	// 변수 quClearCount 안에 id가 클리어한 퀘스트 갯수 들어가있음
	int quClearCount = quresultdao.quCleartCount(id);
	*/
	String id = (String)session.getAttribute("memId");
	MemDataDAO memdatadao = new MemDataDAO();
	// memData DB에 들어가서 레벨 + 1
	memdatadao.LevelUp(id);	 
	MemDataDTO memdatadto = memdatadao.getMemData(id);
%>
<body>
	<script>
	<%--
		alert("Lv<%=memdatadto.getMemLevel() - 1%> - > Lv<%=memdatadto.getMemLevel()%>(이)가 되셨습니다. 축하드립니다");
		var link = 'http://localhost:8080/project/main/memberMain.jsp';
		location.href=link;
		location.replace(link);
		window.open(link);
		--%>
	       window.onload=function(){
        	   swal('레벨업',"Lv<%=memdatadto.getMemLevel() - 1%> - > Lv<%=memdatadto.getMemLevel()%>(이)가 되셨습니다. 축하드립니다",'success')
               .then(function(){
               	location.href="/project/memMyPage/memberMypage.jsp";                   
               })
    	 }
	</script>
	
</body>
</html>