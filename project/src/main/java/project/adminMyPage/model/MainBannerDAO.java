package project.adminMyPage.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import project.volPage.model.VolBoardDTO;

public class MainBannerDAO {
	
	//커넥션
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}	
	
	
	//1. 이미지 번호 주면 해당 이미지 가져오는 메서드
    public MainBannerDTO getMainImg(int mainImgNo) {
       System.out.println("getMainImg메서드 실행");
       MainBannerDTO main = null;
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       try {
          conn = getConnection();
          String sql = "select * from mainBanner where mainImgNo=?";
          pstmt = conn.prepareStatement(sql);
          pstmt.setInt(1, mainImgNo);
          
          rs = pstmt.executeQuery();
          if(rs.next()) {
        	  main = new MainBannerDTO();
             main.setMainBanImg(rs.getString("mainBanImg"));
          
          }
       }catch (Exception e) {
          e.printStackTrace();
       }finally {
           if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
       }
       return main;
    }
 
    
    // 2.이미지 삽입하는 메서드
    public int insetImg(MainBannerDTO main) {
    	Connection conn = null; 
		PreparedStatement pstmt = null; 
		int insertresult = 0;
		try {
			conn = getConnection();
			String sql = "insert into mainBanner(mainImgNo, mainBanImg)";
			sql += " values(mainImg_seq.nextval, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, main.getMainBanImg());
			
			insertresult = pstmt.executeUpdate();
			System.out.println("사진업로드 완료");
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return insertresult;
    	
    }
    
    
    
    
    

	//3. 이미지 업데이트하는 메서드
    public int updateMainImg(MainBannerDTO main){
    	System.out.println("updateMainImg 메서드 들어옴");
    	int result = 0;
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	try {
    		System.out.println("updateMainImg 메서드 try 들어옴");
    		conn = getConnection();
    		String sql = "update mainBanner set mainBanImg=? where mainImgNo=?";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, main.getMainBanImg());
    		pstmt.setInt(2, main.getMainImgNo());
    		
    		result = pstmt.executeUpdate();
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    	}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
    	}
    	System.out.println("메인 이미지 result = " + result);
    	return result;
    }
    
    
    
	
    // 수정전
    // 전체 이미지 가져오는 메서드
    public List<MainBannerDTO> getMainImgAll() {
    	List<MainBannerDTO> mainList = null;
    	Connection conn = null;
    	 PreparedStatement pstmt = null;
         ResultSet rs = null;
    	try {
    		conn = getConnection();
    		String sql = "select * from mainBanner";
    		pstmt = conn.prepareStatement(sql);
    		rs = pstmt.executeQuery();
    		if(rs.next()) {
    			mainList = new ArrayList<MainBannerDTO>();
    			do {
    				MainBannerDTO main = new MainBannerDTO();
    				main = new MainBannerDTO();
    				main.setMainImgNo(rs.getInt("mainImgNo"));
    				main.setMainBanImg(rs.getString("mainBanImg"));
    				mainList.add(main);
    				
    			}while(rs.next());
    		}
    	}catch (Exception e) {
            e.printStackTrace();
        }finally {
           if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
           if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
           if(rs!=null)try {rs.close();}catch(Exception e){e.printStackTrace();}
        }   
    	return mainList;
    }
    
    
    
    // 수정 후
    // 전체 이미지만 가져오는 메서드
    public List<String> getMainImgAllImgName() {
    	List<String> mainList = null;
    	Connection conn = null;
    	 PreparedStatement pstmt = null;
         ResultSet rs = null;
    	try {
    		conn = getConnection();
    		String sql = "select mainBanImg from mainBanner";
    		pstmt = conn.prepareStatement(sql);
    		rs = pstmt.executeQuery();
    		if(rs.next()) {
    			mainList = new ArrayList<String>();
    			do {
    				String main = rs.getString("mainBanImg");
    				mainList.add(main);
    				
    			}while(rs.next());
    		}
    	}catch (Exception e) {
            e.printStackTrace();
        }finally {
           if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
           if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
           if(rs!=null)try {rs.close();}catch(Exception e){e.printStackTrace();}
        }   
    	return mainList;
    }
    
    
    
    
 // 이미지 수 리턴
 		 public int getMainImgCount() {
 			int count = 0;
 			Connection conn = null;
 			PreparedStatement pstmt = null;
 			ResultSet rs = null;
 			try {
 				conn = getConnection();
 				String sql = "select count(*) from mainBanner";
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
 			System.out.println("메인 배너 이미지 수 : " + count);
 			return count; 
 		 }
 	   
    
    
         // 7월 27일 이재훈
         public int insetMainBan1(MainBannerDTO main) {
            Connection conn = null; 
            PreparedStatement pstmt = null; 
            int insertresult = 0;
            try {
               conn = getConnection();
               String sql = "delete from mainBan1";
               pstmt = conn.prepareStatement(sql);
               int delete = pstmt.executeUpdate();
      
               sql = "insert into mainBan1 values(?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, main.getMainBanImg());
                insertresult = pstmt.executeUpdate();
                System.out.println("삭제 후 이미지 잫넣으면 1 떠야함" +insertresult );
            }catch(Exception e) {
               e.printStackTrace();
            }finally {
               if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
               if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
            }
            return insertresult;
            
         }       
         public int insetMainBan2(MainBannerDTO main) {
            Connection conn = null; 
            PreparedStatement pstmt = null; 
            int insertresult = 0;
            try {
               conn = getConnection();
               String sql = "delete from mainBan2";
               pstmt = conn.prepareStatement(sql);
               int delete = pstmt.executeUpdate();
               
               sql = "insert into mainBan2 values(?)";
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, main.getMainBanImg());
               insertresult = pstmt.executeUpdate();
               System.out.println("삭제 후 이미지 잫넣으면 1 떠야함" +insertresult );
            }catch(Exception e) {
               e.printStackTrace();
            }finally {
               if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
               if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
            }
            return insertresult;
            
         }     
         public int insetMainBan3(MainBannerDTO main) {
            Connection conn = null; 
            PreparedStatement pstmt = null; 
            int insertresult = 0;
            try {
               conn = getConnection();
               String sql = "delete from mainBan3";
               pstmt = conn.prepareStatement(sql);
               int delete = pstmt.executeUpdate();
               
               sql = "insert into mainBan3 values(?)";
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, main.getMainBanImg());
               insertresult = pstmt.executeUpdate();
               System.out.println("삭제 후 이미지 잫넣으면 1 떠야함" +insertresult );
            }catch(Exception e) {
               e.printStackTrace();
            }finally {
               if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
               if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
            }
            return insertresult;
            
         }     
         // 메인 배너 이미지1번 불러오기
         
         
        public String callMainBan1() {
             String callMainBan1 = null;
             Connection conn = null; 
             PreparedStatement pstmt = null;
              ResultSet rs = null;
            try {
               conn = getConnection();
               String sql = "select * from mainBan1";
               pstmt = conn.prepareStatement(sql);
               rs = pstmt.executeQuery();
               if(rs.next()) {
                  callMainBan1 = rs.getString(1);
               }
            }catch (Exception e) {
                 e.printStackTrace();
             }finally {
                if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
                if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
                if(rs!=null)try {rs.close();}catch(Exception e){e.printStackTrace();}
             }   
            return callMainBan1;
         }
     // 메인 배너 이미지2번 불러오기
        public String callMainBan2() {
           String callMainBan2 = null;
           Connection conn = null; 
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           try {
              conn = getConnection();
              String sql = "select * from mainBan2";
              pstmt = conn.prepareStatement(sql);
              rs = pstmt.executeQuery();
              if(rs.next()) {
                 callMainBan2 = rs.getString(1);
              }
           }catch (Exception e) {
              e.printStackTrace();
           }finally {
              if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
              if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
              if(rs!=null)try {rs.close();}catch(Exception e){e.printStackTrace();}
           }   
           return callMainBan2;
        }
     // 메인 배너 이미지1번 불러오기
        public String callMainBan3() {
           String callMainBan3 = null;
           Connection conn = null; 
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           try {
              conn = getConnection();
              String sql = "select * from mainBan3";
              pstmt = conn.prepareStatement(sql);
              rs = pstmt.executeQuery();
              if(rs.next()) {
                 callMainBan3 = rs.getString(1);
              }
           }catch (Exception e) {
              e.printStackTrace();
           }finally {
              if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
              if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
              if(rs!=null)try {rs.close();}catch(Exception e){e.printStackTrace();}
           }   
           return callMainBan3;
        }
     
	
	

}
