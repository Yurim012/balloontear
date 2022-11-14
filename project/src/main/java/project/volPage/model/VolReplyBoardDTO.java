package project.volPage.model;

import java.sql.Timestamp;

public class VolReplyBoardDTO {
	
   private int reNo;
   private int volNo;
   private String replyer;
   private String reply;
   private Timestamp reReg;
   private int replyGrp;
   private int replyStep;
   private int replyLevel;
	   
	public int getReNo() {
		return reNo;
	}
	public void setReNo(int reNo) {
		this.reNo = reNo;
	}
	public int getVolNo() {
		return volNo;
	}
	public void setVolNo(int volNo) {
		this.volNo = volNo;
	}
	public String getReplyer() {
		return replyer;
	}
	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public Timestamp getReReg() {
		return reReg;
	}
	public void setReReg(Timestamp reReg) {
		this.reReg = reReg;
	}
	public int getReplyGrp() {
		return replyGrp;
	}
	public void setReplyGrp(int replyGrp) {
		this.replyGrp = replyGrp;
	}
	public int getReplyStep() {
		return replyStep;
	}
	public void setReplyStep(int replyStep) {
		this.replyStep = replyStep;
	}
	public int getReplyLevel() {
		return replyLevel;
	}
	public void setReplyLevel(int replyLevel) {
		this.replyLevel = replyLevel;
	} 
	   
	   
	   

}
