<%@page import="project.memMyPage.model.MemDataDTO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pwFindPro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");	

	System.out.println("비번찾기 프로옴");

	String name = request.getParameter("memName");
	String tel = request.getParameter("memTel");
	String id = request.getParameter("memId");
	
	
	// DB에 이름, id, tel 전달해서 DB에 일치하는 데이터 결과 받기
	MemberSignupDAO dao = new MemberSignupDAO();
	int result = dao.getpwForCheck(name, tel, id); 
    // 이름 없다 : -2 // 전화번호 없다 : -1 // 아이디 없다 : 0 // 세개다 맞다 : 1
	System.out.println("프로 페이지 이름 전화번호 체크 결과 : " + result);
	  
	if(result == -2) { %>
	<script>
		alert("해당 이름의 회원이 존재하지 않습니다... 다시 시도해주세요"); 
		history.go(-1); 
	</script>
<%	}else if(result == -1) { %>
	<script>
		alert("전화번호가 맞지 않습니다... 다시 시도해주세요");
		history.go(-1);
	</script>
	
<% } else if(result == 0){ %>	
	<script>
		alert("아이디가 일치하지 않습니다... 다시 시도해주세요");
		history.go(-1);
	</script>
	
<%	}else { %>
	<script>
		alert("비밀번호 찾기 성공!!");
		window.location="pwFindOk.jsp?memName=<%= name%>&memTel=<%= tel %>&memId=<%= id %>";
	</script>
<%	}	%>




<body>

</body>
</html>