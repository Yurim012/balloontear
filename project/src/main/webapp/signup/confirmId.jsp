<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아이디 중복 확인</title>
	   <%-- 파비콘 --%>
   <link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
   <%-- 부트스트랩 --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	
	<link rel="stylesheet" href="/project/css/loginStyle.css" type="text/css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300&display=swap" rel="stylesheet">

</head>
<%
	// open(url ....) : url = confirmId,jsp?id=값
	String id = request.getParameter("id");
	// DB 연결해서 사용자가 작성한 id 값이 dm테이블에 존재하는지 검사
	MemberSignupDAO dao = new MemberSignupDAO();
	boolean result = dao.confirmId(id); // true 이미 존재함 ,false 존재x 사용가능함
%>
<body class="text-center">
<%
if(result == true){ // db에 id 존재할경우 사용불가 %>
	<table>
		<tr>
			<td><%=id %>은/는 이미 사용중인 아이디 입니다.</td>
		</tr>	
	</table> <br />
	
	<form action="confirmId.jsp" method="post">
		<table>
			<tr>
				<td> 다른 아이디를 선택하세요 <br/>
					<input type="text" name="id"/>
					<input type="submit" class="btn btn-outline-secondary btn-sm" value="ID 중복확인"/>			
				</td>
			</tr>
		</table>
	</form>		
	
<%	}else{ // db에 id가 없을 경우 false %>
	<table>
		<tr>
			<td>
				입력한 <%=id %>은/는 사용가능합니다. 
				<input type="button" class="btn btn-outline-secondary btn-sm" value="사용하기" onclick="setId()" />
			</td>
		</tr>
	</table>			
<%	}%>
	<script>
		function setId() {
			// 팝얼을 열어준 원래 페이지의 id input태그의 value를
			// 최종 사용할 id로 변경.
			opener.document.inputForm.memId.value="<%= id%>";
			// 현재 팝업 닫기.
			self.close();
		}


		
		
		
		
		
	<%--
	if(result == true){ // db에 id 존재할경우 사용불가 
	<table>
		<tr>
			<td><%=id %>은/는 이미 사용중인 아이디 입니다.</td>
		</tr>	
	</table> <br />
	
	<form action="confirmId.jsp" method="post">
		<table>
			<tr>
				<td> 다른 아이디를 선택하세요 <br/>
					<input type="text" name="id"/>
					<input type="submit" value="ID 중복확인"/>			
				</td>
			</tr>
		</table>
	</form>		
	
<%	}else{ // db에 id가 없을 경우 false %>
	<table>
		<tr>
			<td>
				입력한 <%=id %>은/는 사용가능합니다.
				<input type="button" value="사용하기" onclick="setId()" />
			</td>
		</tr>	
	</table>			
<%	}%>
	<script>
		function setId() {
			// 팝얼을 열어준 원래 페이지의 id input태그의 value를
			// 최종 사용할 id로 변경.
			opener.document.inputForm.memId.value="<%= id%>";
			// 현재 팝업 닫기.
			self.close();
		}
		
		--%>
	</script>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
</body>
</html>