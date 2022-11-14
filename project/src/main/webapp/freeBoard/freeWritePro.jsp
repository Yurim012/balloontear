<%@page import="project.free.model.FreeBoardDTO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="project.free.model.FreeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>freeWritePro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("memId");
	if(id== null || id.equals(null) || id.equals("null")) { %>
	   <script>
	         alert("로그인 후 이용해주세요")
	         window.location.href="/project/main/main.jsp";
	   </script>
	<% }else {
	
	
	MemberSignupDAO membersignupDAO = new MemberSignupDAO();
	//id값 주고 카테고리 찾아오기
	String category = membersignupDAO.categorySeach(id);
	
%>
<jsp:useBean id="freeArticle" class="project.free.model.FreeBoardDTO" />
<%
	FreeBoardDAO freedao = new FreeBoardDAO();
	
	//파일업로드처리시 <jsp:setProperty > 사용불가 
	String path = request.getRealPath("save"); // 서버상의 save 폴더 경로 찾기
	System.out.println(path);
	int max = 1024*1024*5; // 파일 최대 크기 
	String enc = "UTF-8"; 
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();  
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp); // 실제 파일은 저장
	
	freeArticle.setBoSubject(mr.getParameter("boSubject")); //제목
	
	if(category.equals("cen")){
		freeArticle.setMemId(mr.getParameter("memName"));//작성자 (센터)
	}else{
		freeArticle.setMemId(mr.getParameter("memId")); //작성자 (일반)
	}
	
	freeArticle.setBoCategory(mr.getParameter("boCategory")); // 카테고리 	 
	
	freeArticle.setBoContent(mr.getParameter("boContent")); //내용
	 
	freeArticle.setBoImg(mr.getFilesystemName("boImg"));
 
	freeArticle.setBoReg(new Timestamp(System.currentTimeMillis()));  // 시스템상 현재 시간으로 reg값 체우기
 


	// DB가서 저장해~~ 
	freedao.insertFreeArticle(freeArticle); 
	   
	// 처리 후 main 페이지로 이동 
	response.sendRedirect("freeWriteOk.jsp");
}%>
<body>

</body>
</html>