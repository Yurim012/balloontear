<%@page import="project.free.model.FreeReplyBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자유게시판 댓글 삭제 Pro</title>
</head>
<%
	String id = (String)session.getAttribute("memId");
	if(id== null || id.equals(null) || id.equals("null")) { %>
	   <script>
	         alert("로그인 후 이용해주세요")
	         window.location.href="/project/main/main.jsp";
	   </script>
<%	}else { 

	int freeReNo = Integer.parseInt(request.getParameter("freeReNo"));
	int boNo = Integer.parseInt(request.getParameter("boNo"));
	String pageNum = request.getParameter("pageNum");
	
	FreeReplyBoardDAO dao = new FreeReplyBoardDAO(); 
	dao.deleteFreeReply(freeReNo);   
	
	response.sendRedirect("freeContent.jsp?boNo=" + boNo + "&pageNum=" + pageNum);
	
}%>


<body>
</html>