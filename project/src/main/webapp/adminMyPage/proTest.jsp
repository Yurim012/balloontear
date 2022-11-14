<%@page import="project.adminMyPage.model.MainBannerDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="project.adminMyPage.model.MainBannerDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	MainBannerDTO main = new MainBannerDTO();
	//파일업로드처리시 <jsp:setProperty > 사용불가 
	String path = request.getRealPath("save"); // 서버상의 save 폴더 경로 찾기
	System.out.println(path);
	int max = 1024*1024*5; // 파일 최대 크기 
	String enc = "UTF-8"; 
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	String mainBanNum = mr.getParameter("mainBanNum");
	System.out.println(mainBanNum);
	if(mainBanNum.equals("1")){
		main.setMainBanImg(mr.getFilesystemName("mainBanImg"));
		MainBannerDAO dao = new MainBannerDAO();
		int result = dao.insetImg(main); 
		dao.insetMainBan1(main);
		
	}else if(mainBanNum.equals("2")){
		main.setMainBanImg(mr.getFilesystemName("mainBanImg"));
		MainBannerDAO dao = new MainBannerDAO();
		int result = dao.insetImg(main); 
		dao.insetMainBan2(main);
		
	}else if(mainBanNum.equals("3")){
		main.setMainBanImg(mr.getFilesystemName("mainBanImg"));
		MainBannerDAO dao = new MainBannerDAO();
		int result = dao.insetImg(main); 
		dao.insetMainBan3(main);
	}%>
	<script>
		alert("수정 완료!!!");
		window.location.href = "mainBanImgAdmin.jsp"; 
	</script>	

<body>
 
</body>
</html>