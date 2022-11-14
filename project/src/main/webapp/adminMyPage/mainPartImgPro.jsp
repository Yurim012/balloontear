<%@page import="project.adminMyPage.model.AdminDateDTO"%>
<%@page import="project.adminMyPage.model.AdminDateDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 파트너 사진변경 pro</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	AdminDateDAO dao = new AdminDateDAO();
	AdminDateDTO dto = new AdminDateDTO();
	
	//파일업로드처리시 <jsp:setProperty > 사용불가 
	String path = request.getRealPath("save"); // 서버상의 save 폴더 경로 찾기
	System.out.println(path);
	
	int max = 1024*1024*5; // 파일 최대 크기 
	String enc = "UTF-8"; 
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp); // 실제 파일은 저장


	dto.setImg(mr.getFilesystemName("mainPartImg"));

	int result = dao.mainPartImgModify(dto); 
	
	if(result == 0) { %>
	<script>
		alert("수정되지 않았습니다... 다시 시도해주세요");
		history.go(-1);
	</script>
<%}else{%>
	<script>
		alert("수정 완료!!!");
		window.location.href = "homepageAdmin.jsp"; 
	</script>
<% } %>
<body>

</body>
</html>