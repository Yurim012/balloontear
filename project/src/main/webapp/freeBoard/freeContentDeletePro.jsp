<%@page import="project.free.model.FreeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자유게시판 게시글 삭제</title>
</head>
<%

	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("memId");
	if(id== null || id.equals(null) || id.equals("null")) { %>
	   <script>
	         alert("로그인 후 이용해주세요")
	         window.location.href="/project/main/main.jsp";
	   </script>
	<% }else {

	//boNo , PageNum 받기
	int boNo = Integer.parseInt(request.getParameter("boNo"));
	String pageNum = (String)request.getParameter("pageNum");

	//boNo주고 해당 게시글 삭제하는 메서드
	FreeBoardDAO freedao = new FreeBoardDAO();
	int result = freedao.deleteOneFreeContent(boNo); 
	 
	
%>
<body>
	
	<%if(result == 1){%>
		<script>
	 	alert("게시글이 삭제되었습니다.")
	 	window.location='freeBoardMain.jsp?boNo=<%=boNo%>&pageNum=<%=pageNum%>';
		</script>
	<%}%>
<%} %>
</body>
</html>