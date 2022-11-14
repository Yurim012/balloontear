<%@page import="project.free.model.FreeReplyBoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="project.free.model.FreeReplyBoardDAO"%>
<%@page import="project.free.model.FreeBoardDTO"%>
<%@page import="project.free.model.FreeBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="project.signup.model.MemberSignupDTO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자유게시판 본문</title>
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

 	
	MemberSignupDAO dao = new MemberSignupDAO();
  	MemberSignupDTO member = dao.getMember(id);
    String category;
      
	if(id != null){
   	 	//아이디 주고 카테고리 찾아오기 메서드 만들기
   		category = dao.categorySeach(id);
	} else{
		category = "null";
	}
	
	
	//id주고 회원정보 가져오기 
	MemberSignupDTO meminfo = dao.getMember(id);
      
    // 봉사 컨텐츠 고유번호, 페이지넘 가져오기
    int boNo = Integer.parseInt(request.getParameter("boNo"));
    String pageNum = (String)request.getParameter("pageNum");
    
    System.out.println("자유게시판 : " + pageNum);
    
    FreeBoardDAO freedao = new FreeBoardDAO();
    FreeBoardDTO freeArticle = freedao.getOneFreeContent(boNo);  // 게시글 1개 정보 가져오는 메서드 호출
     

   // ***************************************************************************
  	// 댓글 페이징 처리 
  	// 페이징 처리 	
  	String replyPageNum = (String)request.getParameter("replyPageNum");
  	if(replyPageNum == null){ // replyPageNum 파라미터 안넘어오면, 1페이지 보여지게 
  		replyPageNum = "1";   // 1로 값 채우기 
  	}
  	System.out.println("replyPageNum : " + replyPageNum);
  	
  	int pageSize = 5;  // 현재 페이지에서 보여줄 글 목록의 수 
  	int currentPage = Integer.parseInt(replyPageNum); // replyPageNum int로 형변환 -> 숫자 연산 
  	int startRow = (currentPage - 1) * pageSize + 1; 
  	int endRow = currentPage * pageSize; 
  	
  	// 댓글 목록 가져오기 
  	FreeReplyBoardDAO freereplydao = new FreeReplyBoardDAO();
  	int count = freereplydao.getFreeReplyCount(boNo);   // 본문글의 해당하는 댓글들의 개수만 조회해오기 

  	List replyList = null;
  	if(count > 0) {
  		// 댓글 목록 가져오기 
  		replyList = freereplydao.getFreeReplies(boNo, startRow, endRow); 
  	 
  	}
      
  	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
      
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
   	<%-- 페이지 타이틀 --%>	
			<h4 align="center"><b>자유게시판</b></h4>
			<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeBoardMain.jsp?boNo=<%=boNo %>&pageNum=<%=pageNum %>'"  style="float: right;">목록으로</button>
			<br />
   <hr />
   
   
      <div class="row">
         <div class="col-sm">
            <table>
				<tr>
					<td><%=freeArticle.getBoCategory() %></td>
				</tr> 
				<tr>
					<td><h3><b><%=freeArticle.getBoSubject() %></b></h3></td> 
				</tr>	
				<tr>
					<td><%= freeArticle.getMemId() %></td> 
				</tr>
				<tr>
					<td><%= sdf.format(freeArticle.getBoReg())%></td>
				</tr>
				<tr><td><br /></td></tr>
				<tr>
					<% if(freeArticle.getBoImg() != null){ %>
					<td><img src="/project/save/<%=freeArticle.getBoImg() %>" width="600"/></td> 
					<% } %>
				</tr>
				<tr>
					<td><pre><%= freeArticle.getBoContent() %></pre></td>
				</tr>
				<tr>
					<td><br /></td>
				</tr>
				<tr>
					<%if(category.equals("cen")){//cen이면
						if(freeArticle.getMemId().equals(meminfo.getMemName())){%>
							<td>
								<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeContentModify.jsp?boNo=<%=boNo %>&pageNum=<%=pageNum %>'">수정하기</button>
								<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeContentDeletePro.jsp?boNo=<%=boNo %>&pageNum=<%=pageNum %>'">삭제하기</button>
							</td>
						<%}
					}else if(category.equals("mem")){//카테고리가 mem이면
						if(freeArticle.getMemId().equals(id)){ %>
							<td>
								<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeContentModify.jsp?boNo=<%=boNo %>&pageNum=<%=pageNum %>'">수정하기</button>
								<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeContentDeletePro.jsp?boNo=<%=boNo %>&pageNum=<%=pageNum %>'">삭제하기</button>
							</td>
						<%}//if%>
					<%}else if(category.equals("admin")){%>
							<td>
								<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeContentModify.jsp?boNo=<%=boNo %>&pageNum=<%=pageNum %>'">수정하기</button>
								<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeContentDeletePro.jsp?boNo=<%=boNo %>&pageNum=<%=pageNum %>'">삭제하기</button>
							</td>
					<%} %>
				</tr>
			</table>
		</div>
	</div> <%--col-sm --%>
<br />
 <hr />
<br />

<%--- 댓글 --%>

	<div class="container">
		<div class="row">
			<div class="col-sm">
			<%if(!freeArticle.getBoCategory().equals("공지")){ %>
				<%if(count == 0) { %>
					<table class="table">
						<thead>
							<tr>
								<td colspan="4"> <b>댓  글</b> 
									<%if(id != null){ %>
										<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeReplyForm.jsp?boNo=<%=boNo%>&pageNum=<%=pageNum%>'" style="float: right;">댓글작성</button> 
									<%} %>
								</td>
							</tr>
							<tr>
								<td> 댓글이 없습니다.</td>
							</tr>
						</thead>
					</table>
				<%}else{ // count가 0보다 크면 = 댓글이 있으면 %>
					<table class="table">
						<thead>
							<tr>
								<th colspan="4"> <b>댓  글</b> 
									<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeReplyForm.jsp?boNo=<%=boNo%>&pageNum=<%=pageNum%>'" style="float: right;">댓글작성</button> 
								</th>
							</tr>
							<tr>
								<th>내  용</th>
								<th>작성자</th>
								<th>작성시간</th>
								<th>&nbsp;</th>
								
							</tr>
						</thead>	
						<tbody style="border: 0.5px; border-color: #cfd8dc;">
							<tr style="border: 0.5px;border-color: #cfd8dc;">
								<%for(int i = 0; i < replyList.size(); i++){
									FreeReplyBoardDTO freeReply = (FreeReplyBoardDTO)replyList.get(i);%>
							</tr>
							<tr>
								<td align="left">
								<% // 댓글의 댓글 들여쓰기 효과 주기 
								int wid = 0; 
								if(freeReply.getFreeReplyLevel() > 0) { 
									wid = 12 * freeReply.getFreeReplyLevel(); %>
									<img src="img/tabImg.PNG" width="<%=wid%>"/>
									<img src="img/replyImg.png" width="12" />
								<%}%>
								<%=freeReply.getFreeReply()%>
								<td><%=freeReply.getFreeReplyer()%></td>
								</td>
								<td><%=sdf.format(freeReply.getFreeReReg())%></td>
								<td>
									<%if(category.equals("cen")){
										if(freeReply.getFreeReplyer().equals(meminfo.getMemName()) || id.equals("admin")){%>
											<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeReplyDeletePro.jsp?freeReNo=<%=freeReply.getFreeReNo()%>&boNo=<%=boNo%>&pageNum=<%=pageNum%>'" style="float: right;">삭제</button>
											<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeReplyModify.jsp?freeReNo=<%=freeReply.getFreeReNo()%>&boNo=<%=boNo%>&pageNum=<%=pageNum%>'" style="float: right;">수정</button> &nbsp;
											<%} 
									 }else if(category.equals("mem")){ //카테고리가 mem이면
										if(id.equals(freeReply.getFreeReplyer()) || id.equals("admin")){ %>
											<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeReplyDeletePro.jsp?freeReNo=<%=freeReply.getFreeReNo()%>&boNo=<%=boNo%>&pageNum=<%=pageNum%>'" style="float: right;">삭제</button>
											<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeReplyModify.jsp?freeReNo=<%=freeReply.getFreeReNo()%>&boNo=<%=boNo%>&pageNum=<%=pageNum%>'" style="float: right;">수정</button> &nbsp;
										<%} 
									}else if(category.equals("admin")){ %>
											<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeReplyDeletePro.jsp?freeReNo=<%=freeReply.getFreeReNo()%>&boNo=<%=boNo%>&pageNum=<%=pageNum%>'" style="float: right;">삭제</button>
											<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeReplyModify.jsp?freeReNo=<%=freeReply.getFreeReNo()%>&boNo=<%=boNo%>&pageNum=<%=pageNum%>'" style="float: right;">수정</button> &nbsp;
									<%} %>
									<button class="btn btn-outline-secondary btn-sm" onclick="window.location='freeReplyForm.jsp?freeReNo=<%=freeReply.getFreeReNo()%>&freeReplyGrp=<%=freeReply.getFreeReplyGrp()%>&freeReplyStep=<%=freeReply.getFreeReplyStep()%>&freeReplyLevel=<%=freeReply.getFreeReplyLevel()%>&boNo=<%=boNo%>&pageNum=<%=pageNum%>'" style="float: right;">답글</button>
								
								</td>
							</tr>
	 						<%}//for문 %>
	 					</tbody>
				</table>
				<%}//만약 카테고리가 공지가 아니라면 %>
			</div>
		</div>
	</div> <%--container --%>

<br />
<%-- 댓글 목록 밑에 페이지 번호 뷰어 추가 --%>
	<br />
	<div align="center">
		<%if(count > 0){
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
				<a class="Atitle" href="freeContent.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=startPage-1%>&boNo=<%=boNo%>"> &lt; &nbsp; </a>
			<%}
			
			for(int i = startPage; i <= endPage; i++){ %>
				<a class="Atitle" href="freeContent.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=i%>&boNo=<%=boNo%>"> &nbsp; <%=i%> &nbsp; </a>
			<%}
			
			if(endPage < pageCount) { %>
				<a class="Atitle" href="freeContent.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=startPage+pageNumSize%>&boNo=<%=boNo%>"> &nbsp; &gt; </a>
			<%}
			
		}//if%>
	</div>
	<%}//else %>
</div>
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