<%@page import="project.memMyPage.model.MemDataDTO"%>
<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@page import="project.adminMyPage.model.AdminDateDTO"%>
<%@page import="project.adminMyPage.model.AdminDateDAO"%>
<%@page import="project.pointPage.model.ShopBoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="project.pointPage.model.ShopBoardDAO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>포인트샵</title>
	<%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
	<%-- 부트스트랩 --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<link rel="stylesheet" href="/project/css/pointShop.css" type="text/css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
   	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  	 <link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300&display=swap" rel="stylesheet">

</head>
<%
	String id = (String)session.getAttribute("memId");
	MemberSignupDAO dao = new MemberSignupDAO();
	//아이디 주고 카테고리 찾아오기 메서드 만들기
	String category = dao.categorySeach(id);   
		   MemDataDAO memdatadao = new MemDataDAO();
		   MemDataDTO memdatadto = null;
		   int memPoint = 0;
		if(id != null){
		   //7월 28일 수정
		  memdatadto = memdatadao.getMemData(id);
		   memPoint = memdatadto.getMemPoint();
		   //7월 28일 수정
		}
	
	
	
	//dto(그릇)해서 dao(담아서 가꼬와야함)해서 끌고와야함
	// 페이징 처리
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){	// pageNumm 안넘어오면 1페이지 보여지게하는거
		pageNum = "1";		// 1로 값 나오게하기
	}
	System.out.println("pageNum : " + pageNum); 
	
	int pageSize = 8;								// 현재 페이지에 나오는 글목록수
	int currentPage = Integer.parseInt(pageNum);	// pageNum -> int 숫자연산
	int startRow = (currentPage -1) * pageSize + 1;
	int endRow = currentPage * pageSize; 
	
	// 게시글가져오고 전체 글 개수구하기
	ShopBoardDAO shopboarddao = new ShopBoardDAO();	
	int count = 0;									// 전체 글 개수 담을 변수
	List<ShopBoardDTO> shopList = null;				// 글 목록 리턴받을 변수
	
	count = shopboarddao.getshopCount2(); 
	if(count > 0){
		shopList = shopboarddao.getshoparticleList2(startRow, endRow);
	}
	
	int number = count - (currentPage - 1) * pageSize;	
	
	AdminDateDAO adDAO = new AdminDateDAO();
	AdminDateDTO adDTO = new AdminDateDTO();
	
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

    <%--**** 타이틀 **** --%>
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
	<%-- 페이지 타이틀 --%>	
	<h4 align="center"><b>포인트샵</b></h4>
	<br />
	
	<main>
		
		<%	if(id == null){ %>
		
		<%	}else if(id.equals("admin")){ %> 
			<div align="right" class="container">
				<button class="btn btn-outline-secondary btn-sm" onclick="window.location='pointWriteForm.jsp'">글작성</button>
				
			</div>
		<%	} %>
			
		<br/>	
			
		<%-- 포인트샵 광고 --%>	
		<%   if(count == 0){ %>
			상품이 없습니다.
		
		<% }else { %>
		
		    <div class="container" >
		    
		    	<div class="cols-2">
		    		 <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4"  >
		    		 	<div class="col" style="width: 25%; height: 291px;">
					          <div class="card shadow-sm cols-1" id="pointcard" style="background-color:#ffb74d; height: 291px;">
									<% if(id == null){ %>
										<br />
										<br />
										<br />
										<br />
										<br />
										<h5 align="center"><b>여러분의 소중한 마음으로</b></h5>
										<h5 align="center"><b>놀라운 변화가 일어납니다 🎈</b></h5>
										<br />
										<br />
										<br />
										<br />
										<br />
									<% }else{ %>
										<br />
										<br />
										<br />
										<br />
										<br />
										<h4 align="center">나의 보유 포인트</h4>			
										<h2 align="center"><b><%=memPoint%>P</b></h2>			
										<br />
										<br />
										<br />
										<br />
									<% } %>	
									
										            	
			         		</div>
		    		 	</div>
		    		 	<div class="cols-3" style="width: 75%; height: 321px;">
					          <div class="card shadow-sm cols-2" id="pointcard">
					          			<% adDTO = adDAO.getImg(2); %>
										<img src="/project/save/<%= adDTO.getImg() %>" height =" 291px"/>
										
										            	
			         		</div>
		    		 	</div>
		    	
		    	
		    		</div>
		    	</div>	
										            	
		      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
					<%-- 제품 이미지 --%>
					<%      for(int i = 0; i < shopList.size(); i++){
					         ShopBoardDTO shoparticle = shopList.get(i);
					         if(shoparticle.getGoodsStatus() != 2){ 
					   
					%> 
						        <div class="col">
						          <div class="card shadow-sm" id="pointcard">
						            <a href="/project/pointPage/pointContent.jsp?sNo=<%=shoparticle.getsNo()%>&pageNum=<%=pageNum%>" >
						            	<img src="/project/save/<%= shoparticle.getShopImg() %>" width="100%" height="260"/>
						            </a>
						            <div class="card-body">
						              <div class="d-flex justify-content-between align-items-center">
						                <div class="btn-group">
						                	<h5><b><%= shoparticle.getGoodsName() %></b></h5>
						                </div>
						                <small class="text-muted"><b><%= shoparticle.getPrice() %>P</b></small>
						              </div>
						            </div> <%-- card body --%>
						          </div>
						        </div>
		          <% } %>
				<% } %>
		      </div>
		   	</div>     
		
		
		<% } %>

		<%--  
		<%   if(count == 0){ %>
		   <div align="center">
		      <table>
		         <tr>
		            <td>상품명</td>     
		            <td>판매상태</td>          
		            <td>상품가격</td>   
		            <td>내용</td>   
		            <td>상품이미지</td>   
		         </tr>
		         <tr>
		            <td>상품이 없습니다.</td>
		         </tr>
		      </table>
		   </div>   
		<%   }else{ %>
		   
		   <div align="center">
		   <table> 
		      <tr>
		         <td>상품명</td>
		         <td>판매상태</td>
		         <td>상품가격</td>
		         <td>내용</td>
		         <td>상품이미지</td>
		      </tr>
		<%      for(int i = 0; i < shopList.size(); i++){
		         ShopBoardDTO shoparticle = shopList.get(i);
		         if(shoparticle.getGoodsStatus() != 2){ 
		   
		%>      
		      <tr>      
		         <td>  
		            <a href="/project/pointPage/pointContent.jsp?sNo=<%=shoparticle.getsNo()%>&pageNum=<%=pageNum%>" >
		               <%=shoparticle.getGoodsName()%>
		            </a>
		         </td>         
		         <td><%if(shoparticle.getGoodsStatus() == 1){ %>
		               판매중
		            <%}else if(shoparticle.getGoodsStatus() == 0){ %>
		               품절
		            <%}else if(shoparticle.getGoodsStatus() == 2){%>
		               삭제중
		            <%} %>      
		         </td>
		         <td><%=shoparticle.getPrice() %></td>
		         <td><%=shoparticle.getContent() %></td>
		         <td> <img src="/project/save/<%=shoparticle.getShopImg()%>" width="100px"></td>
		      </tr>
		      
		      
		         
		<%         } %>      
		<%      } %>
		<%   } %>
		   </table>
		</div>
		--%>
		
		
		<%-- 게시판 번호 --%>
			<br />
			<br />
			<br />
			<div align="center">
		<%
			if(count > 0){
				//	3페이지 번호씩 보여주겠다
				//	총 몇페이지 나오는지 계산 -> 뿌려야되는 페이지번호
				int pageCount = count/ pageSize +(count % pageSize == 0? 0 : 1);
				int pageNumSize = 5; // 한페이지에 보여줄 페이지번호 갯수
				int startPage = (int)((currentPage-1)/pageNumSize)*pageNumSize +1;
				int endPage = startPage + pageNumSize -1;
				//	전체 페이지수보다 위에 계산된 페이지 마지막번호가 더 크면 안되므로.
				//	아래서 endPage 다시 조정
				if(endPage > pageCount){ endPage = pageCount; }			// 엔드페이지가 최종페이지보다 크면 엔드=최종
				System.out.println("pageCount ="+pageCount);
				System.out.println("startPage ="+startPage);
				System.out.println("endPage ="+endPage);
					
				// 페이지 번호 뿌리기
				if(startPage > pageNumSize){ 				//	시작페이지가 표기사이즈보다 크면  < 꺽세 눌러 페이지 이동	%>				
					<a class="Atitle" href="pointShop.jsp?pageNum=<%= startPage-pageNumSize %>"> &lt; &nbsp;</a>		<%-- <꺽세 표시 = &lt; >꺽세= &gt;  --%>
		<%		}
				for(int i = startPage ; i<=endPage ; i++){ %> 
					<a class="Atitle" href= "pointShop.jsp?pageNum=<%= i %>"> <%= i %> &nbsp; </a> &nbsp; <%	//	&nbsp; 가 띄어쓰기 한칸 
				}
				if(endPage < pageCount){ %>				
						<a class="Atitle" href="pointShop.jsp?pageNum=<%= startPage+pageNumSize %>"> &nbsp; &gt; </a>		<%-- < >꺽세 표시 = &lt; --%>
		<%		}
			} %>
			</div>

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