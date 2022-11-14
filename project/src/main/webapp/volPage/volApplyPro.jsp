<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.Date"%>
<%@page import="project.volPage.model.VolApplyBoardDAO"%>
<%@page import="project.volPage.model.VolApplyBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>volApplyPro</title>
</head>
<%



   request.setCharacterEncoding("UTF-8"); //한글깨짐 방지

   String id = (String)session.getAttribute("memId");
   if(id== null || id.equals(null) || id.equals("null")) { %>
      <script>
            alert("로그인 후 이용해주세요")
            window.location.href="/project/main/main.jsp";
      </script>
   <% }else {
   
   VolApplyBoardDTO dto = new VolApplyBoardDTO(); //객체생성
   
   int volNo = Integer.parseInt(request.getParameter("volNo")); //넘어온 volNo 파라미터 꺼내기
   
   String pageNum = request.getParameter("pageNum"); // 넘어온 pageNum 파라미터 꺼내기
   
   String volApplyAgree = request.getParameter("volApplyAgree"); //수신 동의 체크
   
   
   dto.setVolNo(volNo);
   dto.setMemId(id);
   Date selD = Date.valueOf(request.getParameter("selDate"));
   dto.setSelDate(selD);
   
    Date today = new Date(System.currentTimeMillis());  // 마지막으로 접속한 일자
     String to = String.format("%1$tY-%1$tm-%1$td", today);
   dto.setApplyDate(to); 
   
   
   //받아온 결과 DB 저장
   VolApplyBoardDAO applydao = new VolApplyBoardDAO();
   
   // 중복으로 지원했을 경우 쳐내기 중복있을경우 1 없을경우 0 
   //select * from volApplyBoard where memId=? volNO=?;
   int result = applydao.overlapCheck(id,volNo,selD);
   
   
   if(result == 1){ // alect써야하는거면 자바스크립트 열어여함%>
      <script>
         alert("이미 해당 공고에 지원하셨습니다.");
         history.go(-1);
      </script>      
<%   }else{
      //봉사 신청자 정보 인서트 
      applydao.insertVolApply(dto);
      response.sendRedirect("volApplyOk.jsp?volNo="+volNo+"&pageNum="+pageNum);
   }
      //response.sendRedirect("volCount.jsp?volNo="+volNo+"&pageNum="+pageNum);
}%>
<body> 


    
</body>
</html>