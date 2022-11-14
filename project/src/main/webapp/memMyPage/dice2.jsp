<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>돌려돌려 주사위</title>
	<%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 

	
<%
String id = (String)session.getAttribute("memId");
if(id== null || id.equals(null) || id.equals("null")) { %>
	<script>
			alert("로그인 후 이용해주세요")
			window.location.href="/project/main/main.jsp";
	</script>
<%} 
	int random =(int)(Math.random() * 6)+1;  
	int random2 =(int)(Math.random() * 6)+1; 
	int random3 =(int)(Math.random() * 6)+1;  %>
	<meta http-equiv="refresh" content="1.8; url=/project/memMyPage/dice3.jsp?random=<%=random%>&random2=<%=random2%>&random3=<%=random3%>">
</head>
<body>
<div align="center">
	<img src="img/주사위움짤.gif" width=100%>
</div>
</body>
</html>