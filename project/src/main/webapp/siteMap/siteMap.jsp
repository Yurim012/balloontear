<%@page import="project.memMyPage.model.MemDataDTO"%>
<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link href="/project/css/siteMapStyle.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Comfortaa&display=swap" rel="stylesheet">
    
    <style>
        #homeTitle{
           font-family: 'Comfortaa', cursive;
        }
        
    </style>
    
    
</head>
<%  
	String id = (String)session.getAttribute("memId");
	

	MemberSignupDAO dao = new MemberSignupDAO();
   
   //아이디 주고 카테고리 찾아오기 메서드 만들기
   String category = dao.categorySeach(id);
   MemDataDAO memdatadao = new MemDataDAO();
   String userName = dao.getName(id);
   MemDataDTO memdatadto =  memdatadao.getMemData(id);
%>

<body>
	<% if (session.getAttribute("memId")==null){ %>
	   <div align="right">
	      <table>
	         <tr>
	         <td>세션아이디: <%=id %> 회원분류: <%=category %></td>
	            <td><button class="btn btn-outline-warning btn-sm" onclick="window.location='/project/login/loginForm.jsp'">로그인</button></td>
	            <td><button class="btn btn-outline-warning btn-sm" onclick="window.location='/project/signup/signupForm.jsp'">회원가입</button></td>
	         </tr>
	      </table>
	   </div>
	   <%} else { %>
	      <div align="right">
	      <table>
	         <tr>
	         <td>세션아이디: <%=id %> 회원분류: <%=category %></td>
	            <td><button class="btn btn-outline-warning btn-sm" onclick="window.location='/project/login/logoutPro.jsp'">로그아웃</button></td>
	            <td><button class="btn btn-outline-warning btn-sm" onclick="window.location='/project/memMyPage/memberMypage.jsp'">마이페이지</button></td>
	         </tr>
	      </table>
	   </div>
	   <% } %>
	   
    <%--타이틀--%>
    <div class="container-fluid p-5 text-black text-center">
      <h2 id="homeTitle">BALLOONTEAR</h2>
    </div>
    
    <%--내비바 --%>
	<ul class="nav justify-content-center">
		<li class="nav-item">
		  <a class="nav-link active" aria-current="page" href="/project/volPage/volBoardMain.jsp">봉사</a>
		</li>
		<li class="nav-item">
		  <a class="nav-link" href="/project/pointPage/pointShop.jsp">포인트샵</a>
		</li>
		<li class="nav-item">
		  <a class="nav-link" href="/project/freeBoard/freeBoardMain.jsp">자유게시판</a>
		</li>
		<li class="nav-item">
		  <a class="nav-link" href="/project/infoPage/homepageInfo.jsp">소개</a>
		</li>
	</ul>
  
  <br /> <br />
  <%--사이트맵 --%>
  <div class="container text-center">
    <div class="sitemap-content">
        <div class="h3-title-wrap">
            <div class="title-box">
                <h3>사이트맵</h3>
            </div>

            <div class="container text-center">
                <div class="row">
                		<div class="col">게시판</div>
		                <div class="col">포인트샵</div>    
		                <div class="col">소개</div>    
		                <div class="col">마이페이지</div>
		         </div>
		    </div>                
			<hr />
            <div class="container text-center">
                <div class="row">
	                    <div class="col" id="colBoard">
	                       <a href="/project/volPage/volBoardMain.jsp">봉사게시판</a><br />
	                       <a href="/project/freeBoard/freeBoardMain.jsp">자유게시판</a>
	                    </div>
	                    <div class="col" id="colPoint">
	                       <a href="/project/pointPage/pointShop.jsp">포인트샵 상품보기</a>
	                    </div>   
	                    <div class="col" id="colInfo">
	                       <a href="/project/infoPage/homepageInfo.jsp">소개</a>
	                    </div>
	                    <div class="col" id="colMyPage">
	                    	<%if(category == null || category.equals("null")){ %>
	                       		<a href="/project/login/loginForm.jsp" >마이페이지</a>
	                    	<%}else if(category.equals("mem")){ %>
	                       		<a href="/project/memMyPage/memberMypage.jsp">마이페이지</a>
	                       	<%}else if(category.equals("cen")){ %>
	                       		<a href="/project/cenMyPage/centerMypage.jsp">마이페이지</a>
	                       	<%}else if(category.equals("admin")){ %>
	                       		<a href="/project/adminMyPage/adminMypage.jsp">마이페이지</a>
	                       	<%} %>
	                    </div>
				</div>
			</div>
                        
                
                       
  
  
  
   
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>