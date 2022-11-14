<%@page import="project.adminMyPage.model.AdminDateDAO"%>
<%@page import="project.pointPage.model.BuyBoardDAO"%>
<%@page import="project.pointPage.model.BuyBoardDTO"%>
<%@page import="project.pointPage.model.ShopBoardDTO"%>
<%@page import="project.pointPage.model.ShopBoardDAO"%>
<%@page import="project.memMyPage.model.MemDataDTO"%>
<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="project.signup.model.MemberSignupDTO"%>
<%@page import="project.volPage.model.VolBoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="project.volPage.model.VolBoardDAO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>구매회원 관리</title>
	<%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
	<%-- 부트스트랩 --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	<link href="/docs/5.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	
	<link rel="stylesheet" href="/project/css/adminMypageStyle.css" type="text/css">
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
	   MemberSignupDAO signdao = new MemberSignupDAO();
	   
	   if(id== null || id.equals(null) || id.equals("null")) { %>
	   <script>
	   alert("로그인 후 이용해주세요")
	   window.location.href="/project/main/main.jsp";
	   </script>
	   <% }else { 
	   
	   ShopBoardDAO shopDAO = new ShopBoardDAO();
	   BuyBoardDAO buyDAO = new BuyBoardDAO();
	   AdminDateDAO adDAO = new AdminDateDAO();
	   String category = "";
	   String userName = "";
	 //아이디 주고 카테고리 찾아오기 메서드 만들기
	 
	  MemberSignupDTO member = signdao.getMember(id);
		
		if(id != null){
		      category = signdao.categorySeach(id);
		      userName = signdao.getName(id);
		}else{
		   category = "null";
		}

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
		   

	   
	   int count = 0;
	   List<BuyBoardDTO> buyList = null;
	   
	   // 검색 여부 판단 + 상단 검색 여부
	   String sel = request.getParameter("sel");
	   String search = request.getParameter("search");
	   
	   if(sel != null && search != null){  // 일반 검색일 때
		  	count = buyDAO.getBuyMemSearchCount(sel, search);   
	 		System.out.println("하단 검색 고객 수  : " + count);
	   		if(count > 0){
	   			buyList = buyDAO.getBuyMemSearch(startRow, endRow, sel, search); 
	   		}
		   
	   }else{
		   count = buyDAO.getBuyMemCount(); 
	   		System.out.println("제품 구매 고객 : " + count);
		   if(count > 0){
			   buyList = buyDAO.getBuyMemAllList(startRow, endRow);   
		   }
		   
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
  <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px;">
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
 	 <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px; border-radius: 16px";>
      <svg class="bi pe-none me-5" width="40" height="32"></svg>
      <span class="fs-4">MY PAGE</span>
       <div>
		<h3><%=userName %></h3>
	</div>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <a href="/project/adminMyPage/adminMypage.jsp" class="nav-link link-dark">
          <svg class="bi pe-none mr-auto"  width="16" height="16"></svg>
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
        <a href= "/project/adminMyPage/buyMemberList.jsp" class="nav-link active" aria-current="page">
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
        <a href="/project/signup/userModifyForm.jsp" class="nav-link link-dark">
          <svg class="bi pe-none mr-auto" width="16" height="16"></svg>
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
  
  
 <% } %>
			
	<div class="container"> 
		<div class="row">
			<div class="col-sm">
			<h4 align="center"><b>포인트샵 구매회원 관리</b></h4>
			<br />
		  	<hr />
		        <% if(count == 0){ %>
	   			<table class="tableList">
					<tr>
						<td class="tableTd"><b>No.</b></td>	  
						<td class="tableTd"><b>구매번호</b></td>	
						<td class="tableTd"><b>상품번호</b></td> 		
			   			<td class="tableTd"><b>상품명</b></td>	
						<td class="tableTd"><b>회원ID</b></td>	
						<td class="tableTd"><b>회원명</b></td>	
						<td class="tableTd"><b>결제 가격</b></td>
						<td class="tableTd"><b>구매날짜</b></td>
						<td class="tableTd"><b>배송상태</b></td>
						<td class="tableTd"><b>발송</b></td>
					</tr>	
					<tr>
						<td>상품을 구매한 고객이 없습니다.</td>
					</tr>
	   			</table>
	   		<% } else { // 상품이 있으면 %>
  				<table class="tableList">
					<tr>
						<td class="tableTd"><b>No.</b></td>	  
						<td class="tableTd"><b>구매번호</b></td>	
						<td class="tableTd"><b>상품번호</b></td> 		
			   			<td class="tableTd"><b>상품명</b></td>	
						<td class="tableTd"><b>회원ID</b></td>	
						<td class="tableTd"><b>회원명</b></td>	
						<td class="tableTd"><b>결제 가격</b></td>
						<td class="tableTd"><b>구매날짜</b></td>
						<td class="tableTd"><b>배송상태</b></td>
						<td class="tableTd"><b>발송</b></td>
					</tr>	
					<%-- 회원 목록 반복해서 뿌리기 	--%>
					<% 
						for(int i=0 ; i < buyList.size() ; i++){
							BuyBoardDTO buymemDTO = buyList.get(i);
							
							ShopBoardDTO buyShopDTO = shopDAO.getOneShopContent(buymemDTO.getsNo());
							if(buyShopDTO != null){
							MemberSignupDTO memDTO = signdao.getMember(buymemDTO.getMemId());
					%>
					<tr>
						<td class="tableTd"><%= number-- %></td>
						<td class="tableTd"><%= buymemDTO.getBuyNo()%></td>
						<td class="tableTd"><%= buymemDTO.getsNo() %></td>
						<td class="tableTd"><%= buyShopDTO.getGoodsName() %></td>
						<td class="tableTd"><%= buymemDTO.getMemId() %></td>
						<td class="tableTd"><%= memDTO.getMemName() %></td>
						<td class="tableTd"><%= buymemDTO.getPrice() %></td>
						<td class="tableTd"><%= sdf.format(buymemDTO.getBuyReg()) %></td>
						<td class="tableTd"><p id= "demo<%=i%>">발송전</p></td>
                  		<td class="tableTd"><button onclick = "document.getElementById('demo<%=i%>').innerHTML = '발송완료'" class="btn btn-outline-secondary btn-sm"> 발송하기</button></td>
					</tr>
					<% } }  // for%>
	   		</table>
	   		
		
	   		<% } // 회원이 있으면 %>
	   		
				<br />
				
				
			   <%-- 게시판 목록 페이지 번호 뷰어 --%>
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
			            <a class="pageNums" href="buyMemberList.jsp?pageNum=<%=startPage-1%>&sel=<%=sel%>&search=<%=search%>"> &lt; &nbsp; </a>
			         <%}else{%>
			            <a class="pageNums" href="buyMemberList.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
			         <%}
			      }
			      
			      for(int i = startPage; i <= endPage; i++) { 
			         if(sel != null && search != null) { %>
			            <a class="pageNums" href="buyMemberList.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
			         <%}else{ %>
			            <a class="pageNums" href="buyMemberList.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
			         <%} 
			      }
			      
			      if(endPage < pageCount) { 
			         if(sel != null && search != null) { %>
			            <a class="pageNums" href="buyMemberList.jsp?pageNum=<%=startPage+pageNumSize%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; &gt; </a>
			      <%   }else{ %>
			            <a class="pageNums" href="buyMemberList.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
			      <%	}
			     	 } 
			      } %>
			
			      <br /><br />
	   		
	   		<%-- 작성자/내용 검색 --%>
		<form action="buyMemberList.jsp">
			<select name="sel">
				<option value="buyNo" selected>구매번호</option>
				<option value="memId">회원 ID</option>
			</select>
			<input type="text" name="search" /> 
			<input class="btn btn-outline-secondary btn-sm" type="submit" value="검색" />
		</form>
		<br />
		
		<button class="btn btn-outline-secondary btn-sm" onclick="window.location='buyMemberList.jsp'"> 전체 구매회원 </button>
		                    
			</div> <%-- 게시판 페이지 뷰어 --%>
		</div> <%-- 회원관리  --%>
   	</div> <%-- row  --%>
   </div>	<%-- 컨테이너 --%>
</main>
	
	<%-- 
<body> 


	<div align="right">
		<table>
			<tr>
			<td>세션아이디: <%=id %> 회원분류: <%=category %></td>
				<td><button onclick="window.location='/project/login/logoutPro.jsp'">로그아웃</button></td>
					<% if(category.equals("admin")){  // 관리자로 로그인했을시 %>
	            	<td><button onclick="window.location='/project/adminMyPage/adminMypage.jsp'">마이페이지</button></td>
	            	<% } else if(category.equals("cen")){ // 센터로 로그인 했을시 %>
	           		<td><button onclick="window.location='/project/cenMyPage/centerMypage.jsp'">마이페이지</button></td>
	           		<% }else { %>
	            	<td><button onclick="window.location='/project/memMyPage/memberMypage.jsp'">마이페이지</button></td>
            		<%} %>
			</tr>
		</table>
	</div>

	
	<h1 align="center"><a href="/project/main/main.jsp">BALLOONTEER</a></h1>

	<nav>
		<ul>
			<li><a href="/project/volPage/volBoardMain.jsp">봉사</a></li>
			<li><a href="/project/freeBoard/freeBoardMain.jsp">자유게시판</a></li>
			<li><a href="/project/pointPage/pointShop.jsp">포인트샵</a></li>
			<li><a href="/project/infoPage/homepageInfo.jsp">소개</a></li>
		</ul>
	</nav>
	
	<%-- ********************************************************************************************************************** 
	<div class="container">
		<div class="row">
	       <div class="col-sm">
			<aside>
				<h3>MyPage</h3>
				<ul>
					<li><%=userName %></li>
					<li><hr width="200px" align="left"/></li>
					<li><a href= "adminMypage.jsp">회원관리</a></li>
					<li><a href= "pointShopAdmin.jsp">포인트샵 관리</a></li>
					<li><a href= "buyMemberList.jsp">포인트샵 구매회원 관리</a></li>
					<li><a href= "mainBanImgAdmin.jsp"> 메인 배너 관리</a></li>
					<li><a href= "homepageAdmin.jsp"> 홈페이지 관리</a></li>
					<li><a href= "/project/signup/userModifyForm.jsp"> 정보수정</a></li>
				</ul>
			 </aside>
			</div>
			
			
			<div class="col-sm">
			<h2>포인트샵 구매회원 관리</h2>
	
		        <% if(count == 0){ %>
	   			<table>
					<tr>
						<td>No.</td>	  
						<td>구매번호</td>	
						<td>상품번호</td> 		
			   			<td>상품명</td>	
						<td>회원ID</td>	
						<td>회원명</td>	
						<td>구매 수량</td>
						<td>결제 가격</td>
						<td>구매날짜</td>
					</tr>	
					<tr>
						<td>상품을 구매한 고객이 없습니다.</td>
					</tr>
	   			</table>
	   		<% } else { // 상품이 있으면 %>
  				<table>
					<tr>
						<td>No.</td>	  
						<td>구매번호</td>	
						<td>상품번호</td> 		
			   			<td>상품명</td>	
						<td>회원ID</td>	
						<td>회원명</td>	
						<td>결제 가격</td>
						<td>구매날짜</td>
					</tr>	
					<%-- 회원 목록 반복해서 뿌리기 	
					<% 
						for(int i=0 ; i < buyList.size() ; i++){
							BuyBoardDTO buymemDTO = buyList.get(i);
							
							ShopBoardDTO buyShopDTO = shopDAO.getOneShopContent(buymemDTO.getsNo());
							if(buyShopDTO != null){
							MemberSignupDTO memDTO = signdao.getMember(buymemDTO.getMemId());
					%>
					<tr>
						<td><%= number-- %></td>
						<td><%= buymemDTO.getBuyNo()%></td>
						<td><%= buymemDTO.getsNo() %></td>
						<td><%= buyShopDTO.getGoodsName() %></td>
						<td><%= buymemDTO.getMemId() %></td>
						<td><%= memDTO.getMemName() %></td>
						<td><%= buymemDTO.getPrice() %></td>
						<td><%= buymemDTO.getBuyReg() %></td>
					</tr>
					<% } }  // for%>
	   		</table>
	   		
		
	   		<% } // 회원이 있으면 %>
	   		
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
			            <a class="pageNums" href="buyMemberList.jsp?pageNum=<%=startPage-1%>&sel=<%=sel%>&search=<%=search%>"> &lt; &nbsp; </a>
			         <%}else{%>
			            <a class="pageNums" href="buyMemberList.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
			         <%}
			      }
			      
			      for(int i = startPage; i <= endPage; i++) { 
			         if(sel != null && search != null) { %>
			            <a class="pageNums" href="buyMemberList.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
			         <%}else{ %>
			            <a class="pageNums" href="buyMemberList.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
			         <%} 
			      }
			      
			      if(endPage < pageCount) { 
			         if(sel != null && search != null) { %>
			            <a class="pageNums" href="buyMemberList.jsp?pageNum=<%=startPage+pageNumSize%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; &gt; </a>
			      <%   }else{ %>
			            <a class="pageNums" href="buyMemberList.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
			      <%	}
			     	 } 
			      } %>
			
			      <br /><br />
	   		
	   		<%-- 작성자/내용 검색 
		<form action="buyMemberList.jsp">
			<select name="sel">
				<option value="buyNo" selected>구매번호</option>
				<option value="memId">회원 ID</option>
			</select>
			<input type="text" name="search" /> 
			<input type="submit" value="검색" />
		</form>
		<br />
		
		<button onclick="window.location='buyMemberList.jsp'"> 전체 구매회원 </button>
		                    
			</div> <%-- 게시판 페이지 뷰어 
		</div> <%-- 회원관리  
   	</div> <%-- row  
   </div>	<%-- 컨테이너 

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
  
  <% } %>
  
</html>