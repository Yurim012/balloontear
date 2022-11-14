package project.volPage.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class VolBoardDAO {
      //커넥션
      private Connection getConnection() throws Exception {
         Context ctx = new InitialContext(); 
         Context env = (Context)ctx.lookup("java:comp/env");
         DataSource ds = (DataSource)env.lookup("jdbc/orcl");
         return ds.getConnection();
      }   
      
      
      //1.모집 글 작성
        public void insertArticle(VolBoardDTO volArticle) {
          System.out.println("insert 메서드 실행");
          Connection conn = null; 
          PreparedStatement pstmt = null; 
           try {
              conn = getConnection(); 
              System.out.println("try 실행");
              String sql = "insert into volBoard(volNo, volSubject, memId, volContent, volCategory, volMaxNum, volStatus, volStartDate, volEndDate, volLoc, volTime, volImg, volReg) ";
              sql +="values(volBoard_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
              pstmt = conn.prepareStatement(sql);
              pstmt.setString(1, volArticle.getVolSubject());
              pstmt.setString(2, volArticle.getMemId());
              pstmt.setString(3, volArticle.getVolContent());
              pstmt.setString(4, volArticle.getVolCategory());
              pstmt.setInt(5, volArticle.getVolMaxNum());
              pstmt.setInt(6, volArticle.getVolStatus());
              pstmt.setDate(7, volArticle.getVolStartDate());
              pstmt.setDate(8, volArticle.getVolEndDate());
              pstmt.setString(9, volArticle.getVolLoc());
              pstmt.setInt(10, volArticle.getVolTime());
              pstmt.setString(11, volArticle.getVolImg());
              
              int updateCount = pstmt.executeUpdate(); 
              System.out.println("insert update count : " + updateCount);
              System.out.println("insert update 상태값 : " +  volArticle.getVolArticleStatus() );
              
           }catch(Exception e) {
              e.printStackTrace();
           }finally {
              if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
              if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
           }
        }
      
   

   //2.검색한 글의 총개수 
   public int getVolSearchCount(String sel, String search) {
      int count = 0; 
      Connection conn = null; 
      PreparedStatement pstmt = null; 
      ResultSet rs = null;
      try {
         conn = getConnection(); 
         String sql = "select count(*) from volBoard where "+sel+" like '%"+search+"%' and volArticleStatus=1 and(volStatus=0 or volStatus=-1)";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(); 
         if(rs.next()) {
            count = rs.getInt(1);
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
         if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
      }
      return count;
   }//메서드 종료
   
   //2.검색한 글의 총개수 
   public int getVolSearchEndCount(String sel, String search) {
	   int count = 0; 
	   Connection conn = null; 
	   PreparedStatement pstmt = null; 
	   ResultSet rs = null;
	   try {
		   conn = getConnection(); 
		   String sql = "select count(*) from volBoard where "+sel+" like '%"+search+"%' and volArticleStatus=1 and(volStatus=1 or volStatus=2)";
		   pstmt = conn.prepareStatement(sql);
		   rs = pstmt.executeQuery(); 
		   if(rs.next()) {
			   count = rs.getInt(1);
		   }
	   }catch(Exception e) {
		   e.printStackTrace();
	   }finally {
		   if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
		   if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
		   if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	   }
	   return count;
   }//메서드 종료
   
   
   //3.상단 검색한 글의 총개수
   public int getVolTopSearchCount(String topSel, String topSelVal){
      int count = 0; 
      Connection conn = null; 
      PreparedStatement pstmt = null; 
      ResultSet rs = null;
      try {
         conn = getConnection(); 
         String sql = "select count(*) from volBoard where "+topSel+" like '%"+topSelVal+"%' and volArticleStatus=1" ;
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(); 
         if(rs.next()) {
            count = rs.getInt(1);
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
         if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
      }
      return count;
   }
   
   //3-2 .상단 검색한 글의 총개수(모집상태 검색)
   public int getVolTopSearchStatusCount(String topSelStatus, String topSelValStatus){
      System.out.println("상단검색2 메서드 들어옴~");
      System.out.println("상단검색2 topselvalStatus : " + topSelValStatus);
      int count = 0; 
      Connection conn = null; 
      PreparedStatement pstmt = null; 
      ResultSet rs = null;
      try {
         conn = getConnection(); 
         String sql = "select count(*) from volBoard where "+topSelStatus+" like '"+topSelValStatus+"%' and volArticleStatus=1";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(); 
         if(rs.next()) {
            count = rs.getInt(1);
            System.out.println("상단 검색 2 count : " +  count);
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
         if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
      }
      return count;
   }
   
      
   //4.검색한 글 목록 가져오는 메서드 
   public List<VolBoardDTO> getVolSearch(int startRow, int endRow, String sel, String search) {
      List<VolBoardDTO> volList = null; 
      Connection conn = null; 
      PreparedStatement pstmt = null; 
      ResultSet rs = null;
      try {
         conn = getConnection(); 
         String sql = "select B.* from (select rownum r, A.* from "
               + "(select * from volBoard where "+sel+" like '%"+search+"%' and volArticleStatus=1"
               + " order by volReg desc) A) B "
               + "where r >= ? and r <= ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, startRow);
         pstmt.setInt(2, endRow);
         
         rs = pstmt.executeQuery(); 
         if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
            volList = new ArrayList<VolBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
            do {
               VolBoardDTO volArticle = new VolBoardDTO(); 
               volArticle.setVolNo(rs.getInt("volNo")); 
               volArticle.setMemId(rs.getString("memId"));
               volArticle.setVolSubject(rs.getString("volSubject"));
               volArticle.setVolContent(rs.getString("volContent"));
               volArticle.setVolCategory(rs.getString("volCategory"));
               volArticle.setVolMaxNum(rs.getInt("volMaxNum"));
               volArticle.setVolStatus(rs.getInt("volStatus"));
               volArticle.setVolStartDate(rs.getDate("volStartDate"));
               volArticle.setVolEndDate(rs.getDate("volEndDate"));
               volArticle.setVolLoc(rs.getString("volLoc"));
               volArticle.setVolTime(rs.getInt("volTime"));
               volArticle.setVolImg(rs.getString("volImg"));
               volArticle.setVolReg(rs.getTimestamp("volReg"));
               volArticle.setVolArticleStatus(rs.getInt("volArticleStatus"));
               volList.add(volArticle);
            }while(rs.next());
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
         if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
      }
      return volList; 
   }//메서드 종료
   //4.검색한 글 목록 가져오는 메서드(마감 검색)
   
   public List<VolBoardDTO> getVolEndSearch(int startRow, int endRow, String sel, String search) {
	   List<VolBoardDTO> volList = null; 
	   Connection conn = null; 
	   PreparedStatement pstmt = null; 
	   ResultSet rs = null;
	   try {
		   conn = getConnection(); 
		   String sql = "select B.* from (select rownum r, A.* from "
				   + "(select * from volBoard where "+sel+" like '%"+search+"%' and volArticleStatus=1 and(volStatus=-1 or volStatus=0)"
				   + " order by volReg desc) A) B "
				   + "where r >= ? and r <= ?";
		   pstmt = conn.prepareStatement(sql);
		   pstmt.setInt(1, startRow);
		   pstmt.setInt(2, endRow);
		   
		   rs = pstmt.executeQuery(); 
		   if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
			   volList = new ArrayList<VolBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
			   do {
				   VolBoardDTO volArticle = new VolBoardDTO(); 
				   volArticle.setVolNo(rs.getInt("volNo")); 
				   volArticle.setMemId(rs.getString("memId"));
				   volArticle.setVolSubject(rs.getString("volSubject"));
				   volArticle.setVolContent(rs.getString("volContent"));
				   volArticle.setVolCategory(rs.getString("volCategory"));
				   volArticle.setVolMaxNum(rs.getInt("volMaxNum"));
				   volArticle.setVolStatus(rs.getInt("volStatus"));
				   volArticle.setVolStartDate(rs.getDate("volStartDate"));
				   volArticle.setVolEndDate(rs.getDate("volEndDate"));
				   volArticle.setVolLoc(rs.getString("volLoc"));
				   volArticle.setVolTime(rs.getInt("volTime"));
				   volArticle.setVolImg(rs.getString("volImg"));
				   volArticle.setVolReg(rs.getTimestamp("volReg"));
				   volArticle.setVolArticleStatus(rs.getInt("volArticleStatus"));
				   volList.add(volArticle);
			   }while(rs.next());
		   }
	   }catch(Exception e) {
		   e.printStackTrace();
	   }finally {
		   if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
		   if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
		   if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	   }
	   return volList; 
   }//메서드 종료
   
         
   
   
   //5.상단 검색 글 목록 가져오기
   public List<VolBoardDTO> getVolTopSearch(int startRow, int endRow, String topSel, String topSearch){
      List<VolBoardDTO> volList = null; 
      Connection conn = null; 
      PreparedStatement pstmt = null; 
      ResultSet rs = null;
      try {
         conn = getConnection(); 
         String sql = "select B.* from (select rownum r, A.* from "
               + "(select * from volBoard where "+topSel+" like '%"+topSearch+"%' and volArticleStatus=1"
               + " order by volReg desc) A) B "
               + "where r >= ? and r <= ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, startRow);
         pstmt.setInt(2, endRow);
         
         rs = pstmt.executeQuery(); 
         if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
            volList = new ArrayList<VolBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
            do {
               VolBoardDTO volArticle = new VolBoardDTO(); 
               volArticle.setVolNo(rs.getInt("volNo")); 
               volArticle.setMemId(rs.getString("memId"));
               volArticle.setVolSubject(rs.getString("volSubject"));
               volArticle.setVolContent(rs.getString("volContent"));
               volArticle.setVolCategory(rs.getString("volCategory"));
               volArticle.setVolMaxNum(rs.getInt("volMaxNum"));
               volArticle.setVolStatus(rs.getInt("volStatus"));
               volArticle.setVolStartDate(rs.getDate("volStartDate"));
               volArticle.setVolEndDate(rs.getDate("volEndDate"));
               volArticle.setVolLoc(rs.getString("volLoc"));
               volArticle.setVolTime(rs.getInt("volTime"));
               volArticle.setVolImg(rs.getString("volImg"));
               volArticle.setVolReg(rs.getTimestamp("volReg"));
               volArticle.setVolArticleStatus(rs.getInt("volArticleStatus"));
               volList.add(volArticle);
            }while(rs.next());
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
         if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
      }
      return volList; 
   }//메서드 종료
   
   
   //5-2.상단 검색 글 목록 가져오기(모집상태 sort)
   public List<VolBoardDTO> getVolTopSearchStatus(int startRow, int endRow, String topSelStatus, String topSelValStatus){
      List<VolBoardDTO> volList = null; 
      Connection conn = null; 
      PreparedStatement pstmt = null; 
      ResultSet rs = null;
      try {
         conn = getConnection(); 
         String sql = "select B.* from (select rownum r, A.* from "
               + "(select * from volBoard where "+topSelStatus+" like '"+topSelValStatus+"%' and volArticleStatus=1"
               + " order by volReg desc) A) B "
               + "where r >= ? and r <= ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, startRow);
         pstmt.setInt(2, endRow);
         
         rs = pstmt.executeQuery(); 
         if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
            volList = new ArrayList<VolBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
            do {
               VolBoardDTO volArticle = new VolBoardDTO(); 
               volArticle.setVolNo(rs.getInt("volNo")); 
               volArticle.setMemId(rs.getString("memId"));
               volArticle.setVolSubject(rs.getString("volSubject"));
               volArticle.setVolContent(rs.getString("volContent"));
               volArticle.setVolCategory(rs.getString("volCategory"));
               volArticle.setVolMaxNum(rs.getInt("volMaxNum"));
               volArticle.setVolStatus(rs.getInt("volStatus"));
               volArticle.setVolStartDate(rs.getDate("volStartDate"));
               volArticle.setVolEndDate(rs.getDate("volEndDate"));
               volArticle.setVolLoc(rs.getString("volLoc"));
               volArticle.setVolTime(rs.getInt("volTime"));
               volArticle.setVolImg(rs.getString("volImg"));
               volArticle.setVolReg(rs.getTimestamp("volReg"));
               volArticle.setVolArticleStatus(rs.getInt("volArticleStatus"));
               volList.add(volArticle);
            }while(rs.next());
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
         if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
      }
      return volList; 
   }//메서드 종료
   
   
   
   //6.전체 글의 개수 카운팅 메서드 
      public int getVolCount() {
         System.out.println("카운팅");
         int count = 0; 
         Connection conn = null; 
         PreparedStatement pstmt = null; 
         ResultSet rs = null;
         try {
            conn = getConnection(); 
            String sql = "select count(*) from volBoard where volArticleStatus=1";
            pstmt = conn.prepareStatement(sql);
            
            rs = pstmt.executeQuery(); 
            if(rs.next()) {
               count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
            }
            
         }catch(Exception e) {
            e.printStackTrace();
         }finally {
            if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
         }
         return count; 
      }
   
      
      //7.이름에 해당하는 전체 글 개수 카운팅 메서드
      public int getVolCountWithCen(String userName) {
         System.out.println("id 주고 전체 글 개수 카운팅 메서드 실행");
         int count = 0; 
         Connection conn = null; 
         PreparedStatement pstmt = null; 
         ResultSet rs = null;
         try {
            conn = getConnection(); 
            String sql = "select count(*) from volBoard where memId=? and volArticleStatus=1 and (volStatus=-1 or volStatus=0)";
            System.out.println("memId= " + userName );
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userName);
            rs = pstmt.executeQuery(); 
            
            if(rs.next()) {
               count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
               System.out.println("이름 주고 글 카운팅 개수 : " + count);
            }
            
         }catch(Exception e) {
            e.printStackTrace();
         }finally {
            if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
         }
         return count; 
      }//메서드 끝 
      
      
      //7-2.이름에 해당하는 전체 글 개수 카운팅 메서드(마감 카운팅)
      public int getVolEndCountWithCen(String userName) {
    	  System.out.println("id 주고 전체 글 마감 개수 카운팅 메서드 실행");
    	  int count = 0; 
    	  Connection conn = null; 
    	  PreparedStatement pstmt = null; 
    	  ResultSet rs = null;
    	  try {
    		  conn = getConnection(); 
    		  String sql = "select count(*) from volBoard where memId=? and volArticleStatus=1 and (volStatus=1 or volStatus=2)";
    		  System.out.println("memId= " + userName );
    		  pstmt = conn.prepareStatement(sql);
    		  pstmt.setString(1, userName);
    		  rs = pstmt.executeQuery(); 
    		  
    		  if(rs.next()) {
    			  count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
    			  System.out.println("이름 주고 글 카운팅 개수 : " + count);
    		  }
    		  
    	  }catch(Exception e) {
    		  e.printStackTrace();
    	  }finally {
    		  if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
    		  if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
    		  if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
    	  }
    	  return count; 
      }//메서드 끝 
    
      
      
      //8.해당 페이지에 띄워줄 글 가져오기 
      public List<VolBoardDTO> getVol(int startRow, int endRow) {
         System.out.println(1);
         List<VolBoardDTO> volList = null; 
         Connection conn = null; 
         PreparedStatement pstmt = null; 
         ResultSet rs = null;
         try { 
            System.out.println(2);
            conn = getConnection(); 
            String sql = "select B.* from (select rownum r, A.* from "
                  + "(select * from volBoard where volArticleStatus=1 order by volReg desc) A) B "
                  + "where r >= ? and r <= ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, startRow);
            pstmt.setInt(2, endRow);
            rs = pstmt.executeQuery(); 
            System.out.println(3);
            if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
               volList = new ArrayList<VolBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
               do {
                  VolBoardDTO volArticle = new VolBoardDTO(); 
                  volArticle.setVolNo(rs.getInt("volNo")); 
                  volArticle.setMemId(rs.getString("memId"));
                  volArticle.setVolSubject(rs.getString("volSubject"));
                  volArticle.setVolContent(rs.getString("volContent"));
                  volArticle.setVolCategory(rs.getString("volCategory"));
                  volArticle.setVolMaxNum(rs.getInt("volMaxNum"));
                  volArticle.setVolStatus(rs.getInt("volStatus"));
                  volArticle.setVolStartDate(rs.getDate("volStartDate"));
                  volArticle.setVolEndDate(rs.getDate("volEndDate"));
                  volArticle.setVolLoc(rs.getString("volLoc"));
                  volArticle.setVolTime(rs.getInt("volTime"));
                  volArticle.setVolImg(rs.getString("volImg"));
                  volArticle.setVolReg(rs.getTimestamp("volReg"));
                  volArticle.setVolArticleStatus(rs.getInt("volArticleStatus"));
                  volList.add(volArticle);
               }while(rs.next());
            }
         }catch(Exception e) {
            e.printStackTrace();
         }finally {
            if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
         }
         return volList;
      }
   
   
      //9.해당 페이지에 띄워줄 글 가져오기 
            public List<VolBoardDTO> getVolWithCen(int startRow, int endRow, String userName) {
               System.out.println(1);
               List<VolBoardDTO> volList = null; 
               Connection conn = null; 
               PreparedStatement pstmt = null; 
               ResultSet rs = null;
               try { 
                  System.out.println(2);
                  conn = getConnection(); 
                  String sql = "select C.* from(select B.* from (select rownum r, A.* from "
                        + "(select * from volBoard where volArticleStatus=1 and memId=? order by volReg desc) A) B "
                        + "where r>=? and r <=?)C where volStatus=0 or volStatus=-1";
                  pstmt = conn.prepareStatement(sql);
                  pstmt.setString(1, userName);
                  pstmt.setInt(2, startRow);
                  pstmt.setInt(3, endRow);
                  rs = pstmt.executeQuery(); 
                  System.out.println(3);
                  if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
                	  System.out.println("rs.next 들어옴");
                     volList = new ArrayList<VolBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
                     do {
                        VolBoardDTO volArticle = new VolBoardDTO(); 
                        volArticle.setVolNo(rs.getInt("volNo")); 
                        volArticle.setMemId(rs.getString("memId"));
                        volArticle.setVolSubject(rs.getString("volSubject"));
                        volArticle.setVolContent(rs.getString("volContent"));
                        volArticle.setVolCategory(rs.getString("volCategory"));
                        volArticle.setVolMaxNum(rs.getInt("volMaxNum"));
                        volArticle.setVolStatus(rs.getInt("volStatus"));
                        volArticle.setVolStartDate(rs.getDate("volStartDate"));
                        volArticle.setVolEndDate(rs.getDate("volEndDate"));
                        volArticle.setVolLoc(rs.getString("volLoc"));
                        volArticle.setVolTime(rs.getInt("volTime"));
                        volArticle.setVolImg(rs.getString("volImg"));
                        volArticle.setVolReg(rs.getTimestamp("volReg"));
                        volArticle.setVolArticleStatus(rs.getInt("volArticleStatus"));
                        volList.add(volArticle);
                        System.out.println("채움");
                     }while(rs.next());
                  }
               }catch(Exception e) {
                  e.printStackTrace();
               }finally {
                  if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
                  if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
                  if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
               }
               
               return volList;
            }
            
            //9-2.해당 페이지에 띄워줄 글 가져오기 (마감글)
            public List<VolBoardDTO> getVolEndWithCen(int startRow, int endRow, String userName) {
            	System.out.println("마감글 메서드1");
            	List<VolBoardDTO> volList = null; 
            	Connection conn = null; 
            	PreparedStatement pstmt = null; 
            	ResultSet rs = null;
            	try { 
            		System.out.println(2);
            		conn = getConnection(); 
            		String sql = "select C.* from(select B.* from (select rownum r, A.* from "
                            + "(select * from volBoard where volArticleStatus=1 and memId=? order by volReg desc) A) B "
                            + "where r>=? and r <=?)C where volStatus=1 or volStatus=2";
            		pstmt = conn.prepareStatement(sql);
            		pstmt.setString(1, userName);
            		pstmt.setInt(2, startRow);
            		pstmt.setInt(3, endRow);
            		rs = pstmt.executeQuery(); 
            		System.out.println(3);
            		if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
            			volList = new ArrayList<VolBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
            			do {
            				VolBoardDTO volArticle = new VolBoardDTO(); 
            				volArticle.setVolNo(rs.getInt("volNo")); 
            				volArticle.setMemId(rs.getString("memId"));
            				volArticle.setVolSubject(rs.getString("volSubject"));
            				volArticle.setVolContent(rs.getString("volContent"));
            				volArticle.setVolCategory(rs.getString("volCategory"));
            				volArticle.setVolMaxNum(rs.getInt("volMaxNum"));
            				volArticle.setVolStatus(rs.getInt("volStatus"));
            				volArticle.setVolStartDate(rs.getDate("volStartDate"));
            				volArticle.setVolEndDate(rs.getDate("volEndDate"));
            				volArticle.setVolLoc(rs.getString("volLoc"));
            				volArticle.setVolTime(rs.getInt("volTime"));
            				volArticle.setVolImg(rs.getString("volImg"));
            				volArticle.setVolReg(rs.getTimestamp("volReg"));
            				volArticle.setVolArticleStatus(rs.getInt("volArticleStatus"));
            				volList.add(volArticle);
            			}while(rs.next());
            		}
            	}catch(Exception e) {
            		e.printStackTrace();
            	}finally {
            		if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
            		if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
            		if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
            	}
            	return volList;
            }

         
      
   
        //12.게시글 1개 정보 가져오는 메서드
         public VolBoardDTO getOneVolContent(int volNo) {
            System.out.println("게시글1개 가져오는 메서드 실행");
            VolBoardDTO volArticle = null;
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
               conn = getConnection();
               String sql = "select * from volBoard where volNo=? and volArticleStatus=1";
               pstmt = conn.prepareStatement(sql);
               pstmt.setInt(1, volNo);
               
               rs = pstmt.executeQuery();
               if(rs.next()) {
                  volArticle = new VolBoardDTO();
                  volArticle.setVolNo(volNo);
                  volArticle.setMemId(rs.getString("memId"));
                  volArticle.setVolSubject(rs.getString("volSubject"));
                  volArticle.setVolContent(rs.getString("volContent"));
                  volArticle.setVolCategory(rs.getString("volCategory"));
                  volArticle.setVolMaxNum(rs.getInt("volMaxNum"));
                  volArticle.setVolStatus(rs.getInt("volStatus"));
                  volArticle.setVolStartDate(rs.getDate("volStartDate"));
                  volArticle.setVolEndDate(rs.getDate("volEndDate"));
                  volArticle.setVolLoc(rs.getString("volLoc"));
                  volArticle.setVolTime(rs.getInt("volTime"));
                  volArticle.setVolImg(rs.getString("volImg"));
                  volArticle.setVolReg(rs.getTimestamp("volReg"));
                  volArticle.setVolArticleStatus(rs.getInt("volArticleStatus"));
                  
               }
               
               
            }catch (Exception e) {
               e.printStackTrace();
            }finally {
                if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
                 if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
                 if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
            }
            return volArticle;
         }
      
   
   
         //13.한개의 게시글 삭제하는 메서드
         public int deleteOneVol(int volNo) {
            int result = 0;
            int noshow = 0;
            Connection conn = null;
            PreparedStatement pstmt = null;
            
            try {
               conn = getConnection();
               String sql ="update volBoard set volArticleStatus=? where volNo=?"; 
               pstmt = conn.prepareStatement(sql);
               pstmt.setInt(1, noshow);
               pstmt.setInt(2, volNo);
               result = pstmt.executeUpdate();
            }catch(Exception e) {
               e.printStackTrace();
            }finally {
               if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
               if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
            }
            return result;
         }//메서드 종료
   
   
      //14.봉사 게시글 수정하는 메서드
         public int updateVolArticle(VolBoardDTO volArticle) {
            int result = 0;
            Connection conn = null; 
           PreparedStatement pstmt = null; 
           ResultSet rs = null;
           try {
              conn = getConnection();
              String sql = "update volBoard set volSubject=?, volCategory=?, volStatus=?, volMaxNum=?, volStartDate=?, volEndDate=?, volLoc=?, volTime=?, volContent=?, volImg=? where volNo=?";
              pstmt = conn.prepareStatement(sql);
              pstmt.setString(1, volArticle.getVolSubject());
              pstmt.setString(2, volArticle.getVolCategory());
              pstmt.setInt(3, volArticle.getVolStatus());
              pstmt.setInt(4, volArticle.getVolMaxNum());
              pstmt.setDate(5, volArticle.getVolStartDate());
              pstmt.setDate(6, volArticle.getVolEndDate());
              pstmt.setString(7, volArticle.getVolLoc());
              pstmt.setInt(8, volArticle.getVolTime());
              pstmt.setString(9, volArticle.getVolContent());
              pstmt.setString(10, volArticle.getVolImg());
              pstmt.setInt(11, volArticle.getVolNo());
              
              result = pstmt.executeUpdate();
              
           }catch (Exception e) {
              e.printStackTrace();
          }finally {
             if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
             if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
             if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
          }
           
           
            return result;
         }

 /*   
   //15.오늘날짜랑 EndDate값이랑 비교하기 (마감 날짜가 오늘과 같으면 모집마감으로 상태변경)
   public void compareTodayEndDate(String todayFormat) {
      int wanryo = 1; //마감 
      Connection conn = null; 
       PreparedStatement pstmt = null; 
       ResultSet rs = null;
           try {
              System.out.println("compare try");
              conn = getConnection();
              String sql = "select * from volBoard where to_char(volEndDate, 'MM/DD') <= ?";
              pstmt = conn.prepareStatement(sql);
              pstmt.setString(1, todayFormat);
              System.out.println("sql날림");
              rs = pstmt.executeQuery();
              System.out.println("compare rs 담음");
              if(rs.next()) {
                 System.out.println("if 들어옴");
                 do {
                 sql = "update volBoard set volStatus=? where to_char(volEndDate, 'MM/DD') <= ?";
                   pstmt = conn.prepareStatement(sql);
                   pstmt.setInt(1, wanryo);
                   pstmt.setString(2, todayFormat); 
                   int result =pstmt.executeUpdate();
                   
                   System.out.println(result);
                 }while(rs.next());
             
              }   
           }catch(Exception e){
              e.printStackTrace();
           }finally {
              if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
              if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
              if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
              
           }
      
   }//메서드 종료 
       */
         //15.오늘날짜랑 EndDate값이랑 비교하기 (마감 날짜가 오늘과 같으면 모집마감으로 상태변경)
         public void compareTodayEndDate(String todayFormat) {
            int wanryo = 1; //마감 
            Connection conn = null; 
             PreparedStatement pstmt = null; 
             ResultSet rs = null;
                 try {
                    System.out.println("compare try");
                    conn = getConnection();
                    String sql = "select * from volBoard where to_char(volEndDate, 'MM/DD') <= ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, todayFormat);
                    System.out.println("sql날림");
                    rs = pstmt.executeQuery();
                    System.out.println("compare rs 담음");
                    if(rs.next()) {
                       System.out.println("if 들어옴");
                       do {
                       sql = "update volBoard set volStatus=? where to_char(volEndDate, 'MM/DD') <= ? and volStatus not in(2)";
                         pstmt = conn.prepareStatement(sql);
                         pstmt.setInt(1, wanryo);
                         pstmt.setString(2, todayFormat); 
                         int result =pstmt.executeUpdate();
                         sql = "update volBoard set volStatus=0 where to_char(volEndDate, 'MM/DD') = ? and  to_char(volStartDate, 'MM/DD') = ? and volStatus not in(2)";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, todayFormat); 
                        pstmt.setString(2, todayFormat); 
                        pstmt.executeUpdate();
                         
                       }while(rs.next());
                   
                    }   
                 }catch(Exception e){
                    e.printStackTrace();
                 }finally {
                    if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
                    if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
                    if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
                    
                 }
            
         }//메서드 종료 
         
   
   //16.오늘날짜랑 EndDate값이랑 비교하기 (시작날짜가 오늘보다 작거나 같으면 모집중으로 상태변경)
   public void compareTodayStartDate(String todayFormat) {
      int ing = 0; //진행중
      Connection conn = null;  
      PreparedStatement pstmt = null; 
      ResultSet rs = null;
      try {
         System.out.println("compare try 모집중");
         conn = getConnection();
         String sql = "select * from volBoard where to_char(volStartDate, 'MM/DD') <= ? and to_char(volEndDate, 'MM/DD') > ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, todayFormat);
         pstmt.setString(2, todayFormat);
         System.out.println("sql날림");
         rs = pstmt.executeQuery();
         System.out.println("compare rs 모집중 담음");
         if(rs.next()) {
            System.out.println("if 들어옴");
            do {
               sql = "update volBoard set volStatus=? where to_char(volStartDate, 'MM/DD') <= ? and to_char(volEndDate, 'MM/DD') > ? and volStatus not in(2)";
               pstmt = conn.prepareStatement(sql);
               pstmt.setInt(1, ing);
               pstmt.setString(2, todayFormat);
               pstmt.setString(3, todayFormat);
               int result = pstmt.executeUpdate();
               
               System.out.println("진행중?" + result);
            }while(rs.next());
         }   
         System.out.println("compare");
      }catch(Exception e){
         e.printStackTrace();
      }finally {
         if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
         if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
         
      }
      
   }//메서드 종료 
   
   
   //17.오늘날짜랑 비교하기 (시작날짜가 오늘보다 크면 모집예정으로 상태변경)
   public void compareTodayDateIng(String todayFormat) {
      int tomorrow = -1;
      Connection conn = null;  
      PreparedStatement pstmt = null; 
      ResultSet rs = null;
      try {
         System.out.println("compare try 모집예정");
         conn = getConnection();
         String sql = "select * from volBoard where to_char(volStartDate, 'MM/DD') > ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, todayFormat);
         System.out.println("sql날림");
         rs = pstmt.executeQuery();
         System.out.println("compare rs 모집예정 담음");
         if(rs.next()) {
            System.out.println("if 들어옴");
            do {
               sql = "update volBoard set volStatus=? where to_char(volStartDate, 'MM/DD') > ? and volStatus not in(2)";
               pstmt = conn.prepareStatement(sql);
               pstmt.setInt(1, tomorrow);
               pstmt.setString(2, todayFormat);
               int result = pstmt.executeUpdate();
               
               System.out.println("진행중?" + result);
            }while(rs.next());
         }   
         System.out.println("compare");
      }catch(Exception e){
         e.printStackTrace();
      }finally {
         if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
         if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
         
      }
      
   }//메서드 종료 
   
   
   //volNo주고 봉사 인정 시간 가져오는 메서드
   public int getTime(int volNo) {
      int time = 0;
        Connection conn = null; 
        PreparedStatement pstmt = null; 
        ResultSet rs = null; 
         try {
            conn = getConnection();
            String sql = "select volTime from volBoard where volNo=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, volNo);
            rs= pstmt.executeQuery();
            if(rs.next()) {
               time =rs.getInt(1);
               }      
            } catch (Exception e) {
               e.printStackTrace();
            }finally {
               if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
               if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
               if(rs!=null)try {rs.close();}catch(Exception e){e.printStackTrace();}
            }           
             return time;
          }//메서드 종료
      
   
   
   //게시글 1개 정보 가져오는 메서드
   public VolBoardDTO getMemOneVolContent(int volNo) {
      System.out.println("게시글1개 가져오는 메서드 실행");
      VolBoardDTO volArticle = null;
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         conn = getConnection();
         String sql = "select * from volBoard where volNo=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, volNo);
         
         rs = pstmt.executeQuery();
         if(rs.next()) {
            volArticle = new VolBoardDTO();
            volArticle.setVolNo(volNo);
            volArticle.setMemId(rs.getString("memId"));
            volArticle.setVolSubject(rs.getString("volSubject"));
            volArticle.setVolContent(rs.getString("volContent"));
            volArticle.setVolCategory(rs.getString("volCategory"));
            volArticle.setVolMaxNum(rs.getInt("volMaxNum"));
            volArticle.setVolStatus(rs.getInt("volStatus"));
            volArticle.setVolStartDate(rs.getDate("volStartDate"));
            volArticle.setVolEndDate(rs.getDate("volEndDate"));
            volArticle.setVolLoc(rs.getString("volLoc"));
            volArticle.setVolTime(rs.getInt("volTime"));
            volArticle.setVolImg(rs.getString("volImg"));
            volArticle.setVolReg(rs.getTimestamp("volReg"));
            volArticle.setVolArticleStatus(rs.getInt("volArticleStatus"));
            
         }
         
         
      }catch (Exception e) {
         e.printStackTrace();
      }finally {
          if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
           if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
           if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
      }
      return volArticle;
   }
   public void deadline(int volNo) {
	      Connection conn = null;  
	      PreparedStatement pstmt = null; 
	      try {
	    	  conn = getConnection();
	    	  String sql = "update volBoard set volStatus=2 where volNo=?";
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setInt(1, volNo);
	          pstmt.executeUpdate();
 
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally {
	         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	         if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	         
	      }	   
	   
   }
   
   
}