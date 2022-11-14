<%@page import="project.adminMyPage.model.MainBannerDTO"%>
<%@page import="project.adminMyPage.model.MainBannerDAO"%>
<%@page import="project.adminMyPage.model.AdminDateDTO"%>
<%@page import="project.adminMyPage.model.AdminDateDAO"%>
<%@page import="java.sql.Date"%>
<%@page import="project.volPage.model.VolApplyBoardDAO"%>
<%@page import="project.volPage.model.VolBoardDAO"%>
<%@page import="project.signup.model.MemberSignupDTO"%>
<%@page import="project.volPage.model.VolBoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="project.volPage.model.VolBoardDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="project.memMyPage.model.MemDataDTO"%>
<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>BalloonTeer</title>
   	<%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
	<%-- 부트스트랩 --%>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<link rel="stylesheet" href="/project/css/main.css" type="text/css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
   	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  	 <link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300&display=swap" rel="stylesheet">
	
	
	
   <%-- 7월25일 --%>
   <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>
   <!-- 아래 이징 플러그인은 부드러운 모션 처리를 위해서 필요 -->
   <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
   <script src="jquery.motionj.sbanner-1.1.js"></script>
	  <style type="text/css">
	         .skydiv { position: fixed; top: 50%; right: 10px; }
	       .skydiv { border: 1px solid #790000; padding: 10px; }
	   </style>
	   <style type="text/css">
	       .skydiv2 { position: fixed; top: 55%; right: 10px; }
	       .skydiv2 { border: 1px solid #790000; padding: 10px; }
	   </style>
  
   <script>
   (function($){
	      $(document).ready(function(){
	         $('#motionj_slide_01').motionj_slide_banner({
	            width : 1303, //Banner box width
	            height : 310, // Banner box height
	            speed : 500, // Sliding speed
	            delay : 3000, // Delay time
	            image : './images/', // path of images
	            pause : false // true is stop banner, false is auto moving banner
	         });
	      });
	   })(jQuery);  
	   
	   
	   (function($){
		      $(document).ready(function(){
		         $('#motionj_slide_02').motionj_slide_banner({
		            width : 306, //Banner box width
		            height : 280, // Banner box height
		            speed : 500, // Sliding speed
		            delay : 3000, // Delay time
		            image : './images/', // path of images
		            pause : false // true is stop banner, false is auto moving banner
		         });
		      });
		   })(jQuery);  
	   
   </script>    
</head>

<%
	request.setCharacterEncoding("utf-8");
   String id = (String)session.getAttribute("memId");
   MemberSignupDAO dao = new MemberSignupDAO();
   
   
   //아이디 주고 카테고리 찾아오기 메서드 만들기
   String category = dao.categorySeach(id);
   MemDataDAO memdatadao = new MemDataDAO();
   String userName = dao.getName(id);
   MemDataDTO memdatadto =  memdatadao.getMemData(id);
   
   
   
   
   
   // 7월 26일 수정
   // 레벨이 제일 높은 유저 찾기
   String topLevelId = memdatadao.topLevel();
   MemDataDTO topleveliddto =  memdatadao.getMemData(topLevelId);
   // 레벨이 제일 높은 유저의 회원가입db에 있는 모든 데이터 가져오기 메서드 MemberSignDAO에 있음
   MemberSignupDTO topLeveldata =dao.getMember(topLevelId);

   // 봉사횟수가 제일 높은 유저 찾기
   String topVolCount = memdatadao.topCount();
   MemDataDTO topvolcountiddto =  memdatadao.getMemData(topVolCount);
   // 봉사횟수가 제일 높은 유저의 회원가입db에 있는 모든 데이터 가져오기 메서드 MemberSignDAO에 있음
   MemberSignupDTO topVolCountdata = dao.getMember(topVolCount);
   
   // 봉사 시간이 제일 높은 유저 찾기
   String topVolTime = memdatadao.topVolTime();
   MemDataDTO topvoltimedto =  memdatadao.getMemData(topVolTime);
   MemberSignupDTO topVolTimedata = dao.getMember(topVolTime);
   // 7월 26일 수정
   
   
   
	// 봉사신청 총횟수와 오늘의 봉사 신청 횟수 가져오기
   VolApplyBoardDAO volApDAO = new VolApplyBoardDAO();
	Date today = new Date(System.currentTimeMillis());  // 마지막으로 접속한 일자
   	String to = String.format("%1$tY-%1$tm-%1$td", today);


   
   
   
   // 현재 요청된 게시판 페이지 번호
   String pageNum = request.getParameter("pageNum");
   if(pageNum == null
         || pageNum.equals("null")
         || pageNum.equals("")){
      pageNum = "1";
   } // 만약pageNum이 0이면 1값 주기
   System.out.println("pageNum : " + pageNum);
   
   // 현재 페이지에서 보여줄 게시글의 시작과 끝 등의 정보 세팅
   int pageSize = 5;
   int currentPgae = Integer.parseInt(pageNum);
   int startRow = (currentPgae -1 ) * pageSize + 1;
   int endRow = currentPgae * pageSize;
   
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   
   // DB에서 전체 글 개수 가져오기
   VolBoardDAO volboardDAO = new VolBoardDAO();
   int volCount = volboardDAO.getVolCount(); // 글 개수 volcount에 담기 
   List<VolBoardDTO> volList = null; // 글 목록 리턴받을 변수 
   
   if(volCount > 0){
      volList = volboardDAO.getVol(startRow, endRow);  // 게시글이 한개라도 있으면 시작, 끝번호 주면서 게시글 가져오기
   }
   int number = volCount - (currentPgae - 1) * pageSize;  // 화면에 뿌려줄 글번호
    
   
   //0727 - 파트너 이미지 DB연결
   AdminDateDAO adDAO = new AdminDateDAO();
   AdminDateDTO adDTO = new AdminDateDTO();
   
   
   //7월 27일 메인 이미지 가져오기**
   
   
   // 7월 27일 메인 이미지 가져오기
   MainBannerDAO mainDAO = new MainBannerDAO();
   MainBannerDTO mainDTO = new MainBannerDTO();
   
   String  callMainBan1 =mainDAO.callMainBan1(); 
   String  callMainBan2 =mainDAO.callMainBan2();
   String  callMainBan3 =mainDAO.callMainBan3();
   System.out.println("callMainBan1 : " +callMainBan1);
   System.out.println("callMainBan2 : " +callMainBan2);
   System.out.println("callMainBan3 : " +callMainBan3);
   
   
   
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
   
   
<%-- ***************************** 메인배너************************* --%>
	
				
  	<div class="col-sm" align="center">


       <div id="motionj_slide_01">
            <ul style="list-style-type: none">
               <li>
                  <a href='' target='_blank'><img src='/project/save/<%=callMainBan1 %>' alt=''  width=1303  height="310"></a>
               </li>
               <li>
                  <a href='' target='_blank'><img src='/project/save/<%=callMainBan2%>' alt='' width=1303 height="310"/></a>
               </li>
               <li>
                  <a href='' target='_blank'><img src='/project/save/<%=callMainBan3%>' alt='' width=1303 height="310"/></a>
               </li>
            </ul>
       </div>
    
   </div>   
   <br /> 
 <%--  ***************************** 월간 챔피언   *****************************--%>  
	   <div class="container" >
    	<div class="cols-2 g-5">
    		 <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4"  >

    		 	<div class="col" style="width: 25%; height: 300px;">
			     	<div class="card shadow-sm cols-1" id="pointcard" style="background-color: #ffecb3;">
				     	<div id="motionj_slide_02" align="center"  class="cham">
				     	
		                  <ul style="list-style-type: none">
		                 
		                     <li><h5><b>레벨 top</b></h5>
		                        <a><img src='/project/save/<%=topLeveldata.getMemPhoto() %>'   width="60%" class="chamImg"/></a>
		                        <h5><b><%=topLeveldata.getMemName() %></b></h5><h5>Level<%=topleveliddto.getMemLevel() %></h5><br />
		                     </li>
		                     <li><h5><b>봉사횟수 top</b></h5>
		                        <a><img src='/project/save/<%=topVolCountdata.getMemPhoto() %>'  width="60%" class="chamImg"/></a>
		                        <h5><b><%=topVolCountdata.getMemName() %></b></h5><h5>봉사 <%=topvolcountiddto.getMemVolCount() %>회</h5>
		                     </li>
		                     <li><h5><b>봉사시간 top</b></h5>
		                        <a><img src='/project/save/<%=topVolTimedata.getMemPhoto() %>' width="60%" class="chamImg"/></a>
		                        <h5><b><%=topVolTimedata.getMemName() %></b></h5><h5>봉사 <%=topvoltimedto.getMemVolTime() %>시간</h5>
		                     </li>
		                  </ul>
	               </div> 
	            </div>     
    		</div>
    		
 <%--  ***************************** 봉사모집현황   *****************************--%>   
   		 	
 		<div class="cols-3" style="width: 75%; height: 321px;" >
          <div class="card shadow-sm" id="pointcard" style="background-color:#ecf2ff; height: 310px;" >
                        		
               <% if(volList == null){ %>
	               <table id="volBoard">
          			<tr>
          				<td><h3><b>봉사 모집 현황 </b></h3></td>
          				<td><button style="float: right" class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/volPage/volBoardMain.jsp'" >더보기</button></td>
          			</tr>
	               	<tr>
	               		<td>게시글이 없습니다.</td>
	               	</tr>
	               </table>
               <% }else{ %>
	               <%-- 반복해서 뿌리기  --%>
	                <table id="volBoard">
	                	<tr>
          					<td><h3><b>봉사 모집 현황 </b><button style="float: right" class="btn btn-outline-secondary btn-sm" onclick="window.location='/project/volPage/volBoardMain.jsp'" >더보기</button></h3></td>
          				</tr>
	                                        
	                   	<tr>
	                   		<td>&nbsp;</td>
	                   	</tr>
	                <%for(int i = 0; i < volList.size(); i++){ 
	                      VolBoardDTO volarticle= volList.get(i); %>
	                   	<tr>
	                      <td><a class="Atitle" href="/project/volPage/volContent.jsp?volNo=<%=volarticle.getVolNo()%>&pageNum=1"><%=volarticle.getVolSubject()%></a></td>
	                      <td><%=volarticle.getMemId()%></td>
	                      <td><%=volarticle.getVolReg()%></td>
                  		</tr>
                   <% } %>
                <%} //(int i = 0; i < volList.size(); i++)%>

                </table>
       		</div>
 		 </div>
 		 
    </div>
   </div>	
</div> <%-- container --%><br />	

         
         
  <%-- ***************************** 오늘의 참여현황 ************************* --%>
	
	<div class="container">			
	  	<div class="col-sm g-5">
			<div class="card shadow-sm" id="pointcard" style="background-color:#ecf9d5;">
	
		      <table class="volApply">
				<tr>
					<td rowspan="2" align="center"><h3><b>오늘의 봉사 참여현황</b></h3></td>
					<td><h5><b>총 봉사 참여자</b></h5></td>
					<td><h5><%= volApDAO.getAllApplyCount() %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h5></td>
				</tr>
				<tr>
					<td><h5><b>오늘 봉사 참여수</b></h5></td>
					
					<td><h5><%= volApDAO.todayVolApplyCount(to) %> </h5></td>
				</tr>
	 		</table>
	 		
	    </div>
	   </div>   
   </div>
 <br />	   
        
         
   
   <%-- ***************************** 이달의 스페이셜 기프트 ************************* --%>
 	   <div class="container" >
    	<div class="cols-2 g-5">
    		 <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4"  >
    		 	<div class="cols-3" style="width: 75%; height: 300px;" align="left">
			     	<div class="card shadow-sm cols-1" id="pointcard" style="background-color: #ffecb3;">
		     	 	
		                   <% adDTO = adDAO.getImg(4);
		                        if(adDTO != null){ %>
		                        	<img src = "/project/save/<%= adDTO.getImg() %>" width="100%" height="300px"/>  
		                   <% 	} %> 
	            </div>       
    		</div>
    		
 <%--  ***************************** 이달의 파트너   *****************************--%>   
   		 	
 		<div class="col" style="width: 25%; height: 300px;">
          <div class="card shadow-sm" id="pointcard" style="background-color:#ecf2ff;">
                        		
              <% adDTO = adDAO.getImg(1);
              	if(adDTO != null){ %>
              	<img src = "/project/save/<%= adDTO.getImg() %>" width="100%" height="300px"/>  
              <% } %> 
              
       		</div>
 		 </div>
 		 
    </div>
   </div>	
</div> <%-- container --%>
      
   

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