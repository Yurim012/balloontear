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
   
	String pageNum = (String)request.getParameter("pageNum");
%>
<jsp:useBean id="freeReplyDTO" class="project.free.model.FreeReplyBoardDTO" />
<jsp:setProperty property="*" name="freeReplyDTO"/>
<%
	
	FreeReplyBoardDAO freedao = new FreeReplyBoardDAO(); 
	freedao.insertFreeReply(freeReplyDTO);  
  
	response.sendRedirect("freeContent.jsp?boNo=" + freeReplyDTO.getBoNo() + "&pageNum=" + pageNum);
}%>

</body>
</html>