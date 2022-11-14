<%@page import="project.volPage.model.VolReplyBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>reply delete</title>
</head>
<%
String id = (String)session.getAttribute("memId");
if(id== null || id.equals(null) || id.equals("null")) { %>
   <script>
         alert("로그인 후 이용해주세요")
         window.location.href="/project/main/main.jsp";
   </script>
 <%}else {


	int reNo = Integer.parseInt(request.getParameter("reNo"));
	int volNo = Integer.parseInt(request.getParameter("volNo"));
	String pageNum = request.getParameter("pageNum");
	
	VolReplyBoardDAO dao = new VolReplyBoardDAO(); 
	dao.deleteReply(reNo);  
	
	response.sendRedirect("volContent.jsp?volNo=" + volNo + "&pageNum=" + pageNum);
	
}%>


<body>

</body>
</html>