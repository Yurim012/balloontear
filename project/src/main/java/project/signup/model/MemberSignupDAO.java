package project.signup.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class MemberSignupDAO {


   // 커넥션 만들어 리턴해주는 메서드 
   private Connection getConnection() throws NamingException, SQLException {
      Context ctx = new InitialContext(); 
      Context env = (Context)ctx.lookup("java:comp/env"); 
      DataSource ds = (DataSource)env.lookup("jdbc/orcl");
      return ds.getConnection(); 
   }

   //회원가입메서드
   public void insertMember(MemberSignupDTO member) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      
      try {
         conn = getConnection();
   
         String sql = "insert into memberSignup values(?,?,?,?,?,?,?,?,?,?)";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, member.getMemId());
         pstmt.setString(2, member.getMemPw());
         pstmt.setString(3, member.getMemName());
         pstmt.setString(4, member.getMemEmail());
         pstmt.setString(5, member.getMemTel());
         pstmt.setString(6, member.getMemAd());
         pstmt.setString(7, member.getMemPhoto());
         pstmt.setString(8, member.getMemIcon());
         pstmt.setInt(9, member.getMemStatus());
         pstmt.setString(10, member.getMemCategory());
         
         int result =pstmt.executeUpdate();
         System.out.println(" 회원 가입 잘되면 1뜸 : " + result);
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
         if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
      }
   }
   
   
   
   // 아이디 비번 check 메서드
    public int idPwCheck(String id, String pw) {          
       System.out.println("아뒤비번 체크 메서드실행");
       int result = -1; // '아이디가 없다'값으로 초기화  
       Connection conn = null; 
       PreparedStatement pstmt = null; 
       ResultSet rs = null; 
       try {
          conn = getConnection();            
          String sql = "select memId from memberSignup where memId=?"; 
          pstmt = conn.prepareStatement(sql);
          pstmt.setString(1, id);            
          rs = pstmt.executeQuery();  
          System.out.println("아뒤비번 체크 메서드실행");
          
          if(rs.next()) {               
             sql = "select count(*) from memberSignup where memId=? and memPw=?";
             pstmt = conn.prepareStatement(sql); 
             pstmt.setString(1, id);
             pstmt.setString(2, pw);
             
             rs = pstmt.executeQuery();
             if(rs.next()) {                  
                result = rs.getInt(1); // 비번맞으면 1, 안맞으면 0 
                System.out.println("비번맞으면 1 :" + result);
                System.out.println("비번틀리면 0 :" + result);
             }
          }            
       }catch(Exception e) {
          e.printStackTrace();
       }finally {
          if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
          if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
          if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
       }
       return result; 
    }
    
    
    
    // 이름, 전화번호 check 메서드
    public int getNameTelCheck(String name, String tel) {          
        System.out.println("getNameTelCheck메서드 실행");
        int result = -1; // '이름이 없다'값으로 초기화  
        Connection conn = null; 
        PreparedStatement pstmt = null; 
        ResultSet rs = null; 
        try {
           conn = getConnection();            
           System.out.println("try 문 진입");
           System.out.println(name);
           String sql = "select memName from memberSignup where memName = ?"; 
           pstmt = conn.prepareStatement(sql);
           pstmt.setString(1, name);            
           rs = pstmt.executeQuery();  
           if(rs.next()) {               
        	   String id = rs.getString(1);
        	   System.out.println("이름 검색 결과 있음: " + id);
        	   
              sql = "select count(*) from memberSignup where memName=? and memTel=?";
              pstmt = conn.prepareStatement(sql); 
              pstmt.setString(1, name);
              pstmt.setString(2, tel);
              
              rs = pstmt.executeQuery();
              if(rs.next()) {                  
                 result = rs.getInt(1); // 번호맞으면 1, 안맞으면 0 
              }
           }            
        }catch(Exception e) {
           e.printStackTrace();
        }finally {
           if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
           if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
           if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
        }
        return result; 
     }
    
    
    
    
    // 이름, 전화번호 주고 ID 값 가져오는 메서드 
    public String getMemId(String name, String tel) {          
        System.out.println("getMemId 메서드 실행");
        String id = null; // '이름이 없다'값으로 초기화  
        Connection conn = null; 
        PreparedStatement pstmt = null; 
        ResultSet rs = null; 
        try {
           conn = getConnection();            
           String sql = "select memId from memberSignup where memName=? and memTel=?";
              pstmt = conn.prepareStatement(sql); 
              pstmt.setString(1, name);
              pstmt.setString(2, tel);
              rs = pstmt.executeQuery();
              if(rs.next()) {                  
                 id = rs.getString(1); // 번호맞으면 1, 안맞으면 0 
              }
        }catch(Exception e) {
           e.printStackTrace();
        }finally {
           if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
           if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
           if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
        }
        return id; 
     }
    
    
    
    // 이름, 전화번호, 아이디 체크 메서드
    public int getpwForCheck(String name, String tel, String id) {          
        System.out.println("getpwForCheck메서드 실행");
        // 이름 없다 : -2 // 전화번호 없다 : -1 // 아이디 없다 : 0 // 세개다 맞다 : 1
        int result = -2;   // 이름 없다
        Connection conn = null; 
        PreparedStatement pstmt = null; 
        ResultSet rs = null; 
        try {
           conn = getConnection();            
           System.out.println("try 문 진입");
           System.out.println(name);
           String sql = "select memName from memberSignup where memName = ?"; 
           pstmt = conn.prepareStatement(sql);
           pstmt.setString(1, name);            
           rs = pstmt.executeQuery();  
           if(rs.next()) {               
        	   String memName = rs.getString(1);
        	   System.out.println("이름 검색 결과 있음: " + memName);
        	   
              sql = "select memTel from memberSignup where memName=? and memTel=?";
              pstmt = conn.prepareStatement(sql); 
              pstmt.setString(1, name);
              pstmt.setString(2, tel);
              rs = pstmt.executeQuery();
              if(rs.next()) {         
            	String memtel = rs.getString(1);
           	    System.out.println("전화번호 검색 결과 있음: " + memtel);
           	    
           	    sql = "select Count(*) from memberSignup where memName=? and memTel=? and memId=?";
	           	 pstmt = conn.prepareStatement(sql); 
	             pstmt.setString(1, name);
	             pstmt.setString(2, tel);
	             pstmt.setString(3, id);
	             rs = pstmt.executeQuery();
	             if(rs.next()) {
	            	 result = rs.getInt(1); // 세개다 맞으면 1, 안맞으면 0 
	             }else {
	            	 System.out.println("아이디 일치하지 않음");
	                 result = 0; // 세개다 맞으면 1, 안맞으면 0  
	                 System.out.println(result);
	             }
              }else {
            	  result = -1;  // 전화번호 없으면 -1;
              }
           }            
        }catch(Exception e) {
           e.printStackTrace();
        }finally {
           if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
           if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
           if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
        }
        return result; 
     }
    
    
    // 비밀번호 찾기 메서드 
    public String getMemPw(String name, String tel, String id) {          
        System.out.println("getMemPw 메서드 실행");
        String pw = null; 
        Connection conn = null; 
        PreparedStatement pstmt = null; 
        ResultSet rs = null; 
        try {
           conn = getConnection();            
           String sql = "select memPw from memberSignup where memName=? and memTel=? and memId=?";
              pstmt = conn.prepareStatement(sql); 
              pstmt.setString(1, name);
              pstmt.setString(2, tel);
              pstmt.setString(3, id);
              rs = pstmt.executeQuery();
              if(rs.next()) {                  
                 pw = rs.getString(1);
                 System.out.println("pw********************** :" +  pw);
              }
        }catch(Exception e) {
           e.printStackTrace();
        }finally {
           if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
           if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
           if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
        }
        return pw; 
     }
    
    
    
    
    
    // id 중복체크 메서드
    
    public boolean confirmId(String id) {
       boolean result = false;
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       
       try {
          conn = getConnection();
          int count =0;
          String sql = "select count(*) from memberSignup where memId=?";
          pstmt = conn.prepareStatement(sql);
          System.out.println(id);
          pstmt.setString(1, id);
          
          rs = pstmt.executeQuery();
          
          if(rs.next()) {
             count = rs.getInt("count(*)");   
             System.out.println("count : "+ count);
             if(count == 1) {
                result = true;
                System.out.println("");
             }
          }

       } catch (Exception e) {
          e.printStackTrace();
       }finally {
          if(rs != null)try {conn.close();}catch(Exception e){e.printStackTrace();}
          if(pstmt != null)try {conn.close();}catch(Exception e){e.printStackTrace();}
          if(conn != null)try {conn.close();}catch(Exception e){e.printStackTrace();}   
       }
       return result; // result == true 이미 존재, result == false 존재하지않는다.
    }   
    
    
    
    
    
    // 아이디값주고 카테고리 찾아오기
    public String categorySeach(String id) {
       String category = null;
        Connection conn = null; 
        PreparedStatement pstmt = null; 
        ResultSet rs = null; 
      try {
         conn = getConnection();
         String sql = "select memCategory from memberSignup where memId=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         rs= pstmt.executeQuery();
         if(rs.next()) {
            category =rs.getString(1);
         }      
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
         if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
         if(rs!=null)try {rs.close();}catch(Exception e){e.printStackTrace();}
      }           
       return category;
    }
   
    
    
    
    // 아이디값주고 사용자 이름 찾아오기
    public String getName(String id) {
       String userName = null;
        Connection conn = null; 
        PreparedStatement pstmt = null; 
        ResultSet rs = null; 
      try {
         conn = getConnection();
         String sql = "select memName from memberSignup where memId=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         rs= pstmt.executeQuery();
         if(rs.next()) {
            userName =rs.getString(1);
         }      
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
         if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
         if(rs!=null)try {rs.close();}catch(Exception e){e.printStackTrace();}
      }           
       return userName;
    }
   
    
    
    
    
    // 아이디 주면 회원가입db에 들어가있는 데이터 가져오는 메서드
    public MemberSignupDTO getMember(String id) {
       MemberSignupDTO member =null;
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      try {
         conn = getConnection();
         String sql = "select * from memberSignup where memId=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         rs= pstmt.executeQuery();
         if(rs.next()) {
            member = new MemberSignupDTO();
            member.setMemId(id);
            member.setMemPw(rs.getString("memPw"));
            member.setMemName(rs.getString("memName"));
            member.setMemEmail(rs.getString("memEmail"));
            member.setMemTel(rs.getString("memTel"));
            member.setMemAd(rs.getString("memAd"));
            member.setMemPhoto(rs.getString("memPhoto"));
            member.setMemIcon(rs.getString("memIcon"));
            member.setMemStatus(rs.getInt("memStatus"));
            member.setMemCategory(rs.getString("memCategory"));
         }      
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
         if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
         if(rs!=null)try {rs.close();}catch(Exception e){e.printStackTrace();}
      }   
      return member;
   }
    
    
    
    // 아이디 주면 회원가입db에 들어가있는 데이터 가져오는 메서드(마이페이지에서 봉사현황에 뿌릴)
    public MemberSignupDTO getMemberMypage(String id) {
    	MemberSignupDTO member =null;
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	
    	try {
    		conn = getConnection();
    		String sql = "select * from memberSignup where memName=?";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, id);
    		rs= pstmt.executeQuery();
    		if(rs.next()) {
    			member = new MemberSignupDTO();
    			member.setMemId(id);
    			member.setMemPw(rs.getString("memPw"));
    			member.setMemName(rs.getString("memName"));
    			member.setMemEmail(rs.getString("memEmail"));
    			member.setMemTel(rs.getString("memTel"));
    			member.setMemAd(rs.getString("memAd"));
    			member.setMemPhoto(rs.getString("memPhoto"));
    			member.setMemIcon(rs.getString("memIcon"));
    			member.setMemStatus(rs.getInt("memStatus"));
    			member.setMemCategory(rs.getString("memCategory"));
    		}      
    	} catch (Exception e) {
    		e.printStackTrace();
    	}finally {
    		if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
    		if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
    		if(rs!=null)try {rs.close();}catch(Exception e){e.printStackTrace();}
    	}   
    	return member;
    }
    
   
    // 아이디값주고 사용자 전화번호 찾아오기
    public String getPhone(String id) {
       String userPhone = null;
        Connection conn = null; 
        PreparedStatement pstmt = null; 
        ResultSet rs = null; 
      try {
         conn = getConnection();
         String sql = "select memTel from memberSignup where memId=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         rs= pstmt.executeQuery();
         if(rs.next()) {
        	 userPhone = rs.getString(1);
         }      
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
         if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
         if(rs!=null)try {rs.close();}catch(Exception e){e.printStackTrace();}
      }           
       return userPhone;
    }
    
    // 아이디값주고 사용자 이메일 찾아오기
    public String getEmail(String id) {
    	String userEmail = null;
    	Connection conn = null; 
    	PreparedStatement pstmt = null; 
    	ResultSet rs = null; 
    	try {
    		conn = getConnection();
    		String sql = "select memEmail from memberSignup where memId=?";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, id);
    		rs= pstmt.executeQuery();
    		if(rs.next()) {
    			userEmail = rs.getString(1);
    		}      
    	} catch (Exception e) {
    		e.printStackTrace();
    	}finally {
    		if(conn!=null)try {conn.close();}catch(Exception e){e.printStackTrace();}
    		if(pstmt!=null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
    		if(rs!=null)try {rs.close();}catch(Exception e){e.printStackTrace();}
    	}           
    	return userEmail;
    }
    
    
    
    // 회원정보 수정 메서드
    public int userInfoModify(MemberSignupDTO member) {
    	int result = 0;
    	Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "update memberSignup set memPw=?, memName=?, memEmail=?, memTel=?, memAd=?, memPhoto=? where memId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMemPw());
			pstmt.setString(2, member.getMemName());
			pstmt.setString(3, member.getMemEmail());
			pstmt.setString(4, member.getMemTel());
			pstmt.setString(5, member.getMemAd());
			pstmt.setString(6, member.getMemPhoto());
			pstmt.setString(7, member.getMemId());
			result = pstmt.executeUpdate();
			System.out.println("회원정보 수정 : " + result);
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close();} catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try { conn.close();} catch(SQLException e) {e.printStackTrace();}
		}
    	return result;
    }
    
    
    
    // 회원 탈퇴 메서드 (상태정보 수정)
    public void deleteUser(String id) {
    	int result = 0;
    	int zero = 0;
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	
    	try {
    		conn = getConnection();
    		String sql = "update memberSignup set memStatus=? where memId=?";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, zero);
    		pstmt.setString(2, id);
    		result = pstmt.executeUpdate();
    		System.out.println("회원 상태값 변경 : " +  result);
    	}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close();} catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try { conn.close();} catch(SQLException e) {e.printStackTrace();}
		}
    }
    
    
    
    // 회원 중지해제 메서드 (상태정보 수정)
    public void comBackUser(String id) {
       int result = 0;
       int one = 1;
       Connection conn = null;
       PreparedStatement pstmt = null;
       
       try {
          conn = getConnection();
          String sql = "update memberSignup set memStatus=? where memId=?";
          pstmt = conn.prepareStatement(sql);
          pstmt.setInt(1, one);
          pstmt.setString(2, id);
          result = pstmt.executeUpdate();
          System.out.println("회원 상태값 변경 : " +  result);
       }catch (Exception e) {
          e.printStackTrace();
       }finally {
          if(pstmt != null) try { pstmt.close();} catch(SQLException e) {e.printStackTrace();}
          if(conn != null) try { conn.close();} catch(SQLException e) {e.printStackTrace();}
       }
    }
     
    
    
}