<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>아이디 찾기</title>
   <%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
	<%-- 부트스트랩 --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	<link rel="stylesheet" href="/project/css/loginStyle.css" type="text/css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300&display=swap" rel="stylesheet">
</head>

	<%
	   String id = (String)session.getAttribute("memId");
	   MemberSignupDAO dao = new MemberSignupDAO();
	   //아이디 주고 카테고리 찾아오기 메서드 만들기
	   String category = dao.categorySeach(id);
	%>


<body class="text-center">
<%-- 상단 로그인 회원가입 버튼  --%>

	<div align="right">
		<table>
			<tr>
				<td><button class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/login/loginForm.jsp'">로그인</button></td>
				<td><button class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/signup/signupForm.jsp'">회원가입</button></td>
			</tr>
		</table>
	</div>
   
	<%--타이틀--%>
    <div class="container-fluid p-3 text-black text-center">
    <img src="/project/save/logo.png" width="100px" />
      <a class="Atitle" href="/project/main/main.jsp"><h2 id="homeTitle">BALLOONTEAR</h2></a>
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

<%-- ************************************************************************************** --%>
	
	<main class="form-signin w-100 m-auto">
	  <form action="idFindPro.jsp" method="post">
	    <img class="mb-4">
	    	<h1 class="h3 mb-3 fw-normal">아이디 찾기</h1>
	
		    <div class="form-floating">
		      <input type="text" name="memName"  class="form-control" id="floatingInput" required/>
		      <label for="floatingInput" >회원가입시 작성한 이름</label>
		    </div>
		    <div class="form-floating">
		      <input type="text" name="memTel"  class="form-control" id="floatingTel" required/>
		      <label for="floatingTel">회원가입시 작성한 전화번호</label>
		    </div>
	 	   <br />
		    <div>	
		    	<button class="btn btn-outline-success btn-sm" type="submit">아이디 찾기</button>
		    	<input type="button" class="btn btn-outline-secondary btn-sm" value="비밀번호 찾기" onclick="window.location='pwFindForm.jsp'"/>
		    	<input type="button" class="btn btn-outline-secondary btn-sm" value="취소" onclick="history.go(-1)"/> 
		    </div>
		</form>
</main>
	

	
	
<%-- 	


   <br />
   <h1 align="center"> 아이디 찾기 </h1>
   <div align="center">
	   <form action="idFindPro.jsp" method="post">
	      <table>
	         <tr>
	            <td>이름</td>
	            <td> 
	               <input type="text" name="memName" />
	            </td>
	         </tr>
	         <tr>
	           	<td>휴대전화</td>
	            <td> 
	            	<input type="text" name="memTel" />
	            	<input type="button" value="인증하기" />
	             </td>
	         </tr>
	         <tr>
	            <td colspan="3" align="center"> 
		            <input type="submit" value="확인" />
		            <input type="button" value="비밀번호 찾기" onclick="window.location='pwFindForm.jsp'"/>
		            <input type="button" value="취소" onclick="history.go(-1)"/>
	            </td>
	         </tr>   
	      </table>
      </form>
	     
   </div>
--%>   
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
</body>
<br /><br /><br />
<%-- ***********푸터(0801 수정) *********** --%>
<div class="container">
  <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
    <p class="col-md-4 mb-0 text-muted">&copy; BallonTeer (사단법인희망풍선)</p>

    <a href="/" class="col-md-4 d-flex align-items-center justify-content-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
      <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
    </a>

    <ul class="nav col-md-4 justify-content-end">
      <li class="nav-item"><a href="/project/main/main.jsp" class="nav-link px-2 text-muted">메인</a></li>
      <li class="nav-item"><a href="/project/volPage/volBoardMain.jsp" class="nav-link px-2 text-muted">봉사</a></li>
      <li class="nav-item"><a href="/project/pointPage/pointShop.jsp" class="nav-link px-2 text-muted">포인트샵</a></li>
      <li class="nav-item"><a href="/project/freeBoard/freeBoardMain.jsp" class="nav-link px-2 text-muted">자유게시판</a></li>
      
     
    </ul>
  </footer>	
  </div>
</html>