package project.quest.model;

public class QuBoardDTO {
   
   private int quNo;          // 퀘스트고유번호
   private String quSubject;   // 퀘스트이름
   private String quType;      // 퀘스트 타입
   private int quValue;      // 퀘스트 수치
   private String quImg;      // 퀘스트 엠블럼 할지안할지모름
   private int quClearPoint;   // 퀘스트 클리어시 보상 포인트
   public int getQuNo() {
      return quNo;
   }
   public void setQuNo(int quNo) {
      this.quNo = quNo;
   }
   public String getQuSubject() {
      return quSubject;
   }
   public void setQuSubject(String quSubject) {
      this.quSubject = quSubject;
   }
   public String getQuType() {
      return quType;
   }
   public void setQuType(String quType) {
      this.quType = quType;
   }
   public int getQuValue() {
      return quValue;
   }
   public void setQuValue(int quValue) {
      this.quValue = quValue;
   }
   public String getQuImg() {
      return quImg;
   }
   public void setQuImg(String quImg) {
      this.quImg = quImg;
   }
   public int getQuClearPoint() {
      return quClearPoint;
   }
   public void setQuClearPoint(int quClearPoint) {
      this.quClearPoint = quClearPoint;
   }
   

}