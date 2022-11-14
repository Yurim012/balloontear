package project.volPage.model;

import java.sql.Date;
import java.sql.Timestamp;

public class VolBoardDTO {	
	private int volNo;
	private String memId;
	private String volSubject;
	private String volContent;
	private String volCategory;
	private int volMaxNum;
	private int volStatus;
	private Date volStartDate;
	private Date volEndDate;
	private String volLoc;
	private int volTime;
	private String volImg;
	private Timestamp volReg;
	private int volArticleStatus;
	
	public int getVolNo() {
		return volNo;
	}
	public void setVolNo(int volNo) {
		this.volNo = volNo;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getVolSubject() {
		return volSubject;
	}
	public void setVolSubject(String volSubject) {
		this.volSubject = volSubject;
	}
	public String getVolContent() {
		return volContent;
	}
	public void setVolContent(String volContent) {
		this.volContent = volContent;
	}
	public String getVolCategory() {
		return volCategory;
	}
	public void setVolCategory(String volCategory) {
		this.volCategory = volCategory;
	}
	public int getVolMaxNum() {
		return volMaxNum;
	}
	public void setVolMaxNum(int volMaxNum) {
		this.volMaxNum = volMaxNum;
	}
	public int getVolStatus() {
		return volStatus;
	}
	public void setVolStatus(int volStatus) {
		this.volStatus = volStatus;
	}
	public Date getVolStartDate() {
		return volStartDate;
	}
	public void setVolStartDate(Date volStartDate) {
		this.volStartDate = volStartDate;
	}
	public Date getVolEndDate() {
		return volEndDate;
	}
	public void setVolEndDate(Date volEndDate) {
		this.volEndDate = volEndDate;
	}
	public String getVolLoc() {
		return volLoc;
	}
	public void setVolLoc(String volLoc) {
		this.volLoc = volLoc;
	}
	public int getVolTime() {
		return volTime;
	}
	public void setVolTime(int volTime) {
		this.volTime = volTime;
	}
	public String getVolImg() {
		return volImg;
	}
	public void setVolImg(String volImg) {
		this.volImg = volImg;
	}
	public Timestamp getVolReg() {
		return volReg;
	}
	public void setVolReg(Timestamp volReg) {
		this.volReg = volReg;
	}
	public int getVolArticleStatus() {
		return volArticleStatus;
	}
	public void setVolArticleStatus(int volArticleStatus) {
		this.volArticleStatus = volArticleStatus;
	}
	
	
	
	
	
	
	

	
}
