<%@page import="java.sql.Timestamp"%>
<%@page import="project.free.model.FreeBoardDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="project.free.model.FreeBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
		<%
		String id = (String)session.getAttribute("memId");
		if(id== null || id.equals(null) || id.equals("null")) { %>
		   <script>
		         alert("로그인 후 이용해주세요")
		         window.location.href="/project/main/main.jsp";
		   </script>
		<% }else {


		request.setCharacterEncoding("UTF-8");
		FreeBoardDTO freeArticle = new FreeBoardDTO();
		
		String path = request.getRealPath("save");
		System.out.println(path);
		int max = 1024*1024*5;
		String enc = "UTF-8";
		DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
		MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
		
		FreeBoardDAO freedao = new FreeBoardDAO();
		
		//boNo, pageNum
		freeArticle.setBoNo(Integer.parseInt(mr.getParameter("boNo")));
		String pageNum = mr.getParameter("pageNum");
		
		//카테고리
		freeArticle.setBoCategory(mr.getParameter("boCategory"));
		
		//제목
		freeArticle.setBoSubject(mr.getParameter("boSubject")); 
		
		//내용
		freeArticle.setBoContent(mr.getParameter("boContent")); 
		System.out.println("수정pro 내용 : " + mr.getParameter("boContent"));
		 
		//사진
		if(mr.getFilesystemName("boImg") != null){
			freeArticle.setBoImg(mr.getFilesystemName("boImg"));
		}else{
			freeArticle.setBoImg(mr.getParameter("exBoImg"));
		}
		
		//reg값(=시스템상 현재 시간)
		freeArticle.setBoReg(new Timestamp(System.currentTimeMillis())); 
		
		
		
		int result = freedao.updateFreeArticle(freeArticle);  
	
		if(result == 0) { %>
		<script>
			alert("수정이 진행되지 않았습니다... 다시 시도해주세요...");
			history.go(-1);
		</script>
	<%}else{%>
		<script>
			alert("수정 완료!!!");
			window.location.href = "freeContent.jsp?boNo=" + <%=freeArticle.getBoNo()%> + "&pageNum=" + <%=pageNum%>; 
		</script>
	<%} %>
		
	<%} %>	
	

</body>
</html>