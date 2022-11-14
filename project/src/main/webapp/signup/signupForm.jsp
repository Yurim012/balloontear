<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>회원가입폼</title>
    <%-- 파비콘 --%>
   <link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
   <%-- 부트스트랩 --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	
	<link rel="stylesheet" href="/project/css/signupStyle.css" type="text/css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300&display=swap" rel="stylesheet">
    <style>
    table.td{
    	width: 250;
    }
    
    </style>
    <%
	   String id = (String)session.getAttribute("memId");
	   MemberSignupDAO dao = new MemberSignupDAO();
	   //아이디 주고 카테고리 찾아오기 메서드 만들기
	   String category = dao.categorySeach(id);
	%>
    
    
 <% // 로그인 이미 되어있는 상태에서 회원가입 창 못들어오게 하기 
		if(id != null){ 
			if(category.equals("mem")){ %>
		<script>
			alert("이미 회원가입이 되어있습니다.")
			window.location.href="/project/main/memberMain.jsp";
		</script>
		<% } else { %>
		<script>
			alert("이미 회원가입이 되어있습니다.")
			window.location.href="/project/main/main.jsp";
		</script>
		<% } %>
		
<% }else{ %>

  

   <script>
   
      // 유효성검사 
      function checkField() {
         let inputs = document.inputForm; 
         
         if(!inputs.memId.value) { 
            alert("아이디를 입력하세요.");
            return false; 
         }         
         if(!inputs.memPw.value) { 
            alert("비밀번호를 입력하세요.");
            return false; 
         }
         if(!inputs.pwch.value) { 
            alert("비밀번호 확인란을 입력하세요.");
            return false; 
         }
         if(inputs.memPw.value != inputs.pwch.value){
            alert("비밀번호와 비밀번호확인란이 일치하지 않습니다.");
            return false;
         }         
         if(!inputs.memName.value) { 
            alert("이름을 입력하세요.");
            return false;          
         }
         if(!inputs.memEmail.value) { 
            alert("이메일을 입력하세요.");
            return false;          
         }
         if(!inputs.memTel.value) { 
            alert("전화번호를 입력하세요.");
            return false;          
         }
         if(!inputs.memAd.value) { 
            alert("주소를 입력하세요.");
            return false; 
         }   
      }

      function openConfirmId(inputForm) {
          // 사용자가 id 입력란에 작성을 했는지 체크 
          let inputs = document.inputForm; 
          if(!inputs.memId.value){
             alert("아이디를 입력하세요.");
             return;    // 이 함수 강제 종료 
          }
          // 아이디 중복 검사 팝업 열기 
          //let url = "/project/signup/confirmId.jsp?id=" + inputForm.id.value;         
          let url = "/project/signup/confirmId.jsp?id=" + inputForm.memId.value;         
          open(url, "confirmId", "width=400, height=200, toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no"); 
       }
      function noSpaceForm(obj) { // 공백사용못하게
    	    var str_space = /\s/;  // 공백체크
    	    if(str_space.exec(obj.value)) { //공백 체크
    	        alert("해당 항목에는 공백을 사용할수 없습니다.\n\n공백은 자동적으로 제거 됩니다.");
    	        obj.focus();
    	        obj.value = obj.value.replace(' ',''); // 공백제거
    	        return false;
    	    }
    	 // onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);"
    	}
   
   </script>
  
   
   
   
   
</head>
<body class="text-center">

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


<%-- ************************************************************************************** --%>

	<br />
		<h4 align="center"><b>회원가입</b></h4>
	<br />
   <hr />
   
   <div align="center">
   		<form action="signupPro.jsp" method="post" enctype="multipart/form-data" name="inputForm" onsubmit="return checkField()" >
     		<table>
		         <tr>
		            <td colspan="2" align="center">
		               <input type="radio" name="memCategory" value="mem" checked/>개인 회원
		               <input type="radio" name="memCategory" value="cen" />센터 회원
		            </td>
		         </tr>
		         <tr>
		            <td>아이디 *</td>
		            <td>
			            <input type="text" name="memId" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);" required/>
			            <input type="button" class="btn btn-outline-secondary btn-sm" value="아이디 중복 확인" onclick="openConfirmId(this.form)"  />
		            </td>
		         </tr>
		         
		         <tr>
		            <td>비밀번호 *</td>
		            <td><input type="password" name="memPw" placeholder="공백 포함 불가" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);"/></td>
		         </tr>   
		            
		         <tr>
		            <td>비밀번호 확인 *</td>
		            <td><input type="password" name="pwch" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);" /></td>
		         </tr>     
		          
		         <tr>
		            <td>이름 *</td>
		            <td><input type="text" name="memName" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);" /></td>
		         </tr>    
		           
		         <tr>
		            <td>이메일 *</td>
		            <td><input type="text" name="memEmail" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);" /></td>
		         </tr>      
		         
		         <tr>
		            <td>전화번호 *</td>
		            <td><input type="text" name="memTel" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);" /></td>
		         </tr>
		         
		         <tr>
		            <td>주소 *</td>
		            <td><input type="text" name="memAd" /></td>
		         </tr>   
		      
		         <tr>
		            <td>프로필</td>
		            <td>
		               <input type="file" name="memPhoto"/>
		            </td>
		         </tr>
		         
		         <tr>
		            <td colspan="2" align="center">
		               <input type="submit" class="btn btn-outline-success btn-sm" value="회원 가입" />
		               <input type="reset" class="btn btn-outline-secondary btn-sm" value="재작성" />
		               <input type="button" class="btn btn-outline-secondary btn-sm" value="가입취소" onclick="window.location='/project/main/main.jsp'" />
		            </td>
		         </tr>               
    	 	</table>
  		</form>
	</div>   
	<% } %>		

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


<%-- 
   <br />
   <h1 align="center">회원가입</h1>
   <div align="center">
   		<form action="signupPro.jsp" method="post" enctype="multipart/form-data" name="inputForm" onsubmit="return checkField()" >
     		<table>
		         <tr>
		            <td>
		               <input type="radio" name="memCategory" value="mem" checked/>개인 회원
		               <input type="radio" name="memCategory" value="cen" />센터 회원
		            </td>
		         </tr>
		         
		         <tr>
		            <td>아이디 *</td>
		            <td><input type="text" name="memId"/></td>
		            <td><input type="button" value="아이디 중복 확인" onclick="openConfirmId(this.form)" /></td>
		         </tr>
		         
		         <tr>
		            <td>비밀번호 *</td>
		            <td><input type="password" name="memPw"/></td>
		         </tr>   
		            
		         <tr>
		            <td>비밀번호 확인 *</td>
		            <td><input type="password" name="pwch"/></td>
		         </tr>     
		          
		         <tr>
		            <td>이름 *</td>
		            <td><input type="text" name="memName"/></td>
		         </tr>    
		           
		         <tr>
		            <td>이메일 *</td>
		            <td><input type="text" name="memEmail"/></td>
		         </tr>      
		         
		         <tr>
		            <td>전화번호 *</td>
		            <td><input type="text" name="memTel"/></td>
		         </tr>
		         
		         <tr>
		            <td>주소 *</td>
		            <td><input type="text" name="memAd"/></td>
		         </tr>   
		      
		         <tr>
		            <td>프로필</td>
		            <td>
		               <input type="file" name="memPhoto"/>
		            </td>
		         </tr>
		         
		         <tr>
		            <td colspan="2">
		               <input type="submit" value="회원 가입" />
		               <input type="reset" value="재작성" />
		               <input type="button" value="가입취소" onclick="window.location='/project/main/main.jsp'" />
		            </td>
		         </tr>               
    	 	</table>
  		</form>
	</div>   
	<% } %>		
--%>	
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
</body>
</html>