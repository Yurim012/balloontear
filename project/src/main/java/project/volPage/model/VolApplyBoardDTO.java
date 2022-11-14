package project.volPage.model;

import java.sql.Date;

public class VolApplyBoardDTO {

   private int applyNo ;
   private int volNo ;
   private String memId ; 
   private int memActivity ;
   private Date selDate;
   private String applyDate;
   
   
   
   public int getApplyNo() {
      return applyNo;
   }
   public void setApplyNo(int applyNo) {
      this.applyNo = applyNo;
   }
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
   public int getMemActivity() {
      return memActivity;
   }
   public void setMemActivity(int memActivity) {
      this.memActivity = memActivity;
   }
   public Date getSelDate() {
      return selDate;
   }
   public void setSelDate(Date selDate) {
      this.selDate = selDate;
   }
   public String getApplyDate() {
      return applyDate;
   }
   public void setApplyDate(String applyDate) {
      this.applyDate = applyDate;
   }
   
   
   
   
   
   
   
   
   
   
   
   
}