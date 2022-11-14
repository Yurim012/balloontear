<%@page import="project.volPage.model.VolReplyBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>replyPro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String pageNum = (String)request.getParameter("pageNum");
	
	String id = (String)session.getAttribute("memId");
	if(id== null || id.equals(null) || id.equals("null")) { %>
		<script>
    	     alert("로그인 후 이용해주세요")
     	    window.location.href="/project/main/main.jsp";
		</script>
 <%}else {%>
<jsp:useBean id="replyDTO" class="project.volPage.model.VolReplyBoardDTO" />
<jsp:setProperty property="*" name="replyDTO"/>
<%
	
	VolReplyBoardDAO dao = new VolReplyBoardDAO(); 
	dao.insertReply(replyDTO);
  
	response.sendRedirect("volContent.jsp?volNo=" + replyDTO.getVolNo() + "&pageNum=" + pageNum);
}%>

<body>

</body>
</html> 