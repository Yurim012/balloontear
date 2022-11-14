<%@page import="project.volPage.model.VolBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>volContentDeletePro</title>
</head>
<%
String id = (String)session.getAttribute("memId");
if(id== null || id.equals(null) || id.equals("null")) { %>
   <script>
         alert("로그인 후 이용해주세요")
         window.location.href="/project/main/main.jsp";
   </script>
<% }else {
	request.setCharacterEncoding("UTF-8");
	
	//volNo , PageNum 받기
	int volNo = Integer.parseInt(request.getParameter("volNo"));
	String pageNum = (String)request.getParameter("pageNum");

	//volNo주고 해당 게시글 삭제하는 메서드
	VolBoardDAO voldao = new VolBoardDAO();
	int result = voldao.deleteOneVol(volNo);  
	
	
%>
<body>
	
	<%if(result == 1){%>
		<script>
	 	alert("게시글이 삭제되었습니다.")
	 	window.location='volBoardMain.jsp?volNo=<%=volNo%>&pageNum=<%=pageNum%>';
		</script>
	<%}%>
<%} %>
</body>
</html>