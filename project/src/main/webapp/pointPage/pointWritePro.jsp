<%@page import="project.pointPage.model.ShopBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>pointWritePro</title>
</head>
	<jsp:useBean id="shopArticle" class="project.pointPage.model.ShopBoardDTO" />
<%
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("memId").equals("admin")){ 
	
	//파일업로드처리시 <jsp:setProperty > 사용불가 
	String path = request.getRealPath("save"); // 서버상의 save 폴더 경로 찾기
	System.out.println(path);
	int max = 1024*1024*5; // 파일 최대 크기 
	String enc = "UTF-8";   
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp); // 실제 파일은 저장
	
	
	shopArticle.setGoodsName(mr.getParameter("goodsName")); 		// 상품명
	shopArticle.setContent(mr.getParameter("content"));				// 내용
	
		if(mr.getFilesystemName("shopImg") != null){
			shopArticle.setShopImg(mr.getFilesystemName("shopImg"));		// 상품이미지
		}else {
			shopArticle.setShopImg("default.png");
		}
		
	int status = Integer.parseInt(mr.getParameter("goodsStatus"));	// 상품 판매상태
	shopArticle.setGoodsStatus(status);
	
	int stock = Integer.parseInt(mr.getParameter("goodsStock"));	// 상품 재고
	shopArticle.setGoodsStock(stock);
	
	int price = Integer.parseInt(mr.getParameter("price"));			// 상품 가격
	shopArticle.setPrice(price);
			
	ShopBoardDAO shopdao = new ShopBoardDAO();
	// DB가서 저장
	shopdao.insertArticle(shopArticle);
	
	response.sendRedirect("pointShop.jsp");
	}	  
	
%>

<body>

</body>
</html>