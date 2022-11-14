<%@page import="project.volPage.model.VolApplyBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>봉사 신청 취소</title>
	<%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 

</head>
<%
	request.setCharacterEncoding("UTF-8");	
	String id = (String)session.getAttribute("memId");
	
	
	
	int apNum = Integer.parseInt(request.getParameter("applyNo"));
	
	System.out.println("봉사 취소 아이디 가져온 값" + id);
	System.out.println("봉사 취소 봉사번호 가져온 값" + apNum);
	
	
	VolApplyBoardDAO dao = new VolApplyBoardDAO();
	
	int result = dao.checkVolapply(id, apNum);
	System.out.println("봉사 취소 응답" + result);
	
	
	if(result == 1){
		int apcancel = dao.memVolcancel(apNum);  
		
		%>
		<script>
			alert("취소가 완료되었습니다.");
			window.location="memberMyVolPage.jsp";
		</script>
		
	<% } else { %>
		<table>
			<tr>
				<td>취소 불가... 다시 시도해주세요</td>
				<td>
					<input type="button" value="닫기" onclick="setId()" />
				</td>
			</tr>		
		</table>
		
	<% } %>
<script>
		
	</script>
<body>

</body>
</html>