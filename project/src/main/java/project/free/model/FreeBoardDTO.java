package project.free.model;

import java.sql.Timestamp;

public class FreeBoardDTO {
 
    private int boNo;
    private String memId;
    private String boSubject;
    private String boContent;
    private String boCategory;
    private String boImg;
    private Timestamp boReg;
    private int pin;
    
	public int getBoNo() {
		return boNo;
	}
	public void setBoNo(int boNo) {
		this.boNo = boNo;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getBoSubject() {
		return boSubject;
	}
	public void setBoSubject(String boSubject) {
		this.boSubject = boSubject;
	}
	public String getBoContent() {
		return boContent;
	}
	public void setBoContent(String boContent) {
		this.boContent = boContent;
	}
	public String getBoCategory() {
		return boCategory;
	}
	public void setBoCategory(String boCategory) {
		this.boCategory = boCategory;
	}
	public String getBoImg() {
		return boImg;
	}
	public void setBoImg(String boImg) {
		this.boImg = boImg;
	}
	public Timestamp getBoReg() {
		return boReg;
	}
	public void setBoReg(Timestamp boReg) {
		this.boReg = boReg;
	}
	public int getPin() {
		return pin;
	}
	public void setPin(int pin) {
		this.pin = pin;
	} 
    
    
    
    
}
