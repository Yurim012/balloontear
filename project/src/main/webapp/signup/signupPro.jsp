<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>signupPro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="member" class="project.signup.model.MemberSignupDTO"/>
<%
	// 파일 업로드 처리시 jsp set프로퍼티 사용 불가
	String path = request.getRealPath("save"); // 서버상의 save 폴더 경로 찾기
	System.out.println(path);
	int max = 1024*1024*5; // 파일 크기
	String enc = "UTF-8"; //
	DefaultFileRenamePolicy dp  = new DefaultFileRenamePolicy(); // 파일 이름 중복시 숫자 +
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp); // 실제파일은 저장완료 
	
	member.setMemId(mr.getParameter("memId").trim());
	member.setMemPw(mr.getParameter("memPw").trim());
	member.setMemName(mr.getParameter("memName"));
	member.setMemEmail(mr.getParameter("memEmail"));	
	member.setMemTel(mr.getParameter("memTel"));
	member.setMemAd(mr.getParameter("memAd"));	
	System.out.println("주소까지저장");
	// 실제 save 폴더에 저장된 파일명을 dto에 담기 (파일명 중복처리되서 저장되므로, 원본 이름X)
	if(mr.getFilesystemName("memPhoto") != null){ // 파일을 업로드했을 경우
		member.setMemPhoto(mr.getFilesystemName("memPhoto"));  
	}else{ // 파일 업로드를 안했을 경우
		member.setMemPhoto("default.png");
		System.out.println(path);
		System.out.println("파일업로드까지");
	}
	member.setMemIcon(null);
	System.out.println("아이콘까지");
	member.setMemStatus(1);
	System.out.println("활동");
	//회원 종류 mem , cen
	member.setMemCategory(mr.getParameter("memCategory"));
	
		
	   // DB 가서 저장해 ~~ 
	   MemberSignupDAO dao = new MemberSignupDAO();
	   dao.insertMember(member);
	   // memData 테이블에 정보들 insert 
	   MemDataDAO memdata = new MemDataDAO();
	   //String memId =request.getParameter("memId");
	   String memId=member.getMemId();
	   System.out.println(memId);
	   memdata.insertMemData(memId);
	   memdata.insertRouletteTryCount(memId);
	   
	   
	   // 처리후 main 페이지로 이동 
	   response.sendRedirect("signupFinish.jsp");   
%>	
<body>

</body>
</html>