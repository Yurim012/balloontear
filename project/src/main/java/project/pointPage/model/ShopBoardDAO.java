package project.pointPage.model;

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

import project.volPage.model.VolBoardDTO;

public class ShopBoardDAO {

	// 커넥션 만들어 리턴해주는 메서드 
	private Connection getConnection() throws NamingException, SQLException {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env"); 
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection(); 
	}
	
	//1. 글 작성 처리 메서드
	public void insertArticle(ShopBoardDTO shopArticle) {
		System.out.println("insert 메서드 실행");
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		
		try {
			conn = getConnection();          
			String sql ="insert into shopBoard(sNo, goodsName, content, shopImg, goodsStatus, goodsStock, price) values(shopBoard_seq.nextval,? ,? ,? ,? ,? ,? )";
			pstmt = conn.prepareStatement(sql);			
			pstmt.setString(1, shopArticle.getGoodsName());
			pstmt.setString(2, shopArticle.getContent());
			pstmt.setString(3, shopArticle.getShopImg());
			pstmt.setInt(4, shopArticle.getGoodsStatus());
			pstmt.setInt(5, shopArticle.getGoodsStock());
			pstmt.setInt(6, shopArticle.getPrice());
              
			int result = pstmt.executeUpdate(); 
			System.out.println("insert update count : " + result);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}

	//2. 전체 글의 개수 카운팅 메서드 
	public int getshopCount() {
		System.out.println("count");
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			String sql = "select count(*) from shopBoard ";    	   
			conn = getConnection(); 
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

	//3. 게시글 가져오기 (페이징처리 O) 	
	public List<ShopBoardDTO> getshoparticleList(int start, int end) {
		List<ShopBoardDTO> list = null; 
		Connection conn = null;
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from shopBoard order by sNo desc) A ) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				list = new ArrayList<ShopBoardDTO>();
				do {
					ShopBoardDTO shoparticle = new ShopBoardDTO(); 
					shoparticle.setsNo(rs.getInt("sNo"));
					shoparticle.setGoodsName(rs.getString("goodsName"));
					shoparticle.setContent(rs.getString("content"));
					shoparticle.setShopImg(rs.getString("shopImg"));
					shoparticle.setGoodsStatus(rs.getInt("goodsStatus"));
					shoparticle.setGoodsStock(rs.getInt("goodsStock"));
					shoparticle.setPrice(rs.getInt("price"));						
					list.add(shoparticle);
				}while(rs.next()); 
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		}
		return list; 
	}
	
	//4. 게시글 1개 정보 가져오는 메서드
	public ShopBoardDTO getOneShopContent(int sNo) {
		ShopBoardDTO shoparticle = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select * from shopBoard where sNo=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sNo);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				shoparticle = new ShopBoardDTO();
				shoparticle.setsNo(sNo);
				shoparticle.setGoodsName(rs.getString("goodsName"));
				shoparticle.setContent(rs.getString("content"));
				shoparticle.setShopImg(rs.getString("shopImg"));
				shoparticle.setGoodsStatus(rs.getInt("goodsStatus"));
				shoparticle.setGoodsStock(rs.getInt("goodsStock"));
				shoparticle.setPrice(rs.getInt("price"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return shoparticle;
	}	      
	
	//5. 한개의 게시글 삭제하는 메서드
	public int shopdeleteAtricle(int sNo) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();
			String sql = "delete from shopBoard where sNo = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sNo);
			result = pstmt.executeUpdate();			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try { pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try { conn.close();}catch(SQLException e) {e.printStackTrace();}
		}		
		return result;
	}
	
	//6. 포인트content 수정 메서드 
	public int updateShopArticle(ShopBoardDTO shopArticle){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "update shopBoard set goodsName=?, content=?, shopImg=?, goodsStatus=?, GoodsStock=?, Price=? where sNo=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, shopArticle.getGoodsName());
			pstmt.setString(2, shopArticle.getContent());
			pstmt.setString(3, shopArticle.getShopImg());
			pstmt.setInt(4, shopArticle.getGoodsStatus());
			pstmt.setInt(5, shopArticle.getGoodsStock());
			pstmt.setInt(6, shopArticle.getPrice());
			pstmt.setInt(7, shopArticle.getsNo());
			result = pstmt.executeUpdate();			
			
			if(result==0) {
				System.out.println("값이틀렸다");
			}       
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try { rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try { pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try { conn.close();}catch(SQLException e) {e.printStackTrace();}
		}		
		return result;
	}
	
	//7. 물건구매시 재고 -1 하는 메서드
	public void minusStock(int sNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "update shopBoard set goodsStock = goodsStock-1 where sNo=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sNo);			
			int re = pstmt.executeUpdate();
			System.out.println("재고 차감잘되면1 아니면 0 : " + re );
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}
	
	 
	// 8. 검색한 글의 총 개수 가져오는 메서드
		public int getGoodsSearchCount(String sel, String search) {
			int count = 0; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select count(*) from shopBoard where "+sel+" like '%"+search+"%'";
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
	
	      
		
	//9. 검색한 글 목록 가져오기
		public List<ShopBoardDTO> getGoodsSearch(int startRow, int endRow, String sel, String search) {
			List<ShopBoardDTO> list = null; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from shopBoard where "+sel+" like '%"+search+"%'"
						+ " order by sNo desc) A) B "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
					list = new ArrayList<ShopBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
					do {
						ShopBoardDTO goods = new ShopBoardDTO(); 
						goods.setsNo(rs.getInt("sNo"));
						goods.setGoodsName(rs.getString("goodsName"));
						goods.setContent(rs.getString("content"));
						goods.setShopImg(rs.getString("shopImg"));
						goods.setGoodsStatus(rs.getInt("goodsStatus"));
						goods.setGoodsStock(rs.getInt("goodsStock"));
						goods.setPrice(rs.getInt("price"));
						
						list.add(goods);
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
		}//메서드 종료
		
		
		
		// 10. 상단 제품 상태 검색 총 개수 가져오는 메서드
		public int getGoodsStatusCount(String topSel, String topSelVal) {
			int count = 0; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select count(*) from shopBoard where "+topSel+" like '%"+topSelVal+"%'";
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
	
	      
		
	//9. 검색한 글 목록 가져오기
		public List<ShopBoardDTO> getGoodsStatus(int startRow, int endRow, String topSel, String topSelVal) {
			List<ShopBoardDTO> list = null; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from shopBoard where "+topSel+" like '%"+topSelVal+"%'"
						+ " order by sNo desc) A) B "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
					list = new ArrayList<ShopBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
					do {
						ShopBoardDTO goods = new ShopBoardDTO(); 
						goods.setsNo(rs.getInt("sNo"));
						goods.setGoodsName(rs.getString("goodsName"));
						goods.setContent(rs.getString("content"));
						goods.setShopImg(rs.getString("shopImg"));
						goods.setGoodsStatus(rs.getInt("goodsStatus"));
						goods.setGoodsStock(rs.getInt("goodsStock"));
						goods.setPrice(rs.getInt("price"));
						
						list.add(goods);
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
		}//메서드 종료
		
		
		
	    //10. 버튼눌렀을때 value+1
		   public void PlusValue(int sNo) {
		      Connection conn = null;
		      PreparedStatement pstmt = null;

		      try {
		         conn = getConnection();
		         String sql = "update shopBoard set goodsStatus = goodsStatus+1 where sNo=?"; 
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setInt(1, sNo);         
		         int re = pstmt.executeUpdate();
		         System.out.println("value 잘더해지면 1 아니면 0 : " + re );
		      }catch(Exception e){
		         e.printStackTrace();
		      }finally {
		         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
		         if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		      }
		   }
		   
		   //11. 버튼눌렀을때 value-1
		   public void MinusValue(int sNo) {
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      
		      try {
		         conn = getConnection();
		         String sql = "update shopBoard set goodsStatus = goodsStatus-1 where sNo=?"; 
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setInt(1, sNo);         
		         int re = pstmt.executeUpdate();
		         System.out.println("value 잘빼지면 1 아니면 0 : " + re );
		      }catch(Exception e){
		         e.printStackTrace();
		      }finally {
		         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
		         if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		      }
		   }
		
		   
		   
		   


	         //12. 버튼눌렀을때 삭제중으로 (value=2)
	         public void delete(int sNo) {
	            Connection conn = null;
	            PreparedStatement pstmt = null;
	            
	            try {
	               conn = getConnection();
	               String sql = "update shopBoard set goodsStatus = 2 where sNo=?"; 
	               pstmt = conn.prepareStatement(sql);
	               pstmt.setInt(1, sNo);         
	               int re = pstmt.executeUpdate();
	               System.out.println("value 잘빼지면 1 아니면 0 : " + re );
	            }catch(Exception e){
	               e.printStackTrace();
	            }finally {
	               if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	               if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	            }
	         }
	         
	         //13. 버튼눌렀을때 판매중으로 (value=1)
	         public void undelete(int sNo) {
	            Connection conn = null;
	            PreparedStatement pstmt = null;
	            
	            try {
	               conn = getConnection();
	               String sql = "update shopBoard set goodsStatus = 1 where sNo=?"; 
	               pstmt = conn.prepareStatement(sql);
	               pstmt.setInt(1, sNo);         
	               int re = pstmt.executeUpdate();
	               System.out.println("value 잘빼지면 1 아니면 0 : " + re );
	            }catch(Exception e){
	               e.printStackTrace();
	            }finally {
	               if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	               if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	            }
	         }	   
		   
		   
	           //. 전체 글의 개수 카운팅 메서드 (pointshop페이지)
	           public int getshopCount2() {
	              System.out.println("count");
	              int count = 0; 
	              Connection conn = null; 
	              PreparedStatement pstmt = null; 
	              ResultSet rs = null;
	              try {
	                 String sql = "select count(*) from shopBoard where goodsStatus = 1  order by sNo desc";          
	                 conn = getConnection(); 
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

	          //3. 게시글 가져오기 (페이징처리 O) 포인트샵
	          public List<ShopBoardDTO> getshoparticleList2(int start, int end) {
	             List<ShopBoardDTO> list = null; 
	             Connection conn = null;
	             PreparedStatement pstmt = null; 
	             ResultSet rs = null; 
	             
	             try {
	                conn = getConnection(); 
	                String sql = "select B.* from (select rownum r, A.* from "
	                      + "(select * from shopBoard where goodsStatus = 1 order by sNo desc) A ) B "
	                      + "where r >= ? and r <= ?";
	                pstmt = conn.prepareStatement(sql);
	                pstmt.setInt(1, start);
	                pstmt.setInt(2, end);
	                rs = pstmt.executeQuery(); 
	                if(rs.next()) {
	                   list = new ArrayList<ShopBoardDTO>();
	                   do {
	                      ShopBoardDTO shoparticle = new ShopBoardDTO(); 
	                      shoparticle.setsNo(rs.getInt("sNo"));
	                      shoparticle.setGoodsName(rs.getString("goodsName"));
	                      shoparticle.setContent(rs.getString("content"));
	                      shoparticle.setShopImg(rs.getString("shopImg"));
	                      shoparticle.setGoodsStatus(rs.getInt("goodsStatus"));
	                      shoparticle.setGoodsStock(rs.getInt("goodsStock"));
	                      shoparticle.setPrice(rs.getInt("price"));                  
	                      list.add(shoparticle);
	                   }while(rs.next()); 
	                }
	             }catch(Exception e) {
	                e.printStackTrace();
	             }finally {
	                if(rs != null) try { rs.close(); }catch(SQLException e) { e.printStackTrace(); }
	                if(pstmt != null) try { pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
	                if(conn != null) try { conn.close(); }catch(SQLException e) { e.printStackTrace(); }
	             }
	             return list; 
	          }       
	         
	         
		   
}