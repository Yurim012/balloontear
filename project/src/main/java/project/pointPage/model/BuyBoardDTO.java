package project.pointPage.model;

import java.sql.Timestamp;

public class BuyBoardDTO {
	private int buyNo;
	private int sNo;
	private String memId;
	private int price;
	private Timestamp buyReg;
		
	public int getBuyNo() {
		return buyNo;
	}
	public void setBuyNo(int buyNo) {
		this.buyNo = buyNo;
	}
	public int getsNo() {
		return sNo;
	}
	public void setsNo(int sNo) {
		this.sNo = sNo;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Timestamp getBuyReg() {
		return buyReg;
	}
	public void setBuyReg(Timestamp buyReg) {
		this.buyReg = buyReg;
	}
	
	
	
	
	
	
	

}
