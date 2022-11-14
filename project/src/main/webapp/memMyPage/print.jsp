<%@page import="project.volPage.model.VolBoardDTO"%>
<%@page import="project.volPage.model.VolBoardDAO"%>
<%@page import="project.signup.model.MemberSignupDTO"%>
<%@page import="project.signup.model.MemberSignupDAO"%>
<%@page import="project.volPage.model.VolApplyBoardDAO"%>
<%@page import="project.volPage.model.VolApplyBoardDTO"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>&nbsp;</title>
	<%-- 파비콘 --%>
	<link rel="shortcut icon" href="/project/save/favicon.ico" type="image/x-icon"> 
	<%-- 부트스트랩 --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	<link href="/docs/5.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	<link rel="stylesheet" href="/project/css/memberMypageStyle.css" type="text/css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300&display=swap" rel="stylesheet">
	

   
</head>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	Date today = new Date(System.currentTimeMillis());

	int applyNo = Integer.parseInt(request.getParameter("applyNo"));
	
	VolApplyBoardDAO memApDAO = new VolApplyBoardDAO();
	VolApplyBoardDTO memApDTO = memApDAO.getOneApply(applyNo);
	
	String id = memApDTO.getMemId();
			
	MemberSignupDAO memberDAO = new MemberSignupDAO();
	MemberSignupDTO memberDTO = memberDAO.getMember(id);
	
	
	int volnum = memApDTO.getVolNo();
	VolBoardDAO volDAO = new VolBoardDAO();
	VolBoardDTO volDTO = volDAO.getOneVolContent(volnum);
	
%>

<script>
function jsprint(){
document.getElementById("buttonTable").style.display = "none";
            window.print();
            self.close();
}
</script>


 <style>
		.print {
		  font-size: 20px;
		}
	   </style>

<body>
	
	<div class="container">
	
		
	
	
		<div class="col-sm">
			<div align="center">
			<table id="buttonTable">
		                    <tr>
		                        <td align="right">
		                            <input type="button" name="btprint" value="인쇄" onclick="javascript:jsprint();">
		                            <input type="button" name="btclose" value="닫기" onclick="self.close();">
		                        </td>
		                    </tr>
	   </table>
	   </div>	
		<br />
		
		   		제 <%= today %>
		   		<!-- 원래 부모였던 div -->
				    <div style="padding:10px;height:100px;">
				        
				        <!-- 새롭게 부모가 된 div -->
				        <div style="position:relative; width:100%;height:100%;">
				
					        <!-- 자식 div -->
					        <div style="position:absolute; opacity:0.7; width:100%;height:100%; padding:10px;">
						        <div align="center">
						        	<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
						        	<table class="print">
										<tr><td><b>성명</b></td> <td><%= memberDTO.getMemName() %></td> </tr>
										<tr><td><b>활동명</b></td> <td><%= volDTO.getVolSubject() %></td> </tr>
										<tr><td><b>활동 기관명</b></td> <td><%= volDTO.getMemId() %></td> </tr>
										<tr><td><b>봉사시간</b></td> <td><%= volDTO.getVolTime() %></td> </tr>
										<tr><td><b>봉사일</b></td> <td><%= memApDTO.getSelDate() %></td> </tr>
									
						        	</table>
						        	<br /><br /><br /><br /><br /><br />
						        	<h4><b>사회 봉사 활동 인증관리규정 제 9조 제3항에 따라</b></h4>
									<h4><b>위와 같이 자원봉사 활동 실적이 있음을 인증합니다.</b></h4>
									<br />
						        	<h2><b><%= today %></b></h2>
						        </div>
					        </div>
				
				        <img src="/project/save/print.jpg" width="700px"/>   
				
				        </div>  
				    </div>
	
		<br/>		    
   	</div>
   </div>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>

</html>