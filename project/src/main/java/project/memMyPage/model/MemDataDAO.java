package project.memMyPage.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemDataDAO {
	// 커넥션 만들어 리턴해주는 메서드 
	private Connection getConnection() throws NamingException, SQLException {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env"); 
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection(); 
	}
	
	
	public void insertMemData(String memId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
	
			String sql = "insert into memData values(?,?,?,?,?,?,?,?,sysdate)"; // 9개 sysdate
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memId);
			pstmt.setInt(2, 0);
			pstmt.setInt(3, 1);
			pstmt.setInt(4, 0);
			pstmt.setInt(5, 0);
			pstmt.setInt(6, 0);
			pstmt.setInt(7, 0);
			pstmt.setInt(8, 1);
			int result =pstmt.executeUpdate();
			System.out.println(" MemData에 데이터잘들어가면 1뜸 : " + result);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
		}		
		
	}
	

	
	   // 멤버 데이터 (봉사횟수,봉사시간 등등 가져오기)
	   public MemDataDTO getMemData(String id) {
		   System.out.println("getMemData 실행");
		   System.out.println("받아온 id : " + id);
	      MemDataDTO memdata = null; 
	      Connection conn = null; 
	      PreparedStatement pstmt = null; 
	      ResultSet rs = null; 
	      try {
	         conn = getConnection();
	         String sql = "select * from memData where memId=?"; 
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, id);
	         System.out.println("getMemData 쿼리문까지넣기성공");
	         rs = pstmt.executeQuery(); 
	         if(rs.next()) {
	            memdata = new MemDataDTO(); // 결과가 있으면 메모리 점유해서 저장할 공간 준비 
	            memdata.setMemId(id);
	            System.out.println("id : " +id);
	            memdata.setMemPoint(rs.getInt("memPoint"));
	            memdata.setMemLevel(rs.getInt(3));
	            System.out.println("등급 : " +rs.getInt("memLevel"));
	            memdata.setMemVolCount(rs.getInt("memVolCount"));
	            memdata.setMemVolTime(rs.getInt("memVolTime"));
	            System.out.println(rs.getInt("memVolTime"));
	            memdata.setMemBuyPoint(rs.getInt("memBuyPoint"));
	            memdata.setMemBuyCount(rs.getInt("memBuyCount"));
	            memdata.setMemDayCount(rs.getInt("memDayCount"));
	            memdata.setMemLastVisitDay(rs.getDate("memLastVisitDay"));
	            System.out.println("memdataDTO 에 값들어감");
	         }
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(rs != null) try { rs.close(); }catch(SQLException e) { e.printStackTrace(); }
	         if(pstmt != null) try { pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
	         if(conn != null) try { conn.close(); }catch(SQLException e) { e.printStackTrace(); }
	      }   
	      return memdata;      
	   }
	
	
	
	   // 회원중에서 레벨 제일높은회원 찾아오기
	   //select * from memData ORDER BY memLevel desc;
	   public String topLevel() {
	      String id = null;
	      Connection conn = null; 
	      PreparedStatement pstmt = null; 
	      ResultSet rs = null; 
	      try {
	         conn = getConnection();
	         String sql = "select * from memData ORDER BY memLevel desc"; 
	         pstmt = conn.prepareStatement(sql);
	         rs = pstmt.executeQuery();
	         System.out.println("쿼리문던짐");
	         if(rs.next()) {
	            id = rs.getString(1);
	            System.out.println("레벨제일 높은 아이디 : " + id);
	         }
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(rs != null) try { rs.close(); }catch(SQLException e) { e.printStackTrace(); }
	         if(pstmt != null) try { pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
	         if(conn != null) try { conn.close(); }catch(SQLException e) { e.printStackTrace(); }
	      }      
	      return id;
	   }
	   
	   
	   
	      // 회원 중에 제일 봉사 횟수 많은사람 불러오기
	      public String topCount() {
	            String id = null;
	            Connection conn = null; 
	            PreparedStatement pstmt = null; 
	            ResultSet rs = null; 
	            try {
	               conn = getConnection();
	               String sql = "select * from memData ORDER BY memVolCount desc"; 
	               pstmt = conn.prepareStatement(sql);
	               rs = pstmt.executeQuery();
	               System.out.println("쿼리문던짐");
	               if(rs.next()) {
	                  id = rs.getString(1);
	                  System.out.println("봉사시간 제일 높은 아이디 : " + id);
	               }
	            }catch(Exception e) {
	               e.printStackTrace();
	            }finally {
	               if(rs != null) try { rs.close(); }catch(SQLException e) { e.printStackTrace(); }
	               if(pstmt != null) try { pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
	               if(conn != null) try { conn.close(); }catch(SQLException e) { e.printStackTrace(); }
	            }      
	            return id;
	         }
	      
	      
	      
	      
	      
	      // 회원 중에 제일 봉사 시간 많은사람 불러오기
	      public String topVolTime() {
	            String id = null;
	            Connection conn = null; 
	            PreparedStatement pstmt = null; 
	            ResultSet rs = null; 
	            try {
	               conn = getConnection();
	               String sql = "select * from memData ORDER BY memVolTime desc"; 
	               pstmt = conn.prepareStatement(sql);
	               rs = pstmt.executeQuery();
	               System.out.println("쿼리문던짐");
	               if(rs.next()) {
	                  id = rs.getString(1);
	                  System.out.println("봉사시간 제일 긴 id : " + id);
	               }
	            }catch(Exception e) {
	               e.printStackTrace();
	            }finally {
	               if(rs != null) try { rs.close(); }catch(SQLException e) { e.printStackTrace(); }
	               if(pstmt != null) try { pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
	               if(conn != null) try { conn.close(); }catch(SQLException e) { e.printStackTrace(); }
	            }      
	            return id;
	         } 
	   
	   
	   
	   
	   
	   // 로그인시 출석 1 플러스해주는거
	   public void memLastVisitDayCount(String id, Date today) {
		   System.out.println("출석 포인트 메서드 실행");
		   Connection conn = null;
		   PreparedStatement pstmt = null;
		   int countresult = 0;  // 카운트 업데이트한 결과
		   int dateresult = 0;  // 날짜 업데이트한 결과
		   
		   try {
			   conn = getConnection();
			   String sql = "update memData set memDayCount=memDayCount+1 where memId=?";
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setString(1, id);
			   
			   countresult = pstmt.executeUpdate();
			   
			   System.out.println("출석 count update : " + countresult);
			   	if(countresult != 0) {
			   		sql = "update memData set memLastVisitDay=? where memId=?";
			   		pstmt = conn.prepareStatement(sql);
			   		pstmt.setDate(1, today);
			   		pstmt.setString(2, id);
			   		dateresult = pstmt.executeUpdate();
			   		System.out.println("출석일수 update : " + countresult + "날짜 update : " + dateresult);
			   	}
		   }catch(Exception e) {
			   e.printStackTrace();
		   }finally {
		         if(pstmt != null) try { pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
		         if(conn != null) try { conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		   }
		   
	   }
	   
	  /* 
	   // 포인트 업데이트 해주는 메서드
	   public void memVisitPointPlus(String id) {
		   Connection conn = null;
		   PreparedStatement pstmt  = null;
		   ResultSet rs = null;
		   String sql = null;
		   int result = 0;
		   int memdayCount = 0;
		   
		   try {
			   conn = getConnection();
			   sql = "select memDayCount from memData where memId = ?";
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setString(1, id);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   memdayCount = rs.getInt(1);
				   
				   
				   if( memdayCount == 1) {
					   sql = "update memData set memPoint=memPoint+300 where memId=?";
				   } else if( memdayCount == 5){
					   sql = "update memData set memPoint=memPoint+1000 where memId=?";
				   }else if( memdayCount == 12) {
					   sql = "update memData set memPoint=memPoint+2000 where memId=?";
				   }else if( memdayCount == 25) {
					   sql = "update memData set memPoint=memPoint+2500 where memId=?";
				   }else if( memdayCount == 50) {
					   sql = "update memData set memPoint=memPoint+3000 where memId=?";
				   }else { // 아무것도 해당 안되면
					   sql = "update memData set memPoint=memPoint+0 where memId=?";
				   }
			   }
			  
			   pstmt=conn.prepareStatement(sql);
			   pstmt.setString(1, id);
			   result = pstmt.executeUpdate();
			   System.out.println("출석포인트 업데이트 성공 : "+result);
			   
		   }catch (Exception e) {
			   e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}

	   }
	   */
	   
	   
       // 포인트 업데이트 해주는 메서드
       public int memVisitPointPlus(String id,int dayPoint) {
          Connection conn = null;
          PreparedStatement pstmt  = null;
          ResultSet rs = null;
          int result = 0;
          
          try {
             conn = getConnection();
             String sql = "update memData set memPoint=memPoint+? where memId=?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setInt(1, dayPoint);        
             pstmt.setString(2, id);        
             pstmt.executeUpdate();
             result=1;

          }catch (Exception e) {
             e.printStackTrace();
       }finally {
    	   
    	  if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
          if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
          if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
       }
       return result;
       }
	 
       
       // 물건구매시 포인트 차감하는 메서드 
       public void minusPoint(String id, int price) {
          Connection conn = null;
          PreparedStatement pstmt = null;
          
          try {
             conn = getConnection();
             String sql = "update memData set memPoint=memPoint-? where memId=?"; 
             pstmt = conn.prepareStatement(sql);
             pstmt.setInt(1, price);
             pstmt.setString(2, id);
             int re = pstmt.executeUpdate();
             System.out.println("포인트차감잘되면1 아니면 0 : " + re );
             
          }catch(Exception e){
             e.printStackTrace();
          }finally {
             if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
             if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
          }
       }
          
       // 포인트샵 물품구매성공시 memdata에 구매횟수 +1 만드는 누적포인트 올려주는 메서드
       public void pointQuUpdate(int price, String id){
           Connection conn = null;
           PreparedStatement pstmt = null;
           
           try {
              conn = getConnection();
              String sql = "update memData set memBuyCount=memBuyCount+1,memBuyPoint=memBuyPoint+? where memId=?"; 
              pstmt = conn.prepareStatement(sql);
              pstmt.setInt(1, price);
              pstmt.setString(2, id);
              int re = pstmt.executeUpdate();
              System.out.println("pointQuUpdate잘되면 1 안되면 0 : " + re );
              
           }catch(Exception e){
              e.printStackTrace();
           }finally {
              if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
              if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
           }
        } 
         
       
       
       // 레벨업 하는 메서드
       public void LevelUp(String id) {
          Connection conn = null;
           PreparedStatement pstmt = null;
           try {
              conn = getConnection();
              String sql = "update memData set memLevel=memLevel+1 where memId=?"; 
              pstmt = conn.prepareStatement(sql);
              pstmt.setString(1, id);
              int complete = pstmt.executeUpdate();
              System.out.println("level업 하면 1뜸 : " + complete );
              
           }catch(Exception e){
              e.printStackTrace();
           }finally {
              if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
              if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
           }   
       } // LevelUp
          
       
       
     //멤버의 봉사진행여부 변경에 따른 memDate - memVolTime 값 update
       public void updateMemVolTime(String memId, int time, int memVolCount) {
          System.out.println("memVolTime update 메서드 들어옴");
          int result = 0;
          Connection conn = null;
           PreparedStatement pstmt = null;
           try {
              System.out.println("try 입장~");
              conn = getConnection();
              String sql = "update memData set memVolTime=memVolTime+?, memVolCount=memVolCount+? where memId=?"; 
              pstmt = conn.prepareStatement(sql);
              pstmt.setInt(1, time);
              pstmt.setInt(2, memVolCount);
              pstmt.setString(3, memId);
              result = pstmt.executeUpdate();
              System.out.println("sql 날림");
              System.out.println("memTime update 실행완료(1이면 ok) : " + result );
              
           }catch(Exception e){
              e.printStackTrace();
           }finally {
              if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
              if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
           }   
       }
       
       
       
       //멤버의 봉사진행여부 변경에 따른 memDate - memVolTime 값 update (빼기 - 승인 취소)
       public void updateMemVolTimeCancle(String memId, int time, int memVolCount) {
          System.out.println("memVolTime update 메서드 들어옴");
          int result = 0;
          Connection conn = null;
          PreparedStatement pstmt = null;
          try {
             System.out.println("try 입장~");
             conn = getConnection();
             String sql = "update memData set memVolTime=memVolTime-?, memVolCount=memVolCount-? where memId=?"; 
             pstmt = conn.prepareStatement(sql);
             pstmt.setInt(1, time);
             pstmt.setInt(2, memVolCount);
             pstmt.setString(3, memId);
             result = pstmt.executeUpdate();
             System.out.println("sql 날림");
             System.out.println("memTime update 실행완료(1이면 ok) : " + result );
             
          }catch(Exception e){
             e.printStackTrace();
          }finally {
             if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
             if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
          }   
       }
       
       
       public void insertRouletteTryCount(String memId) {
    	      Connection conn = null;
    	      PreparedStatement pstmt = null;
    	      
    	      try {
    	         conn = getConnection();
    	   
    	         String sql = "insert into rouletteTryCount values(?,?,?,sysdate)"; // 2개 sysdate
    	         pstmt = conn.prepareStatement(sql);
    	         pstmt.setString(1, memId);
    	         pstmt.setInt(2, 0);
    	         pstmt.setInt(3, 0);
    	         int result =pstmt.executeUpdate();
    	         System.out.println(" rouletteTryCount에 데이터잘들어가면 1뜸 : " + result);
    	      } catch (Exception e) {
    	         e.printStackTrace();
    	      }finally {
    	         if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
    	         if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
    	      }            
    	   }
    	      
    	         // 7월 29일
    	      public void rouletteCount (String id, Date today) {
    	         System.out.println("출석 포인트 메서드 실행");
    	         Connection conn = null;
    	         PreparedStatement pstmt = null;
    	         int countresult = 0;  // 카운트 업데이트한 결과
    	         int dateresult = 0;  // 날짜 업데이트한 결과
    	         
    	         try {
    	            conn = getConnection();
    	            String sql = "update rouletteTryCount set tryCount=tryCount+1 where memId=?";
    	            pstmt = conn.prepareStatement(sql);
    	            pstmt.setString(1, id);
    	            
    	            countresult = pstmt.executeUpdate();
    	            
    	            System.out.println("출석 count update : " + countresult);
    	               if(countresult != 0) {
    	                  sql = "update rouletteTryCount set memLastVisitDay=? where memId=?";
    	                  pstmt = conn.prepareStatement(sql);
    	                  pstmt.setDate(1, today);
    	                  pstmt.setString(2, id);
    	                  dateresult = pstmt.executeUpdate();
    	                  System.out.println("출석일수 update : " + countresult + "날짜 update : " + dateresult);
    	               }
    	         }catch(Exception e) {
    	            e.printStackTrace();
    	         }finally {
    	               if(pstmt != null) try { pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
    	               if(conn != null) try { conn.close(); }catch(SQLException e) { e.printStackTrace(); }
    	         }
    	         
    	      }          
    	      // 7월 29일 아이디값 주면 도박 남은 카운트 가져오기
    	            public int getRouletteTryCount(String id) {
    	                  int getRouletteTryCount = 0;
    	                  Connection conn = null; 
    	                  PreparedStatement pstmt = null; 
    	                  ResultSet rs = null; 
    	                  try {
    	                     conn = getConnection();
    	                     String sql = "select tryCount from rouletteTryCount where memId = ?"; 
    	                     pstmt = conn.prepareStatement(sql);
    	                     pstmt.setString(1, id);
    	                     rs = pstmt.executeQuery();
    	                     if(rs.next()) {
    	                        getRouletteTryCount = rs.getInt(1);
    	                       
    	                     }
    	                  }catch(Exception e) {
    	                     e.printStackTrace();
    	                  }finally {
    	                     if(rs != null) try { rs.close(); }catch(SQLException e) { e.printStackTrace(); }
    	                     if(pstmt != null) try { pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
    	                     if(conn != null) try { conn.close(); }catch(SQLException e) { e.printStackTrace(); }
    	                  }      
    	                  return getRouletteTryCount;
    	               }       
    	            // 7월 29일 도박카운트 -1 하는 메서드
    	             public void updateRouletteTryCount(String id) {
    	                 Connection conn = null;
    	                 PreparedStatement pstmt = null;
    	                 try {
    	                    System.out.println("try 입장~");
    	                    conn = getConnection();
    	                    String sql = "update rouletteTryCount set tryCount=tryCount-1 where memId=?"; 
    	                    pstmt = conn.prepareStatement(sql);
    	                    pstmt.setString(1, id);
    	                    pstmt.executeUpdate();
    	                    
    	                 }catch(Exception e){
    	                    e.printStackTrace();
    	                 }finally {
    	                    if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
    	                    if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
    	                 }   
    	              }
    	             
    	             // 8월 1일 봉사 도박 카운트 +1
    	             public void VolRouletteCount (String id) {
    	                Connection conn = null;
    	                PreparedStatement pstmt = null;
    	                
    	                try {
    	                   conn = getConnection();
    	                   String sql = "update rouletteTryCount set volTryCount=volTryCount+1 where memId=?";
    	                   pstmt = conn.prepareStatement(sql);
    	                   pstmt.setString(1, id);
    	                   
    	                   pstmt.executeUpdate();

    	                }catch(Exception e) {
    	                   e.printStackTrace();
    	                }finally {
    	                      if(pstmt != null) try { pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
    	                      if(conn != null) try { conn.close(); }catch(SQLException e) { e.printStackTrace(); }
    	                }
    	                
    	             }     
    	             // 8월 1일 봉사 도박 카운트 횟수 불러오기
    	                public int getRouletteVolTryCount(String id) {
    	                      int getRouletteVolTryCount = 0;
    	                      Connection conn = null; 
    	                      PreparedStatement pstmt = null; 
    	                      ResultSet rs = null; 
    	                      try {
    	                         conn = getConnection();
    	                         String sql = "select volTryCount from rouletteTryCount where memId = ?"; 
    	                         pstmt = conn.prepareStatement(sql);
    	                         pstmt.setString(1, id);
    	                         rs = pstmt.executeQuery();
    	                         if(rs.next()) {
    	                            getRouletteVolTryCount = rs.getInt(1);
    	                           
    	                         }
    	                      }catch(Exception e) {
    	                         e.printStackTrace();
    	                      }finally {
    	                         if(rs != null) try { rs.close(); }catch(SQLException e) { e.printStackTrace(); }
    	                         if(pstmt != null) try { pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
    	                         if(conn != null) try { conn.close(); }catch(SQLException e) { e.printStackTrace(); }
    	                      }      
    	                      return getRouletteVolTryCount;
    	                   }    
    	                 public void updateRouletteVolTryCount(String id,int point) {
    	                     Connection conn = null;
    	                     PreparedStatement pstmt = null;
    	                     try {
    	                        System.out.println("try 입장~");
    	                        conn = getConnection();
    	                        String sql = "update rouletteTryCount set VoltryCount=VolTryCount-1 where memId=?"; 
    	                        pstmt = conn.prepareStatement(sql);
    	                        pstmt.setString(1, id);
    	                        pstmt.executeUpdate();
    	                        sql = "update memData set memPoint=memPoint+? where memId=?";
    	                        pstmt = conn.prepareStatement(sql);
    	                        pstmt.setInt(1, point);
    	                        pstmt.setString(2, id);
    	                        pstmt.executeUpdate();
    	                        
    	                     }catch(Exception e){
    	                        e.printStackTrace();
    	                     }finally {
    	                        if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
    	                        if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
    	                     }   
    	                  }
       
	   
}
