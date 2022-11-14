<%@page import="project.free.model.FreeReplyBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

	String pageNum = request.getParameter("pageNum");
	int boNo = Integer.parseInt(request.getParameter("boNo"));
	int freeReNo = Integer.parseInt(request.getParameter("freeReNo"));
	String freeReply = request.getParameter("freeReply");
	
	FreeReplyBoardDAO dao = new FreeReplyBoardDAO(); 
	dao.updateFreeReply(freeReNo, freeReply);   
	 
	response.sendRedirect("freeContent.jsp?boNo=" + boNo + "&pageNum=" + pageNum);
}%>

<body>
</body>
</html>