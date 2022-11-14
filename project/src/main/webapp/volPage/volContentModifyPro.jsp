<%@page import="java.text.SimpleDateFormat"%>
<%@page import="project.volPage.model.VolBoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.Date"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="project.volPage.model.VolBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>volContentModifyPro</title>
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
		VolBoardDTO volArticle = new VolBoardDTO();
		
		String path = request.getRealPath("save");
		System.out.println(path);
		int max = 1024*1024*5;
		String enc = "UTF-8";
		DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
		MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
		
		VolBoardDAO volDAO = new VolBoardDAO();
		
		volArticle.setVolNo(Integer.parseInt(mr.getParameter("volNo")));
		volArticle.setVolSubject(mr.getParameter("volSubject")); 
		volArticle.setVolCategory(mr.getParameter("volCategory"));
		
		
		int status = Integer.parseInt(mr.getParameter("volStatus")); //진행상태 = int 
		volArticle.setVolStatus(status);
		
		 //오늘 날짜 스트링으로 
	      SimpleDateFormat sdf = new SimpleDateFormat("MM/dd"); 
	      Date today = new Date((System.currentTimeMillis()));
	      System.out.println(today);
	      String todayFormat = (sdf.format(today));
	      System.out.println(todayFormat);
	      
	   //today 날짜를 주고 endDate랑 비교해서 volStatus 바꾸기 
	      VolBoardDTO voldto = new VolBoardDTO(); 
	      volDAO.compareTodayEndDate(todayFormat);   //(모집마감)
	   //today 날짜를 주고 endDate랑 비교해서 volStatus 바꾸기 (봉사진행중)
	      volDAO.compareTodayStartDate(todayFormat);     
	   //today 날짜를 주고 endDate랑 비교해서 volStatus 바꾸기 (봉사예정)
	      volDAO.compareTodayDateIng(todayFormat);     
		
	      
	      
		Date startDate = Date.valueOf(mr.getParameter("volStartDate"));
	 	volArticle.setVolStartDate(startDate);
	 	
	 	
		Date endDate = Date.valueOf(mr.getParameter("volEndDate"));
		volArticle.setVolEndDate(endDate);
	      
	      
		int maxnum = Integer.parseInt(mr.getParameter("volMaxNum")); //모집인원 (int)
		volArticle.setVolMaxNum(maxnum);
		
	 	
		volArticle.setVolLoc(mr.getParameter("volLoc")); //봉사장소
		
		int time = Integer.parseInt(mr.getParameter("volTime")); //인정시간 (int)
		volArticle.setVolTime(time);
		
		volArticle.setVolContent(mr.getParameter("volContent")); //내용
		 
		if(mr.getFilesystemName("volImg") != null){
			volArticle.setVolImg(mr.getFilesystemName("volImg"));
		}else{
			volArticle.setVolImg(mr.getParameter("exVolImg"));
		}
		
		volArticle.setVolReg(new Timestamp(System.currentTimeMillis()));  // 시스템상 현재 시간으로 reg값 체우기
		
		String pageNum = mr.getParameter("pageNum");
		System.out.println("봉사 수정완료");
		
		
		int result = volDAO.updateVolArticle(volArticle); 
	
		if(result == 0) { %>
		<script>
			alert("수정이 진행되지 않았습니다... 다시 시도해주세요...");
			history.go(-1);
		</script>
	<%}else{%>
		<script>
			alert("수정 완료!!!");
			window.location.href = "volContent.jsp?volNo=" + <%=volArticle.getVolNo()%> + "&pageNum=" + <%=pageNum%>; 
		</script>
	<%} %>
		
<%} %>		
	

<body>

</body>
</html>