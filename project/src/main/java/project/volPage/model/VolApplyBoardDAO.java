package project.volPage.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class VolApplyBoardDAO {
	//커넥션
			private Connection getConnection() throws Exception {
				Context ctx = new InitialContext(); 
				Context env = (Context)ctx.lookup("java:comp/env");
				DataSource ds = (DataSource)env.lookup("jdbc/orcl");
				return ds.getConnection();
			}	
	
	//1.봉사 신청 받기
	public void insertVolApply(VolApplyBoardDTO volApply) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int zero = -1;
		
		try {
			conn = getConnection();
			String sql ="insert into volApplyBoard(applyNo, volNo, memId, memActivity, selDate, applyDate)";
			sql +=" values(volApplyBoard_seq.nextval, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, volApply.getVolNo());
			pstmt.setString(2, volApply.getMemId());
			pstmt.setInt(3, zero);
			pstmt.setDate(4, volApply.getSelDate());
			pstmt.setString(5, volApply.getApplyDate());
			
			int applyUpdate = pstmt.executeUpdate();
			System.out.println("봉사 신청 결과 : " +  applyUpdate);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			 if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
             if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
	}//메서드 끝
	
	//2.봉사 신청 데이터 가져오기 
	   public VolApplyBoardDTO getOneApplyerInForm(int volNo){
	      VolApplyBoardDTO volApplyArticle = null;
	            Connection conn = null;
	            PreparedStatement pstmt = null;
	            ResultSet rs = null;
	            try {
	               conn = getConnection();
	               String sql = "select * from volApplyBoard where volNo=?";
	               pstmt = conn.prepareStatement(sql);
	               pstmt.setInt(1, volNo);
	               
	               rs = pstmt.executeQuery();
	               if(rs.next()) {
	                  volApplyArticle = new VolApplyBoardDTO();
	                  
	                  volApplyArticle.setApplyNo(rs.getInt("ApplyNo"));
	                  volApplyArticle.setVolNo(volNo);
	                  volApplyArticle.setMemId(rs.getString("memId"));
	                  volApplyArticle.setMemActivity(rs.getInt("memActivity"));
	                  volApplyArticle.setSelDate(rs.getDate("selDate"));
	               }
	            }catch (Exception e) {
	               e.printStackTrace();
	            }finally {
	                if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
	                if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	                if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	         }
	      
	      return volApplyArticle;
	   } 
	
	   
	//3.봉사 신청자 수 가져오기
	public int getApplyCount(int volNo){
		int applyCount = 0;
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
        	conn = getConnection();
        	String sql ="select Count(*) from VolApplyBoard where volNo=?";
        	pstmt = conn.prepareStatement(sql);
        	pstmt.setInt(1, volNo);
        	rs = pstmt.executeQuery();
        	if(rs.next()) {
        		applyCount = rs.getInt(1);
        	}
        }catch(Exception e) {
        	e.printStackTrace();
        }finally {
     		if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
        	if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
        }
		
		return applyCount;
	}
	
	
	
	//4. 전체 봉사 신청자수 가져오기
	   public int getAllApplyCount() {
	      int allCount = 0;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         conn = getConnection();
	         String sql = "select Count(*) from VolApplyBoard";
	         pstmt = conn.prepareStatement(sql);
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	            allCount = rs.getInt(1);
	         }
	      }catch(Exception e) {
	           e.printStackTrace();
	        }finally {
	           if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
	           if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	        }
	      return allCount;
	   }
	   
	   
	    
	   //5. 오늘 봉사 신청한 사람 수 가져오기
	   public int todayVolApplyCount(String today) {
	      int toVolApCount = 0;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         conn = getConnection();
	         String sql = "select Count(*) from VolApplyBoard where applyDate = ?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, today);
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	            toVolApCount = rs.getInt(1);
	         }
	      }catch(Exception e) {
	           e.printStackTrace();
	        }finally {
	           if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
	           if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	        }
	      return toVolApCount;
	   }
	   
	   
	//6. 내가 신청한 봉사 수 가져오기
	      public int getmyApplyVolCount(String id){
	         int myApplyCount = 0;
	         Connection conn = null;
	           PreparedStatement pstmt = null;
	           ResultSet rs = null;
	           try {
	              conn = getConnection();
	              String sql ="select Count(*) from VolApplyBoard where memId=?";
	              pstmt = conn.prepareStatement(sql);
	              pstmt.setString(1, id);
	              rs = pstmt.executeQuery();
	              if(rs.next()) {
	                 myApplyCount = rs.getInt(1);
	              }
	           }catch(Exception e) {
	              e.printStackTrace();
	           }finally {
	              if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
	              if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	               if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	           }
	         
	         return myApplyCount;
	      }
	   
	   
	   //7. 내가 신청한 봉사 리스트 가져오기 (페이징처리해서) 
	      public List<VolApplyBoardDTO> getMyVolAllList(int startRow, int endRow, String id) {
	         System.out.println("내가 신청한 봉사 리스트 가져오기 실행");
	         List<VolApplyBoardDTO> myVolApplyList = null; 
	         Connection conn = null; 
	         PreparedStatement pstmt = null; 
	         ResultSet rs = null;
	         try { 
	            System.out.println(2);
	            conn = getConnection(); 
	            String sql = "select B.* from (select rownum r, A.* from "
	                  + "(select * from volApplyBoard order by volNo desc) A) B "
	                  + "where r >= ? and r <= ? and memId=?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, startRow);
	            pstmt.setInt(2, endRow);
	            pstmt.setString(3, id);
	            rs = pstmt.executeQuery(); 
	            System.out.println(3);
	            if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
	               myVolApplyList = new ArrayList<VolApplyBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
	               System.out.println(4);
	               do {
	                  VolApplyBoardDTO myVolApplyArticle = new VolApplyBoardDTO();
	                  System.out.println(5);
	                     myVolApplyArticle.setApplyNo(rs.getInt("applyNo"));
	                     myVolApplyArticle.setVolNo(rs.getInt("volNo"));
	                     myVolApplyArticle.setMemId(id);
	                     myVolApplyArticle.setMemActivity(rs.getInt("memActivity"));
	                     myVolApplyArticle.setSelDate(rs.getDate("selDate"));
	                     myVolApplyArticle.setApplyDate(rs.getString("applyDate"));
	                     myVolApplyList.add(myVolApplyArticle);
	                     System.out.println(6);
	               }while(rs.next());
	            }
	         }catch(Exception e) {
	            e.printStackTrace();
	         }finally {
	            if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
	            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	         }
	         System.out.println(7);
	         return myVolApplyList;
	      }
	
	
	   //8. 해당 봉사에 신청한 사람들 목록 가져오기 
	      public List<VolApplyBoardDTO> getmemVolApplyList(int startRow, int endRow, int volNo) {
	         System.out.println("해당봉사에 신청한 사람들 목록 가져오기");
	         List<VolApplyBoardDTO> memVolApplyList = null; 
	         Connection conn = null; 
	         PreparedStatement pstmt = null; 
	         ResultSet rs = null;
	         try { 
	            System.out.println(2);
	            conn = getConnection(); 
	            String sql = "select B.* from (select rownum r, A.* from "
	                  + "(select * from volApplyBoard order by volNo desc) A) B "
	                  + "where r >= ? and r <= ? and volNo=?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, startRow);
	            pstmt.setInt(2, endRow);
	            pstmt.setInt(3, volNo);
	            rs = pstmt.executeQuery(); 
	            System.out.println(3);
	            if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
	            	memVolApplyList = new ArrayList<VolApplyBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
	               System.out.println(4);
	               do {
	                  VolApplyBoardDTO myVolApplyArticle = new VolApplyBoardDTO();
	                  System.out.println(5);
	                     myVolApplyArticle.setApplyNo(rs.getInt("applyNo"));
	                     myVolApplyArticle.setVolNo(volNo);
	                     myVolApplyArticle.setMemId(rs.getString("memId"));
	                     myVolApplyArticle.setMemActivity(rs.getInt("memActivity"));
	                     myVolApplyArticle.setSelDate(rs.getDate("selDate"));
	                     myVolApplyArticle.setApplyDate(rs.getString("applyDate"));
	                     memVolApplyList.add(myVolApplyArticle);
	                     System.out.println(6);
	               }while(rs.next());
	            }
	         }catch(Exception e) {
	            e.printStackTrace();
	         }finally {
	            if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
	            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	         }
	         System.out.println(7);
	         return memVolApplyList;
	      }
	      
	
	
	//9.센터가 승인 눌렀을때 멤버의 봉사 Activity값 변경하는 메서드      
	public int changeMemActivity(int applyNo) {
		 System.out.println("센터 승인 시 멤버봉사avtivity값 변경 메서드 시작");
	     Connection conn = null; 
	     PreparedStatement pstmt = null; 
	     int result = 0;
	     int active = 1;
	     
	     try { 
	    	System.out.println("try입장~");
	    	conn = getConnection();
	    	String sql ="update volApplyBoard set memActivity=? where applyNo=?"; 
	    	System.out.println("applyNo : " + applyNo);
	    	pstmt = conn.prepareStatement(sql);
	    	pstmt.setInt(1, active);
	    	pstmt.setInt(2, applyNo);
	    	result = pstmt.executeUpdate();
	    	System.out.println("멤버봉사activity값 업뎃(완료시 1) : " + result);
	    	
	     }catch(Exception e) {
	    	 e.printStackTrace();
	     }finally {
	    	 if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	    	 if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	     }
	     return result;
	     }//메서드 끝
	         
	         
	//9-2. 승인 한 멤봉사 Activity값 변경하는 메서드 
	public int changeMemActivityCancle(int applyNo) {
		 System.out.println("센터 승인취소 시 멤버봉사avtivityCancle값 변경 메서드 시작");
	     Connection conn = null; 
	     PreparedStatement pstmt = null; 
	     int result = 0;
	     int active = -1;
	     
	     try { 
	    	System.out.println("try입장~");
	    	conn = getConnection();
	    	String sql ="update volApplyBoard set memActivity=? where applyNo=?"; 
	    	System.out.println("applyNo : " + applyNo);
	    	pstmt = conn.prepareStatement(sql);
	    	pstmt.setInt(1, active);
	    	pstmt.setInt(2, applyNo);
	    	result = pstmt.executeUpdate();
	    	System.out.println("멤버봉사activity Cancle값 업뎃(완료시 1) : " + result);
	    	
	     }catch(Exception e) {
	    	 e.printStackTrace();
	     }finally {
	    	 if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	    	 if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	     }
	     return result;
	     }//메서드 끝
	
	
	
	
	// 봉사 있는지 없는지 여부 확인 메서드
    public int checkVolapply(String id, int applyNo) {
       System.out.println("봉사 취소 체크 메서드 실행");
       int result = 0;
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       try {
          conn = getConnection();
          String sql = "select Count(*) from volApplyBoard where memId=? and applyNo=?";
          pstmt = conn.prepareStatement(sql);
          pstmt.setString(1, id);
          pstmt.setInt(2, applyNo);
          rs = pstmt.executeQuery();
          if(rs.next()) {
             result = rs.getInt(1);
          }
          
       }catch (Exception e) {
          e.printStackTrace();
       }finally{
          if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
          if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
          if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
       }
       return result;
    }
    
    
    
    // 봉사 신청 취소 메서드
    public int memVolcancel(int applyNo) {
       int result = 0;
       Connection conn = null;
       PreparedStatement pstmt = null;
       try {
          conn = getConnection();
          String sql = "delete from volApplyBoard where applyNo=?";
          pstmt = conn.prepareStatement(sql);
          pstmt.setInt(1, applyNo);
          result= pstmt.executeUpdate();
       }catch (Exception e) {
          e.printStackTrace();
       }finally {
          if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
          if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
       }
       return result;   
       
    }
	         
    
    //봉사신청번호 주면 봉사 신청내역 돌려주는 메서드  
    public VolApplyBoardDTO getOneApply(int applyNo){
    	VolApplyBoardDTO volApplyArticle = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
             try {
                conn = getConnection();
                String sql = "select * from volApplyBoard where applyNo=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, applyNo);
                
                rs = pstmt.executeQuery();
                if(rs.next()) {
                   volApplyArticle = new VolApplyBoardDTO();
                   
                   volApplyArticle.setApplyNo(applyNo);
                   volApplyArticle.setVolNo(rs.getInt("volNo"));
                   volApplyArticle.setMemId(rs.getString("memId"));
                   volApplyArticle.setMemActivity(rs.getInt("memActivity"));
                   volApplyArticle.setSelDate(rs.getDate("selDate"));
                }
             }catch (Exception e) {
                e.printStackTrace();
             }finally {
                 if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
                 if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
                 if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
          }
       
       return volApplyArticle;
       
       
    } 

	    
	//봉사신청번호 주면 봉사 해당 멤버의ID 돌려주는 메서드 
	public String getMemId(int applyNo) {
		String memApplyId = "";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
             try {
                conn = getConnection();
                String sql = "select memId from volApplyBoard where applyNo=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, applyNo);
                rs = pstmt.executeQuery();
                if(rs.next()) {
                	memApplyId = rs.getString("memId");
                }
             }catch (Exception e) {
                e.printStackTrace();
             }finally {
                 if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
                 if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
                 if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
          }
       
       return memApplyId;
	   }//메서드 끝
    
	
	 // 봉사 신청 전에 지원자가 해당 글에 다시 지원헀는지 중복체크하기
	   // 중복으로 지원했을 경우 쳐내기 중복있을경우 1 없을경우 0
	   //select * from volApplyBoard where memId=? volNO=?;
	   //applydao.overlapCheck(id,volNo);
	   public int overlapCheck(String id,int volNo,java.sql.Date selD) {
	      int overlapCheck = 0; // 중복있을경우 1 없을경우 0
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        try {
	           conn = getConnection();
	           String sql = "select * from volApplyBoard where memId=? and volNo=? and selDate=?";
	           pstmt = conn.prepareStatement(sql);
	           pstmt.setString(1, id);
	           pstmt.setInt(2, volNo);
	           pstmt.setDate(3, selD);
	           rs = pstmt.executeQuery();
	           if(rs.next()) {
	              overlapCheck = 1; // 중복이 있네? 1이야
	           }
	        }catch (Exception e) {
	           e.printStackTrace();
	        }finally {
	            if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
	            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	        }
	        return overlapCheck;      
	   }      
	      
	
	
}
