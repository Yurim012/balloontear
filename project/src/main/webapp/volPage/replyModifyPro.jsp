<%@page import="project.volPage.model.VolReplyBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>reply modify pro</title>
</head>
<%
	String id = (String)session.getAttribute("memId");
	if(id== null || id.equals(null) || id.equals("null")) { %>
		<script>
    	     alert("로그인 후 이용해주세요")
     	    window.location.href="/project/main/main.jsp";
		</script>
 <%}else {

	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	int volNo = Integer.parseInt(request.getParameter("volNo"));
	int reNo = Integer.parseInt(request.getParameter("reNo"));
	String reply = request.getParameter("reply");
	
	VolReplyBoardDAO dao = new VolReplyBoardDAO();
	dao.updateReply(reNo, reply);   
	 
	response.sendRedirect("volContent.jsp?volNo=" + volNo + "&pageNum=" + pageNum);
}%>

<body>

</body>
</html>