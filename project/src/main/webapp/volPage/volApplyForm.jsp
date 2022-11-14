<%@page import="java.util.List"%>
<%@page import="project.volPage.model.VolApplyBoardDAO"%>
<%@page import="project.volPage.model.VolBoardDAO"%>
<%@page import="project.volPage.model.VolBoardDTO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>봉사신청하기</title>
	 <%-- 파비콘 --%>
   <link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
   <%-- 부트스트랩 --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<link rel="stylesheet" href="/project/css/vol.css" type="text/css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
   	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  	<link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300&display=swap" rel="stylesheet">

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
	//아이디 주고 이름 받아오기 메서드 
	String userName = dao.getName(id);
	//아이디 주고 전화번호 받아오기 메서드 
	String userPhone = dao.getPhone(id);
	//아이디 주고 이메일 받아오기 메서드
	String userEmail = dao.getEmail(id); 
	
	
	int volNo = Integer.parseInt(request.getParameter("volNo")); 
	String pageNum = request.getParameter("pageNum");

	//volNo주고 봉사정보 가져오기 
	VolBoardDAO voldao = new VolBoardDAO();
	VolBoardDTO volArticle = voldao.getOneVolContent(volNo);
	

	
%>
<body>

   
<%-- ***** 상단 로그인/마이페이지 분기처리 ***** (0801 수정)--%>
<% if (session.getAttribute("memId")!=null){ %>
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
	<br /> <br/>	

	
	<%-- VolApplyForm 시작 --%>
<div class="container">
	<h4 align="center"><b>봉사 신청</b></h4>
	<br />
	<div align="center">
		<div class="card shadow-sm" id="volApply" style="background-color:#f8fafc; width: 800px; padding: 40px;">
			<form action="volApplyPro.jsp?volNo=<%=volNo %>&pageNum=<%=pageNum %>" method="post">   
			<input type="hidden" name="memActivity" /> 
			<table class="table">
				<tr>
					<th>선택봉사</th>
					<td><%= volArticle.getVolSubject() %></td>
				</tr>		
				<tr>
					<th>선택일자</th>
					<%--시작날짜와 끝나는날짜에서만 선택할수 있도록 날짜 제한--%>
					<td><input type="date" name="selDate" min="<%=volArticle.getVolStartDate() %>" max="<%=volArticle.getVolEndDate() %>" required/></td> 	
				</tr>
				<tr>
					<th>신청자명</th>
					<td><%=userName%></td>
				</tr>
				<tr>
					<th>신청자 전화번호</th>
					<td><%=userPhone%></td>
				</tr>
				<tr>
					<th>신청자 e-mail</th>
					<td><%=userEmail%></td>
				</tr>
			</table>
			<br />
			<br />	
			<div align="center">
				<p><b> 회원님이 등록하신 정보가 표시됩니다. </b><br />
				<b>등록된 정보가 정확한지 확인해 주세요.</b></p>
				<br />
						<table style="font-size: 20px; margin: 30px;">
							<tr>
								<th>신청자명</th>
								<td>&nbsp;<%=userName%></td>
							</tr>
							<tr>
								<th>신청자 전화번호</th>
								<td>&nbsp;<%=userPhone%></td>
							</tr>
							<tr>
								<th>신청자 e-mail</th>
								<td>&nbsp;<%=userEmail%></td>
							</tr>
						</table>
						<br />
					<br />
					<p> 연락처가 미 등록된 경우 봉사활동 정보를 받으실 수 없습니다. <br />
					입력된 연락처 및 이메일로 봉사활동 정보를 제공 받으시겠습니까?</p>
					<input type="checkbox" name="volApplyAgree" value="1" required/> 정보제공 수신 동의
					<br />
					<br />
				<input type="submit" value="신청하기"  class="btn btn-outline-secondary btn-sm"/>
			
			</div>	
			
			
			
			</form>
		</div>
	</div>
</div>	
	<%} %>
</body>

<br />
<br />
<br />
<%-- ***********푸터(0801 수정) *********** --%>
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