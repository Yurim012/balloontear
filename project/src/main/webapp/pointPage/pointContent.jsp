<%@page import="project.memMyPage.model.MemDataDTO"%>
<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@page import="project.pointPage.model.ShopBoardDTO"%>
<%@page import="project.pointPage.model.ShopBoardDAO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>

<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>포인트샵 - 물품보기</title>
	<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>
	<%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
	<%-- 부트스트랩 --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<link rel="stylesheet" href="/project/css/pointShop.css" type="text/css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
   	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  	 <link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300&display=swap" rel="stylesheet">
  	 <script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>
  	 
  	 
</head>
<%
	String id = (String)session.getAttribute("memId");


		MemberSignupDAO dao = new MemberSignupDAO();
		
		
		String category = dao.categorySeach(id); 
		
		int sNo = Integer.parseInt(request.getParameter("sNo"));
		String pageNum = request.getParameter("pageNum");
		
		ShopBoardDAO shopdao = new ShopBoardDAO(); 
		ShopBoardDTO shoparticle = shopdao.getOneShopContent(sNo); 
		
		MemDataDAO memdatadao = new MemDataDAO();
		MemDataDTO memdatadto = memdatadao.getMemData(id);
		// 아이디값에 있는 포인트 끌고오기
		
		int mpoint = 0;
		if(id == null){
			mpoint = 0;
		}else {
			mpoint = memdatadto.getMemPoint();
		}
	
	%>
	<body>
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
	      <td><%=id %>님 환영합니다.</td>
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
		
	
		<main>
		
	
	
		
		<div class="container">
		<div class="row g-5">
	      <div class="col-md-4 order-md-2 mb-4">
	        <h4 class="d-flex justify-content-between align-items-center mb-3">
	          <span class="text-black"><b>구매하기</b></span>
	        </h4>
	        <ul class="list-group mb-3">
	          <li class="list-group-item d-flex justify-content-between lh-sm bg-light">
	            <div>
	              <h5 class="my-0"><b><%=shoparticle.getGoodsName() %></b></h5>
	              <small class="text-muted">상품번호 <%=shoparticle.getsNo() %></small>
	            </div>
	            <strong><%=shoparticle.getPrice() %>P</strong>
	          </li>
	          <li class="list-group-item d-flex justify-content-between lh-sm">
	              <h6 class="my-0">판매 상태</h6>
						<%if(shoparticle.getGoodsStatus() == 1){ %>
						 <span class="text-muted">판매중</span>
						<%}else if(shoparticle.getGoodsStatus() == 0){ %>
							<span class="text-muted">품절</span>
						<%}else if(shoparticle.getGoodsStatus() ==2){ %>
							<span class="text-muted">삭제</span>
						<%} %>
	          </li>
	          <li class="list-group-item d-flex justify-content-between lh-sm">
	            <div>
	              <h6 class="my-0">남은 수량</h6>
	            </div>
	            <span class="text-muted"><%=shoparticle.getGoodsStock() %>개</span>
	          </li>
	          <li class="list-group-item d-flex justify-content-between bg-light">
	            <div class="text-success">
	              <h6 class="my-0">※ 포인트로 교환시 상품의 교환, 환불이 불가합니다 신중한 구매 부탁드립니다 </h6> <br/>
	              <h6 class="my-0">※ 구매가능 : 2등급 이상 + 봉사참여 1회이상. </h6>
	            </div>
	          </li>
	        </ul>
	        
	
	
	        <form class="card p-2">
	         	<%	if(id != null){ %>
				<%		if(category.equals("admin")){ %>
							<input type="button" onclick="window.location='pointContentModifyForm.jsp?sNo=<%=shoparticle.getsNo()%>&pageNum=<%=pageNum%>'" value="수정하기" class="btn btn-secondary"/>
							<br/>
							<input type="button" onclick="window.location='pointDeletePro.jsp?sNo=<%=shoparticle.getsNo()%>&pageNum=<%=pageNum%>'" value="삭제하기" class="btn btn-secondary"/>
							
				<%		}else if(category.equals("mem")){
							if(memdatadto.getMemLevel() >= 2){ 
								if(mpoint < shoparticle.getPrice()){ %> 
									<button class="btn btn-secondary" disabled>포인트가 부족합니다</button>
				<%				}else if(shoparticle.getGoodsStock() == 0){ %>
									<button class="btn btn-secondary" disabled>재고부족으로 구매가 불가능합니다</button>
				<%				}else if(shoparticle.getGoodsStatus() != 1){ %>
									<button class="btn btn-secondary" disabled>현재 판매중단 상품입니다</button>
				<%				}else if(memdatadto.getMemVolCount() < 1){ %>
									<button class="btn btn-secondary" disabled>봉사 1회 이상시 구매가능합니다</button>										
				<%				}else{ %>
									<%--
									<input type="button" class="btn btn-secondary" onclick="test()" value="구매하기">
									--%>
									<button type="button" class="btn btn-secondary" onclick="test2()">구매하기</button>
				<%				}
							
							}		 		
						} %>
				<%	}else{ %>
						<input type="button" value="login" onclick="window.location='/project/login/loginForm.jsp'" class="btn btn-secondary"/>
	            <% } %>
	        </form>
	      </div>
	     <script>
			function test() {
				if (!confirm(" 구매시 교환 및 환불이 불가합니다.\n 구매를 희망하시면 확인버튼을 눌러주세요  ")) {
					alert("취소하셨습니다.");
				}else {
					alert("구매하셨습니다.");
					window.location='memberBuyPro.jsp?id=<%=id%>&price=<%=shoparticle.getPrice()%>&sNo=<%=shoparticle.getsNo() %>';
				}
	
			}	
			
		</script>
		
		<script>
         function test2() {
            swal({
                  title: "확인",
                  text: "구매시 교환 및 환불이 불가합니다.\n 구매를 희망하시면 구매하기버튼을 눌러주세요",
                  icon: "warning", //"info,success,warning,error" 중 택1
                  buttons: ["취소", "구매하기"],
               }).then((구매하기) => {
                    if (구매하기) {
                        swal({
                              title: "구매완료!",
                              text: "잠시 후 다음 페이지로 이동합니다.",
                              icon: "success" //"info,success,warning,error" 중 택1
                           })   
                        setTimeout("test3()", 2000);
                        }else {
                           swal({
                                 title: "구매취소!",
                                 text: "",
                                 icon: "warning" //"info,success,warning,error" 중 택1
                              })                              
                        }
                   })
            
         }
         function test3() {
            window.location='memberBuyPro.jsp?id=<%=id%>&price=<%=shoparticle.getPrice()%>&sNo=<%=shoparticle.getsNo() %>';
         }
      </script>
	      
	      
	      
	      <div class="col-md-8 order-md-1">
	        <h4><b>포인트샵</b></h4>
	        <hr class="my-2">
	        <form class="needs-validation" novalidate>
	          <div class="row g-3">
	            <div class="col-sm">
	            	<br/>	
					<h3><b><%=shoparticle.getGoodsName() %></b></h3>
	            </div>
	
	           <div>
	           
					<%	if(shoparticle.getShopImg() != null){ %>
					
					<img src="/project/save/<%=shoparticle.getShopImg()%>" width="90%" />
				
					<%	} %>
					
					<br />
					<%=shoparticle.getContent() %>
				
	           </div>
	          </div>
	
	

	
	        </form>
	      </div>
	    </div>
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