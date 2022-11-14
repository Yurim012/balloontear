<%@page import="project.quest.model.QuBoardDAO"%>
<%@page import="project.quest.model.QuMemResultDAO"%>
<%@page import="java.util.List"%>
<%@page import="project.quest.model.QuMemResultDTO"%>
<%@page import="project.signup.model.MemberSignupDTO"%>
<%@page import="project.memMyPage.model.MemDataDTO"%>
<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>멤버 마이페이지</title>
	<%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
	<%-- 부트스트랩 --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	<link href="/docs/5.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	<link rel="stylesheet" href="/project/css/memberMypageStyle.css" type="text/css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300&display=swap" rel="stylesheet">
	<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>
	<style>
	.container{
	padding-right: 100px;
	padding-bottom: 100px;
	padding-left: 100px;
	}
	
	#mypagetest{
	
	float: right;
	width: 300px;
	height: auto;
	
	}
	.emblem {
		  width: 900px;
		  border-radius : 16px;
		  border-spacing: 0;
		}

	
	
	</style>

</head>


	<%
	String id = (String)session.getAttribute("memId");
	String category =null; 
	if(id== null || id.equals(null) || id.equals("null")) { %>
		<script>
				alert("로그인 후 이용해주세요")
				window.location.href="/project/main/main.jsp";
		</script>
	<% }else {
	
	   MemberSignupDAO dao = new MemberSignupDAO();
	   
	   //아이디 주고 카테고리 찾아오기 메서드 만들기
	   category = dao.categorySeach(id);
	   MemDataDAO memdatadao = new MemDataDAO();
	   String userName = dao.getName(id);
	   MemDataDTO memdatadto =  memdatadao.getMemData(id);
	   
	   MemberSignupDAO memDAO = new MemberSignupDAO();
	   MemberSignupDTO member = memDAO.getMember(id);
	   QuMemResultDAO qumemresultdao = new QuMemResultDAO();
	   
	   // 엠블럼 체크 메서드
	   boolean check = false;
	  List<Integer> list = qumemresultdao.memquNoListint(id);
	  
      // 7월 28일
      // 완료한 퀘스트 갯수 가져오기
      QuMemResultDAO quresultdao = new QuMemResultDAO();
      // select count(*) from quMemResult where memId=?; 리턴해와야함
      // 변수 quClearCount 안에 id가 클리어한 퀘스트 갯수 들어가있음
      int quClearCount = quresultdao.quCleartCount(id); 
	  
      
      // 7월 29일 도박 남은 횟수 가져오기!!!
      int rouletteTryCount = memdatadao.getRouletteTryCount(id);
      int rouletteVolTryCount = memdatadao.getRouletteVolTryCount(id);
      
	  
      //7월 26일
      QuBoardDAO quboarddao = new QuBoardDAO();
      int memVolTime = memdatadto.getMemVolTime();      // 개인의 봉사 시간
      int volTimeResult = 0;
      if(0 <= memVolTime && memVolTime < 3){      
         volTimeResult = 0;
      }else if(3 <= memVolTime && memVolTime < 10){
          volTimeResult = 3;
      }else if(10 <= memVolTime && memVolTime < 20){
          volTimeResult = 10;
      }else if(20 <= memVolTime && memVolTime < 30){  
          volTimeResult = 20;
      }else if(30 <= memVolTime && memVolTime < 50){
         volTimeResult = 30;
      }else if(50 <= memVolTime && memVolTime < 1000000){
         volTimeResult = 50;
      }  
      System.out.println("volTimeResult : " + volTimeResult);
      // 개인의 봉사 시간 주고 봉사 시간과 일치하는 퀘스트 있으면 클리어 포인트 가져옴 없으면 0
      int volTimePoint = quboarddao.volTimePoint(volTimeResult);
      // 개인의 봉사 시간 주고 봉사 시간과 일치하는 퀘스트 번호 가져오기 21 22 23 24 25 0 중 하나
      int volTimeQuno = quboarddao.volTimeQuNo(volTimeResult);
      // 개인이 깬 20번대 퀘스트 리스트 가져오기
      List<QuMemResultDTO> volTimeQuList = qumemresultdao.quNoList20(id);
      
      boolean volTimeCheck = false;
      // 가져온 값들이 있을경우
      if(volTimeQuList != null){
            for(int i = 0; i < volTimeQuList.size(); i++ ){
             QuMemResultDTO qumemresultdto = volTimeQuList.get(i);
             int a = qumemresultdto.getQuNO();
                 if(volTimeQuno != 0 && a != volTimeQuno ){
                    volTimeCheck  = true;
                 }else{
                    volTimeCheck  = false;
                 }
          }
      }
      if(volTimeCheck){%>
          <script>
	          <%--
	          alert("봉사 <%=volTimeResult%>시간 달성  <%=volTimePoint%>포인트 획득 !");
	          --%>
	          setTimeout("volTime()", 2000);
          </script>
       <%quboarddao.insertquMemResult(id, volTimeQuno);
         memdatadao.memVisitPointPlus(id,volTimePoint);
      }else{ // 처음 2-1 깨는 사람
         if(volTimeQuno !=0 && volTimeQuList == null){%>
                   <script>
	                   <%--
	                   alert("봉사 <%=volTimeResult%>시간 달성  <%=volTimePoint%>포인트 획득 !");
	                   --%>
	                   setTimeout("volTime()", 2000);
                </script>
          <%quboarddao.insertquMemResult(id, volTimeQuno);
            memdatadao.memVisitPointPlus(id,volTimePoint);
         }
      }      
      
      int memVolCount = memdatadto.getMemVolCount();  // 개인의 봉사 횟수
      // 개인의 봉사 횟수 주고 봉사 횟수와 일치하는 퀘스트 있으면 클리어 포인트 가져옴 없음 0
      int volCountPoint = quboarddao.volCountPoint(memVolCount);  
      // 개인의 봉사 횟수 주고 봉사 횟수와 일치하는 퀘스트 번호 가져오기 31 32 33 34 35 0 중 하나      
      int volCountQuNo =quboarddao.volCountQuNo(memVolCount);                  
      
      // 개인이 깬 30번대 퀘스트 리스트 가져오기
      List<QuMemResultDTO> volCountQuList = qumemresultdao.quNoList30(id);
      boolean volCountCheck = false;
      // 가져온 값들이 있을경우
      if(volCountQuList != null){
            for(int i = 0; i < volCountQuList.size(); i++ ){
             QuMemResultDTO qumemresultdto = volCountQuList.get(i);
             int a = qumemresultdto.getQuNO();
             int b = qumemresultdto.getQuNO() -1;
                 if(volCountQuNo != 0 && a != volCountQuNo && b!=volCountQuNo){
                    volCountCheck  = true;
                    System.out.println("********true*******");
                 }else{
                    volCountCheck  = false;
                    System.out.println("********false*******");
                    break;
                 }
            }//for(int i = 0; i < volCountQuList.size(); i++ ){
      }//if(volCountQuList != null){
      
      // 
      if(volCountCheck){%>
          <script>
	          <%-- 
	          alert("봉사횟수 <%=memVolCount%>회 달성  <%=volCountPoint%>포인트 획득 !");
	          --%>
	          setTimeout("volCount()", 1000);
          </script>
       <%quboarddao.insertquMemResult(id, volCountQuNo);
         memdatadao.memVisitPointPlus(id,volCountPoint);
      }else{ // 처음 3-1 깨는 사람
         if(volCountQuNo !=0 && volCountQuList == null ){%>
                   <script>
                   <%-- 
                   alert("봉사횟수 <%=memVolCount%>회 달성  <%=volCountPoint%>포인트 획득 !");
                   --%>
                   setTimeout("volCount()", 1000);
                </script>
          <%quboarddao.insertquMemResult(id, volCountQuNo);
            memdatadao.memVisitPointPlus(id,volCountPoint);
         }
      }
	  
	  
	  

	%>

<script>
   function volCount() {
      swal({
            title: "퀘스트완료!",
            text: "봉사횟수 <%=memVolCount%>회 달성  <%=volCountPoint%>포인트 획득!",
            icon: "success" //"info,success,warning,error" 중 택1
         })      
   }
</script>
<script>
   function volTime() {
      swal({
            title: "퀘스트완료!",
            text: "봉사 <%=volTimeResult%>시간 달성  <%=volTimePoint%>포인트 획득!",
            icon: "success" //"info,success,warning,error" 중 택1
         })      
   }
</script>



<body class="text-center">
 <% if (session.getAttribute("memId")==null){ %>
   <div align="right">
      <table>
         <tr>
            <td><button class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/login/loginForm.jsp'">로그인</button></td>
            <td><button class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/signup/signupForm.jsp'">회원가입</button></td>
         </tr>
      </table>
   </div>
   <%} else { %>
      <div align="right">
      <table>
         <tr>
         <td><%=id %>님 환영합니다</td>
            <td><button class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/login/logoutPro.jsp'">로그아웃</button></td>
               <%if(category.equals("mem")){ %>
                   <td><button class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/memMyPage/memberMypage.jsp'">마이페이지</button></td>
                  <%}else if(category.equals("cen")){ %>
                  <td><button class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/cenMyPage/centerMypage.jsp'">마이페이지</button></td>  
                  <%}else{ %>
                  <td><button class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/adminMyPage/adminMypage.jsp'">마이페이지</button></td>  
                  <%} %>
         </tr>
      </table>
   </div>
   <% } %>
	
		    <%--타이틀--%>
      <div class="container-fluid p-3 text-black text-center"> 
    	<img src="/project/save/logo.png" width="100px" />
      <%if (session.getAttribute("memId")==null){ %>
            <a class="Atitle" href="/project/main/main.jsp"><h2 id="homeTitle">BALLOONTEER</h2></a>
      <% }else { %>
         <%if(category.equals("mem")){ %>
            <a class="Atitle" href="/project/main/memberMain.jsp"><h2 id="homeTitle">BALLOONTEER</h2></a>
         <% } else { %>
            <a class="Atitle" href="/project/main/main.jsp"><h2 id="homeTitle">BALLOONTEER</h2></a>
         <% } %>
      <% } %>
      </div>
    
	  <%--내비바 --%>
	   <ul class="nav justify-content-center">
	      <li class="nav-item">
	        <a class="nav-link active" aria-current="page" href="/project/volPage/volBoardMain.jsp"><b>봉사</b></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="/project/pointPage/pointShop.jsp"><b>포인트샵</b></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="/project/freeBoard/freeBoardMain.jsp"><b>자유게시판</b></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="/project/infoPage/homepageInfo.jsp"><b>소개</b></a>
	      </li>
	   </ul>


<%-- ********************************************************************************************************************** --%>	
<br />
<div class="container">
	<div class ="justify-content-md-center"> 
	
	<main class="d-flex flex-nowrap" >
 	<% if(category.equals("mem")){  // 카테고리가 mem이면 개인회원 폼띄워주기 %>
  	<div class="b-example-divider b-example-vr"></div>
  	<div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 250px; border-radius: 16px; ">
		<svg class="bi pe-none me-5" width="40" height="32"></svg>
		<span class="fs-4">MY PAGE</span>
       <div>
			<img src="/project/save/<%= member.getMemPhoto() %>" width="200"/>
			<br />
			<h3><%= member.getMemName() %></h3>
			<br />
			 <h5 align="center">현재 등급 : <%= memdatadto.getMemLevel() %></h5>
             <h5 align="center">보유 포인트 : <%= memdatadto.getMemPoint()%></h5>
             
             <hr />
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <a href ="/project/memMyPage/memberMypage.jsp" class="nav-link-active" aria-current="page" >
          <svg class="bi pe-none mr-auto" width="16" height="16"></svg>
          MY BOARD
        </a>
      </li>
      <li>
        <a href="/project/memMyPage/memberMyVolPage.jsp" class="nav-link link-dark">
          <svg class="bi pe-none mr-auto" width="16" height="16"></svg>
          내 봉사 현황
        </a>
      </li>
      <li>
        <a href="/project/memMyPage/memberMyPointPage.jsp" class="nav-link link-dark">
          <svg class="bi pe-none mr-auto" width="16" height="16"></svg>
          포인트 이용 내역
        </a>
      </li>
      <li>
        <a href="/project/signup/userModifyForm.jsp" class="nav-link link-dark"> 
          <svg class="bi pe-none mr-auto" width="16" height="16"></svg>
          회원 정보 수정
        </a>
      </li>
    </ul>
		</div>
	<hr />
    <div class="dropdown">
      <a href="#" class="d-flex align-items-center link-dark text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
        <img src="/project/save/<%= member.getMemPhoto() %>" width="32" height="32" class="rounded-circle me-3">
        <strong><%= member.getMemName() %></strong>
      </a>
      <ul class="dropdown-menu text-small shadow">
        <li><a class="dropdown-item" href="/project/login/logoutPro.jsp">로그아웃</a></li>
      </ul>
    </div>
  </div>
  
  
  
  <%--	admin일때 분기처리 --%>
   <% } else { %>
     <div class="b-example-divider b-example-vr"></div>
  <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px;">
      <svg class="bi pe-none mr-auto" width="40" height="32"></svg>
      <span class="fs-4">MY PAGE</span>
       <div>
		<h3><%=userName %></h3>
	</div>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <a href= "/project/adminMyPage/adminMypage.jsp" class="nav-link link-dark">
          <svg class="bi pe-none mr-auto" width="16" height="16"></svg>
          회원관리
        </a>
      </li>
      <li>
        <a href= "/project/adminMyPage/pointShopAdmin.jsp" class="nav-link link-dark">
          <svg class="bi pe-none mr-auto" width="16" height="16"></svg>
          포인트샵 관리
        </a>
      </li>
      <li>
        <a href= "/project/adminMyPage/buyMemberList.jsp" class="nav-link link-dark">
          <svg class="bi pe-none mr-auto" width="16" height="16"></svg>
          포인트샵 구매회원 관리
        </a>
      </li>
      <li>
        <a href="/project/adminMyPage/mainBanImgAdmin.jsp" class="nav-link link-dark">
          <svg class="bi pe-none mr-auto" width="16" height="16"></svg>
          메인 배너 관리
        </a>
      </li>
      <li>
        <a href="/project/adminMyPage/homepageAdmin.jsp" class="nav-link link-dark">
          <svg class="bi pe-none mr-auto" width="16" height="16"></svg>
          홈페이지 관리
        </a>
      </li>
      <li>
        <a href="/project/signup/userModifyForm.jsp" class="nav-link active" aria-current="page">
          <svg class="bi pe-none me-2" width="16" height="16"></svg>
          정보수정
        </a>
      </li>
    </ul>
    <hr>
    <div class="dropdown">
      <a href="#" class="d-flex align-items-center link-dark text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
        <strong><%=userName %></strong>
      </a>
 
      <ul class="dropdown-menu text-small shadow">
		<li><a class="dropdown-item" href="/project/login/logoutPro.jsp">로그아웃</a></li>
      </ul>
    </div>
  </div>
  </main>
 <% } %>

<div class="container"> 
	<div class="row">
	<h2 align="left"><b>MY BOARD</b> <a href="/project/main/info.jsp" onclick="window.open(this.href, '_blank', 'width=1000, height=900'); return false;">&nbsp;<img src="/project/main/img/물음표.png"  width="20"></a></h2>
                           
	   			
                   <br/>
                  <%if(memdatadto.getMemLevel()==1){ %>
                     <p align="right">퀘스트 <%=quClearCount %>/1  모두 완료시 레벨업가능
                  <%   if(quClearCount <1){ %>
                        <button class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/main/levelCheck.jsp'" style="width:100px" style="float:right" disabled>레벨업</button>  <br/>
                  <%   }else{%>  
                          <button type="button" class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/main/levelCheck.jsp'" style="width:100px" style="float:right"> 레벨업 </button> <br/></p>
                      <div id="alertBox" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);">
                            <img src="img/레벨업2.gif" alt="축하이미지" width="250"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                             &nbsp;&nbsp;&nbsp;&nbsp;
                           <br/>
                      </div>
                <script>
                         document.getElementById("alertBox").style.display = '';
                      </script>
                  <%   }%>
                  <%}else if(memdatadto.getMemLevel()==2){%>
                     <p align="right">퀘스트 <%=quClearCount%>/6 모두 완료시 레벨업가능
                  <%   if(quClearCount <6){ %>
                        <button class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/main/levelCheck.jsp'" style="width:100px" style="float:right" disabled>레벨업</button>  <br/>
                  <%   }else{%>
                          <button type="button" class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/main/levelCheck.jsp'" style="width:100px" style="float:right"> 레벨업 </button>  <br/></p>
                      <div id="alertBox" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);">
                      <img src="img/레벨업2.gif" alt="축하이미지" width="250"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      &nbsp;&nbsp;&nbsp;&nbsp;
                         <br/>
                       
                </div>
               <%   }%>
            <%   }%>
            <div class="row">
			    <p align="left">
             	출석 이벤트 : <%= rouletteTryCount%> 회 
             	<%if(rouletteTryCount>0){ %>
             	<button class="btn btn-outline-secondary btn-sm" onclick="window.location='try2.jsp'">도전</button> &nbsp; &nbsp;
			    <% } %>
			    봉사 이벤트 : <%= rouletteVolTryCount%> 회 
            	 <%if(rouletteVolTryCount>0){ %>
          		   <button class="btn btn-outline-secondary btn-sm"  onclick="window.location='dice.jsp'">도전</button>
            		 <%}%>
			    </p>
                </div>        
            
        <br/>    
	<!-- 원래 부모였던 div -->
			    <div class="row" align="left">
			        
			        <!-- 새롭게 부모가 된 div -->
			        <div style="position:relative; float:right;" id="mypagetest" style="width: 75%; height: 315px;">
					        <!-- 자식 div -->
					        <div style="position:absolute; opacity:0.7; width:100%;height:100%; margin : 20px;">
						       <p align="left"">
					        <br />
                            	출석<%=memdatadto.getMemDayCount() %>회 <br />
                               <progress id="progress" value="<%=memdatadto.getMemDayCount() %>" max="50" style="width: 25%;" aria-valuenow="<%=memdatadto.getMemDayCount()*2%>" aria-valuemin="0" aria-valuemax="50"></progress> <b style="font-size: 13px;"><%=memdatadto.getMemDayCount()*2%>%</b> <br />                               
                               봉사시간<%=memdatadto.getMemVolTime() %>시간 <br />
                               <progress id="progress" value="<%=memdatadto.getMemVolTime() %>" max="40" style="width: 25%;" aria-valuenow="<%=memdatadto.getMemVolTime()*2.5%>" aria-valuemin="0" aria-valuemax="40"></progress><b style="font-size: 13px;"><%=memdatadto.getMemVolTime()*2.5%>%</b> <br />
                              봉사횟수<%=memdatadto.getMemVolCount() %>회<br />
                               <progress id="progress" value="<%=memdatadto.getMemVolCount() %>" max="20" style="width: 25%;" aria-valuenow="<%=memdatadto.getMemVolCount()*5%>" aria-valuemin="0" aria-valuemax="20"></progress><b style="font-size: 13px;"><%=memdatadto.getMemVolCount()*5%>%</b> <br />
                               포인트샵 누적 횟수<%=memdatadto.getMemBuyCount() %>회<br />
                               <progress id="progress" value="<%=memdatadto.getMemBuyCount() %>" max="10" style="width: 25%;" aria-valuenow="<%=memdatadto.getMemBuyCount()*10%>" aria-valuemin="0" aria-valuemax="10"></progress><b style="font-size: 13px;"><%=memdatadto.getMemBuyCount()*10%>%</b>  <br />
                               포인트샵 누적 금액<%=memdatadto.getMemBuyPoint() %>회<br />
                               <progress id="progress" value="<%=memdatadto.getMemBuyPoint() %>" max="5000" style="width: 25%;" aria-valuenow="<%=memdatadto.getMemBuyPoint()*0.02%>" aria-valuemin="0" aria-valuemax="5000"></progress><b style="font-size: 13px;"><%=memdatadto.getMemBuyPoint()*0.02%>%</b>
                            </p>
					        </div>
					      <% if(memdatadto.getMemLevel()==1){ %>
						<img src="/project/save/level1.gif" width="900px" height="315px" />
					      
					      <% }else{ %>
						<img src="/project/save/level2.gif" width="900px" height="315px" />
					      
					      <%} %>  
			        </div>  
			    </div>
						
			    
			    <br /> <br /> <br /> <br /> <br />  <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> 
			   
			    
			   

	   </div>
	
	   <%-- ******************* 엠블럼 ****************** --%>
	  <div class="row" style ="background-color : #fbfeef; border-radius: 16px">
	   <div class="col-sm" style="margin : 30px;">
		<h4 align="left"><b>✨ 나의 엠블럼 ✨</b></h4>
	   <table class="emblem" style="text-align: left">
	   <% if(list != null){ %>
	   	<tr>
	   			<td><b>출석 퀘스트</b></td>
	   		<% if(list.contains(11)){ %>
	   			<td><img src="/project/save/emblem/11_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(12)){ %>
	   			<td><img src="/project/save/emblem/12_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(13)){ %>
	   			<td><img src="/project/save/emblem/13_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(14)){ %>
	   			<td><img src="/project/save/emblem/14_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(15)){ %>
	   			<td><img src="/project/save/emblem/15_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   	
	   	</tr>
	   	
	   	<tr>
	   		<td><b>봉사 시간 퀘스트</b></td>
	   		<% if(list.contains(21)){ %>
	   			<td><img src="/project/save/emblem/11_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(22)){ %>
	   			<td><img src="/project/save/emblem/12_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(23)){ %>
	   			<td><img src="/project/save/emblem/13_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(24)){ %>
	   			<td><img src="/project/save/emblem/14_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(25)){ %>
	   			<td><img src="/project/save/emblem/15_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   	</tr>	
	   		
  	   	<tr>
  	   		<td><b>봉사 횟수 퀘스트</b></td>
  	   		<% if(list.contains(31)){ %>
	   			<td><img src="/project/save/emblem/11_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(32)){ %>
	   			<td><img src="/project/save/emblem/12_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(33)){ %>
	   			<td><img src="/project/save/emblem/13_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(34)){ %>
	   			<td><img src="/project/save/emblem/14_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(35)){ %>
	   			<td><img src="/project/save/emblem/15_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   	</tr>
	   	
	    <tr>
	    	<td><b>포인트샵 누적 구매 횟수 <br />퀘스트</b></td>
	    	<% if(list.contains(41)){ %>
	   			<td><img src="/project/save/emblem/11_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(42)){ %>
	   			<td><img src="/project/save/emblem/12_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(43)){ %>
	   			<td><img src="/project/save/emblem/13_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(44)){ %>
	   			<td><img src="/project/save/emblem/14_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(45)){ %>
	   			<td><img src="/project/save/emblem/15_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   	</tr>
	   
	   
	    <tr>
	    	<td><b>포인트샵 누적 구매 금액 <br /> 퀘스트</b></td>
	    	<% if(list.contains(51)){ %>
	   			<td><img src="/project/save/emblem/11_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(52)){ %>
	   			<td><img src="/project/save/emblem/12_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(53)){ %>
	   			<td><img src="/project/save/emblem/13_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(54)){ %>
	   			<td><img src="/project/save/emblem/14_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(55)){ %>
	   			<td><img src="/project/save/emblem/15_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   	</tr>
	   <% }else{ %>
	   <tr>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   </tr>
	   
      	<tr>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   </tr>
	   
	   <tr>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   </tr>
	   
	   <tr>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   </tr>
	   
	   <tr>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   </tr>
	   
	   
	   <% } %>
	   
	   </table>
	   </div>
	   
	   
      </div>
      
	   
	   
  </div>
	
	</div>

 </div>





<%-- 

	<div align="right">
		<table>
			<tr>
			<td>세션아이디: <%=id %> 회원분류: <%=category %></td>
				<td><button onclick="window.location='/project/login/logoutPro.jsp'">로그아웃</button></td>
				<td><button onclick="window.location='/project/memMyPage/memberMypage.jsp'">마이페이지</button></td>
			</tr>
		</table>
	</div>



	<h1 align="center"><a href="/project/main/memberMain.jsp">BALLOONTEER</a></h1>
	<nav>
		<ul>
			<li><a href="/project/volPage/volBoardMain.jsp">봉사</a></li>
			<li><a href="/project/freeBoard/freeBoardMain.jsp">자유게시판</a></li>
			<li><a href="/project/pointPage/pointShop.jsp">포인트샵</a></li>
			<li><a href="/project/infoPage/homepageInfo.jsp">소개</a></li>
		</ul>
	</nav>
	
	********************************************************************************************************************** 
   
   <div class="container">
      <div class="row">
          <div class="col-sm">
	         <aside>
	               <h3>MyPage</h3>
		            <ul>
		               <li><img src="/project/save/<%= member.getMemPhoto() %>" width="200"/></li>
		               <li><h3><%= member.getMemName() %></h3></li>
		               
		               <li><hr width="200px" align="left"/></li>
		               <li><a href ="memberMypage.jsp">My Board</a></li>
		               <li><a href ="memberMyVolPage.jsp">내 봉사 현황</a></li>
		               <li><a href ="memberMyPointPage.jsp">포인트 이용 내역</a></li>
		               <li>나의 작성글</li>
		               <li><a href= "/project/signup/userModifyForm.jsp"> 회원 정보 수정</a></li>
		            </ul>
	         </aside>
     	 </div>
     	 
	   	<div class="col-sm">
	   		<h2>MY BOARD <a href="/project/main/info.jsp" onclick="window.open(this.href, '_blank', 'width=1000, height=900'); return false;">&nbsp;<img src="/project/main/img/물음표.png"  width="20"></a></h2>
                           
	   			 <h5>현재 등급 : <%= memdatadto.getMemLevel() %></h5>
                 <h5>보유 포인트 : <%= memdatadto.getMemPoint()%></h5>
                  <%if(memdatadto.getMemLevel()==1){ %>
                     퀘스트 <%=quClearCount %>/1  모두 완료시 레벨업가능
                  <%   if(quClearCount <1){ %>
                        <button onclick="window.location='levelCheck.jsp'" disabled>레벨업</button>  <br/>
                  <%   }else{%>  
                          <button type="button" onclick="window.location='levelCheck.jsp'"> 레벨업 </button> <br/>
                      <div id="alertBox" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);">
                            <img src="img/레벨업2.gif" alt="축하이미지" width="250"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                             &nbsp;&nbsp;&nbsp;&nbsp;
                           <br/>
                      </div>
                <script>
                         document.getElementById("alertBox").style.display = '';
                      </script>
                  <%   }%>
                  <%}else if(memdatadto.getMemLevel()==2){%>
                     퀘스트 <%=quClearCount%>/6 모두 완료시 레벨업가능
                  <%   if(quClearCount <6){ %>
                        <button onclick="window.location='levelCheck.jsp'" disabled>레벨업</button>  <br/>
                  <%   }else{%>
                          <button type="button" onclick="window.location='levelCheck.jsp'"> 레벨업 </button>  <br/>
                      <div id="alertBox" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);">
                      <img src="img/레벨업2.gif" alt="축하이미지" width="250"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      &nbsp;&nbsp;&nbsp;&nbsp;
                         <br/>
                </div>
               <%   }%>
            <%   }%>
	   		
	   		
	   		<!-- 원래 부모였던 div -->
			    <div style="padding:10px;height:100px;">
			        
			        <!-- 새롭게 부모가 된 div -->
			        <div style="position:relative; width:100%;height:100%;">
			
				        <!-- 자식 div -->
				        <div style="position:absolute; opacity:0.7; width:100%;height:100%; padding:10px;">
					        봉사시간
	                        <%=memdatadto.getMemVolTime() %>시간
	                        <progress value="<%=memdatadto.getMemVolTime() %>" max="40"></progress><b><%=memdatadto.getMemVolTime()*2.5%>%</b> <br/>
	   
	                        봉사횟수
	                        <%=memdatadto.getMemVolCount() %>회
	                        <progress value="<%=memdatadto.getMemVolCount() %>" max="20"></progress><b><%=memdatadto.getMemVolCount()*5%>%</b> <br />
				        </div>
			
			        <img src="/project/save/mypagetest.gif"/>   
			
			        </div>  
			    </div>
			    
			    <br /> <br /> <br /> <br /> <br />  <br /> <br /> <br /> <br /> <br />
			    <br /> <br /> <br /> <br /> <br />  
			    
			   
             	기회 : <%= rouletteTryCount%> 회 
             	<%if(rouletteTryCount>0){ %>
             	<button><a href="try2.jsp" onclick="window.location='try2.jsp'">&nbsp;도전</a></button>
			    <% } %>
			    
			    
			    출석<%=memdatadto.getMemDayCount() %>회
                <progress value="<%=memdatadto.getMemDayCount() %>" max="50"></progress><b><%=memdatadto.getMemDayCount()*2%>%</b> <br />
                봉사시간<%=memdatadto.getMemVolTime() %>시간
                <progress value="<%=memdatadto.getMemVolTime() %>" max="40"></progress><b><%=memdatadto.getMemVolTime()*2.5%>%</b> <br />
   				봉사횟수<%=memdatadto.getMemVolCount() %>회
                <progress value="<%=memdatadto.getMemVolCount() %>" max="20"></progress><b><%=memdatadto.getMemVolCount()*5%>%</b> <br />
                포인트샵 누적 횟수<%=memdatadto.getMemBuyCount() %>회
                <progress value="<%=memdatadto.getMemBuyCount() %>" max="10"></progress><b><%=memdatadto.getMemBuyCount()*10%>%</b>  <br />
                포인트샵 누적 금액<%=memdatadto.getMemBuyPoint() %>회
                <progress value="<%=memdatadto.getMemBuyPoint() %>" max="5000"></progress><b><%=memdatadto.getMemBuyPoint()*0.02%>%</b>
                        <br />	

	   </div>
  </div>
  
  
  	  ******************* 엠블럼 ****************** 
	   <div class="col-sm">
	   <style>
		.emblem {
		  width: 100%;
		  border: 1px solid #444444;
		  padding: 0;
		  margin: 0;
		  border-spacing: 0;
		}
	   </style>
	   
	   <table class="emblem">
	   <% if(list != null){ %>
	   	<tr>
	   		<% if(list.contains(11)){ %>
	   			<td><img src="/project/save/emblem/11_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(12)){ %>
	   			<td><img src="/project/save/emblem/12_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(13)){ %>
	   			<td><img src="/project/save/emblem/13_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(14)){ %>
	   			<td><img src="/project/save/emblem/14_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(15)){ %>
	   			<td><img src="/project/save/emblem/15_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   	
	   	</tr>
	   	
	   	<tr>
	   		<% if(list.contains(21)){ %>
	   			<td><img src="/project/save/emblem/11_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(22)){ %>
	   			<td><img src="/project/save/emblem/12_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(23)){ %>
	   			<td><img src="/project/save/emblem/13_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(24)){ %>
	   			<td><img src="/project/save/emblem/14_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(25)){ %>
	   			<td><img src="/project/save/emblem/15_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   	</tr>	
	   		
  	   	<tr>
  	   		<% if(list.contains(31)){ %>
	   			<td><img src="/project/save/emblem/11_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(32)){ %>
	   			<td><img src="/project/save/emblem/12_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(33)){ %>
	   			<td><img src="/project/save/emblem/13_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(34)){ %>
	   			<td><img src="/project/save/emblem/14_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(35)){ %>
	   			<td><img src="/project/save/emblem/15_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   	</tr>
	   	
	    <tr>
	    	<% if(list.contains(41)){ %>
	   			<td><img src="/project/save/emblem/11_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(42)){ %>
	   			<td><img src="/project/save/emblem/12_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(43)){ %>
	   			<td><img src="/project/save/emblem/13_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(44)){ %>
	   			<td><img src="/project/save/emblem/14_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(45)){ %>
	   			<td><img src="/project/save/emblem/15_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   	</tr>
	   
	   
	    <tr>
	    	<% if(list.contains(51)){ %>
	   			<td><img src="/project/save/emblem/11_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(52)){ %>
	   			<td><img src="/project/save/emblem/12_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(53)){ %>
	   			<td><img src="/project/save/emblem/13_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(54)){ %>
	   			<td><img src="/project/save/emblem/14_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   		
	   		<% if(list.contains(55)){ %>
	   			<td><img src="/project/save/emblem/15_em.png" width="80px"/></td>
	   		<% }else{ %>
	   			<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   		<% } %>
	   	</tr>
	   <% }else{ %>
	   <tr>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   </tr>
	   
      	<tr>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   </tr>
	   
	   <tr>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   </tr>
	   
	   <tr>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   </tr>
	   
	   <tr>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
		   	<td><img src="/project/save/emblem/emblem.png" width="80px"/></td>
	   </tr>
	   
	   
	   <% } %>
	   
	   </table>
	   </div>
	   
	   
      </div>
      
       --%>

<% } %>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
<script src="/docs/5.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>	

</body>
<%-- ***********푸터(0801 수정) *********** --%>
<br /><br /><br />
<div class="container">
  <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
    <p class="col-md-4 mb-0 text-muted">&copy; BallonTeer (사단법인희망풍선)</p>

    <a href="/" class="col-md-4 d-flex align-items-center justify-content-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
      <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
    </a>

    <ul class="nav col-md-4 justify-content-end">
         <%if (session.getAttribute("memId")==null){ %>
            <li class="nav-item"><a href="/project/main/main.jsp" class="nav-link px-2 text-muted">메인</a></li>
      <% }else { %>
         <%if(category.equals("mem")){ %>
            <li class="nav-item"><a href="/project/main/memberMain.jsp" class="nav-link px-2 text-muted">메인</a></li>
         <% } else { %>
            <li class="nav-item"><a href="/project/main/main.jsp" class="nav-link px-2 text-muted">메인</a></li>
         <% } 
         } %>
         
      <li class="nav-item"><a href="/project/volPage/volBoardMain.jsp" class="nav-link px-2 text-muted">봉사</a></li>
      <li class="nav-item"><a href="/project/pointPage/pointShop.jsp" class="nav-link px-2 text-muted">포인트샵</a></li>
      <li class="nav-item"><a href="/project/freeBoard/freeBoardMain.jsp" class="nav-link px-2 text-muted">자유게시판</a></li>
      
      <% if(category != null){ %>
         <% if(category.equals("mem")){ %>
            <li class="nav-item"><a href="/project/memMyPage/memberMypage.jsp" class="nav-link px-2 text-muted">마이페이지</a></li>
         <% }else if(category.equals("cen")){ %>
            <li class="nav-item"><a href="/project/cenMyPage/centerMypage.jsp" class="nav-link px-2 text-muted">마이페이지</a></li>
         <% }else if(category.equals("admin")){ %>
            <li class="nav-item"><a href="/project/adminMyPage/adminMypage.jsp" class="nav-link px-2 text-muted">마이페이지</a></li>
         <% } 
      }%>
    </ul>
  </footer>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>