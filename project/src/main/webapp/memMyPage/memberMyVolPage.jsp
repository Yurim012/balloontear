<%@page import="project.volPage.model.VolBoardDTO"%>
<%@page import="project.volPage.model.VolBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="project.volPage.model.VolApplyBoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="project.volPage.model.VolApplyBoardDAO"%>
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
	<title>내 봉사내역</title>
	<%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
	<%-- 부트스트랩 --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	<link href="/docs/5.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	
	<link rel="stylesheet" href="/project/css/memberMypageStyle.css" type="text/css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300&display=swap" rel="stylesheet">
	
	<style>
	.container{
	padding-right: 100px;
	padding-bottom: 100px;
	padding-left: 100px;
	}
	
   </style>
</head>
<% 
		String id = (String)session.getAttribute("memId");
		String category = null;
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
	   
	   
	   // 페이징 처리    
	   String pageNum = request.getParameter("pageNum");
	   if(pageNum == null){ // pageNum 파라미터 안넘어오면, 1페이지 보여지게 
	      pageNum = "1";   // 1로 값 체우기 
	   }
	   System.out.println("pageNum : " + pageNum);
	   
	   int pageSize = 10;  // 현재 페이지에서 보여줄 글 목록의 수 
	   int currentPage = Integer.parseInt(pageNum); // pageNum을 int로 형변환 -> 숫자 연산 
	   int startRow = (currentPage - 1) * pageSize + 1; 
	   int endRow = currentPage * pageSize; 
	   
	   // vol넘 주면 해당 봉사 정보 가져오는 메서드 실행
	   VolBoardDAO volDAO = new VolBoardDAO();
	   
	   
	   
	   // 봉사 리스트 가져오기
	   // 내가 신청한 전체 봉사 개수 가져오기
	   VolApplyBoardDAO volApplyDAO = new VolApplyBoardDAO();
	   
	   int count = 0;
	   List<VolApplyBoardDTO> applyList = null;
	   count = volApplyDAO.getmyApplyVolCount(id);
	   System.out.println("내가 신청한 봉사 갯수 " + count);
	   if(count > 0){
		   applyList = volApplyDAO.getMyVolAllList(startRow, endRow, id);
	   }
	   int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글번호(bno아님)
	      SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm"); 
	   
	%>
	


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
         <td><%=id %>님 환영합니다 </td>
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
            <a class="Atitle" href="/project/main/main.jsp"><h2 align="center" id="homeTitle">BALLOONTEER</h2></a>
      <% }else { %>
         <%if(category.equals("mem")){ %>
            <a class="Atitle" href="/project/main/memberMain.jsp"><h2 align="center" id="homeTitle">BALLOONTEER</h2></a>
         <% } else { %>
            <a class="Atitle" href="/project/main/main.jsp"><h2 align="center" id="homeTitle">BALLOONTEER</h2></a>
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
	<div class ="container" justify-content-md-center"> 
	<main class="d-flex flex-nowrap" >
 	<% if(category.equals("mem")){  // 카테고리가 mem이면 개인회원 폼띄워주기 %>
  	<div class="b-example-divider b-example-vr"></div>
  	<div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 250px; border-radius: 16px;">
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
        <a href ="/project/memMyPage/memberMypage.jsp" class="nav-link link-dark">
          <svg class="bi pe-none mr-auto" width="16" height="16"></svg>
          MY BOARD
        </a>
      </li>
      <li>
        <a href="/project/memMyPage/memberMyVolPage.jsp" class="nav-link-active" aria-current="page">
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
  
  <%-- 센터일때 분기처리 --%>
 <% }else if(category.equals("cen")){ %>
    <div class="b-example-divider b-example-vr"></div>
  <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px;">
      <svg class="bi pe-none me-5" width="40" height="32"></svg>
      <span class="fs-4">MY PAGE</span>
      <div>
       <%=userName %>
	</div>

    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <a href= "/project/cenMyPage/centerMypage.jsp" class="nav-link link-dark">
          <svg class="bi pe-none mr-auto" width="16" height="16"></svg>
          봉사 모집 현황
        </a>
      </li>
      <li>
        <a href= "/project/signup/userModifyForm.jsp" class="nav-link active" aria-current="page">
          <svg class="bi pe-none mr-auto" width="16" height="16"></svg>
          회원 정보 수정
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
	   	<div class="col-sm">
	   		<h4 align="center"><b>내 봉사 현황</b></h4>
		   <br />
		   <hr />
	   		<% if(count == 0){ %>
	   			<table class="tableList">
				<tr>
					<td class="tableTd"><b>No.</b></td>	  
					<td class="tableTd"><b>봉사명</b></td>	 		
		   			<td class="tableTd"><b>센터명</b></td>	
					<td class="tableTd"><b>봉사시간</b></td>	
					<td class="tableTd"><b>봉사날짜</b></td>
					<td class="tableTd"><b>신청날짜</b></td>
					<td class="tableTd"><b>신청관리</b></td>	
					<td class="tableTd"><b>인증서 출력</b></td>
				</tr>	
				<tr>
					<td colspan="8">신청한 봉사가 없습니다.</td>
				</tr>
	   		</table>
	   		<% } else { %>
	
	   		
		   		<table class="tableList">
				<tr>
					<td class="tableTd"><b>No.</b></td>	  
					<td class="tableTd"><b>봉사명</b></td>	 		
		   			<td class="tableTd"><b>센터명</b></td>	
					<td class="tableTd"><b>봉사시간</b></td>	
					<td class="tableTd"><b>봉사날짜</b></td>
					<td class="tableTd"><b>신청날짜</b></td>
					<td class="tableTd"><b>신청관리</b></td>	
					<td class="tableTd"><b>인증서 출력</b></td>
				</tr>	
					
					   <% 
                  int apnum = 0;
                  if(applyList != null){
                     for(int i = 0; i < applyList.size() ; i++){ 
                           VolApplyBoardDTO myVolApplyDTO = applyList.get(i);
                           VolBoardDTO volDTO = volDAO.getMemOneVolContent(myVolApplyDTO.getVolNo());
                           MemberSignupDTO ceninfo = memDAO.getMemberMypage(volDTO.getMemId());
                           
                            System.out.println("getMemId " + volDTO.getMemId());
                            System.out.println("내가 신청한 봉사 갯수 " + count);
                            
                      %>
					
					
					<tr>
						<td class="tableTd"><%= number-- %></td>
						<td class="tableTd"><%= volDTO.getVolSubject()%></td>
						<td class="tableTd"><%= ceninfo.getMemName()%></td>
						<td class="tableTd"><%= volDTO.getVolTime() %></td>
						<td class="tableTd"><%= myVolApplyDTO.getSelDate() %></td>
						<td class="tableTd"><%= myVolApplyDTO.getApplyDate() %></td>
						
						<% if(myVolApplyDTO.getMemActivity() == -1){
							apnum = myVolApplyDTO.getApplyNo();  %>
						<td><button type="button" onclick="myConfirm('<%=apnum %>')" class="btn btn-outline-secondary btn-sm">취소</button></td>
						<%-- <td><button type="button" onclick="window.location='volApplyCancel.jsp?applyNo=<%= myVolApplyDTO.getApplyNo()%>&memId=<%= id %>'" class="btn btn-outline-secondary btn-sm">취소</button></td>--%>
						<% }else{ %> 
						<td><button  type="button" disabled class="btn btn-outline-secondary btn-sm">완료</button></td>
						<% } %>
						<% if(myVolApplyDTO.getMemActivity() == 1){ 
								apnum = myVolApplyDTO.getApplyNo(); %>
							<td><input type="button" onclick="print('<%=apnum %>')" class="btn btn-outline-secondary btn-sm" value="출력"/></td>
						<% }else{ %>
							<td><input type="button" disabled class="btn btn-outline-secondary btn-sm" value="출력"/></td>
							<% } %> 
						
					</tr>
					
					<% } 
					} %>
	   			</table>

				<script>
					function myConfirm(apnum) {
					                    
					var ok = confirm("신청을 취소하시겠습니까?")
						if(ok) location.href='volApplyCancel.jsp?applyNo='+apnum;
					}
					
					function print(apnum){
						window.open("print.jsp?applyNo="+apnum, "a", "width=900, height=1200");
						
						
					}
				
				</script>
				
	   		<% } %>
		</div>
  	</div>
  </div>
</div>


<% } %>




<%-- 
<body>
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
		               <li><a href = "memberMypage.jsp">My Board</a></li>
		               <li><a href ="memberMyVolPage.jsp">내 봉사 현황</a></li>
		               <li><a href ="memberMyPointPage.jsp">포인트 이용 내역</a></li>
		               <li>나의 작성글</li>
		               <li><a href= "/project/signup/userModifyForm.jsp"> 회원 정보 수정</a></li>
		            </ul>
	         </aside>
     	 </div>
     	 
	   	<div class="col-sm">
	   		<h2>내 봉사 현황</h2>
	   		<% if(count == 0){ %>
	   			<table>
				<tr>
					<td>No.</td>	  
					<td>봉사명</td>	 		
		   			<td>센터명</td>	
					<td>봉사시간</td>	
					<td>봉사날짜</td>	
					<td>신청관리</td>	
					<td>인증서 출력</td>
				</tr>	
				<tr>
					<td>신청한 봉사가 없습니다.</td>
				</tr>
	   		</table>
	   		<% } else { %>
	
	   		
		   		<table>
					<tr>
						<td>No.</td>	  
						<td>봉사명</td>	 		
			   			<td>센터명</td>	
						<td>봉사시간</td>	
						<td>봉사날짜</td>	
						<td>신청날짜</td>	
						<td>신청관리</td>	
						<td>인증서 출력</td>
					</tr>	
					
					   <% 
                  int apnum = 0;
                  if(applyList != null){
                     for(int i = 0; i < applyList.size() ; i++){ 
                           VolApplyBoardDTO myVolApplyDTO = applyList.get(i);
                           VolBoardDTO volDTO = volDAO.getMemOneVolContent(myVolApplyDTO.getVolNo());
                           MemberSignupDTO ceninfo = memDAO.getMemberMypage(volDTO.getMemId());
                           
                            System.out.println("getMemId " + volDTO.getMemId());
                            System.out.println("내가 신청한 봉사 갯수 " + count);
                            
                      %>
					
					
					<tr>
						<td><%= number-- %></td>
						<td><%= volDTO.getVolSubject()%></td>
						<td><%= ceninfo.getMemName()%></td>
						<td><%= volDTO.getVolTime() %></td>
						<td><%= myVolApplyDTO.getSelDate() %></td>
						<td><%= myVolApplyDTO.getApplyDate() %></td>
						
						<% if(myVolApplyDTO.getMemActivity() == -1){
							apnum = myVolApplyDTO.getApplyNo();  %>
						<td><button onclick="myConfirm('<%=apnum %>')">취소</button></td>
							// <td><button onclick="window.location='volApplyCancel.jsp?applyNo=<%= myVolApplyDTO.getApplyNo()%>&memId=<%= id %>'">취소</button></td>
						<% }else{ %> 
						<td><button  disabled>완료</button></td>
						<% } %>
						<% if(myVolApplyDTO.getMemActivity() == 1){ 
								apnum = myVolApplyDTO.getApplyNo(); %>
							<td><button onclick="print('<%=apnum %>')">출력</button></td>
						<% }else{ %>
							<td><button disabled>출력</button></td>
							<% } %> 
						
					</tr>
					
					<% } 
					} %>
	   			</table>

				<script>
				function myConfirm(apnum) {
				                    
				var ok = confirm("신청을 취소하시겠습니까?")
					if(ok) location.href='volApplyCancel.jsp?applyNo='+apnum;
				}
				
				function print(apnum){
					window.open("print.jsp?applyNo="+apnum, "a", "width=600, left=100, top=50");
					
				}
				
				</script>
	   		<% } %>
		</div>
  	</div>
  </div>


<% } %>

--%>


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
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>