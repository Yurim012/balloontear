<%@page import="project.pointPage.model.ShopBoardDAO"%>
<%@page import="project.pointPage.model.BuyBoardDAO"%>
<%@page import="project.quest.model.QuMemResultDTO"%>
<%@page import="java.util.List"%>
<%@page import="project.quest.model.QuMemResultDAO"%>
<%@page import="project.quest.model.QuBoardDAO"%>
<%@page import="project.memMyPage.model.MemDataDTO"%>
<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>구매완료페이지</title>
   <script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>
</head>
<%
   int price = Integer.parseInt(request.getParameter("price"));
   String id = (String)session.getAttribute("memId");
   int sNo = Integer.parseInt(request.getParameter("sNo"));
   
   BuyBoardDAO buyboarddao = new BuyBoardDAO();
   buyboarddao.insertBuyBoard(sNo, id, price); 
   
   // 재고 -1
   ShopBoardDAO shopboarddao = new ShopBoardDAO();
   shopboarddao.minusStock(sNo);  
   
   MemDataDAO memdatadao = new MemDataDAO();
   MemDataDTO memdatadto = memdatadao.getMemData(id);
   
   // 아이디값에 있는 포인트 끌고오기
   int mpoint = memdatadto.getMemPoint();
   memdatadao.pointQuUpdate(price, id);
   memdatadao.minusPoint(id, price);
   int memBuyCount = memdatadto.getMemBuyCount() + 1;         // 개인의 구매횟수가져와변수담기
   int memBuyPoint = memdatadto.getMemBuyPoint() + price ;      // 개인의 누적 구매 금액 가져와 담기
   int memBuyPointResult = 0 ;
   
   if(0 <= memBuyPoint && memBuyPoint < 300){      
      memBuyPointResult = 0;
   }else if(300 <= memBuyPoint && memBuyPoint < 1000){
      memBuyPointResult = 300;
   }else if(1000 <= memBuyPoint && memBuyPoint < 2000){
      memBuyPointResult = 1000;
   }else if(2000 <= memBuyPoint && memBuyPoint < 3000){  
      memBuyPointResult = 2000;
   }else if(3000 <= memBuyPoint && memBuyPoint < 5000){
      memBuyPointResult = 3000;
   }else if(5000 <= memBuyPoint && memBuyPoint < 1000000){
      memBuyPointResult = 5000;
   }   
   System.out.println("memBuyPointResult"  + memBuyPointResult);

   QuBoardDAO qudao = new QuBoardDAO(); 
   QuMemResultDAO qumemresultdao = new QuMemResultDAO();
   int buyCountQuNo = qudao.buyCountQuNo(memBuyCount);
   int buyPointQuNo = qudao.buyPointQuNo(memBuyPointResult); 
   
   int buyCountPoint = qudao.buyCountPoint(memBuyCount);
   int totalBuyPoint = qudao.totalBuyPoint(memBuyPointResult);
   
   List<QuMemResultDTO> buyCountList = qumemresultdao.quNoList40(id);
   List<QuMemResultDTO> totalBuyList = qumemresultdao.quNoList50(id);
   
   boolean check = false;
   
   if(buyCountList != null){
      for(int i = 0; i < buyCountList.size(); i++){
         QuMemResultDTO qumemresultdto = buyCountList.get(i);
         int a = qumemresultdto.getQuNO();
         if(buyCountQuNo!=0 && a != buyCountQuNo){
            check = true;
         }else{ // if
            check = false;
         }
      }//for문
      if(check){ %>
         <script>
         <%--
         alert("포인트샵 물품 <%=memBuyCount%>회 구매완료!<%=buyCountPoint%>P 획득 ");
         --%>
            setTimeout("buyTotal()", 100);
         </script>
<%
         qudao.insertquMemResult(id,buyCountQuNo);
         memdatadao.memVisitPointPlus(id,buyCountPoint);   
      }
   }else { // 처음 4-1 퀘 깨는 사람 
      if(buyCountQuNo != 0){
         qudao.insertquMemResult(id,buyCountQuNo);
         memdatadao.memVisitPointPlus(id,buyCountPoint);            
      }
      if(memBuyCount > 0){ %>
         <script>
         <%--
         alert("포인트샵 물품 <%=memBuyCount%>회 구매완료!<%=buyCountPoint%>P 획득 ");
         --%>
            setTimeout("buyTotal()", 500);
         </script>         
<%      }
   } %>
<%
   if(totalBuyList != null){
      for(int i = 0; i < totalBuyList.size(); i++){
         QuMemResultDTO qumemresultdto = totalBuyList.get(i);
         int a = qumemresultdto.getQuNO();
         int b = qumemresultdto.getQuNO() - 1;
         if(buyPointQuNo!=0 && a != buyPointQuNo && b!= buyPointQuNo){
            check = true;
         }else{ // if
            check = false;
         }
      }//for문
      if(check){ %>
         <script>
            <%--
            alert("포인트샵 구매 누적 <%=memBuyPointResult%>P 달성!<%=totalBuyPoint%>P 획득 ");
            --%>
            setTimeout("buyCount()", 3000);
         </script>
<%
         qudao.insertquMemResult(id,buyPointQuNo);
         memdatadao.memVisitPointPlus(id,totalBuyPoint);   
      }   
   }else { // 처음 5-1 퀘 깨는 사람 
      if(buyPointQuNo != 0){
         qudao.insertquMemResult(id,buyPointQuNo);
         memdatadao.memVisitPointPlus(id,totalBuyPoint);            
      }
      if(memBuyPointResult > 0){ %>
         <script>
            setTimeout("buyCount()", 3000);
         </script>         
<%      }
   } %>   
   
<body>
<script>
   function buyCount() {
      swal({
            title: "퀘스트완료!",
            text: "포인트샵 구매 누적 <%=memBuyPointResult%>P 달성!<%=totalBuyPoint%>P 획득 .",
            icon: "success" //"info,success,warning,error" 중 택1
         })      
   }
</script>
<script>
   function buyTotal() {
      swal({
            title: "퀘스트완료!",
            text: "포인트샵 물품 <%=memBuyCount%>회 구매완료!<%=buyCountPoint%>P 획득!",
            icon: "success" //"info,success,warning,error" 중 택1
         })      
   }
</script>
<script>
   function comeBack() {
      location.href="pointShop.jsp";
   }
</script>
<script>
   setTimeout("comeBack()", 5000);
</script>
   </br></br></br></br></br></br>
   <h1 align="center"> 잠시 후 포인트샵 페이지로 이동합니다.</h1>
</body>
</html>


<%--
<%@page import="project.pointPage.model.ShopBoardDAO"%>
<%@page import="project.pointPage.model.BuyBoardDAO"%>
<%@page import="project.quest.model.QuMemResultDTO"%>
<%@page import="java.util.List"%>
<%@page import="project.quest.model.QuMemResultDAO"%>
<%@page import="project.quest.model.QuBoardDAO"%>
<%@page import="project.memMyPage.model.MemDataDTO"%>
<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	int price = Integer.parseInt(request.getParameter("price"));
	String id = (String)session.getAttribute("memId");
	int sNo = Integer.parseInt(request.getParameter("sNo"));
	
	BuyBoardDAO buyboarddao = new BuyBoardDAO();
	buyboarddao.insertBuyBoard(sNo, id, price); 
	
	// 재고 -1
	ShopBoardDAO shopboarddao = new ShopBoardDAO();
	shopboarddao.minusStock(sNo);  
	
	MemDataDAO memdatadao = new MemDataDAO();
	MemDataDTO memdatadto = memdatadao.getMemData(id);
	
	// 아이디값에 있는 포인트 끌고오기
	int mpoint = memdatadto.getMemPoint();
	memdatadao.pointQuUpdate(price, id);
	memdatadao.minusPoint(id, price);
	int memBuyCount = memdatadto.getMemBuyCount() + 1;			// 개인의 구매횟수가져와변수담기
	int memBuyPoint = memdatadto.getMemBuyPoint() + price ;		// 개인의 누적 구매 금액 가져와 담기
	int memBuyPointResult = 0 ;
	
	if(0 <= memBuyPoint && memBuyPoint < 300){      
		memBuyPointResult = 0;
	}else if(300 <= memBuyPoint && memBuyPoint < 1000){
		memBuyPointResult = 300;
	}else if(1000 <= memBuyPoint && memBuyPoint < 2000){
		memBuyPointResult = 1000;
	}else if(2000 <= memBuyPoint && memBuyPoint < 3000){  
		memBuyPointResult = 2000;
	}else if(3000 <= memBuyPoint && memBuyPoint < 5000){
		memBuyPointResult = 3000;
	}else if(5000 <= memBuyPoint && memBuyPoint < 1000000){
		memBuyPointResult = 5000;
	}   
	System.out.println("memBuyPointResult"  + memBuyPointResult);

	QuBoardDAO qudao = new QuBoardDAO(); 
	QuMemResultDAO qumemresultdao = new QuMemResultDAO();
	int buyCountQuNo = qudao.buyCountQuNo(memBuyCount);
	int buyPointQuNo = qudao.buyPointQuNo(memBuyPointResult); 
	
	int buyCountPoint = qudao.buyCountPoint(memBuyCount);
	int totalBuyPoint = qudao.totalBuyPoint(memBuyPointResult);
	
	List<QuMemResultDTO> buyCountList = qumemresultdao.quNoList40(id);
	List<QuMemResultDTO> totalBuyList = qumemresultdao.quNoList50(id);
	
	boolean check = false;
	
	if(buyCountList != null){
		for(int i = 0; i < buyCountList.size(); i++){
			QuMemResultDTO qumemresultdto = buyCountList.get(i);
			int a = qumemresultdto.getQuNO();
			if(buyCountQuNo!=0 && a != buyCountQuNo){
				check = true;
			}else{ // if
				check = false;
			}
		}//for문
		if(check){ %>
			<script>
				alert("포인트샵 물품 <%=memBuyCount%>회 구매완료!<%=buyCountPoint%>P 획득 ");
			</script>
<%
			qudao.insertquMemResult(id,buyCountQuNo);
			memdatadao.memVisitPointPlus(id,buyCountPoint);   
		}
	}else { // 처음 4-1 퀘 깨는 사람 
		if(buyCountQuNo != 0){
			qudao.insertquMemResult(id,buyCountQuNo);
			memdatadao.memVisitPointPlus(id,buyCountPoint);            
		}
		if(memBuyCount > 0){ %>
			<script>
				alert("포인트샵 물품 <%=memBuyCount%>회 구매완료!<%=buyCountPoint%>P 획득 ");
			</script>         
<%		}
	} %>
<%
	if(totalBuyList != null){
		for(int i = 0; i < totalBuyList.size(); i++){
			QuMemResultDTO qumemresultdto = totalBuyList.get(i);
			int a = qumemresultdto.getQuNO();
			int b = qumemresultdto.getQuNO() - 1;
			if(buyPointQuNo!=0 && a != buyPointQuNo && b!= buyPointQuNo){
				check = true;
			}else{ // if
				check = false;
			}
		}//for문
		if(check){ %>
			<script>
				alert("포인트샵 구매 누적 <%=memBuyPointResult%>P 달성!<%=totalBuyPoint%>P 획득 ");
			</script>
<%
			qudao.insertquMemResult(id,buyPointQuNo);
			memdatadao.memVisitPointPlus(id,totalBuyPoint);   
		}   
	}else { // 처음 5-1 퀘 깨는 사람 
		if(buyPointQuNo != 0){
			qudao.insertquMemResult(id,buyPointQuNo);
			memdatadao.memVisitPointPlus(id,totalBuyPoint);            
		}
		if(memBuyPointResult > 0){ %>
			<script>
				alert("포인트샵 구매 누적 <%=memBuyPointResult%>P 달성!<%=totalBuyPoint%>P 획득 ");
			</script>         
<%		}
	} %>   
		<script>
	
			location.href="pointShop.jsp";
		</script>
<body>

</body>
</html>
--%>