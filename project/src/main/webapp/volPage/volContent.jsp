<%@page import="project.volPage.model.VolReplyBoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="project.volPage.model.VolReplyBoardDAO"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="project.volPage.model.VolApplyBoardDAO"%>
<%@page import="project.signup.model.MemberSignupDTO"%>
<%@page import="project.volPage.model.VolBoardDTO"%>
<%@page import="project.volPage.model.VolBoardDAO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
   <title>volContent Page</title>
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
	MemberSignupDAO dao = new MemberSignupDAO();
  	MemberSignupDTO member = dao.getMember(id);
    String category;
      
	if(id != null){
   	 	//아이디 주고 카테고리 찾아오기 메서드 만들기
   		category = dao.categorySeach(id);
	} else{
		category = "null";
	}
	
      
      // 봉사 컨텐츠 고유번호, 페이지넘 가져오기
      int volNo = Integer.parseInt(request.getParameter("volNo"));
      String pageNum = (String)request.getParameter("pageNum");
      
      VolBoardDAO voldao = new VolBoardDAO();
    
      //오늘 날짜 스트링으로 
      SimpleDateFormat sdf = new SimpleDateFormat("MM/dd"); 
      Date today = new Date((System.currentTimeMillis()));
      System.out.println(today);
      String todayFormat = (sdf.format(today));
      System.out.println(todayFormat);
      
   //today 날짜를 주고 endDate랑 비교해서 volStatus 바꾸기 
      VolBoardDTO voldto = new VolBoardDTO(); 
      voldao.compareTodayEndDate(todayFormat);     
      voldao.compareTodayStartDate(todayFormat);     
      voldao.compareTodayDateIng(todayFormat);
      VolBoardDTO volArticle = voldao.getOneVolContent(volNo);  // 게시글 1개 정보 가져오는 메서드 호출
      
      //volNo 주고 지원 인원수 가져오는 메서드
      VolApplyBoardDAO applydao = new VolApplyBoardDAO();
      int applyCount = applydao.getApplyCount(volNo);
      
      int recruitment = volArticle.getVolMaxNum();
      System.out.println("현재 지원 봉사 인원 *****************" + applyCount );
      System.out.println("모집 최대 인원  *****************" + recruitment );
      System.out.println("현재게시글 고유번호  *****************" + volNo );
      if(applyCount == recruitment){
	      voldao.deadline(volNo);
      }
      
      
   // ***************************************************************************
  	// 댓글 페이징 처리 
  	// 페이징 처리 	
  	String replyPageNum = (String)request.getParameter("replyPageNum");
  	if(replyPageNum == null){ // replyPageNum 파라미터 안넘어오면, 1페이지 보여지게 
  		replyPageNum = "1";   // 1로 값 채우기 
  	}
  	System.out.println("replyPageNum : " + replyPageNum);
  	
  	int pageSize = 10;  // 현재 페이지에서 보여줄 글 목록의 수 
  	int currentPage = Integer.parseInt(replyPageNum); // replyPageNum int로 형변환 -> 숫자 연산 
  	int startRow = (currentPage - 1) * pageSize + 1; 
  	int endRow = currentPage * pageSize; 
  	
  	// 댓글 목록 가져오기 
  	VolReplyBoardDAO replydao = new VolReplyBoardDAO();
  	int count = replydao.getReplyCount(volNo);   // 본문글의 해당하는 댓글들의 개수만 조회해오기 

  	List replyList = null;
  	if(count > 0) {
  		// 댓글 목록 가져오기 
  		replyList = replydao.getReplies(volNo, startRow, endRow); 
  	
  	}
      
  	SimpleDateFormat reSdf = new SimpleDateFormat("yy-MM-dd HH:mm");
      
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



<main>
<div class="container">
	<div class="row g-5">
		<div class="col-md-4 order-md-2 mb-4"> <%-- 오른쪽 먼저 --%>
	        <h4 class="d-flex justify-content-between align-items-center mb-3">
	        	<span class="text-black"><b>신청하기</b></span>
	   		 </h4> 
	   		 
	   		<ul class="list-group mb-3">
	          <li class="list-group-item d-flex justify-content-between lh-sm bg-light">
	            <div>
	              <h5 class="my-0"><b>신청 <%= applyCount %>명</b></h5> <br/>
	            	<progress id="progress" value="<%= applyCount %>" max="<%=volArticle.getVolMaxNum() %>"></progress>
	            </div>
	            	<strong>모집인원 <%= volArticle.getVolMaxNum() %></strong>
	          </li>
	          <li class="list-group-item d-flex justify-content-between lh-sm">
	              <h6><b>봉사 인정 시간</b></h6>
	              <h5><b><%=volArticle.getVolTime()%> 시간</b></h5>
	          </li>
	          <li class="list-group-item d-flex justify-content-between lh-sm">
	            <div>
	              <h6><b>봉사 기간</b></h6>
	            </div>
	            <h5><b><%= volArticle.getVolStartDate() %> - <%=volArticle.getVolEndDate() %></b></h5>
	          </li>
	          
	        </ul> 
	        
	       <form class="card p-2">
	         		<% if(id != null){ %>     
	            		<input class="btn btn-secondary" onclick="window.location='volBoardMain.jsp??volNo=<%=volArticle.getVolNo()%>&pageNum=<%=pageNum%>'" value="목록으로"/>    <br />      
	            	<%if(category.equals("mem")){ %>
	            		<%if(volArticle.getVolStatus() != 1){ %>
	            		
			            	<%if(volArticle.getVolMaxNum() > applyCount){ %>
			                  <input type ="button" value="신청하기" onclick="window.location='volApplyForm.jsp?volNo=<%=volArticle.getVolNo()%>&pageNum=<%=pageNum%>'" class="btn btn-secondary"/>
			           	 	<% }else if(volArticle.getVolMaxNum() == applyCount){ %>
			                  <input type ="button" value="신청하기" onclick="alert('모집인원이 마감되었습니다')" class="btn btn-secondary"/>
			                  <%} %>
			                  
			                  
			                  
		                  <%}else{ //getStatus != 1 %>
		                  	<input type ="button" value="신청마감" disabled class="btn btn-secondary"/>
		                  <%} %>
		            	<%}//category "mem"%>
			            	
		            <%if(volArticle.getMemId().equals(member.getMemName())) { %>
		               <input type ="button" value="수정하기" onclick="window.location='volContentModifyForm.jsp?volNo=<%=volArticle.getVolNo()%>&pageNum=<%=pageNum%>'" class="btn btn-secondary"/> <br />
		               <input type ="button" value="삭제하기" onclick="window.location='volContentDeletePro.jsp?volNo=<%=volArticle.getVolNo()%>&pageNum=<%=pageNum%>'" class="btn btn-secondary"/>
		            <% }else if(id.equals("admin")){ %>
		               <input type ="button" value="삭제하기" onclick="window.location='volContentDeletePro.jsp?volNo=<%=volArticle.getVolNo()%>&pageNum=<%=pageNum%>'" class="btn btn-secondary"/>
		            <% } 
	           	} else { %>
	         		 <input type ="button" value="로그인 후 이용해주세요" onclick="window.location='/project/login/loginForm.jsp'" class="btn btn-secondary"/>
	        	<% } %>		
	            
	        </form> 
	        
	   	</div>	<%-- 오른쪽 먼저 --%>   
	   	
	 	<div class="col-md-8 order-md-1">
	        <h4><b>봉사</b></h4>  	
	        <hr class="my-2">
	        <%=volArticle.getVolCategory()%>
	        <%if(volArticle.getVolStatus() == -1){%>
				진행예정
			<%}else if(volArticle.getVolStatus() == 0){ %>
				봉사진행중
			<%}else{ %>
				모집마감
			<%} %>
	        <form class="needs-validation" novalidate>
	          <div class="row g-3">
	            <div class="col-sm">
	            	<br/>	
					<h3><b><%=volArticle.getVolSubject() %></b></h3>
					<%= volArticle.getMemId() %>
	            </div>
	
	           <div>
					<% if(volArticle.getVolImg() != null){ %>
	                	<img src="/project/save/<%=volArticle.getVolImg() %>" width="90%"/>
	               <% } %>
					
					<br /><br />
					<pre><%= volArticle.getVolContent() %></pre>
	           </div>
	           <br />
	           <br />
	           
	            <hr class="my-2">
	            
	           <br /> 
	           
	           
	 			 <div>
	           
<%--********** 댓글 ********** --%>
					   <%
					   if(count == 0) { %>
					   <table class="table">
					   	<thead>
					      <tr>
					         <th colspan="4"> <b>댓  글</b> 
					            <%if(id != null){ %>
					            <input type="button" onclick="window.location='replyForm.jsp?volNo=<%=volNo%>&pageNum=<%=pageNum%>'"  value="댓글작성" class="btn btn-outline-secondary btn-sm" style="float: right;"/>
					         </th>
					      </tr>  
					    </thead>
					    <tbody style="border: 0.5px;border-color: #cfd8dc;">   
						  	<tr style="border: 0.5px;border-color: #cfd8dc;">
						         <td> 댓글이 없습니다.</td>
						   </tr>
					            <%}else{ %>
					      <tr style="border: 0.5px;border-color: #cfd8dc;">
					         <td> 댓글이 없습니다. 댓글 작성을 원하시면 로그인 해 주세요.</td>
					      </tr>
					      		<%} %>
					      </tbody>		
					   </table>
					   
					   <%}else{ // count가 0보다 크면 = 댓글이 있으면 %>
					   <table class="table">
					   	<thead>
					      <tr>
					         <th colspan="4"> <b>댓  글</b> 
					          <%if(id != null){ %>
					            <input type="button" onclick="window.location='replyForm.jsp?volNo=<%=volNo%>&pageNum=<%=pageNum%>'"  value="댓글작성" class="btn btn-outline-secondary btn-sm" style="float: right;"/> 
					         </th>
					      </tr>
					      <tr style="border: 0.5px;border-color: #cfd8dc;">
					         <th>내  용</th>
					         <th>작성자</th>
					         <th>작성시간</th>
					         <th>&nbsp;</th>
					      </tr>   
				        </thead>
				        <tbody style="border: 0.5px;border-color: #cfd8dc;">
					         <%
					         for(int i = 0; i < replyList.size(); i++){
					            VolReplyBoardDTO reply = (VolReplyBoardDTO)replyList.get(i);         
					         %>
						            
						      <tr style="border: 0.5px;border-color: #cfd8dc;">
				               <td align="left">
				                  <% // 댓글의 댓글 들여쓰기 효과 주기 
				                  int wid = 0; 
				                  if(reply.getReplyLevel() > 0) { 
				                     wid = 12 * reply.getReplyLevel(); %>
				                     <img src="img/tabImg.PNG" width="<%=wid%>"/>
				                     <img src="img/replyImg.png" width="20px" />
				                  <%}%>
				                  <%=reply.getReply()%>
				               </td>
				               <td><%=reply.getReplyer()%></td>
				               <td><%=reSdf.format(reply.getReReg())%></td>
				               <td>
				                  <input type="button" onclick="window.location='replyForm.jsp?reNo=<%=reply.getReNo()%>&replyGrp=<%=reply.getReplyGrp()%>&replyStep=<%=reply.getReplyStep()%>&replyLevel=<%=reply.getReplyLevel()%>&volNo=<%=volNo%>&pageNum=<%=pageNum%>'" class="btn btn-outline-secondary btn-sm" value="답글" />
				                  <%if(id.equals(reply.getReplyer())){ %>
				                     <input type="button" onclick="window.location='replyModify.jsp?reNo=<%=reply.getReNo()%>&volNo=<%=volNo%>&pageNum=<%=pageNum%>'" value="수정" class="btn btn-outline-secondary btn-sm" />
				                     <input type="button" onclick="window.location='replyDeletePro.jsp?reNo=<%=reply.getReNo()%>&volNo=<%=volNo%>&pageNum=<%=pageNum%>'" value="삭제" class="btn btn-outline-secondary btn-sm" />
				                  <% }else if(id.equals("admin")){ %>
				                     <input type="button" onclick="window.location='replyDeletePro.jsp?reNo=<%=reply.getReNo()%>&volNo=<%=volNo%>&pageNum=<%=pageNum%>'" value="삭제" class="btn btn-outline-secondary btn-sm" />
				                  <%} %> 
				               </td>
						      </tr>
						       <%}//for문 %>
						       <%}else{ %>
						       <tr style="border: 0.5px;border-color: #cfd8dc;">
									<td>댓글을 보시려면 로그인 해 주세요~</td>
						       </tr>
						       <%} %>
					       </tbody>
					      </table>
							
					
					<%-- 댓글 목록 밑에 페이지 번호 뷰어 추가 --%>
						<br />
						<div align="center">
						<%
							if(count > 0){
								// 10페이지 번호씩 보여주겠다 
								// 총 몇페이지 나오는지 계산 -> 뿌려야되는 페이지번호 
								int pageCount = count / pageSize + (count % pageSize == 0? 0 : 1);
								int pageNumSize = 3;  // 한페이지에 보여줄 페이지번호 개수
								int startPage = (int)((currentPage-1)/pageNumSize)*pageNumSize + 1; 
								int endPage = startPage + pageNumSize - 1;
								// 전체 페이지수보다 위에 계산된 페이지 마지막번호가 더 크면 안되므로, 
								// 아래서 endPage다시 조정하기 
								if(endPage > pageCount) { endPage = pageCount; } 
								
								// 페이지 번호 뿌리기 
								
								if(startPage > pageNumSize) { %>
									<a class="Atitle" href="volContent.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=startPage-1%>&volNo=<%=volNo%>"> &lt; &nbsp; </a>
								<%}
								
								for(int i = startPage; i <= endPage; i++){ %>
									<a class="Atitle" href="volContent.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=i%>&volNo=<%=volNo%>"> &nbsp; <%=i%> &nbsp; </a>
								<%}
								
								if(endPage < pageCount) { %>
									<a class="Atitle" href="volContent.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=startPage+pageNumSize%>&volNo=<%=volNo%>"> &nbsp; &gt; </a>
								<%}
								
							}//if
						%>
						</div>
					<%	}// else%>
	              
	              
	              
	           
	           </div>
	          </div>
	        </form> 
	    </div> <%-- 왼쪽 --%>   
	</div> <%-- row g-5 --%>
</div><%--container --%>	   	 
	   	 
	   	 
	 <%-- 페이지 타이틀 	
		<h4 align="center"><b>봉사</b></h4>
		<br />
	   	<hr />
		<br />
		 
	      <div class="row">
	         <div class="col-sm">
	            <table>
	               <tr>
	                  <td><%=volArticle.getVolCategory()%></td>
	               </tr> 
	               <tr>
						<td>
						<%if(volArticle.getVolStatus() == -1){%>
						진행예정
						<%}else if(volArticle.getVolStatus() == 0){ %>
						봉사진행중
						<%}else{ %>
						모집마감
						<%} %>
						</td>
	               </tr>
	               <tr>
	                  <td><h2><%=volArticle.getVolSubject() %></h2></td> 
	               </tr>
	               
	               <tr>
	                  <td><%= volArticle.getMemId() %></td> 
	               </tr>
	               
	               <% if(volArticle.getVolImg() != null){ %>
	                 <tr>
	                     <td><img src="/project/save/<%=volArticle.getVolImg() %>" width="300"/></td> 
	                  </tr>
	               <% } %>
	               <tr>
	                  <td><%= volArticle.getVolContent() %></td>
	               </tr>
	            </table>
	        --%> 
	            
	        <%-- </div> col-sm 
	         <div class="col-sm">
	         <h2><%= applyCount %></h2> 
	         <h4><%= volArticle.getVolMaxNum() %></h4>
	         <h3> 봉사 인정 시간 : <%=volArticle.getVolTime()%> 시간</h3>
	         
	         <progress value="<%= applyCount %>" max="<%=volArticle.getVolMaxNum() %>"></progress>
	         <h5><%= volArticle.getVolStartDate() %> ~ <%=volArticle.getVolEndDate() %></h5>
	         
	            <% if(id != null){ %>     
	            	<button onclick="window.location='volBoardMain.jsp??volNo=<%=volArticle.getVolNo()%>&pageNum=<%=pageNum%>'">봉사게시판으로</button>	            
	            	<%if(category.equals("mem")){ %>
	            		<%if(volArticle.getVolStatus() != 1){ %>
	            		
			            	<%if(volArticle.getVolMaxNum() > applyCount){ %>
			                  <input type ="button" value="신청하기" onclick="window.location='volApplyForm.jsp?volNo=<%=volArticle.getVolNo()%>&pageNum=<%=pageNum%>'"/>
			           	 	<% }else if(volArticle.getVolMaxNum() == applyCount){ %>
			                  <input type ="button" value="신청하기" onclick="alert('모집인원이 마감되었습니다')"/>
			                  <%} %>
			                  
			                  
			                  
		                  <%}else{ //getStatus != 1 %>
		                  	<input type ="button" value="신청마감" disabled/>
		                  <%} %>
		            	<%}//category "mem"%>
			            	
		            <%if(volArticle.getMemId().equals(member.getMemName())) { %>
		               <input type ="button" value="수정하기" onclick="window.location='volContentModifyForm.jsp?volNo=<%=volArticle.getVolNo()%>&pageNum=<%=pageNum%>'"/>
		               <input type ="button" value="삭제하기" onclick="window.location='volContentDeletePro.jsp?volNo=<%=volArticle.getVolNo()%>&pageNum=<%=pageNum%>'"/>
		            <% }else if(id.equals("admin")){ %>
		               <input type ="button" value="삭제하기" onclick="window.location='volContentDeletePro.jsp?volNo=<%=volArticle.getVolNo()%>&pageNum=<%=pageNum%>'"/>
		            <% } 
	           } //id != null %>
	         </div>
	         
	      </div>
	--%>
	
	

	<%--- 댓글 
	   <%
	   if(count == 0) { %>
	   <table>
	      <tr>
	         <td colspan="4"> <b>댓  글</b> 
	            <%if(id != null){ %>
	            <button onclick="window.location='replyForm.jsp?volNo=<%=volNo%>&pageNum=<%=pageNum%>'">댓글작성</button> 
	         </td>
		      <tr>
		         <td> 댓글이 없습니다.</td>
		      <tr>
		   </tr>
	            <%}else{ %>
	      <tr>
	         <td> 댓글이 없습니다. 댓글 작성을 원하시면 로그인 해 주세요.</td>
	      <tr>
	      		<%} %>
	   </table>
	   
	   <%}else{ // count가 0보다 크면 = 댓글이 있으면 %>
	   <table>
	      <tr>
	         <td colspan="4"> <b>댓  글</b> 
	          <%if(id != null){ %>
	            <button onclick="window.location='replyForm.jsp?volNo=<%=volNo%>&pageNum=<%=pageNum%>'">댓글작성</button> 
	         </td>
	      </tr>
	      <tr>
	         <td>내  용</td>
	         <td>작성자</td>
	         <td>작성시간</td>
	         <td>수정 삭제</td>
	      <tr>
	         <%
	         for(int i = 0; i < replyList.size(); i++){
	            VolReplyBoardDTO reply = (VolReplyBoardDTO)replyList.get(i);         
	         %>
	            
	      <tr>
	               <td align="left">
	                  <% // 댓글의 댓글 들여쓰기 효과 주기 
	                  int wid = 0; 
	                  if(reply.getReplyLevel() > 0) { 
	                     wid = 12 * reply.getReplyLevel(); %>
	                     <img src="img/tabImg.PNG" width="<%=wid%>"/>
	                     <img src="img/replyImg.png" width="12" />
	                  <%}%>
	                  <%=reply.getReply()%>
	               </td>
	               <td><%=reply.getReplyer()%></td>
	               <td><%=reSdf.format(reply.getReReg())%></td>
	               <td>
	                  <button onclick="window.location='replyForm.jsp?reNo=<%=reply.getReNo()%>&replyGrp=<%=reply.getReplyGrp()%>&replyStep=<%=reply.getReplyStep()%>&replyLevel=<%=reply.getReplyLevel()%>&volNo=<%=volNo%>&pageNum=<%=pageNum%>'">답글</button>
	                  <%if(id.equals(reply.getReplyer())){ %>
	                     <button onclick="window.location='replyModify.jsp?reNo=<%=reply.getReNo()%>&volNo=<%=volNo%>&pageNum=<%=pageNum%>'">수정</button>
	                     <button onclick="window.location='replyDeletePro.jsp?reNo=<%=reply.getReNo()%>&volNo=<%=volNo%>&pageNum=<%=pageNum%>'">삭제</button>
	                  <% }else if(id.equals("admin")){ %>
	                     <button onclick="window.location='replyDeletePro.jsp?reNo=<%=reply.getReNo()%>&volNo=<%=volNo%>&pageNum=<%=pageNum%>'">삭제</button>
	                  <%} %> 
	               </td>
	      </tr>
	       <%}//for문 %>
	       <%}else{ %>
	       <tr>
				<td>댓글을 보시려면 로그인 해 주세요~</td>
	       </tr>
	       <%} %>
	      </table>
	--%>		
	
	<%-- 댓글 목록 밑에 페이지 번호 뷰어 추가 
		<br />
		<div align="center">
		<%
			if(count > 0){
				// 10페이지 번호씩 보여주겠다 
				// 총 몇페이지 나오는지 계산 -> 뿌려야되는 페이지번호 
				int pageCount = count / pageSize + (count % pageSize == 0? 0 : 1);
				int pageNumSize = 3;  // 한페이지에 보여줄 페이지번호 개수
				int startPage = (int)((currentPage-1)/pageNumSize)*pageNumSize + 1; 
				int endPage = startPage + pageNumSize - 1;
				// 전체 페이지수보다 위에 계산된 페이지 마지막번호가 더 크면 안되므로, 
				// 아래서 endPage다시 조정하기 
				if(endPage > pageCount) { endPage = pageCount; } 
				
				// 페이지 번호 뿌리기 
				
				if(startPage > pageNumSize) { %>
					<a class="pageNums" href="volContent.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=startPage-1%>&volNo=<%=volNo%>"> &lt; &nbsp; </a>
				<%}
				
				for(int i = startPage; i <= endPage; i++){ %>
					<a class="pageNums" href="volContent.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=i%>&volNo=<%=volNo%>"> &nbsp; <%=i%> &nbsp; </a>
				<%}
				
				if(endPage < pageCount) { %>
					<a class="pageNums" href="volContent.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=startPage+pageNumSize%>&volNo=<%=volNo%>"> &nbsp; &gt; </a>
				<%}
				
			}//if
		%>
		</div>
	<%	}// else%>
	--%>

</main>
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