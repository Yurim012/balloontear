<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 프로</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("memId");
	String pw = request.getParameter("memPw");
	 System.out.println("id는 : " + id);
	 System.out.println("pw는 : " + pw);
	
	MemberSignupDAO dao = new MemberSignupDAO();
	int check = dao.idPwCheck(id, pw);
	if(check == 1){
		dao.deleteUser(id); %>
		<script>
		alert("탈퇴가 완료되었습니다!");
	</script>	
	<% 
		session.invalidate();
		response.sendRedirect("/project/main/main.jsp");
	}else{ %>
		<script>
			alert("비밀번호가 맞지 않습니다... 다시 시도해주세요...");
			history.go(-1);	
		</script>
	<% } %>


<body>

</body>
</html>