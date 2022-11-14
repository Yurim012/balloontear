package project.pointPage.model;

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

public class BuyBoardDAO {
	
	//커넥션
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}	
	
	//1. 구매내역 insert
	public void insertBuyBoard(int sNo, String id, int price) {   
		System.out.println("바이인서트 실행");
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn= getConnection();
			String sql = "insert into buyBoard values(buyBoard_seq.nextval, ? , ? , ? ,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sNo);
			pstmt.setString(2, id);
			pstmt.setInt(3, price);
			int result = pstmt.executeUpdate(); 
			System.out.println("구매내역 잘되면 1 안되면 0 : " + result);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}         
		}
	}

	//2. 나의 구매횟수 가져오기
	public int getMyBuyCount(String id) {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql ="select count(*) from buyBoard where memId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return count;
	}
	
	//3. 내가 구매한 구매내역 가져오기
	public List<BuyBoardDTO> getMybuyAllList(int startRow, int endRow, String id) {
		System.out.println("getMybuyAllList 메서드들어옴");
		List<BuyBoardDTO> buyList = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try { 
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from buyBoard order by buyReg desc) A) B "
					+ "where r >= ? and r <= ? and memId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			pstmt.setString(3, id);
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				buyList = new ArrayList<BuyBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					BuyBoardDTO article = new BuyBoardDTO(); 
					article.setBuyNo(rs.getInt("buyNo"));
					article.setsNo(rs.getInt("sNo"));
					article.setMemId(rs.getString("memId"));
					article.setPrice(rs.getInt("price"));
					article.setBuyReg(rs.getTimestamp("buyReg"));
					buyList.add(article);
				}while(rs.next());
				System.out.println("getMyBuyList저장완료");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return buyList;
	}
	
	
	// 포인트샵에서 구매한 전체 고객 count 
	public int getBuyMemCount() {
		System.out.println("count");
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			String sql = "select count(*) from buyBoard";    	   
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

	
	
	
	// 포인트샵에서 구매한 고객 목록 전체 가져오기
	public List<BuyBoardDTO> getBuyMemAllList(int startRow, int endRow) {
		List<BuyBoardDTO> list = null; 
		Connection conn = null;
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from buyBoard order by buyReg desc) A ) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				list = new ArrayList<BuyBoardDTO>();
				do {
					BuyBoardDTO buymember = new BuyBoardDTO(); 
					buymember.setBuyNo(rs.getInt("buyNo"));
					buymember.setsNo(rs.getInt("sNo"));
					buymember.setMemId(rs.getString("memId"));
					buymember.setPrice(rs.getInt("price"));
					buymember.setBuyReg(rs.getTimestamp("buyReg"));
					list.add(buymember);
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
	
	
	// 검색한 고객 총 count 메서드
	public int getBuyMemSearchCount(String sel, String search) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from buyBoard where "+sel+" like '%"+search+"%'";
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
			public List<BuyBoardDTO> getBuyMemSearch(int startRow, int endRow, String sel, String search) {
				List<BuyBoardDTO> list = null; 
				Connection conn = null; 
				PreparedStatement pstmt = null; 
				ResultSet rs = null;
				try {
					conn = getConnection(); 
					String sql = "select B.* from (select rownum r, A.* from "
							+ "(select * from buyBoard where "+sel+" like '%"+search+"%'"
							+ " order by buyNo desc) A) B "
							+ "where r >= ? and r <= ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, startRow);
					pstmt.setInt(2, endRow);
					
					rs = pstmt.executeQuery(); 
					if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
						list = new ArrayList<BuyBoardDTO>(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
						do {
							BuyBoardDTO buymember = new BuyBoardDTO(); 
							buymember.setBuyNo(rs.getInt("buyNo"));
							buymember.setsNo(rs.getInt("sNo"));
							buymember.setMemId(rs.getString("memId"));
							buymember.setPrice(rs.getInt("price"));
							buymember.setBuyReg(rs.getTimestamp("buyReg"));
							list.add(buymember);
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
	

}
