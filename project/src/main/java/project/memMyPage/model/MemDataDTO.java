package project.memMyPage.model;

import java.sql.Date;
import java.sql.Timestamp;

public class MemDataDTO {
	
	private String memId;
	private int memPoint,memLevel,memVolCount,memVolTime,memBuyPoint,memBuyCount,memDayCount;
	private Date memLastVisitDay;
	
	
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public int getMemPoint() {
		return memPoint;
	}
	public void setMemPoint(int memPoint) {
		this.memPoint = memPoint;
	}
	public int getMemLevel() {
		return memLevel;
	}
	public void setMemLevel(int memLevel) {
		this.memLevel = memLevel;
	}
	public int getMemVolCount() {
		return memVolCount;
	}
	public void setMemVolCount(int memVolCount) {
		this.memVolCount = memVolCount;
	}
	public int getMemVolTime() {
		return memVolTime;
	}
	public void setMemVolTime(int memVolTime) {
		this.memVolTime = memVolTime;
	}
	public int getMemBuyPoint() {
		return memBuyPoint;
	}
	public void setMemBuyPoint(int memBuyPoint) {
		this.memBuyPoint = memBuyPoint;
	}
	public int getMemBuyCount() {
		return memBuyCount;
	}
	public void setMemBuyCount(int memBuyCount) {
		this.memBuyCount = memBuyCount;
	}
	public int getMemDayCount() {
		return memDayCount;
	}
	public void setMemDayCount(int memDayCount) {
		this.memDayCount = memDayCount;
	}
	public Date getMemLastVisitDay() {
		return memLastVisitDay;
	}
	public void setMemLastVisitDay(Date memLastVisitDay) {
		this.memLastVisitDay = memLastVisitDay;
	}
	
	
	

	
}
