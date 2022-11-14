<%@page import="project.pointPage.model.ShopBoardDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="project.pointPage.model.ShopBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>contentModifyForm</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%	
	if(session.getAttribute("memId").equals("admin")){ 	
		ShopBoardDTO shopArticle = new ShopBoardDTO();
		
		String path = request.getRealPath("save"); // 서버상의 save 폴더 경로 찾기
		System.out.println(path);
		int max = 1024*1024*20; // 파일 최대 크기 
		String enc = "UTF-8";   
		DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
		MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp); // 실제 파일은 저장
	
		shopArticle.setsNo(Integer.parseInt(mr.getParameter("sNo")));	// 고유번호
		shopArticle.setGoodsName(mr.getParameter("goodsName")); 		// 상품명
		shopArticle.setContent(mr.getParameter("content"));				// 내용
		//String img = mr.getFilesystemName("shopImg");
		
			//바꿧을때
		if(mr.getFilesystemName("shopImg")!=null){
			shopArticle.setShopImg(mr.getFilesystemName("shopImg"));		// 상품이미지
		}else {
			System.out.println(mr.getParameter("exshopImg"));
			shopArticle.setShopImg(mr.getParameter("exshopImg"));		// 상품이미지
		}
		
		int status = Integer.parseInt(mr.getParameter("goodsStatus"));	// 상품 판매상태
		shopArticle.setGoodsStatus(status);
		
		int stock = Integer.parseInt(mr.getParameter("goodsStock"));	// 상품 재고
		shopArticle.setGoodsStock(stock);
		
		int price = Integer.parseInt(mr.getParameter("price"));			// 상품 가격
		shopArticle.setPrice(price);
		
		String pageNum = mr.getParameter("pageNum");
			
		ShopBoardDAO shopdao = new ShopBoardDAO();
		// DB가서 저장
		int result = shopdao.updateShopArticle(shopArticle);  
%> 

<%
		if(result == 1){ %>  
			<script>
				alert("수정이 완료되었습니다");
				window.location.href = "pointContent.jsp?sNo=" + <%=shopArticle.getsNo()%> + "&pageNum=" + <%=pageNum%>; 
			</script>	
<%		}else{ %>
			<script>
				alert("오류");
				history.go(-1);
			</script>
 
<%		} %>
<body>
 

<%	} %>
</body>
</html>