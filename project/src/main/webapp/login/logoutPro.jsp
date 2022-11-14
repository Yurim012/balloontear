<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>logout</title>
</head>
<%   
	session.invalidate();

	//	자동로그인 쿠키도 삭제
	Cookie [] coos = request.getCookies();
	if(coos != null){
		for(Cookie c : coos){
			if(c.getName().equals("autoId") || c.getName().equals("autoPw") || c.getName().equals("auto")){
				c.setMaxAge(0);
				c.setPath("/project/");
				response.addCookie(c);
			}
		}
	}	
	response.sendRedirect("/project/main/main.jsp");
%>

<body>

</body>
</html>