<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@page import="project.volPage.model.VolBoardDAO"%>
<%@page import="project.volPage.model.VolApplyBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>activeOk(pro)</title>
</head>
<%
	System.out.println("ok 페이지옴");
	int volNum = Integer.parseInt(request.getParameter("volNum"));
	int applyNo = Integer.parseInt(request.getParameter("applyNo"));
	String part = request.getParameter("part");
	
	//넘어온 volNum, 아이디 주고 신청자 상태 바꾸기
	VolApplyBoardDAO applydao = new VolApplyBoardDAO();
	int activityChange = applydao.changeMemActivity(applyNo);   
	System.out.println("activityChange : " + activityChange);
	
	
	//액티비티 값이 바뀌면  
	if(activityChange == 1){
		//volNo에 해당하는 volBoard의 volTime값 가져와서 memVolTime update  
		VolBoardDAO boarddao = new VolBoardDAO();
		int time = boarddao.getTime(volNum);
		
		
		//해당 멤버의(applyNo)의 memId를 받아서  memData의 memVolTime update 
		String memApplyId = applydao.getMemId(applyNo);
		
		//memId + time 주고 
		int memVolCount = 1; 
		MemDataDAO memdatadao = new MemDataDAO();
		memdatadao.updateMemVolTime(memApplyId, time, memVolCount);  
	    //8월 1일
	      memdatadao.VolRouletteCount(memApplyId);
		 
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