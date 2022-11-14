<%@page import="project.signup.model.MemberSignupDTO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>봉사 신청</title>
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

	MemberSignupDAO membersignupDAO = new MemberSignupDAO();
	MemberSignupDTO member = membersignupDAO.getMember(id);
	category = membersignupDAO.categorySeach(id);

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


<%-- 글 작성 폼 --%>
<div class="container">
   <h4 align="center"><b>봉사 모집글 작성</b></h4>
   	<br />
	<hr />
   
   <div align="center">
	   <form action ="volWritePro.jsp" name="volWriteForm" method="post" enctype="multipart/form-data" onsubmit="return checkField()">
	   <input type="hidden" name="memName" value="<%= member.getMemName()%>"/>
	   <input type="hidden" name="volStatus" value="-1"/>
	   <br />
	   <table>
	      <tr>
	         <td>제목</td>
	         <td><input type="text" name="volSubject" required/><td>
	      </tr>
	      <tr>
	         <td>작성자</td>
	         <td><%=member.getMemName()%></td>
	      </tr>
	      <tr>
	         <td>카테고리</td>
	         <td>         
	            <select name="volCategory" required>
	               <option value="어린이">어린이</option>
	               <option value="환경">환경</option>
	               <option value="어르신">어르신</option>
	               <option value="동물">동물</option>
	               <option value="교육">교육</option>
	              </select>
	           </td>
	      </tr>     
	      <tr>
	           <td>모집인원</td>
	           <td><input type="text" name="volMaxNum" required onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" /></td>
	       </tr>
	      <tr>
	           <td>봉사시작일</td>
	           <td><input type="date" name="volStartDate" onsubmit="return checkField()" required/></td> 
	       </tr>
	       <tr>
	           <td>봉사종료일</td>
	           <td><input type="date" name="volEndDate" onsubmit="return checkField()" required/></td> 
	       </tr> 
	      <tr>
	         <td>봉사장소</td>
	         <td><input type="text" name="volLoc" required/></td>
	       </tr>
	      <tr>
	         <td>봉사인정시간</td>
	         <td><input type="number" name="volTime" min="1" max="6" step="1" required onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');"/> ※ 6시간 이하 시간만 입력 가능합니다.</td>
	          
                
	       </tr>
	      <tr>
	         <td>내용</td>
	         <td><textarea wrap="hard" name="volContent" rows="10" cols="50" required></textarea> </td>
	       </tr>
	       <tr>
	          <td>파일첨부</td>
	          <td><input type="file" name="volImg"/></td>
	       </tr>
	   </table>
	   		<br />
			<input type="submit" value="등록하기" class="btn btn-outline-secondary btn-sm" />
	        <input type="button" value="취소" onclick="history.go(-1)" class="btn btn-outline-secondary btn-sm"/>
	       
	   </form>
   </div>
</div>
<script>
      /*
      //유효성 검사
      function checkField(){
         let inputs = document.volWriteForm;
         let volsd = new Date(inputs.volStartDate.value);
         const volsd2 = volsd.toLocaleDateString();
         
         console.log("봉사 시작일" +volsd);
         console.log("volsd2" + volsd2);
         
         
         let voled = new Date(inputs.volEndDate.value);
         const voled2 = voled.toLocaleDateString();
         console.log("봉사 종료일" +voled);
         
         
         const today = new Date();
         const today2 = today.toLocaleDateString();
         
         
         
        if(volsd2.before(today2) && voled2.before(today2)){
        	   alert("현재 날짜보다 느림 "+ volsd2 + " ~ " + voled2);
               return false;
        }
        
        if(volsd2.before(voled2)){
            alert("봉사시작날짜를 봉사종료날짜보다 늦게 설정할 수 없습니다.");
            return false;
         }
        
        if(volsd2 < today2){
            alert("봉사시작날짜를 오늘날짜보다 빠르게 설정할 수 없습니다.");
            return false;
         }
         
         

      }//체크필드
      */
      
      

      
      function checkField(){
         var inputs = document.volWriteForm;
         var startDate = new Date(inputs.volStartDate.value);
         startDate.setHours(startDate.getHours()+14);      
         console.log(" startDate : "+startDate);
         
         let endDate = new Date(inputs.volEndDate.value);
         endDate.setHours(endDate.getHours()+14);
         console.log(" endDate : "+ endDate);
         
         var today = new Date();
         console.log("지금 시스템 시간"+today);
         

         if(today >startDate && today > endDate){
            alert("봉사시작일과 봉사종료일을 지난날로 설정할 수 없어")
            return false;
         }if(endDate < startDate){
            alert("봉사 종료일을 봉사 시작일보다 빠르게 설정할 수 없어");
            return false;
         }if(startDate < today){
            alert("지난날을 봉사시작일로 선택할수 없어");
            return false;          
         }
      }
</script>
      
      
      


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