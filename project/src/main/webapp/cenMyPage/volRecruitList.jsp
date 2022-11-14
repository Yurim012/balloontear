<%@page import="project.signup.model.MemberSignupDTO"%>
<%@page import="project.volPage.model.VolApplyBoardDTO"%>
<%@page import="project.volPage.model.VolApplyBoardDAO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@page import="project.volPage.model.VolBoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="project.volPage.model.VolBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>모집중 공고 전체보기</title>
	<%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
	<%-- 부트스트랩 --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	<link href="/docs/5.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	
	<link rel="stylesheet" href="/project/css/centerMypageStyle.css" type="text/css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300&display=swap" rel="stylesheet">
	
	<style>
	.container{
	padding-right: 20px;
	padding-bottom: 20px;
	padding-left: 20px;
	}
	
	
	</style>
</head>
<% 
	

	   String id = (String)session.getAttribute("memId");
		
		if(id== null || id.equals(null) || id.equals("null")) { %>
		<script>
		alert("로그인 후 이용해주세요")
		window.location.href="/project/main/main.jsp";
		</script>
		<% }else { 
	   
	   MemberSignupDAO dao = new MemberSignupDAO();
	   //아이디 주고 카테고리 찾아오기 
	   String category = dao.categorySeach(id);
	   //아이디 주고 이름 찾아오기
	   String userName = dao.getName(id);
	   
	   MemberSignupDAO memDAO = new MemberSignupDAO();
	   MemberSignupDTO member = memDAO.getMember(id); 
	   
	   // 현재 요청된 게시판 페이지 번호
	   String pageNum = request.getParameter("pageNum");
	   if(pageNum == null
	         || pageNum.equals("null")
	         || pageNum.equals("")){
	      pageNum = "1";
	   } // 만약pageNum이 0이면 1값 주기
	   System.out.println("pageNum : " + pageNum);
	   
	   // 현재 페이지에서 보여줄 게시글의 시작과 끝 등의 정보 세팅
	   int pageSize = 10;
	   int currentPage = Integer.parseInt(pageNum);
	   int startRow = (currentPage -1 ) * pageSize + 1;
	   int endRow = currentPage * pageSize;
	   
	   VolBoardDAO volboarddao = new VolBoardDAO(); 
	    
	   // 전체 글의 개수 구하고, 
	   // DB에서 전체 글 개수 가져오기
	   int count = 0;             // (전체/검색) 전체 글 개수 담을 변수 
   		List<VolBoardDTO> volList = null;    // (전체/검색) 글 목록 리턴받을 변수 
   
   // 검색 여부 판단 +//위 검색 여부 
      String sel = request.getParameter("sel");
      String search = request.getParameter("search"); 
      String topSel = "volCategory";
      String topSelVal = request.getParameter("topSelVal");
      if(sel != null && search != null) { // 검색일때 
         count = volboarddao.getVolSearchCount(sel, search);  // 검색에 맞는 게시글에 개수 가져오기 
         if(count > 0) { 
            // 검색한 글 목록 가져오기 
            volList = volboarddao.getVolSearch(startRow, endRow, sel, search);  
         }
      }else { // 일반 게시판일때 
         count = volboarddao.getVolCountWithCen(userName);  // 그냥 전체 게시글 개수 가져오기 
         // 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
         if(count > 0){
            volList = volboarddao.getVolWithCen(startRow, endRow, userName);  
         }
      } 
      System.out.println("article count : " + count);
      System.out.println(volList);
      
      int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글번호(bno아님)
     
	   
	%>
<body class="text-center">
 <% if (session.getAttribute("memId")==null){ %>
   <div align="right">
      <table>
         <tr>
         <td>세션아이디: <%=id %> 회원분류: <%=category %></td>
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
  	<div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 250px;">
		<svg class="bi pe-none me-5" width="40" height="32"></svg>
		<span class="fs-4">MY PAGE</span>
       <div>
			<h3><%= member.getMemName() %></h3>
		</div>
    
    <hr>
    
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <a href ="/project/memMyPage/memberMypage.jsp" class="nav-link-active" aria-current="page">
          <svg class="bi pe-none mr-auto" width="16" height="16"></svg>
          MY BOARD
        </a>
      </li>
      <li>
        <a href="/project/memMyPage/memberMyVolPage.jsp" class="nav-link link-dark" >
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
    <hr>
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
  <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px; border-radius: 16px;">
      <svg class="bi pe-none me-5" width="40" height="32"></svg>
      <span class="fs-4">MY PAGE</span>
      <div>
       <%=userName %>
	</div>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <a href ="/project/cenMyPage/centerMypage.jsp" class="nav-link-active" aria-current="page">
          <svg class="bi pe-none mr-auto" width="16" height="16"></svg>
          봉사 모집 현황
        </a>
      </li>
      <li>
        <a href= "/project/signup/userModifyForm.jsp" class="nav-link link-dark" >
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
    </a>
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
				<h4 align="center"><b>모집중 공고 전체목록</b></h4>
					<button class="btn btn-outline-secondary btn-sm" id="moreButton" onclick="window.location='centerMypage.jsp'">마이페이지로 돌아가기</button>
				<br />
				<hr />
                    <table class="tableList">
                    <% if(volList == null){ %>
                    	<tr>
                    		<td>게시글이 없습니다.</td>
                    	</tr>
                    </table>
                    <% }else{ %>
                    <%-- 반복해서 뿌리기  --%>
                    <table class="tableList">
                         <tr>
                           <td class="tableTd">제목</td>
                           <td class="tableTd">봉사시작일</td>
                           <td class="tableTd">봉사종료일</td>
                           <td class="tableTd">모집현황</td>
                           <td class="tableTd">지원자보기</td>
                        </tr>            
                     <%for(int i = 0; i < volList.size(); i++){ 
                           VolBoardDTO volArticle= volList.get(i); 
                           	if(volArticle.getVolStatus() == -1 || volArticle.getVolStatus() == 0){
                           		if(volArticle.getMemId().equals(userName)){%>
                        <tr>
                           <td class="tableTd"><a href="/project/volPage/volContent.jsp?volNo=<%=volArticle.getVolNo()%>"><%=volArticle.getVolSubject()%></a></td>
                           <td class="tableTd"><%=volArticle.getVolStartDate()%></td>
                           <td class="tableTd"><%=volArticle.getVolEndDate()%></td>
                           <td class="tableTd">
                           <%if(volArticle.getVolStatus() == -1){ %>
                           모집예정
                           <%}else{ %>
                           봉사진행중
                           <%} %>
                           </td>
                           <td class="tableTd">
                          	 <button class="btn btn-outline-secondary btn-sm" onclick="window.location='volIngApplyList.jsp?volNo=<%=volArticle.getVolNo()%>'">지원자 보기</button>
                           </td>
                        </tr>
                        <%} %>
                        <%} %>
                     <%}//for문 //(int i = 0; i < volList.size(); i++)%>
   					<%}//else %>
                    </table>
                    </div>
          </div>                
	

	
	
	<%-- 페이지 넘버링 + 검색창 --%>
	<br />
 	<%-- 게시판 목록 페이지 번호 뷰어  --%>
 	<div class="row">
   	<div align="center">
   	<% if(count > 0) { 
         // 한페이지에 보여줄 번호의 개수 
         int pageNumSize = 5; 
         // 총 몇페이지 나오는지 계산 
         int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
         // 현재 페이지에 띄울 첫번째 페이지 번호 
         int startPage = ((currentPage - 1) / pageSize) * pageNumSize + 1; 
         // 현재 페이지에 띄울 마지막 페이지번호  (startPage ~ endPage까지 번호 반복해서 뿌릴)
         int endPage = startPage + pageNumSize - 1; 
      if(endPage > pageCount) { endPage = pageCount; } // 마지막 페이지번호 조정 

      if(startPage > pageNumSize) { 
         if(sel != null && search != null) { %>
            <a class="Atitle" href="volEndRecruitList.jsp?pageNum=<%=startPage-1%>&sel=<%=sel%>&search=<%=search%>"> &lt; &nbsp; </a>
         <%}else{%>
            <a class="Atitle" href="volEndRecruitList.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
         <%}
      }
      
      for(int i = startPage; i <= endPage; i++) { 
         if(sel != null && search != null) { %>
            <a class="Atitle" href="volRecruitList.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
         <%}else{ %>
            <a class="Atitle" href="volRecruitList.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
         <%} 
      }
      
      if(endPage < pageCount) { 
         if(sel != null && search != null) { %>
            <a class="Atitle" href="volRecruitList.jsp?pageNum=<%=startPage+pageNumSize%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; &gt; </a>
      <%   }else{ %>
            <a class="Atitle" href="volRecruitList.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
      <%}
      } 
      } %>

      <br /><br />
       <%-- 작성자/내용 검색 --%>
      <form action="volRecruitList.jsp">
         <select name="sel">
            <option value="volSubject" selected>제목</option>
            <option value="volCategory">카테고리</option>
         </select>
         <input type="text" name="search" /> 
         <input class="btn btn-outline-secondary btn-sm" type="submit" value="검색" />
      </form>
      <br />
      
      <button class="btn btn-outline-secondary btn-sm" onclick="window.location='volRecruitList.jsp'"> 전체 목록 </button>
   
   </div>
 	</div>
 </div>
 </div>
	
	
	<%-- 
	
	<body>
	<div class="container">
		<div class="row">
			<div class="col-sm">
	
	<h2>MY BOARD</h2>
					<button onclick="window.location='/project/main/main.jsp'">메인으로 돌아가기</button>
					<button onclick="window.location='centerMypage.jsp'">마이페이지로 돌아가기</button>
                    <h2>모집중 공고</h2>
                    <table>
                    <% if(volList == null){ %>
                    	<tr>
                    		<td>게시글이 없습니다.</td>
                    	</tr>
                    </table>
                    <table>
                    <% }else{ %>
                    <%-- 반복해서 뿌리기  
                         <tr>
                           <td>제목</td>
                           <td>봉사시작일</td>
                           <td>봉사종료일</td>
                           <td>모집현황</td>
                           <td>지원자보기</td>
                        </tr>            
                     <%for(int i = 0; i < volList.size(); i++){ 
                           VolBoardDTO volArticle= volList.get(i); 
                           	if(volArticle.getVolStatus() == -1 || volArticle.getVolStatus() == 0){
                           		if(volArticle.getMemId().equals(userName)){%>
                        <tr>
                           <td><a href="/project/volPage/volContent.jsp?volNo=<%=volArticle.getVolNo()%>"><%=volArticle.getVolSubject()%></a></td>
                           <td><%=volArticle.getVolStartDate()%></td>
                           <td><%=volArticle.getVolEndDate()%></td>
                           <td>
                           <%if(volArticle.getVolStatus() == -1){ %>
                           모집예정
                           <%}else{ %>
                           봉사진행중
                           <%} %>
                           </td>
                           <td>
                          	 <button onclick="window.location='volIngApplyList.jsp?volNo=<%=volArticle.getVolNo()%>'">지원자 보기</button>
                           <td>
                        </tr>
                        <%} %>
                        <%} %>
                     <%}//for문 //(int i = 0; i < volList.size(); i++)%>
   					<%}//else %>
                    </table>
                    </div>
          </div>  row                   
	</div> container 

	
	
	<%-- 페이지 넘버링 + 검색창 
	<br />
 	<%-- 게시판 목록 페이지 번호 뷰어 
   	<div align="center">
   	<% if(count > 0) { 
         // 한페이지에 보여줄 번호의 개수 
         int pageNumSize = 5; 
         // 총 몇페이지 나오는지 계산 
         int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
         // 현재 페이지에 띄울 첫번째 페이지 번호 
         int startPage = ((currentPage - 1) / pageSize) * pageNumSize + 1; 
         // 현재 페이지에 띄울 마지막 페이지번호  (startPage ~ endPage까지 번호 반복해서 뿌릴)
         int endPage = startPage + pageNumSize - 1; 
      if(endPage > pageCount) { endPage = pageCount; } // 마지막 페이지번호 조정 

      if(startPage > pageNumSize) { 
         if(sel != null && search != null) { %>
            <a class="pageNums" href="volEndRecruitList.jsp?pageNum=<%=startPage-1%>&sel=<%=sel%>&search=<%=search%>"> &lt; &nbsp; </a>
         <%}else{%>
            <a class="pageNums" href="volEndRecruitList.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
         <%}
      }
      
      for(int i = startPage; i <= endPage; i++) { 
         if(sel != null && search != null) { %>
            <a class="pageNums" href="volEndRecruitList.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
         <%}else{ %>
            <a class="pageNums" href="volEndRecruitList.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
         <%} 
      }
      
      if(endPage < pageCount) { 
         if(sel != null && search != null) { %>
            <a class="pageNums" href="volEndRecruitList.jsp?pageNum=<%=startPage+pageNumSize%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; &gt; </a>
      <%   }else{ %>
            <a class="pageNums" href="volEndRecruitList.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
      <%}
      } 
      } %>

      <br /><br />
       <%-- 작성자/내용 검색 
      <form action="volRecruitList.jsp">
         <select name="sel">
            <option value="volSubject" selected>제목</option>
            <option value="volCategory">카테고리</option>
         </select>
         <input type="text" name="search" /> 
         <input type="submit" value="검색" />
      </form>
      <br />
      
      <button onclick="window.location='volRecruitList.jsp'"> 전체 목록 </button>
   
   </div>
   
	
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
      <svg class="bi me-2" width="40" height="32"></svg>
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
  <% } %>
</html>