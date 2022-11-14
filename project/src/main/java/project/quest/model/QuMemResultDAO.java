package project.quest.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class QuMemResultDAO {
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}	
	
	
	
	
	
	public List<QuMemResultDTO> quNoAllList(String id){
	      List<QuMemResultDTO> list = null;
	      Connection conn = null; 
	      PreparedStatement pstmt = null; 
	      ResultSet rs = null;
	      try {
	         conn = getConnection(); 
	         String sql = "select quNo from quMemResult where memId=? and quNo like '1%'";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, id);
	         rs = pstmt.executeQuery(); 
	         
	         if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
	            list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
	            do {
	               QuMemResultDTO article = new QuMemResultDTO(); 
	               article.setQuNO(rs.getInt("quNo"));
	               System.out.println("quNo 리스트에 추가 ");
	               list.add(article);
	            }while(rs.next());
	         }
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
	         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	         if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	      }      
	      
	      return list;
	   }
	
	
	
    public int quCleartCount(String id){
        int quClearCount = 0;
         Connection conn = null;
         PreparedStatement pstmt  = null;
         ResultSet rs = null;
         
         try {
          conn = getConnection();
          String sql = "select count(*) from quMemResult where memId=?";
          pstmt = conn.prepareCall(sql);
          pstmt.setString(1, id);
          rs = pstmt.executeQuery();
          if(rs.next()) {
             quClearCount = rs.getInt(1);
          }
       } catch (Exception e) {
          e.printStackTrace();
       }finally {
             if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
             if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
             if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
        }      
        
        return quClearCount;
     }   
  
	
	public List<Integer> memquNoListint(String id){
	      List<Integer> list = null;
	      Connection conn = null; 
	      PreparedStatement pstmt = null; 
	      ResultSet rs = null;
	      try {
	         conn = getConnection(); 
	         String sql = "select quNo from quMemResult where memId=?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, id);
	         rs = pstmt.executeQuery(); 
	         
	         if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
	            list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
	            do {
	            	
	               list.add(rs.getInt("quNo"));
	               System.out.println("quNo 리스트에 추가 ");
	            }while(rs.next());
	         }
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
	         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	         if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	      }      
	      
	      return list;
	   }
	
	
	
    
	public List<QuMemResultDTO> quNoList40(String id){
	       List<QuMemResultDTO> list = null;
	       Connection conn = null; 
	       PreparedStatement pstmt = null; 
	       ResultSet rs = null;
	       try {
	          conn = getConnection(); 
	          String sql = "select quNo from quMemResult where memId=? and quNo like '4%'";
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, id);
	          rs = pstmt.executeQuery(); 
	          
	          if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
	             list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
	             do {
	                QuMemResultDTO article = new QuMemResultDTO(); 
	                article.setQuNO(rs.getInt("quNo"));
	                System.out.println("quNo 리스트에 추가 ");
	                list.add(article);
	             }while(rs.next());
	          }
	       }catch(Exception e) {
	          e.printStackTrace();
	       }finally {
	          if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
	          if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	          if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	       }      
	       
	       return list;
	    }   
	
	
	
	 // 50번대 퀘스트 리스트 불러오기
	 public List<QuMemResultDTO> quNoList50(String id){
	       List<QuMemResultDTO> list = null;
	       Connection conn = null; 
	       PreparedStatement pstmt = null; 
	       ResultSet rs = null;
	       try {
	          conn = getConnection(); 
	          String sql = "select quNo from quMemResult where memId=? and quNo like '5%'";
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, id);
	          rs = pstmt.executeQuery(); 
	          
	          if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
	             list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
	             do {
	                QuMemResultDTO article = new QuMemResultDTO(); 
	                article.setQuNO(rs.getInt("quNo"));
	                System.out.println("quNo 리스트에 추가 ");
	                list.add(article);
	             }while(rs.next());
	          }
	       }catch(Exception e) {
	          e.printStackTrace();
	       }finally {
	          if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
	          if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	          if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	       }      
	       
	       return list;
	    }
	 
	 
	 
	    // 퀘스트 20번대 리턴 봉사 횟수
	    public List<QuMemResultDTO> quNoList20(String id){
	          List<QuMemResultDTO> list = null;
	          Connection conn = null; 
	          PreparedStatement pstmt = null; 
	          ResultSet rs = null;
	          try {
	             conn = getConnection(); 
	             String sql = "select quNo from quMemResult where memId=? and quNo like '2%'";
	             pstmt = conn.prepareStatement(sql);
	             pstmt.setString(1, id);
	             rs = pstmt.executeQuery(); 
	             
	             if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
	                list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
	                do {
	                   QuMemResultDTO article = new QuMemResultDTO(); 
	                   article.setQuNO(rs.getInt("quNo"));
	                   System.out.println("quNo 리스트에 추가 ");
	                   list.add(article);
	                }while(rs.next());
	             }
	          }catch(Exception e) {
	             e.printStackTrace();
	          }finally {
	             if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
	             if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	             if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	          }      
	          return list;
	       }    
	    
	    
	    
	    
	    
	    //퀘스트 30번대 리스트로 리턴 봉사 시간
	    public List<QuMemResultDTO> quNoList30(String id){
	          List<QuMemResultDTO> list = null;
	          Connection conn = null; 
	          PreparedStatement pstmt = null; 
	          ResultSet rs = null;
	          try {
	             conn = getConnection(); 
	             String sql = "select quNo from quMemResult where memId=? and quNo like '3%'";
	             pstmt = conn.prepareStatement(sql);
	             pstmt.setString(1, id);
	             rs = pstmt.executeQuery(); 
	             
	             if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
	                list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
	                do {
	                   QuMemResultDTO article = new QuMemResultDTO(); 
	                   article.setQuNO(rs.getInt("quNo"));
	                   System.out.println("quNo 리스트에 추가 ");
	                   list.add(article);
	                }while(rs.next());
	             }
	          }catch(Exception e) {
	             e.printStackTrace();
	          }finally {
	             if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
	             if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	             if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	          }      
	          return list;
	       }
    
	

}
