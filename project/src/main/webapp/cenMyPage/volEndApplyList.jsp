<%@page import="project.signup.model.MemberSignupDTO"%>
<%@page import="project.volPage.model.VolBoardDAO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@page import="java.util.List"%>
<%@page import="project.volPage.model.VolApplyBoardDAO"%>
<%@page import="project.volPage.model.VolApplyBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마감공고 지원자 관리</title>
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
<%	
	String id = (String)session.getAttribute("memId");	
	//volNo 파라미터
	
	 if(id== null || id.equals(null) || id.equals("null")) { %>
	   <script>
	   alert("로그인 후 이용해주세요")
	   window.location.href="/project/main/main.jsp";
	   </script>
	   <% }else { 
	int volNo = Integer.parseInt(request.getParameter("volNo"));

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
	   
	
	    VolApplyBoardDAO volapplydao = new VolApplyBoardDAO();
	   // 전체 글의 개수 구하고, 
	   // DB에서 전체 글 개수 가져오기
	   int count = 0;             // (전체/검색) 전체 글 개수 담을 변수 
	   List<VolApplyBoardDTO> applyArticleList = null;    // (전체/검색) 글 목록 리턴받을 변수 
   
  	
      count = volapplydao.getApplyCount(volNo);  // volNo에 해당하는 전체지원자 수 가져오기
      if(count > 0){ // 일반 게시판일때 
         // 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
        	 applyArticleList = volapplydao.getmemVolApplyList(startRow, endRow, volNo);   
         }
       
      System.out.println("article count : " + count);
      System.out.println(applyArticleList);
      
      int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글번호(bno아님)
	
	
%>

</head>

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


<div class="container">
		<div class="row">
			<div class="col-sm">
				<br />
				<h4 align="center"><b>신청자 목록</b></h4>
                <button class="btn btn-outline-secondary btn-sm" id="moreButton" onclick="window.location='volEndRecruitList.jsp'" >돌아가기</button>
				<button class="btn btn-outline-secondary btn-sm" id="moreButton" onclick="window.location='centerMypage.jsp'">마이페이지로 돌아가기</button>
				<br />
				<hr />
                    <table class="tableList">
                    <% if(applyArticleList == null){ %>
                         <tr>
                           <td class="tableTd">이름</td>
                           <td class="tableTd">아이디</td>
                           <td class="tableTd">진행상황</td>
                           <td class="tableTd">봉사선택날짜</td>
                           <td class="tableTd">봉사시간</td>
                           <td class="tableTd">봉사신청날짜</td>
                           <td class="tableTd">이메일</td>
                           <td class="tableTd">휴대폰 번호</td>
                           <td class="tableTd">출석여부</td>
                        </tr>    
                    	<tr>
                    		<td class="tableTd" colspan="9" align="center">신청자가 없습니다.</td>
                    	</tr>
                    </table>
                    <% }else{  %>
                    <%-- 반복해서 뿌리기  --%>
                    <table class="tableList">
                         <tr>
                           <td class="tableTd">이름</td>
                           <td class="tableTd">아이디</td>
                           <td class="tableTd">진행상황</td>
                           <td class="tableTd">봉사선택날짜</td>
                           <td class="tableTd">봉사시간</td>
                           <td class="tableTd">봉사신청날짜</td>
                           <td class="tableTd">이메일</td>
                           <td class="tableTd">휴대폰 번호</td>
                           <td class="tableTd">출석여부</td>
                        </tr>    
                        
                     <%int volNum = 0; int applyNo = 0; String part ="b";
                     for(int i = 0; i < applyArticleList.size(); i++){ 
                    	 
                           VolApplyBoardDTO volApplyArticle = applyArticleList.get(i); 
							//한명의 회원정보 가져오기
							MemberSignupDAO signupdao = new MemberSignupDAO();
							
							userName = signupdao.getName(volApplyArticle.getMemId()); //신청자 memId주고 신청자 이름 가져와서 담기
							String userEmail = signupdao.getEmail(volApplyArticle.getMemId());
							String phoneNum = signupdao.getPhone(volApplyArticle.getMemId());
							//봉사시간을 위해 봉사 보드 데이터 갖고오기 (volNo주고)
							VolBoardDAO volboarddao = new VolBoardDAO();
							int time = volboarddao.getTime(volApplyArticle.getVolNo());
							%> 		
							
							
                        <tr>
                           	<td class="tableTd"><%=userName %></td>
                           	<td class="tableTd"><%=volApplyArticle.getMemId() %>
                           	<td class="tableTd">
                           	<%if(volApplyArticle.getMemActivity() == -1){ %>
                           	봉사신청완료
                           	<%}else if(volApplyArticle.getMemActivity() == 1){ %>
                           	봉사활동완료
                           	<%} %>
                           	</td>
                           	<td class="tableTd"><%=volApplyArticle.getSelDate()%></td>
                           	<td class="tableTd"><%= time%></td>
                           	<td class="tableTd"><%=volApplyArticle.getApplyDate()%></td>
                           	<td class="tableTd"><%=userEmail%></td> 
                            <td class="tableTd"><%=phoneNum %></td> 
                            <%if(volApplyArticle.getMemActivity() == -1){ 
                             		volNum=volApplyArticle.getVolNo();
                            		applyNo=volApplyArticle.getApplyNo(); %>
									<td><button class="btn btn-outline-secondary btn-sm" onclick="myConfirm('<%=volNum%>', '<%=applyNo%>', '<%=part%>')">승인</button></td>
							<%}else if(volApplyArticle.getMemActivity() == 1){ 
									volNum=volApplyArticle.getVolNo();
	                        		applyNo=volApplyArticle.getApplyNo();%>
									<td><button class="btn btn-outline-secondary btn-sm" onclick="cancleConfirm('<%=volNum%>', '<%=applyNo%>', '<%=part%>')" >승인 취소</button></td>
									
							<%}%>
                		</tr>

                     <%}//for문 //(int i = 0; i < volList.size(); i++)%>
                    </table>
						<script>
						function myConfirm(volNum, applyNo, part) {
						  	//console.log("volNum : " + volNum + ", applyNo : " + applyNo);
							var ok = confirm("승인하시겠습니까?")
							if(ok) location.href='activeOk.jsp?volNum='+volNum+'&applyNo='+applyNo+'&part='+part;
						}
						
						function cancleConfirm(volNum, applyNo, part){
						  	//console.log("volNum : " + volNum + ", applyNo : " + applyNo);
							var cancle = confirm("승인 취소하시겠습니까?")
							if(cancle) location.href='activeCancle.jsp?volNum='+volNum+'&applyNo='+applyNo+'&part='+part;
						}
						</script>	
   					<%}//else %>
                    </div>
          </div> <%-- row --%>                     
	</div> <%--container --%>
	</div>
	
	
	
	
<%-- 
<body>


<div class="container">
		<div class="row">
			<div class="col-sm">
	
                    <button onclick="window.location='volEndRecruitList.jsp'" >돌아가기</button>
					<button onclick="window.location='centerMypage.jsp'">마이페이지로 돌아가기</button>
                    
                    <h2>신청자 리스트</h2>
                    <table>
                    <% if(applyArticleList == null){ %>
                    	<tr>
                    		<td>신청자가 없습니다.</td>
                    	</tr>
                    </table>
                    <% }else{  %>
                    <%-- 반복해서 뿌리기  
                    <table>
                         <tr>
                           <td>이름</td>
                           <td>아이디</td>
                           <td>진행상황</td>
                           <td>봉사선택날짜</td>
                           <td>봉사시간</td>
                           <td>봉사신청날짜</td>
                           <td>이메일</td>
                           <td>휴대폰 번호</td>
                           <td>출석여부</td>
                        </tr>    
                        
                              
                     <%int volNum = 0; int applyNo = 0; String part ="b";
                     for(int i = 0; i < applyArticleList.size(); i++){ 
                    	 
                           VolApplyBoardDTO volApplyArticle = applyArticleList.get(i); 
							//한명의 회원정보 가져오기
							MemberSignupDAO signupdao = new MemberSignupDAO();
							
							String userName = signupdao.getName(volApplyArticle.getMemId()); //신청자 memId주고 신청자 이름 가져와서 담기
							String userEmail = signupdao.getEmail(volApplyArticle.getMemId());
							String phoneNum = signupdao.getPhone(volApplyArticle.getMemId());
							//봉사시간을 위해 봉사 보드 데이터 갖고오기 (volNo주고)
							VolBoardDAO volboarddao = new VolBoardDAO();
							int time = volboarddao.getTime(volApplyArticle.getVolNo());
							%> 		
							
							
                        <tr>
                           	<td><%=userName %></td>
                           	<td><%=volApplyArticle.getMemId() %>
                           	<td>
                           	<%if(volApplyArticle.getMemActivity() == -1){ %>
                           	봉사신청완료
                           	<%}else if(volApplyArticle.getMemActivity() == 1){ %>
                           	봉사활동완료
                           	<%} %>
                           	</td>
                           	<td><%=volApplyArticle.getSelDate()%></td>
                           	<td><%= time%></td>
                           	<td><%=volApplyArticle.getApplyDate()%></td>
                           	<td><%=userEmail%></td> 
                            <td><%=phoneNum %></td> 
                            <%if(volApplyArticle.getMemActivity() == -1){ 
                             		volNum=volApplyArticle.getVolNo();
                            		applyNo=volApplyArticle.getApplyNo(); %>
									<td><button onclick="myConfirm('<%=volNum%>', '<%=applyNo%>', '<%=part%>')">승인</button></td>
							<%}else if(volApplyArticle.getMemActivity() == 1){ 
									volNum=volApplyArticle.getVolNo();
	                        		applyNo=volApplyArticle.getApplyNo();%>
									<td><button onclick="cancleConfirm('<%=volNum%>', '<%=applyNo%>', '<%=part%>')" >승인 취소</button></td>
									
							<%}%>
                		</tr>

                     <%}//for문 //(int i = 0; i < volList.size(); i++)%>
                    </table>
						<script>
						function myConfirm(volNum, applyNo, part) {
						  	//console.log("volNum : " + volNum + ", applyNo : " + applyNo);
							var ok = confirm("승인하시겠습니까?")
							if(ok) location.href='activeOk.jsp?volNum='+volNum+'&applyNo='+applyNo+'&part='+part;
						}
						
						function cancleConfirm(volNum, applyNo, part){
						  	//console.log("volNum : " + volNum + ", applyNo : " + applyNo);
							var cancle = confirm("승인 취소하시겠습니까?")
							if(cancle) location.href='activeCancle.jsp?volNum='+volNum+'&applyNo='+applyNo+'&part='+part;
						}
						</script>	
   					<%}//else %>
                    </div>
          </div> <%-- row                      
	</div> <%--container

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