<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 회원 탈퇴 페이지</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("memId");
	String memberId = request.getParameter("memberId"); 
	String pageNum = request.getParameter("pageNum");
	
	 System.out.println("id는 : " + id);
	
	MemberSignupDAO dao = new MemberSignupDAO();
	dao.deleteUser(memberId); %>
	<script>
		alert("활동 중지 처리가 완료되었습니다!");
		window.location="adminMypage.jsp?pageNum=<%= pageNum %>";
	</script>	
	



<body>

</body>
</html>