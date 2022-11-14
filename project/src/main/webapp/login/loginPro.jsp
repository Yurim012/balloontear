<%@page import="project.signup.model.MemberSignupDTO"%>
<%@page import="project.quest.model.QuBoardDAO"%>
<%@page import="project.quest.model.QuMemResultDTO"%>
<%@page import="java.util.List"%>
<%@page import="project.quest.model.QuMemResultDAO"%>
<%@page import="project.quest.model.QuBoardDAO"%>
<%@page import="project.memMyPage.model.MemDataDTO"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.lang.model.util.SimpleAnnotationValueVisitor14"%>
<%@page import="project.memMyPage.model.MemDataDAO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>login Pro</title>
   <script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>
</head>
<%
   request.setCharacterEncoding("UTF-8"); // 한글깨짐 방지

   String id = request.getParameter("memId");
   String pw = request.getParameter("memPw");
   String auto = request.getParameter("auto");
   // 쿠키가 꺼내서 정보가 나오면 위 변수에 저장
   Cookie [] coos = request.getCookies();
   if(coos != null){
      for(Cookie c : coos){
         if(c.getName().equals("autoId")) id=c.getValue();
         if(c.getName().equals("autoPw")) pw=c.getValue();
         if(c.getName().equals("auto")) auto=c.getValue();
      
      }
   }
   MemberSignupDAO dao = new MemberSignupDAO();  
   MemberSignupDTO memdto = dao.getMember(id);
   // result : 1 로그인, 0 비번틀림, -1 아이디없다
   int result = dao.idPwCheck(id, pw); 
   if(result == -1) { %>
       <script>
       window.onload=function(){
    	   swal('로그인 실패!',"존재하지않는 아이디 입니다.",'error')
           .then(function(){
           	location.href="loginForm.jsp";                   
           })
	 }
       </script>
<% }else if(result == 0) { %>
       <script>
		   /*
           alert("비밀번호가 맞지 않습니다.. 다시 시도해주세요...");
           history.go(-1);
           */
       window.onload=function(){
        	   swal('로그인 실패!',"비밀번호가 맞지않습니다.",'error')
               .then(function(){
               	location.href="loginForm.jsp";                   
               })
    	 }
       </script>
<% }else { // 아이디 비번 맞을 경우 
      // 로그인 처리!! 
     
   if(auto != null){ // 사용자가 자동로그인 체크하고 로그인했을떄
      //쿠키생성
      Cookie c1 = new Cookie("autoId", id);
      Cookie c2 = new Cookie("autoPw", pw);
      Cookie c3 = new Cookie("auto", auto);
      
      c1.setPath("/project/");
      c2.setPath("/project/");
      c3.setPath("/project/");
      
      //   유효기간 설정
      c1.setMaxAge(60 * 60 * 24);   // 24시간
      c2.setMaxAge(60 * 60 * 24);   // 24시간
      c3.setMaxAge(60 * 60 * 24);   // 24시간            
      //   응답객체에 추가해서 사용자에게 저장하라고 전달
      response.addCookie(c1);
      response.addCookie(c2);
      response.addCookie(c3);                       
     }
   
      
     // 로그인 처리!! 
     session.setAttribute("memId", id);


      
      System.out.println("세션 set");
      String category = dao.categorySeach(id);
      
      
      
          if(memdto.getMemStatus() != 0){
            if(category.equals("mem")){ // 관리자가 아니면 
                MemDataDAO memDAO = new MemDataDAO();
               MemDataDTO memDTO = memDAO.getMemData(id);
               Date last = memDTO.getMemLastVisitDay();  // DB에 저장된 마지막으로 접속한 일자
               String dateToStr = String.format("%1$tY-%1$tm-%1$td", last);
               Date today = new Date(System.currentTimeMillis());  // 마지막으로 접속한 일자
               String to = String.format("%1$tY-%1$tm-%1$td", today);
               SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
               System.out.println("user : " + id + "  마지막 접속 : " + today);
               if( !dateToStr.equals(to) ){
                  memDAO.memLastVisitDayCount(id, today); // 마지막 출석날짜 오늘 날짜로 업데이트하고 출석일수 +1
                  System.out.println("출석 +1");
                  //7월 29일 수정
                  memDAO.rouletteCount(id, today); // 마지막 출석날짜 오늘 날짜로 업데이트하고 도박횟수 +1
                  
               }
             }
            
            
            // MemDataDAO 객체생성
            MemDataDAO memdatadao = new MemDataDAO();
            //아이디 값주면 memData(멤버정보) 디비가서 데이터 가져오기 !
            MemDataDTO memdatadto = memdatadao.getMemData(id);
            int memDayCount = memdatadto.getMemDayCount();    // 1. 출석
            QuBoardDAO qudao = new QuBoardDAO();   
            //퀘스트기준quBoard DB와 개인정보memdata DB 안에 있는 데이터를 비교하기 (출석) 
            QuMemResultDAO qumemresultdao = new QuMemResultDAO();
            //QuMemResultDTO qumemresultdto = new QuMemResultDTO();   
            // id 가 깬 퀘스트 고유번호 리스트 불러오기 11 12
            List<QuMemResultDTO> list = qumemresultdao.quNoAllList(id);
      
            /*for(int i = 0; i < list.size();i++) {
               QuMemResultDTO qumemresultdto = list.get(i);
               qumemresultdto.getQuNO();
            } */         
            // 파라미터값주고 기준에 맞을 경우 퀘스트의 고유번호 불러오기
            int dpQuNo = qudao.DayPointQuNo(memDayCount);
            //가져온포인트 변수에 넣기
            int dayPoint = qudao.DayPoint(memDayCount);
            // 퀘스트기준에 맞아서 포인트가 추가될경우  resultDay 변수가 1로 채워짐 
            //int resultDay = memdatadao.memVisitPointPlus(id,dayPoint);
            //reseult 변수가 1일 경우에만 quMemResult DB에 퀘스트 고유번호와 아이디 insert
            
            // 경우의 수   
            // 출석 2회가 안되는사람
            // 출석 2회 째 로그인하는사람
            
            
            int b = 0;
               boolean check = false;
               
               if(list != null){
                  for(int i = 0; i < list.size(); i++) {
                     QuMemResultDTO qumemresultdto = list.get(i);
                    
                     int a = qumemresultdto.getQuNO();
                        if(dpQuNo!=0 && a != dpQuNo ){ 
                           check = true;
                     }else{ // if
                        check = false;
                     }
                  }//for(int i = 0; i < list.size();i++)    
                     
                           
                  if(check){ %>
                           <script>
                           
                               alert("출석<%=memDayCount%>회 완료 <%=dayPoint%> 획득!");
                               

                           </script>

                     <% 
                     // 저장하고 포인트 주는 메서드
                     qudao.insertquMemResult(id,dpQuNo);
                         memdatadao.memVisitPointPlus(id,dayPoint);
                  }
                         
                         
                     
               } else { // 처음 1-1 퀘 꺠는 사람 2회출석
                  if(dpQuNo != 0){
                     qudao.insertquMemResult(id,dpQuNo);
                     memdatadao.memVisitPointPlus(id,dayPoint);
                  }
               
                  if(dayPoint > 0){%>
                  
                     <script>

                          alert("출석<%=memDayCount%>회 완료 <%=dayPoint%> 포인트 획득!");

                        </script>
         <%        }
               }
               
            
      %>
                <script>
                window.onload=function(){
             	   swal('로그인 성공!',"<%=id%>님 환영합니다.",'success')
                    .then(function(){
                    	<%if(category.equals("mem")){%>
                    	location.href="/project/main/memberMain.jsp"; 
                    	<%}else{%>
                    	location.href="/project/main/main.jsp";
                    	<% } %>
                    })
         	 }
                </script>
              <%
       }else{ // 상태값이 0일 경우
             session.invalidate();
       %>
        <script>
        window.onload=function(){
     	   swal('로그인 불가!',"<%=id%>회원님은 계정 정지로 인해 사이트이용이 불가능합니다.",'warning')
            .then(function(){
            	location.href="loginForm.jsp";                   
            })
 	 }
          </script>
     <%      
                
                   
                }
                
          }// else아이디 비번 맞을 경우%>
          

<body>
   


</body>
</html>