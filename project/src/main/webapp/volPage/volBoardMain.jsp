<%@page import="java.sql.Date"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="project.volPage.model.VolBoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="project.volPage.model.VolBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <title>volPage</title>
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
   String category = "";
   
   //아이디 주고 카테고리 찾아오기 메서드 만들기
   
   if(id != null){
         category = dao.categorySeach(id);
   }else{
      category = "null";
   }

   // 페이징 처리    
   String pageNum = request.getParameter("pageNum");
   if(pageNum == null){ // pageNum 파라미터 안넘어오면, 1페이지 보여지게 
      pageNum = "1";   // 1로 값 체우기 
   }
   System.out.println("pageNum : " + pageNum);
   
   int pageSize = 5;  // 현재 페이지에서 보여줄 글 목록의 수 
   int currentPage = Integer.parseInt(pageNum); // pageNum을 int로 형변환 -> 숫자 연산 
   int startRow = (currentPage - 1) * pageSize + 1; 
   int endRow = currentPage * pageSize; 
   
   // 게시글 가져오기 
   // 전체 글의 개수 구하고, 
   VolBoardDAO volboarddao = new VolBoardDAO(); 
   
   //오늘 날짜 스트링으로 
      SimpleDateFormat sdf = new SimpleDateFormat("MM/dd"); 
      Date today = new Date((System.currentTimeMillis()));
      System.out.println(today);
      String todayFormat = (sdf.format(today));
      System.out.println(todayFormat);
      
   //today 날짜를 주고 endDate랑 비교해서 volStatus 바꾸기 
      VolBoardDTO voldto = new VolBoardDTO(); 
      volboarddao.compareTodayEndDate(todayFormat);   //모집마감(기간종료)
   //today 날짜를 주고 endDate랑 비교해서 volStatus 바꾸기 (봉사진행중)
      volboarddao.compareTodayStartDate(todayFormat);     
     //today 날짜를 주고 endDate랑 비교해서 volStatus 바꾸기 (봉사예정)
      volboarddao.compareTodayDateIng(todayFormat); 
     
      
   int count = 0;             // (전체/검색) 전체 글 개수 담을 변수 
   List<VolBoardDTO> volList = null;    // (전체/검색) 글 목록 리턴받을 변수 
      
   //하단 검색
      String sel = request.getParameter("sel");
      String search = request.getParameter("search"); 
      
   //상단 검색 1
      String topSel = "volCategory";
      String topSelVal = request.getParameter("topSelVal"); //카테고리  sort 
      
   //상단 검색2 
      String topSelStatus = "volStatus";
      String topSelValStatus = request.getParameter("topSelValStatus"); //모집상태 sort 
        System.out.println("2검색: " + topSelValStatus);
      
      
      if(sel != null && search != null) { //하단 검색일때 
         count = volboarddao.getVolSearchCount(sel, search);  // 검색에 맞는 게시글에 개수 가져오기 
         if(count > 0) { 
            // 검색한 글 목록 가져오기 
            volList = volboarddao.getVolSearch(startRow, endRow, sel, search);  
         }
      }else if(topSelVal != null){ //상단 검색 1 일때 
        System.out.println("1검색: " + topSelVal);
        count = volboarddao.getVolTopSearchCount(topSel, topSelVal);
        if(count > 0) { 
             // 상단검색한 글 목록 가져오기 
             volList = volboarddao.getVolTopSearch(startRow, endRow, topSel, topSelVal);
        }
      }else if(topSelValStatus != null){ //상단 검색 2일때
        count = volboarddao.getVolTopSearchStatusCount(topSelStatus, topSelValStatus); 
        if(count > 0) { 
             // 검색한 글 목록 가져오기 
             volList = volboarddao.getVolTopSearchStatus(startRow, endRow, topSelStatus, topSelValStatus);  
          } 
      }else { // 일반 게시판일때 
         count = volboarddao.getVolCount();  // 그냥 전체 게시글 개수 가져오기 
         // 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
         if(count > 0){
            volList = volboarddao.getVol(startRow, endRow);  
         }
      } 
      System.out.println("article count : " + count);
      System.out.println(volList);
      
      int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글번호(bno아님)
     
        
      
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
      
      <%-------------------------------------------봉사보드메인 ------------------------%>
      
<div class="container">
	<%-- 페이지 타이틀 --%>	
	<h4 align="center"><b>봉사</b></h4>
	<br />
      <%-- 상단 카테고리 검색(sort) --%>
      <div style="display: inline-block">
         <form action="volBoardMain.jsp" >
               <select name="topSelVal" >
               	<% 
				topSelVal = request.getParameter("topSelVal");               	
               	if(topSelVal != null){ %>
                 <option value="어린이" <%if(topSelVal.equals("어린이")){%>selected="selected"<%}%>>어린이</option>
                  <option value="환경"<%if(topSelVal.equals("환경")){%>selected="selected"<%}%>>환경</option>
                  <option value="어르신"<%if(topSelVal.equals("어르신")){%>selected="selected"<%}%>>어르신</option>
                  <option value="동물"<%if(topSelVal.equals("동물")){%>selected="selected"<%}%>>동물</option>
                  <option value="교육"<%if(topSelVal.equals("교육")){%>selected="selected"<%}%>>교육</option>
                  <% }else{ %>
                  <option value="어린이">어린이</option>
                  <option value="환경">환경</option>
                  <option value="어르신">어르신</option>
                  <option value="동물">동물</option>
                  <option value="교육">교육</option>
                  <% } %>
                  
              </select>
               <input type="submit" value="검색" class="btn btn-outline-secondary btn-sm"/>     
      	</form> 
     </div>      
     &nbsp;
      <%-- 상단 모집상태 검색(sort) --%>  
     <div style="display: inline-block"> 
      <form action="volBoardMain.jsp">
            <select name="topSelValStatus" >
            <% 
            	topSelValStatus = (String)request.getParameter("topSelValStatus");               	
               	if(topSelValStatus != null){ %>
              <option value="-1" <%if(topSelValStatus.equals("-1")){%>selected="selected"<%}%>>모집중</option>
               <option value="0"<%if(topSelValStatus.equals("0")){%>selected="selected"<%}%>>봉사진행중</option>
               <option value="1"<%if(topSelValStatus.equals("1")){%>selected="selected"<%}%>>모집마감(기간종료)</option>
               <option value="2"<%if(topSelValStatus.equals("2")){%>selected="selected"<%}%>>모집마감(인원마감)</option>
               <% }else{ %>
                 <option value="-1">모집중</option>
               	<option value="0">봉사진행중</option>
               	<option value="1">모집마감(기간종료)</option>
               	<option value="2">모집마감(인원마감)</option>
               
               <% } %>
           </select>
            <input type="submit" value="검색" class="btn btn-outline-secondary btn-sm"/>         
      </form>
    </div>  
    
    <div style="display: inline-block; float: right;">
      <% if(category.equals("cen")){ %>
         <button onclick="window.location='volWriteForm.jsp'" class="btn btn-outline-secondary btn-sm">글작성</button> <br />
       <% } %>
	</div>
	
    <hr />

      <br />
      <br />
      
      
<%-- ***** 봉사 본문 ***** --%>
	<div>
     <%  if(count == 0){ // 글이 없으면 %>
         <table class="table table-hover">
         	<thead>
                 <tr>
                  <th class="table-align">진행상황</th>
                  <th class="table-align">제  목</th>
                  <th class="table-align">봉사시간</th>
                  <th class="table-align">봉사기간</th>
                  <th class="table-align">모집인원</th>
               </tr>
             </thead>
             <tbody style="border: 0.5px; border-color: #cfd8dc;">  
               <tr style="border: 0.5px;border-color: #cfd8dc;">
                  <td class="table-align">게시글이 없습니다.</td>
                 </tr>
             </tbody>    
         </table>
   <%}else { // 글이 하나라도 있으면 %>
      <table class="table table-hover">  
      	<thead>
	         <tr>
	            <th class="table-align">진행상황</th>
	            <th class="table-align">제  목</th>
	            <th class="table-align">봉사시간</th>
	            <th class="table-align">봉사기간</th>
	            <th class="table-align">모집인원</th>
	         </tr>
         </thead>
         <%-- 게시글 목록 반복해서 뿌리기 tr-td묶음 --%>
         <%
         
         for(int i = 0; i < volList.size(); i++){
            // List에 제네릭타입을 지정안했기때문에 get()으로 꺼내면 Object타입으로 리턴해줌. 
            // DTO로 우리가 list에 추가해 이미 DTO타입을 알기때문에 바로 형변환해서 변수에 담아주자.
            VolBoardDTO volArticle = volList.get(i); 
           		if(volArticle.getVolArticleStatus() == 1){ %>
            <tbody style="border: 0.5px;border-color: #cfd8dc;">
            <tr style="border: 0.5px;border-color: #cfd8dc;">
               <td class="table-align">
               <%if(volArticle.getVolStatus() == -1){ %>
                  모집예정
               <%}else if(volArticle.getVolStatus() == 0){ %>
                  봉사진행중
               <% }else if(volArticle.getVolStatus() == 1){%>
                  모집마감(기간종료)
               <%}else if(volArticle.getVolStatus() == 2){ // 8월 2일%>
               	  모집마감(인원마감)
               <%} %>

               </td>
               
               <td><a class="Atitle" href="/project/volPage/volContent.jsp?volNo=<%=volArticle.getVolNo()%>&pageNum=<%=pageNum%>">
                  <%= volArticle.getVolSubject() %></a></td>
               <td class="table-align"><%= volArticle.getVolTime() %></td>
               <td class="table-align"><%= volArticle.getVolStartDate() %> ~ <%=volArticle.getVolEndDate() %></td>
               <td class="table-align"><%= volArticle.getVolMaxNum()%></td>
            </tr>
         <% } 
         } %>
         </tbody>
      </table>
      </div>
   <% } //else%> 

      
      
      
      
      <br />
   <%-- 게시판 목록 페이지 번호 뷰어 --%>
            <div align="center">
            <% if(count > 0) { 
                  // 한페이지에 보여줄 번호의 개수 
                  int pageNumSize = 5; 
                  // 총 몇페이지 나오는지 계산 
                  int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
                  // 현재 페이지에 띄울 첫번째 페이지 번호 
                  int startPage = ((currentPage - 1) / pageSize) * pageNumSize + 1; 
                  // 현재 페이지에 띄울 마지막 페이지번호  (startPage ~ endPage까지 번호 반복해서 뿌릴)
                  int endPage = startPage + pageNumSize - 1; 
               if(endPage > pageCount) { endPage = pageCount; } // 마지막 페이지번호 조정 
         
               if(startPage > pageNumSize) { 
                  if(sel != null && search != null) { %>
                     <a class="Atitle" href="volBoardMain.jsp?pageNum=<%=startPage-1%>&sel=<%=sel%>&search=<%=search%>"> &lt; &nbsp; </a>
                 <% }else if(topSel != null && topSelVal != null){ %>   
                     <a class="Atitle" href="volBoardMain.jsp?pageNum=<%=startPage-1%>&topSel=<%=topSel%>&topSelVal=<%=topSelVal%>"> &lt; &nbsp; </a>
                  <%}else if(topSelStatus != null && topSelValStatus != null){%>
                     <a class="Atitle" href="volBoardMain.jsp?pageNum=<%=startPage-1%>&topSelStatus=<%=topSelStatus%>&topSelValStatus=<%=topSelValStatus%>"> &lt; &nbsp; </a>
                 <% }else{%>
                     <a class="Atitle" href="volBoardMain.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
                  <%}
               }
               
               for(int i = startPage; i <= endPage; i++) { 
                  if(sel != null && search != null) { %>
                     <a class="Atitle" href="volBoardMain.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
                  <%} else if(topSel != null && topSelVal != null){ %>   
                     <a class="Atitle" href="volBoardMain.jsp?pageNum=<%=i%>&topSel=<%=topSel%>&topSelVal=<%=topSelVal%>"> &nbsp; <%= i %> &nbsp; </a>
                  <%} else if(topSelStatus != null && topSelValStatus != null){ %>   
                     <a class="Atitle" href="volBoardMain.jsp?pageNum=<%=i%>&topSelStatus=<%=topSelStatus%>&topSelValStatus=<%=topSelValStatus%>"> &nbsp; <%= i %> &nbsp; </a>
                  <%}else{ %>
                     <a class="Atitle" href="volBoardMain.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
                  <%} 
               }
               
               if(endPage < pageCount) { 
                  if(sel != null && search != null) { %>
                     <a class="Atitle" href="volBoardMain.jsp?pageNum=<%=startPage+pageNumSize%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; &gt; </a>
              <%  }else if(topSel != null && topSelVal != null){ %>   
                     <a class="Atitle" href="volBoardMain.jsp?pageNum=<%=startPage+pageNumSize%>&topSel=<%=topSel%>&topSelVal=<%=topSelVal%>"> &nbsp; &gt; </a>
              <%  }else if(topSelStatus != null && topSelValStatus != null){ %>   
                     <a class="Atitle" href="volBoardMain.jsp?pageNum=<%=startPage+pageNumSize%>&topSelStatus=<%=topSelStatus%>&topSelValStatus=<%=topSelValStatus%>"> &nbsp; &gt; </a>
               <%   }else{ %>
                     <a class="Atitle" href="volBoardMain.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
               <%   }
                  } 
               } %>
      <br /><br />
      
      <%-- 작성자/내용 검색 --%>
      <form action="volBoardMain.jsp">
         <select name="sel">
         	<% 
         	sel = request.getParameter("sel");
         	if(sel != null){ %>
            <option value="volSubject" <%if(sel.equals("volSubject")){%>selected="selected"<%}%>>제목</option>
            <option value="volCategory"<%if(sel.equals("volCategory")){%>selected="selected"<%}%>>카테고리</option>
            <%}else{ %>
            <option value="volSubject">제목</option>
            <option value="volCategory">카테고리</option>
            <% } %>
         </select>
         
         <%
         search = request.getParameter("search");
         if(search != null){ %>
         <input type="text" name="search" value="<%= search %>"/> 
         <input type="submit" value="검색" class="btn btn-outline-secondary btn-sm"/>
         <% }else{ %>
          <input type="text" name="search" /> 
         <input type="submit" value="검색" class="btn btn-outline-secondary btn-sm"/>
         <% } %>
      </form>
      <br />
      
      <button class="btn btn-outline-secondary btn-sm" onclick="window.location='volBoardMain.jsp'"> 전체 게시글 </button>
   
   </div>
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