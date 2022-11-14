package project.free.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import project.volPage.model.VolBoardDTO;

public class FreeBoardDAO {
		//커넥션
		private Connection getConnection() throws Exception {
			Context ctx = new InitialContext(); 
			Context env = (Context)ctx.lookup("java:comp/env");
			DataSource ds = (DataSource)env.lookup("jdbc/orcl");
			return ds.getConnection();
		}	
	
		//1.검색한 글의 총개수 
		public int getVolSearchCount(String sel, String search) {
			int count = 0; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select count(*) from freeBoard where "+sel+" like '%"+search+"%'";
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
		
		
		
		//2.검색한 글 목록 가져오는 메서드 
		public List<FreeBoardDTO> getVolSearch(int startRow, int endRow, String sel, String search) {
			List<FreeBoardDTO> freeList = null; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from freeBoard where "+sel+" like '%"+search+"%'"
						+ " order by boReg desc) A) B "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
					freeList = new ArrayList<FreeBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
					do {
						FreeBoardDTO freeArticle = new FreeBoardDTO(); 
						freeArticle.setBoNo(rs.getInt("boNo"));
						freeArticle.setMemId(rs.getString("memId"));
						freeArticle.setBoSubject(rs.getString("boSubject"));
						freeArticle.setBoContent(rs.getString("boContent"));
						freeArticle.setBoCategory(rs.getString("boCategory"));
						freeArticle.setBoImg(rs.getString("boImg"));
						freeArticle.setBoReg(rs.getTimestamp("boReg"));
						freeArticle.setPin(rs.getInt("pin"));
						freeList.add(freeArticle);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return freeList; 
		}//메서드 종료
	
		
		
		//3.상단 검색한 글의 총개수
		public int getVolTopSearchCount(String topSel, String topSelVal){
			int count = 0; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select count(*) from freeBoard where "+topSel+" like '%"+topSelVal+"%'";
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
		
		
		
		
		//4.상단 검색 글 목록 가져오기
		public List<FreeBoardDTO> getVolTopSearch(int startRow, int endRow, String topSel, String topSearch){
			List<FreeBoardDTO> freeList = null; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from freeBoard where "+topSel+" like '%"+topSearch+"%'"
						+ " order by boReg desc) A) B "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
					freeList = new ArrayList<FreeBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
					do {
						FreeBoardDTO freeArticle = new FreeBoardDTO(); 
						freeArticle.setBoNo(rs.getInt("boNo"));
						freeArticle.setMemId(rs.getString("memId"));
						freeArticle.setBoSubject(rs.getString("boSubject"));
						freeArticle.setBoContent(rs.getString("boContent"));
						freeArticle.setBoCategory(rs.getString("boCategory"));
						freeArticle.setBoImg(rs.getString("boImg"));
						freeArticle.setBoReg(rs.getTimestamp("boReg"));
						freeList.add(freeArticle);
						freeArticle.setPin(rs.getInt("pin"));
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return freeList; 
		}//메서드 종료
		
		
		//5.전체 글의 개수 카운팅 메서드 
				public int getVolCount() {
					System.out.println("카운팅");
					int count = 0; 
					Connection conn = null; 
					PreparedStatement pstmt = null; 
					ResultSet rs = null;
					try {
						conn = getConnection(); 
						String sql = "select count(*) from freeBoard";
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
				
				
		//6.해당 페이지에 띄워줄 글 가져오기 
				public List<FreeBoardDTO> getArticle(int startRow, int endRow) {
					System.out.println(1);
					List<FreeBoardDTO> freeList = null; 
					Connection conn = null; 
					PreparedStatement pstmt = null; 
					ResultSet rs = null;
					try { 
						System.out.println(2);
						conn = getConnection(); 
						String sql = "select B.* from (select rownum r, A.* from "
								+ "(select * from freeBoard order by pin desc, boReg desc) A) B "
								+ "where r >= ? and r <= ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, startRow);
						pstmt.setInt(2, endRow);
						rs = pstmt.executeQuery(); 
						System.out.println(3);
						if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
							freeList = new ArrayList<FreeBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
							do {
								FreeBoardDTO freeArticle = new FreeBoardDTO(); 
								freeArticle.setBoNo(rs.getInt("boNo"));
								freeArticle.setMemId(rs.getString("memId"));
								freeArticle.setBoSubject(rs.getString("boSubject"));
								freeArticle.setBoContent(rs.getString("boContent"));
								freeArticle.setBoCategory(rs.getString("boCategory"));
								freeArticle.setBoImg(rs.getString("boImg"));
								freeArticle.setBoReg(rs.getTimestamp("boReg"));
								freeArticle.setPin(rs.getInt("pin"));
								freeList.add(freeArticle);
							}while(rs.next());
						}
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
						if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
						if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
					}
					return freeList;
				}
		
		
				//7.글 작성
		        public void insertFreeArticle(FreeBoardDTO freeArticle) { 
		          System.out.println("자유게시판 insert 메서드 실행");
		          Connection conn = null; 
		          PreparedStatement pstmt = null; 
		          ResultSet rs = null;
		           try {
		              conn = getConnection(); 
		              System.out.println("자유게시판 try 실행");
		              
		              String sql = "insert into freeBoard(boNo, boSubject, memId, boContent, boCategory, boImg, boReg, pin) ";
		              sql +="values(freeBoard_seq.nextval, ?, ?, ?, ?, ?, sysdate, ?)";
		              pstmt = conn.prepareStatement(sql);
		              pstmt.setString(1, freeArticle.getBoSubject());
		              pstmt.setString(2, freeArticle.getMemId());
		              pstmt.setString(3, freeArticle.getBoContent());
		              pstmt.setString(4, freeArticle.getBoCategory());
		              pstmt.setString(5, freeArticle.getBoImg());
		              pstmt.setInt(6, freeArticle.getPin());
		              
		              	
		              int updateCount = pstmt.executeUpdate(); 
		              System.out.println("insert update count : " + updateCount);
		              System.out.println("자유게시판 글작성 memID : " + freeArticle.getMemId());
		        
		           }catch(Exception e) {
		              e.printStackTrace();
		           }finally {
		        	  if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
		              if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
		              if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		           }
		        }//메서드 종료
		
		
		        //공지면 pin 값 바꾸기 
		        public void updatePinVal() {
		          System.out.println("자유게시판 updatePintVal 메서드 실행");
		          Connection conn = null; 
		          PreparedStatement pstmt = null; 
		          ResultSet rs = null;
		          int notice = 1;
		          String not = "공지";
		          try {
		              conn = getConnection(); 
		              System.out.println("자유게시판 try 실행"); 
		              String sql = "update freeBoard set pin=? where boCategory=?";
		              pstmt = conn.prepareStatement(sql);
		              pstmt.setInt(1, notice);
		              pstmt.setString(2, not);
		              rs = pstmt.executeQuery();
		          }catch(Exception e) {
		        	  e.printStackTrace();
		          }finally {
		        	  if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
		              if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
		              if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		          } 
		        }//메서드 종료
				          
				          
		        
		        //8.게시글 1개 정보 가져오는 메서드
			      public FreeBoardDTO getOneFreeContent(int boNo) {
			         System.out.println("자유게시판 글 1개 가져오는 메서드 실행");
			         FreeBoardDTO freeArticle = null;
			         Connection conn = null;
			         PreparedStatement pstmt = null;
			         ResultSet rs = null;
			         try {
			            conn = getConnection();
			            String sql = "select * from freeBoard where boNo=?";
			            pstmt = conn.prepareStatement(sql);
			            pstmt.setInt(1, boNo);
			            
			            rs = pstmt.executeQuery();
			            if(rs.next()) {
			            	freeArticle = new FreeBoardDTO();
			            	freeArticle.setBoNo(rs.getInt("boNo"));
			            	freeArticle.setMemId(rs.getString("memId"));
			            	freeArticle.setBoSubject(rs.getString("boSubject"));
			            	freeArticle.setBoContent(rs.getString("boContent"));
							freeArticle.setBoCategory(rs.getString("boCategory"));
							freeArticle.setBoImg(rs.getString("boImg"));
							freeArticle.setBoReg(rs.getTimestamp("boReg"));
							freeArticle.setPin(rs.getInt("pin"));
			            }
			            
			            
			         }catch (Exception e) {
			            e.printStackTrace();
			         }finally {
			             if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			              if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			              if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			         }
			         return freeArticle;
			      }
		        
			      
			      //9.한개의 게시글 삭제하는 메서드
			      public int deleteOneFreeContent(int boNo) {
			    	  int result = 0;
			    	  Connection conn = null;
			    	  PreparedStatement pstmt = null;
			    	  
			    	  try {
			    		  conn = getConnection();
			    		  String sql ="delete from freeBoard where boNo=?";
			    		  pstmt = conn.prepareStatement(sql);
			    		  pstmt.setInt(1, boNo);
			    		  result = pstmt.executeUpdate();
			    	  }catch(Exception e) {
			    		  e.printStackTrace();
			    	  }finally {
			    		  if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			    		  if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			    	  }
			    	  return result;
			      }//메서드 종료
			
			
			    //10.봉사 게시글 수정하는 메서드
			      public int updateFreeArticle(FreeBoardDTO freeArticle) {
			        int result = 0;
			        Connection conn = null; 
			        PreparedStatement pstmt = null; 
			        ResultSet rs = null;
			        try {
			           conn = getConnection();
			           String sql = "update freeBoard set boCategory=?, boSubject=?, boContent=?, boImg=? where boNo=?";
			           pstmt = conn.prepareStatement(sql);
			           pstmt.setString(1, freeArticle.getBoCategory());
			           pstmt.setString(2, freeArticle.getBoSubject());
			           pstmt.setString(3, freeArticle.getBoContent());
			           pstmt.setString(4, freeArticle.getBoImg());
			           pstmt.setInt(5, freeArticle.getBoNo());
			         
			           
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
			      
			      
			      
		        
		
}
