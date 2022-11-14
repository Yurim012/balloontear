<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@page import="project.volPage.model.VolBoardDAO"%>
<%@page import="project.volPage.model.VolApplyBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>activeCancle(pro)</title>
</head>
<%
	System.out.println("deleteCancle 페이지옴");
	int volNum = Integer.parseInt(request.getParameter("volNum"));
	int applyNo = Integer.parseInt(request.getParameter("applyNo"));
	String part = request.getParameter("part");
	
	//넘어온 volNum, 아이디 주고 신청자 상태 바꾸기
	VolApplyBoardDAO applydao = new VolApplyBoardDAO();
	int activityChange = applydao.changeMemActivityCancle(applyNo);    
	System.out.println("activityChange : " + activityChange);
	
	
	//액티비티 값이 바뀌면  
	if(activityChange == 1){
		//volNo에 해당하는 volBoard의 volTime값 가져와서 memVolTime update  
		VolBoardDAO boarddao = new VolBoardDAO();
		int time = boarddao.getTime(volNum);
		
		
		//해당 멤버의(applyNo)의 memId를 받아서  
		String memApplyId = applydao.getMemId(applyNo);
		
		//memData의 memVolTime을 update 
		//memId + time 주고 
		int memVolCount = 1; //봉사 횟수
		MemDataDAO memdatadao = new MemDataDAO();
		memdatadao.updateMemVolTimeCancle(memApplyId, time, memVolCount);  
		
		 
	}
	
	if(part.equals("a")){	
		response.sendRedirect("volIngApplyList.jsp?volNo="+volNum);
		}else{
		response.sendRedirect("volEndApplyList.jsp?volNo="+volNum);
		}
	
%>
<body>
	
</body>
</html>