<%@page import="project.free.model.FreeBoardDTO"%>
<%@page import="project.free.model.FreeBoardDAO"%>
<%@page import="project.signup.model.MemberSignupDTO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자유게시판 - 게시글 수정</title>
	<%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
	<%-- 부트스트랩 --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<link rel="stylesheet" href="/project/css/free.css" type="text/css">
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

	MemberSignupDAO membersignupDAO = new MemberSignupDAO();
	MemberSignupDTO member = membersignupDAO.getMember(id);
	
   //아이디 주고 카테고리 찾아오기 메서드 만들기
   category = membersignupDAO.categorySeach(id);
   
   int boNo = Integer.parseInt(request.getParameter("boNo"));
   String pageNum = request.getParameter("pageNum");
   
   //게시글 하나 찾아오기
   FreeBoardDAO freedao = new FreeBoardDAO();
   FreeBoardDTO freeArticle = freedao.getOneFreeContent(boNo);  
	
	

%>
<body>
<%-- ***** 상단 로그인/마이페이지 분기처리 ***** (0801 수정)--%>
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
		<br /> <br/>	
		

<%-- ************************************************************************************** --%>

	<div class="container">
   <h4 align="center"><b>자유게시판 게시글 수정하기</b></h4>
   <br />
   <hr />
   
   <div align="center">
   <form action ="freeContentModifyPro.jsp?pageNum=<%= pageNum %>&boNo=<%=boNo %>" method="post" enctype="multipart/form-data">
	   <br />
	   <table>
			<tr>
				<td>카테고리</td>
					<%if(id.equals("admin")){ %>
						<td>       
							<select name="boCategory" value="<%= freeArticle.getBoCategory()%>" required >
								<option value="공지">공지</option>
								<option value="후기">후기</option>
								<option value="잡담">잡담</option>
								<option value="실시간봉사">실시간봉사</option>
							</select>
						</td>
					<%}else{ %>
						<td>         
							<select name="boCategory" value="<%= freeArticle.getBoCategory()%>" required >
								<option value="후기">후기</option>
								<option value="잡담">잡담</option>
								<option value="실시간봉사">실시간봉사</option>
							</select>
						</td>
					<%} %> 
	      </tr>
			  <tr>
			     <td>제목</td>
			     <td><input type="text" name="boSubject" value="<%= freeArticle.getBoSubject()%>" required/><td>
			</tr>
			<tr>
				<td>작성자</td>
					 <%if(category.equals("cen")){ %>
						<td><%=member.getMemName()%></td>
					<%}else{ %>
						<td><%=member.getMemId()%></td>
					<%} %>
			</tr>
			<tr>
	        	<td>내용</td>
				<td><textarea wrap="hard" name="boContent" rows="10" cols="80" required><%= freeArticle.getBoContent() %></textarea> </td>
	       </tr>
	       <tr>
				<td>파일첨부</td>
					<% if(freeArticle.getBoImg() == null){ %>
	          			<td><input type="file" name="boImg"/></td>
					<% }else{ %>
		          		<td>
		          			<img src = "/project/save/<%= freeArticle.getBoImg() %>" width="300" /> <br/>
		          		</td>
	          			<td><input type="file" name="boImg"/></td>
	          			<td><input type="hidden" name="exBoImg" value="<%= freeArticle.getBoImg() %>"/></td>
					<% } %>
	       </tr>
	   </table>
	   <br />
					<input type="submit" value="수정하기" class="btn btn-outline-secondary btn-sm" />
					<input type="reset" value="재작성" class="btn btn-outline-secondary btn-sm"/>
					<input type="button" value="취소" onclick="history.go(-1)" class="btn btn-outline-secondary btn-sm"/> 
	</form>
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