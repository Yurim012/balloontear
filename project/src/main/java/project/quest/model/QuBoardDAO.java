package project.quest.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class QuBoardDAO {
   // 커넥션 만들어 리턴해주는 메서드 
   private Connection getConnection() throws NamingException, SQLException {
      Context ctx = new InitialContext(); 
      Context env = (Context)ctx.lookup("java:comp/env"); 
      DataSource ds = (DataSource)env.lookup("jdbc/orcl");
      return ds.getConnection(); 
   }
   
   
   
   
   //해당하는 포인트 들고오기    DayPoint(int memDayCount)
   // select quClearPoint from quBoard where quValue=? and quType='qudayCount'
    public int DayPoint(int memDayCount) {
       int dayPoint = 0;
        Connection conn = null;
        PreparedStatement pstmt  = null;
        ResultSet rs = null;
        
        try {
         conn = getConnection();
         //String sql = "select quClearPoint from quBoard where quValue=? and quType=?";
         String sql = "select quClearPoint from quBoard where quValue=? and quType='quDayCount'";
         pstmt = conn.prepareCall(sql);
         System.out.println("쿼리문들어감");
         pstmt.setInt(1, memDayCount);
         //pstmt.setString(2, quDayCount);
         
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            dayPoint = rs.getInt(1);
            System.out.println(dayPoint);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
            if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
       }
       
       return dayPoint;
    }   
    
    
    
    
    
   // qudao.DayPointQuNo
    public int DayPointQuNo(int memDayCount) {
       int dayPointQuNo = 0;
        Connection conn = null;
        PreparedStatement pstmt  = null;
        ResultSet rs = null;
        
        try {
         conn = getConnection();
         String sql = "select quNo from quBoard where quValue=? and quType='quDayCount'";
         pstmt = conn.prepareCall(sql);
         System.out.println(" DayPointQuNo 쿼리문들어감");
         pstmt.setInt(1, memDayCount);
         //pstmt.setString(2, quDayCount);
         
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            dayPointQuNo = rs.getInt(1);
            System.out.println(dayPointQuNo);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
            if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
       }
       
       return dayPointQuNo;
    }
    
    
    
    
    // 퀘스트 결과 테이블에 데이터 넣기 insertquMemResult(id,dpQuNo);
   public void insertquMemResult(String id,int dpQuNo) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      
      try {
         conn = getConnection();
   
         String sql = "insert into quMemResult values(?,?)"; // 9개 sysdate
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, dpQuNo);
         pstmt.setString(2, id);
         int result =pstmt.executeUpdate();
         System.out.println(" quMemResult에 데이터잘들어가면 1뜸 : " + result);
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
         if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
      }      
      
   }    
    
   
   // 개인의 구매횟수를 주면 퀘스트 번호 돌려줌 41 42 43 44 45
   public int buyCountQuNo(int memBuyCount) {
       int buyCountQuNo = 0;
        Connection conn = null;
        PreparedStatement pstmt  = null;
        ResultSet rs = null;
        
        try {
         conn = getConnection();
         String sql = "select quNo from quBoard where quValue=? and quType='quBuyCount'";
         pstmt = conn.prepareCall(sql);
         System.out.println(" quBuyCount 쿼리문들어감");
         pstmt.setInt(1, memBuyCount);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
           buyCountQuNo = rs.getInt(1);
            System.out.println(buyCountQuNo);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
            if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
       }
       return buyCountQuNo;
    } 
    
    
    
   // 개인의 구매 포인트를 주면 퀘스트 번호 리턴 51 51 53 54 55
   public int buyPointQuNo(int buyPoint) {
       int buyPointQuNo = 0;
        Connection conn = null;
        PreparedStatement pstmt  = null;
        ResultSet rs = null;
        
        try {
         conn = getConnection();
         String sql = "select quNo from quBoard where quValue=? and quType='quBuyPoint'";
         pstmt = conn.prepareCall(sql);
         System.out.println(" quBuyPoint 쿼리문들어감");
         pstmt.setInt(1, buyPoint);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
           buyPointQuNo = rs.getInt(1);
            System.out.println("buyPointQuNo : " +buyPointQuNo);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
            if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
       }
       return buyPointQuNo;
    } 
    
   
   
    
   
   // 구매횟수에 따른 퀘스트 클리어 포인트 가져오는 메서드
   public int buyCountPoint(int memDayCount) {
       int buyCountPoint = 0;
        Connection conn = null;
        PreparedStatement pstmt  = null;
        ResultSet rs = null;
        
        try {
         conn = getConnection();
         //String sql = "select quClearPoint from quBoard where quValue=? and quType=?";
         String sql = "select quClearPoint from quBoard where quValue=? and quType='quBuyCount'";
         pstmt = conn.prepareCall(sql);
         System.out.println("쿼리문들어감");
         pstmt.setInt(1, memDayCount);
         //pstmt.setString(2, quDayCount);
         
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            buyCountPoint = rs.getInt(1);
            System.out.println("buyCountPoint" + buyCountPoint);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
            if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
       }
       
       return buyCountPoint;
    }    
   
   
   
   // 개인의 총 구매 금액에 따른 포인트 지급
   public int totalBuyPoint(int memBuyPointResult) {
       int totalBuyPoint = 0;
        Connection conn = null;
        PreparedStatement pstmt  = null;
        ResultSet rs = null;
        
        try {
         conn = getConnection();
         //String sql = "select quClearPoint from quBoard where quValue=? and quType=?";
         String sql = "select quClearPoint from quBoard where quValue=? and quType='quBuyPoint'";
         pstmt = conn.prepareCall(sql);
         System.out.println("totalBuyPoint 쿼리문들어감");
         pstmt.setInt(1, memBuyPointResult);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
           totalBuyPoint = rs.getInt(1);
            System.out.println("totalBuyPoint" + totalBuyPoint);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
            if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
       }
       
       return totalBuyPoint;
    }       
    
   
   
   public int volTimePoint(int volTimeResult) {
       int volTimePoint = 0;
       Connection conn = null;
       PreparedStatement pstmt  = null;
       ResultSet rs = null;
       
       try {
        conn = getConnection();
        //String sql = "select quClearPoint from quBoard where quValue=? and quType=?";
        String sql = "select quClearPoint from quBoard where quValue=? and quType='quVolTime'";
        pstmt = conn.prepareCall(sql);
        System.out.println("쿼리문들어감");
        pstmt.setInt(1, volTimeResult);
        //pstmt.setString(2, quDayCount);
        
        rs = pstmt.executeQuery();
        
        if(rs.next()) {
          volTimePoint = rs.getInt(1);
           System.out.println("volTimePoint" + volTimePoint);
        }
     } catch (Exception e) {
        e.printStackTrace();
     }finally {
           if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
           if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
           if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
      }
      return volTimePoint;
   }      
  // 개인의 봉사 횟수와 일치하는 퀘스트 번호 가져오기 21 22 23 24 25 중하나 없음 0 리턴
  public int volCountQuNo(int memVolCount) {
      int volCountQuNo = 0;
       Connection conn = null;
       PreparedStatement pstmt  = null;
       ResultSet rs = null;
       
       try {
        conn = getConnection();
        String sql = "select quNo from quBoard where quValue=? and quType='quVolCount'";
        pstmt = conn.prepareCall(sql);
        System.out.println(" DayPointQuNo 쿼리문들어감");
        pstmt.setInt(1, memVolCount);
        rs = pstmt.executeQuery();
        if(rs.next()) {
          volCountQuNo = rs.getInt(1);
           System.out.println(volCountQuNo);
        }
     } catch (Exception e) {
        e.printStackTrace();
     }finally {
           if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
           if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
           if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
      }
      return volCountQuNo;
   }   
  
  
  // 개인의 봉사 시간과 일치하는 퀘스트 번호 가져오기 31 32 33 34 35 중하나 없음 0 리턴
  public int volTimeQuNo(int volTimeResult) {
      int volTimeQuNo = 0;
       Connection conn = null;
       PreparedStatement pstmt  = null;
       ResultSet rs = null;
       
       try {
        conn = getConnection();
        String sql = "select quNo from quBoard where quValue=? and quType='quVolTime'";
        pstmt = conn.prepareCall(sql);
        System.out.println(" volTimeQuNo 쿼리문들어감");
        pstmt.setInt(1,volTimeResult);
        rs = pstmt.executeQuery();
        if(rs.next()) {
          volTimeQuNo = rs.getInt(1);
           System.out.println("volTimeQuNo : " +volTimeQuNo);
        }
     } catch (Exception e) {
        e.printStackTrace();
     }finally {
           if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
           if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
           if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
      }
      return volTimeQuNo;
   }    
   
   
  // 7월 26일
  // 봉사횟수에 따른 퀘스트 클리어 포인트 가져오는 메서드
  public int volCountPoint(int memVolCount) {
      int volCountPoint = 0;
       Connection conn = null;
       PreparedStatement pstmt  = null;
       ResultSet rs = null;
       
       try {
        conn = getConnection();
        //String sql = "select quClearPoint from quBoard where quValue=? and quType=?";
        String sql = "select quClearPoint from quBoard where quValue=? and quType='quVolCount'";
        pstmt = conn.prepareCall(sql);
        System.out.println("쿼리문들어감");
        pstmt.setInt(1, memVolCount);
        
        rs = pstmt.executeQuery();
        
        if(rs.next()) {
           volCountPoint = rs.getInt(1);
           System.out.println("buyCountPoint" + volCountPoint);
        }
     } catch (Exception e) {
        e.printStackTrace();
     }finally {
           if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
           if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
           if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
      }
      return volCountPoint;
   }   
   
 
    
}