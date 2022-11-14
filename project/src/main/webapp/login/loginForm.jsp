<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>로그인</title>
   <%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
	<%-- 부트스트랩 --%>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
   <link rel="stylesheet" href="/project/css/loginStyle.css" type="text/css">
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300&display=swap" rel="stylesheet">
   
</head>




<body class="text-center">
   <div align="right">
      <table>
         <tr>
            <td><input type="button" class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/login/loginForm.jsp'" value="로그인" /></td>
            <td><button class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/signup/signupForm.jsp'">회원가입</button></td>
         </tr>
      </table>
   </div>


   
   <%--타이틀--%>
    <div class="container-fluid p-3 text-black text-center">
    <img src="/project/save/logo.png" width="100px" />
      <a class="Atitle" href="/project/main/main.jsp"><h2 id="homeTitle">BALLOONTEER</h2></a>
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
   
   
<%-- html 코드 --%>

    
<main class="form-signin w-100 m-auto">
  <form action="loginPro.jsp" method="post">
    <img class="mb-4">
    <h1 class="h3 mb-3 fw-normal">LOGIN</h1>

    <div class="form-floating">
      <input type="text" name="memId" class="form-control" id="floatingInput" placeholder="아이디를 입력하세요">
      <label for="floatingInput" >아이디</label>
    </div>
    <div class="form-floating">
      <input type="password" name="memPw"  class="form-control" id="floatingPassword" placeholder="Password">
      <label for="floatingPassword">비밀번호</label>
    </div>

    <div class="checkbox mb-3">
      <label>
        <input type="checkbox" name="auto" value="1"> 자동로그인
      </label>
    </div>
    <div class="d-grid gap-2 col-2 mx-auto">
       <input type="submit" class="btn btn-outline-success"  value="로그인" />
    </div>
    <br />
    <div>   
       <input type="button" class="btn btn-outline-secondary btn-sm" value="아이디 찾기" onclick="window.location='idFindForm.jsp'"/>
       <input type="button" class="btn btn-outline-secondary btn-sm" value="비밀번호 찾기" onclick="window.location='pwFindForm.jsp'"/>
       <input type="button" class="btn btn-outline-secondary btn-sm" value="회원가입" onclick="window.location='/project/signup/signupForm.jsp'"/> 
    </div>
   </form>
</main>






<%--
   <br />
   <h1 align="center"> 로그인 </h1>
   <br/>
   <div align="center">
   <form action="loginPro.jsp" method="post">
      <table>
         <tr>
            <td>아이디</td>
            <td> 
               <input type="text" name="memId" />
            </td>
            <td colspan="2">
               <input type="submit" value="로그인" />
            </td>
         </tr>
         <tr>
            <td>비밀번호</td>
            <td> <input type="password" name="memPw" /> </td>
         </tr>
      <tr><td>&nbsp;</td></tr>
      
         <tr>
            <td align="center">          
               <input type="checkbox" name="auto" value="1" /> 자동로그인       
            </td>
        
            <td>   
               <input type="button" value="아이디 찾기" onclick="window.location='idFindForm.jsp'"/>
               <input type="button" value="비밀번호 찾기" onclick="window.location='pwFindForm.jsp'"/>
               <input type="button" value="회원가입" onclick="window.location='/project/signup/signupForm.jsp'"/> 
            </td>
         </tr>         
      </table>
   </form>
   </div>
--%>
   
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
  </body>
  
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
</html>
