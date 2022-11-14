<%@page import="project.memMyPage.model.MemDataDTO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>idFindPro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");	

	System.out.println("아이디찾기 프로옴");

	String name = request.getParameter("memName");
	String tel = request.getParameter("memTel");
	
	// DB에 id, tel 전달해서 DB에 일치하는 데이터 결과 받기
	MemberSignupDAO dao = new MemberSignupDAO();
	int result = dao.getNameTelCheck(name, tel);  // result : 1 ok, 0 비번틀림, -1 아이디없다
	System.out.println("이름 전화번호 체크 결과 : " + result);
	 
	if(result == -1) { %>
	<script>
		alert("해당 이름의 아이디는 존재하지 않습니다..."); 
		history.go(-1); 
	</script>
<%	}else if(result == 0) { %>
	<script>
		alert("전화번호가 맞지 않습니다... 다시 시도해주세요");
		history.go(-1);
	</script>
<%	}else { 
	
%>
	 <input type="hidden" name="memName" value=<%= name %> />
	 <input type="hidden" name="memTel" value=<%= tel %> />
	<script>
		alert("아이디 찾기 성공!!");
		window.location="idFindOk.jsp?memName=<%= name%>&memTel=<%= tel %>";
	</script>
<%	}%>




<body>

</body>
</html>