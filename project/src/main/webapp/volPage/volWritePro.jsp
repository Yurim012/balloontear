<%@page import="java.util.List"%>
<%@page import="project.volPage.model.VolApplyBoardDAO"%>
<%@page import="java.sql.Date"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@page import="project.volPage.model.VolBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>volWritePro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("memId");
	
%>
<jsp:useBean id="volArticle" class="project.volPage.model.VolBoardDTO" />
<%
	 if(id== null || id.equals(null) || id.equals("null")) { %>
     <script>
           alert("로그인 후 이용해주세요")
           window.location.href="/project/main/main.jsp";
     </script>
  <% }else {
	VolBoardDAO voldao = new VolBoardDAO();
	
	//파일업로드처리시 <jsp:setProperty > 사용불가 
	String path = request.getRealPath("save"); // 서버상의 save 폴더 경로 찾기
	System.out.println(path);
	int max = 1024*1024*5; // 파일 최대 크기 
	String enc = "UTF-8"; 
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp); // 실제 파일은 저장
	
	volArticle.setVolSubject(mr.getParameter("volSubject")); //제목
	volArticle.setMemId(mr.getParameter("memName")); //작성자
	volArticle.setVolCategory(mr.getParameter("volCategory")); // 카테고리 	 
	
	int status = Integer.parseInt(mr.getParameter("volStatus")); //진행상태 = int 
	volArticle.setVolStatus(status);
	
	int maxnum = Integer.parseInt(mr.getParameter("volMaxNum")); //모집인원 (int)
	volArticle.setVolMaxNum(maxnum);
	
	
	Date startDate = Date.valueOf(mr.getParameter("volStartDate"));
 	volArticle.setVolStartDate(startDate);
 	
 	
	Date endDate = Date.valueOf(mr.getParameter("volEndDate"));
	volArticle.setVolEndDate(endDate);
	
	volArticle.setVolLoc(mr.getParameter("volLoc")); //봉사장소
	
	int time = Integer.parseInt(mr.getParameter("volTime")); //인정시간 (int)
	volArticle.setVolTime(time);
	
	volArticle.setVolContent(mr.getParameter("volContent")); //내용
	 
	volArticle.setVolImg(mr.getFilesystemName("volImg"));
 
	volArticle.setVolReg(new Timestamp(System.currentTimeMillis()));  // 시스템상 현재 시간으로 reg값 체우기
 
	    
	    
	// DB가서 저장해~~ 
	voldao.insertArticle(volArticle);
	   
	// 처리 후 main 페이지로 이동 
	response.sendRedirect("volWriteOk.jsp");
}%>

<body>

</body>
</html>