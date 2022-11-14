package project.free.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import project.volPage.model.VolReplyBoardDTO;

public class FreeReplyBoardDAO {
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 본문글에 해당하는 댓글의 개수 조회 
		public int getFreeReplyCount(int boNo) {
			int count = 0; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select count(*) from freeReplyBoard where boNo = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, boNo);
				
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
	
	
	

		// 본문에해당하는 댓글들 가져오기 (페이징처리까지) 
		public List getFreeReplies(int boNo, int start, int end) {
			List replyList = null; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select B.* from (select A.*, rownum r from "
						+ "(select * from freeReplyBoard where boNo=? "
						+ "order by freeReplyGrp desc, freeReplyStep asc) A "
						+ "order by freeReplyGrp desc, freeReplyStep asc) B "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, boNo);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					replyList = new ArrayList(); 
					do {
						FreeReplyBoardDTO freeReply = new FreeReplyBoardDTO(); 
						freeReply.setFreeReNo(rs.getInt("freeReNo"));
						freeReply.setBoNo(boNo);
						freeReply.setFreeReplyer(rs.getString("freeReplyer"));
						freeReply.setFreeReply(rs.getString("freeReply"));
						freeReply.setFreeReReg(rs.getTimestamp("freeReReg"));
						freeReply.setFreeReplyGrp(rs.getInt("freeReplyGrp"));
						freeReply.setFreeReplyStep(rs.getInt("freeReplyStep"));
						freeReply.setFreeReplyLevel(rs.getInt("freeReplyLevel"));
						replyList.add(freeReply);
					}while(rs.next());
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return replyList;
		}//메서드 종료
		
	
		
		// 댓글 등록 처리 
				public void insertFreeReply(FreeReplyBoardDTO dto) {
					Connection conn = null; 
					PreparedStatement pstmt = null; 
					ResultSet rs = null;
					// 새댓글, 댓글의 댓글인지에 따라 조정이 필요한 값들 미리 뽑아 놓기 
					int freeReNo = dto.getFreeReNo(); 				// 새 댓글  = 0, 댓글의 댓글 = 1 이상
					int freeReplyGrp = dto.getFreeReplyGrp(); 		// 1			 1이상 
					int freeReplyLevel = dto.getFreeReplyLevel(); 	// 0			 
					int freeReplyStep = dto.getFreeReplyStep();		// 0
					int number = 0; 						// replyGrp 체워줄때 필요한 임시변수
					try {
						conn = getConnection(); 
						String sql = "select max(freeReNo) from freeReplyBoard";
						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery(); 
						if(rs.next()) number = rs.getInt(1) + 1; //댓글이 있고, 가장 큰번호 
						else number = 1; // 댓글이 하나도 없을 경우 
						
						// 댓글의 댓글 
						if(freeReNo != 0) {
							System.out.println("자유게시판 대댓글 들어옴");
							sql = "update freeReplyBoard set freeReplyStep=freeReplyStep+1 where freeReplyGrp=? and freeReplyStep > ?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, freeReplyGrp);
							pstmt.setInt(2, freeReplyStep);
							pstmt.executeUpdate();
							
							// insert 날리기위해 1씩 증가해주기
							freeReplyStep += 1; 
							freeReplyLevel += 1;
						}else { // 새댓글 
							freeReplyGrp = number;
							freeReplyStep = 0; 
							freeReplyLevel = 0; 
						}

						sql = "insert into freeReplyBoard(freeReNo,boNo,freeReplyer,freeReply,freeReReg,freeReplyGrp,freeReplyStep,freeReplyLevel) ";
						sql += "values(freeReplyBoard_seq.nextval,?,?,?,sysdate,?,?,?)";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, dto.getBoNo());
						pstmt.setString(2, dto.getFreeReplyer());
						pstmt.setString(3, dto.getFreeReply());
						pstmt.setInt(4, freeReplyGrp);
						pstmt.setInt(5, freeReplyStep);
						pstmt.setInt(6, freeReplyLevel);
						
						int result = pstmt.executeUpdate(); 
						System.out.println("insert result : " + result);
						System.out.println("댓글 등록 메서드 : " + dto.getBoNo());
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
						if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
						if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
					}
				}//메서드 종료
	
				
				// 댓글 삭제 
				public void deleteFreeReply(int freeReNo) {
					Connection conn = null; 
					PreparedStatement pstmt = null; 
					try {
						conn = getConnection(); 
						String sql = "delete from freeReplyBoard where freeReNo=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, freeReNo);
						
						pstmt.executeUpdate();
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
						if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
					}
				}//메서드 종료
	
	
				// 댓글 하나 가져오기 
				public FreeReplyBoardDTO getOneFreeReply(int freeReNo) {
					FreeReplyBoardDTO reply = null; 
					Connection conn = null; 
					PreparedStatement pstmt = null; 
					ResultSet rs = null;
					try {
						conn = getConnection(); 
						String sql = "select * from freeReplyBoard where freeReNo = ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, freeReNo);
						
						rs = pstmt.executeQuery(); 
						if(rs.next()) {
							reply = new FreeReplyBoardDTO(); 
							reply.setFreeReNo(freeReNo);
							reply.setBoNo(rs.getInt("boNo"));
							reply.setFreeReplyer(rs.getString("freeReplyer"));
							reply.setFreeReply(rs.getString("freeReply"));
							reply.setFreeReReg(rs.getTimestamp("freeReReg"));
							reply.setFreeReplyGrp(rs.getInt("freeReplyGrp"));
							reply.setFreeReplyStep(rs.getInt("freeReplyStep"));
							reply.setFreeReplyLevel(rs.getInt("freeReplyLevel"));
						}
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
						if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
						if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
					}
					return reply;
				}//메서드 종료
				
				
				// 댓글 수정 
				public void updateFreeReply(int freeReNo, String freeReply) {
					Connection conn = null; 
					PreparedStatement pstmt = null; 
					try {
						conn = getConnection(); 
						String sql = "update freeReplyBoard set freeReply=? where freeReNo=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, freeReply);
						pstmt.setInt(2, freeReNo);
						
						pstmt.executeUpdate();
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
						if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
					}
					
				}
	
	
}
