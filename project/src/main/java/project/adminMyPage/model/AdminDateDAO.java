package project.adminMyPage.model;

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

import project.signup.model.MemberSignupDTO;



public class AdminDateDAO {
	

	   // 커넥션 만들어 리턴해주는 메서드 
	   private Connection getConnection() throws NamingException, SQLException {
	      Context ctx = new InitialContext(); 
	      Context env = (Context)ctx.lookup("java:comp/env"); 
	      DataSource ds = (DataSource)env.lookup("jdbc/orcl");
	      return ds.getConnection(); 
	   }
		
		// 1. 전체 회원 수 카운트 메서드
		 public int getMemCount() {
			System.out.println("회원 수 카운팅");
			int count = 0;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				String sql = "select count(*) from memberSignup";
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
			System.out.println("회원수 : " + count);
			return count; 
		 }
	   
	   
	   
		
	    // 2. 회원가입db에 들어가있는 회원 데이터 가져오는 메서드
	    public List<MemberSignupDTO> getAllMember(int startRow, int endRow) {
	    	System.out.println("회원 getAllmember메서드 실행");
	       List<MemberSignupDTO> memberList =null;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	    	  System.out.println("try 진입");
	         conn = getConnection();
	         String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from memberSignup order by memId desc) A) B "
						+ "where r >= ? and r <= ?";
	         System.out.println("첫번째 sql문 완료");
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, startRow);
	         pstmt.setInt(2, endRow);
	         rs= pstmt.executeQuery();
	         System.out.println("executeQury완료");
	         if(rs.next()) {
	        	 memberList = new ArrayList<MemberSignupDTO>();
	        	 System.out.println("if문 진입");
	        	 do {
	        		 MemberSignupDTO member = new MemberSignupDTO();
	        		 System.out.println("do while문 진입");
	        		 member = new MemberSignupDTO();
	        		 member.setMemId(rs.getString("memId"));
	        		 member.setMemPw(rs.getString("memPw"));
	        		 member.setMemName(rs.getString("memName"));
	        		 member.setMemEmail(rs.getString("memEmail"));
	        		 member.setMemTel(rs.getString("memTel"));
	        		 member.setMemAd(rs.getString("memAd"));
	        		 member.setMemPhoto(rs.getString("memPhoto"));
	        		 member.setMemIcon(rs.getString("memIcon"));
	        		 member.setMemStatus(rs.getInt("memStatus"));
	        		 member.setMemCategory(rs.getString("memCategory"));
	        		 memberList.add(member);
	        		 System.out.println("list 저장완료");
	        	 }while(rs.next());
	         }      
	      } catch (Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
	         if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
	         if(rs!=null)try {rs.close();}catch(Exception e){e.printStackTrace();}
	      }   
	      return memberList;
	   }
	    
	    
	  //3. 회원 아이디, 이름 검색한 결과의 총 개수
	  	public int getMemSearchCount(String sel, String search) {
	  		int count = 0; 
	  		Connection conn = null; 
	  		PreparedStatement pstmt = null; 
	  		ResultSet rs = null;
	  		try {
	  			conn = getConnection(); 
	  			String sql = "select count(*) from memberSignup where "+sel+" like '%"+search+"%'";
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
	    
	  	
	  	
	  	 //4. 상단 활동중, 활동 중지 회원 검색결과 카운트
	  	public int getMemStatusCount(String topSel, String topSelVal){
	  		int count = 0; 
	  		Connection conn = null; 
	  		PreparedStatement pstmt = null; 
	  		ResultSet rs = null;
	  		try {
	  			conn = getConnection(); 
	  			String sql = "select count(*) from memberSignup where "+topSel+" like '%"+topSelVal+"%'";
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
	    
	  	
	  	
	  	//5. 검색한 회원 목록 가져오는 메서드 
	    public List<MemberSignupDTO> getMemberSearch(int startRow, int endRow, String sel, String search) {
	    	System.out.println("getMemberSearch 메서드 실행");
	       List<MemberSignupDTO> memberList =null;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	    	  System.out.println("try 진입");
	         conn = getConnection();
	         String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from memberSignup where "+sel+" like '%"+search+"%'"
						+ " order by memName desc) A) B "
						+ "where r >= ? and r <= ?";
	         System.out.println("첫번째 sql문 완료");
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, startRow);
	         pstmt.setInt(2, endRow);
	         
	         rs= pstmt.executeQuery();
	         System.out.println("executeQury완료");
	         if(rs.next()) {
	        	 memberList = new ArrayList<MemberSignupDTO>();
	        	 System.out.println("if문 진입");
	        	 do {
	        		 MemberSignupDTO member = new MemberSignupDTO();
	        		 System.out.println("do while문 진입");
	        		 member = new MemberSignupDTO();
	        		 member.setMemId(rs.getString("memId"));
	        		 member.setMemPw(rs.getString("memPw"));
	        		 member.setMemName(rs.getString("memName"));
	        		 member.setMemEmail(rs.getString("memEmail"));
	        		 member.setMemTel(rs.getString("memTel"));
	        		 member.setMemAd(rs.getString("memAd"));
	        		 member.setMemPhoto(rs.getString("memPhoto"));
	        		 member.setMemIcon(rs.getString("memIcon"));
	        		 member.setMemStatus(rs.getInt("memStatus"));
	        		 member.setMemCategory(rs.getString("memCategory"));
	        		 memberList.add(member);
	        		 System.out.println("list 저장완료");
	        	 }while(rs.next());
	         }      
	      } catch (Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
	         if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
	         if(rs!=null)try {rs.close();}catch(Exception e){e.printStackTrace();}
	      }   
	      return memberList;
	   }
	    
	    
	    
	    //6. 회원 상태 검색 회원 목록 가져오기
	    public List<MemberSignupDTO> getMemberStatus(int startRow, int endRow, String topSel, String topSearch) {
	    	System.out.println("getMemberSearch 메서드 실행");
	       List<MemberSignupDTO> memberList =null;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	    	  System.out.println("try 진입");
	         conn = getConnection();
	         String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from memberSignup where "+topSel+" like '%"+topSearch+"%'"
						+ " order by memName desc) A) B "
						+ "where r >= ? and r <= ?";
	         System.out.println("첫번째 sql문 완료");
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, startRow);
	         pstmt.setInt(2, endRow);
	         
	         rs= pstmt.executeQuery();
	         System.out.println("executeQury완료");
	         if(rs.next()) {
	        	 memberList = new ArrayList<MemberSignupDTO>();
	        	 System.out.println("if문 진입");
	        	 do {
	        		 MemberSignupDTO member = new MemberSignupDTO();
	        		 System.out.println("do while문 진입");
	        		 member = new MemberSignupDTO();
	        		 member.setMemId(rs.getString("memId"));
	        		 member.setMemPw(rs.getString("memPw"));
	        		 member.setMemName(rs.getString("memName"));
	        		 member.setMemEmail(rs.getString("memEmail"));
	        		 member.setMemTel(rs.getString("memTel"));
	        		 member.setMemAd(rs.getString("memAd"));
	        		 member.setMemPhoto(rs.getString("memPhoto"));
	        		 member.setMemIcon(rs.getString("memIcon"));
	        		 member.setMemStatus(rs.getInt("memStatus"));
	        		 member.setMemCategory(rs.getString("memCategory"));
	        		 memberList.add(member);
	        		 System.out.println("list 저장완료");
	        	 }while(rs.next());
	         }      
	      } catch (Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
	         if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
	         if(rs!=null)try {rs.close();}catch(Exception e){e.printStackTrace();}
	      }   
	      return memberList;
	   }
	    

	//1. 이미지 번호 주면 해당 이미지 가져오는 메서드
    public AdminDateDTO getImg(int imgNo) {
       System.out.println("getImg메서드 실행");
       AdminDateDTO img = null;
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       try {
          conn = getConnection();
          String sql = "select * from adminData where mainPartImg=?";
          pstmt = conn.prepareStatement(sql);
          pstmt.setInt(1, imgNo);
          rs = pstmt.executeQuery();
          if(rs.next()) {
        	  img = new  AdminDateDTO();
        	 img.setImgNo(imgNo);
             img.setImg(rs.getString("img"));
          
          }
       }catch (Exception e) {
          e.printStackTrace();
       }finally {
           if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
            if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
       }
       return img;
    }
	  	
	    
	    
	    
	    
	// 메인 파트너 이미지 변경  imgNo = 1
	    public int mainPartImgModify(AdminDateDTO dto) {
	    	int result = 0;
	    	Connection conn = null;
	    	PreparedStatement pstmt = null;
	    	try {
	    		conn = getConnection();
	    		String sql = "update adminData set img=? where imgNo=?";
	    		pstmt = conn.prepareStatement(sql);
	    		pstmt.setString(1, dto.getImg());
	    		pstmt.setInt(2, 1);
	    		
	    		result = pstmt.executeUpdate();
	    		
	    	}catch(Exception e) {
	    		e.printStackTrace();
	    	}finally {
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	    	}
	    	System.out.println("메인 파트너 이미지 result = " + result);
	    	return result;
	    }
	
	    
	    
	 // 포인트샵 이미지 변경   imgNo = 2
	    public int pointShopImgModify(AdminDateDTO dto) {
	    	int result = 0;
	    	Connection conn = null;
	    	PreparedStatement pstmt = null;
	    	try {
	    		conn = getConnection();
	    		String sql = "update adminData set img=? where imgNo=?";
	    		pstmt = conn.prepareStatement(sql);
	    		pstmt.setString(1, dto.getImg());
	    		pstmt.setInt(2, 2);
	    		
	    		result = pstmt.executeUpdate();
	    		
	    	}catch(Exception e) {
	    		e.printStackTrace();
	    	}finally {
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	    	}
	    	System.out.println("포인트샵 이미지 result = " + result);
	    	return result;
	    }
	    
	    
	    
	    
	 // 소개이미지 변경    imgNo = 3
	    public int introImgModify(AdminDateDTO dto) {
	    	int result = 0;
	    	Connection conn = null;
	    	PreparedStatement pstmt = null;
	    	try {
	    		conn = getConnection();
	    		String sql = "update adminData set img=? where imgNo=?";
	    		pstmt = conn.prepareStatement(sql);
	    		pstmt.setString(1, dto.getImg());
	    		pstmt.setInt(2, 3);
	    		
	    		result = pstmt.executeUpdate();
	    		
	    	}catch(Exception e) {
	    		e.printStackTrace();
	    	}finally {
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	    	}
	    	System.out.println("소개이미지 이미지 result = " + result);
	    	return result;
	    }  
	    
		 
	    // 메인 이달의 스페셜 기프트 이미지 변경  imgNo = 4
	    public int mainGiftImgModify(AdminDateDTO dto) {
	    	int result = 0;
	    	Connection conn = null;
	    	PreparedStatement pstmt = null;
	    	try {
	    		conn = getConnection();
	    		String sql = "update adminData set img=? where imgNo=?";
	    		pstmt = conn.prepareStatement(sql);
	    		pstmt.setString(1, dto.getImg());
	    		pstmt.setInt(2, 4);
	    		
	    		result = pstmt.executeUpdate();
	    		
	    	}catch(Exception e) {
	    		e.printStackTrace();
	    	}finally {
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	    	}
	    	System.out.println("이달의 스페이셜 기프트 이미지 result = " + result);
	    	return result;
	    }  
	    
	
	

}
