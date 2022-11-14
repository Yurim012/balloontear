<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정지 해제</title>
</head>
<%

	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("memId");
	
	if (id== null || id.equals(null) || id.equals("null")){ %>
		   <script>
					alert("로그인 후 이용해주세요")
					window.location.href="/project/main/main.jsp";
			</script>
	<%  } else {
	id = (String)session.getAttribute("memId");
	String memberId = request.getParameter("memberId"); 
	String pageNum = request.getParameter("pageNum");
	
	 System.out.println("id는 : " + id);
	 System.out.println("정지 풀 아이디 id는 : " + id);
	
	MemberSignupDAO dao = new MemberSignupDAO();
	dao.comBackUser(memberId);
	
	
	
	%>
	<script>
		alert("정지해제 완료되었습니다!");
		window.location="adminMypage.jsp?pageNum=<%= pageNum %>";
	</script>	
	



<body>

</body>
<% } %>
</html>