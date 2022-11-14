<%@page import="project.signup.model.MemberSignupDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원정보 수정</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("memId");
	MemberSignupDAO dao = new MemberSignupDAO();
	//아이디 주고 카테고리 찾아오기 
	String category = dao.categorySeach(id);
	//아이디 주고 이름 찾아오기
	String userName = dao.getName(id);
	MemberSignupDTO member = new MemberSignupDTO();
	
	
	// MultipartRequest 생성 
	String path = request.getRealPath("save");
	System.out.println(path);
	int max = 1024*1024*5; 
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp); 
	
	// 8월 2일 트림 넣기
	member.setMemId(id);
	member.setMemPw(mr.getParameter("memPw").trim());
	member.setMemName(mr.getParameter("memName").trim());
	member.setMemEmail(mr.getParameter("memEmail").trim());	
	member.setMemTel(mr.getParameter("memTel").trim());
	member.setMemAd(mr.getParameter("memAd"));	
	System.out.println("주소까지저장");
	// 실제 save 폴더에 저장된 파일명을 dto에 담기 (파일명 중복처리되서 저장되므로, 원본 이름X)
	if(mr.getFilesystemName("memPhoto") != null){ // 파일을 업로드했을 경우
		member.setMemPhoto(mr.getFilesystemName("memPhoto"));  
	}else{ // 파일 업로드를 안했을 경우
		member.setMemPhoto(mr.getParameter("exMemPhoto"));
	}
	member.setMemIcon(null);
	System.out.println("아이콘까지");
	member.setMemStatus(1);
	System.out.println("활동");
	//회원 종류 mem , cen
	member.setMemCategory(mr.getParameter("memCategory"));
	
	int modifyCheck = dao.userInfoModify(member);
	

%>


<body>
		<%	if(modifyCheck == 1) { %>
		<script>
			alert("수정 완료!!!!");
			window.location.href = "userModifyOk.jsp";
		</script>
	<%	}else{  %>
		<script>
			alert("수정 실패... 다시 시도해주세요...");
			history.go(-1);
		</script>
	<%	} %>


</body>
</html>