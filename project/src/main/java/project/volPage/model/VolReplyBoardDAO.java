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




public class VolReplyBoardDAO {

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 본문글에 해당하는 댓글의 개수 조회 
		public int getReplyCount(int volNo) {
			int count = 0; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select count(*) from replyBoard where volNo = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, volNo);
				
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
		public List getReplies(int volNo, int start, int end) {
			System.out.println("댓글 가져오는 메서드 실행요~");
			List replyList = null; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				System.out.println("댓글 가져오는 메서드 try 입장~");
				conn = getConnection(); 
				String sql = "select B.* from (select A.*, rownum r from "
						+ "(select * from replyBoard where volNo=? "
						+ "order by replyGrp desc, replyStep asc) A "
						+ "order by replyGrp desc, replyStep asc) B "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, volNo);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					replyList = new ArrayList(); 
					do {
						VolReplyBoardDTO reply = new VolReplyBoardDTO(); 
						reply.setReNo(rs.getInt("reNo"));
						reply.setVolNo(volNo);
						reply.setReplyer(rs.getString("replyer"));
						reply.setReply(rs.getString("reply"));
						reply.setReReg(rs.getTimestamp("reReg"));
						reply.setReplyGrp(rs.getInt("replyGrp"));
						reply.setReplyStep(rs.getInt("replyStep"));
						reply.setReplyLevel(rs.getInt("replyLevel"));
						replyList.add(reply);
					}while(rs.next());
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
				System.out.println("댓글 가져오는 메서드 list 리턴함~");
			}
			return replyList;
			
		}//메서드 종료
		
		
		// 댓글 등록 처리 
		public void insertReply(VolReplyBoardDTO dto) {
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			// 새댓글, 댓글의 댓글인지에 따라 조정이 필요한 값들 미리 뽑아 놓기 
			int reNo = dto.getReNo(); 				// 새 댓글  = 0, 댓글의 댓글 = 1 이상
			int replyGrp = dto.getReplyGrp(); 		// 1			 1이상 
			int replyLevel = dto.getReplyLevel(); 	// 0			 
			int replyStep = dto.getReplyStep();		// 0
			int number = 0; 						// replyGrp 체워줄때 필요한 임시변수
			try {
				conn = getConnection(); 
				String sql = "select max(reNo) from replyBoard";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery(); 
				if(rs.next()) number = rs.getInt(1) + 1; //댓글이 있고, 가장 큰번호 
				else number = 1; // 댓글이 하나도 없을 경우 
				
				// 댓글의 댓글 
				if(reNo != 0) {
					System.out.println("대댓글 들어옴");
					sql = "update replyBoard set replyStep=replyStep+1 where replyGrp=? and replyStep > ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, replyGrp);
					pstmt.setInt(2, replyStep);
					pstmt.executeUpdate();
					
					// insert 날리기위해 1씩 증가해주기
					replyStep += 1; 
					replyLevel += 1;
				}else { // 새댓글 
					replyGrp = number;
					replyStep = 0; 
					replyLevel = 0; 
				}

				sql = "insert into replyBoard(reNo,reply,replyer,volNo,replyGrp,replyLevel,replyStep,reReg) ";
				sql += "values(replyBoard_seq.nextval,?,?,?,?,?,?,sysdate)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getReply());
				pstmt.setString(2, dto.getReplyer());
				pstmt.setInt(3, dto.getVolNo());
				pstmt.setInt(4, replyGrp);
				pstmt.setInt(5, replyLevel);
				pstmt.setInt(6, replyStep);
				
				int result = pstmt.executeUpdate(); 
				System.out.println("insert result : " + result);
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
		}//메서드 종료
		
		
		// 댓글 하나 가져오기 
		public VolReplyBoardDTO getOneReply(int reNo) {
			VolReplyBoardDTO reply = null; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select * from replyBoard where reNo = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, reNo);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					reply = new VolReplyBoardDTO(); 
					reply.setReNo(reNo);
					reply.setVolNo(rs.getInt("volNo"));
					reply.setReplyer(rs.getString("replyer"));
					reply.setReply(rs.getString("reply"));
					reply.setReReg(rs.getTimestamp("reReg"));
					reply.setReplyGrp(rs.getInt("replyGrp"));
					reply.setReplyStep(rs.getInt("replyStep"));
					reply.setReplyLevel(rs.getInt("replyLevel"));
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
		public void updateReply(int reNo, String reply) {
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			try {
				conn = getConnection(); 
				String sql = "update ReplyBoard set reply=? where reNo=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, reply);
				pstmt.setInt(2, reNo);
				
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			
		}
		
		// 댓글 삭제 
		public void deleteReply(int reNo) {
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			try {
				conn = getConnection(); 
				String sql = "delete from replyBoard where reNo=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, reNo);
				
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
		}//메서드 종료
		
	
}
