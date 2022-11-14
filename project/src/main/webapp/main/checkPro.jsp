<%@page import="java.util.List"%>
<%@page import="project.quest.model.QuMemResultDAO"%>
<%@page import="project.quest.model.QuMemResultDTO"%>
<%@page import="project.quest.model.QuBoardDAO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@page import="project.memMyPage.model.MemDataDTO"%>
<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>checkPro</title>
</head>
<%
   // 아이디 받아오고
   String id = (String)session.getAttribute("memId");
   MemDataDAO memdatadao = new MemDataDAO();
   // 카테고리 받아오고
   MemberSignupDAO dao = new MemberSignupDAO();
   String category = dao.categorySeach(id);
   
   // 아이디 값주면 memData(멤버정보) 디비가서 데이터 가져오기 !
   MemDataDTO memdatadto = memdatadao.getMemData(id);
   int memDayCount = memdatadto.getMemDayCount();    // 1. 출석
   int memVolTime = memdatadto.getMemVolTime();    // 2. 봉사 시간
   int memVolCount = memdatadto.getMemVolCount();    // 3. 봉사 횟수
   int memBuyCount = memdatadto.getMemBuyCount();    // 4. 포인트샵 누적 구매 횟수
   int memBuyPoint = memdatadto.getMemBuyPoint();   // 5. 포인트샵 누적 구매 금액
   
   //
   QuBoardDAO qudao = new QuBoardDAO(); 
   QuMemResultDAO qumemresultdao = new QuMemResultDAO();
   
   
   
   
   /***** 출석 퀘스트  ******/
   //퀘스트기준quBoard DB와 개인정보memdata DB 안에 있는 데이터를 비교하기 (출석) 
   
   // (출석) 파라미터값주고 기준에 맞을경우 퀘스트의 고유번호 불러오기
   int dpQuNo = qudao.DayPointQuNo(memDayCount);
  	if(dpQuNo != 0){
	  
	   	QuMemResultDTO  qumemresultdto = null;
	 	int check = 1; //
	   
	   	// id 가 깬 퀘스트 고유번호 리스트 불러오기 
	   	List<QuMemResultDTO> list = qumemresultdao.quNoAllList(id);
	   	for(int i = 0; i < list.size() ;i++) { // 리스트 사이즈 만큼 돌려서 dpQuNo가 있냐 없냐 체크
	   		// 체크하기 
	   		qumemresultdto = list.get(i);
	   		
	   		if(qumemresultdto.getQuNO() == check){ // 값 있으면
	   			check = 0;
	   		}
	  	 }  // for 문     
	   		if(check == 1){
		   			if(dpQuNo != 0){
			   		qudao.insertquMemResult(id,dpQuNo);
			   		int dayPoint = qudao.DayPoint(memDayCount);  //해당 퀘스트 보상 포인트 값 가져오기
			   		int resultDay = memdatadao.memVisitPointPlus(id,dayPoint);  // 멤데이터에 보상포인트 추가해주기
		   			}
	   		}
  	} // if
   
 	response.sendRedirect("memberMain.jsp");

   
   
%>
<body>   



</body>
</html>