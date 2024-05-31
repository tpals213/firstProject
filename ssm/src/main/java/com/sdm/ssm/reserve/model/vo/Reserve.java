package com.sdm.ssm.reserve.model.vo;

import java.sql.Date;

//vo(dto, do, entity, bean) 작성규칙
//1. 반드시 직렬화할 것
//2. 모든 필드는 private : 반드시 캡슐화할 것
//3. 기본생성자, 매개변수 있는 생성자 작성할 것
//4. 모든 필드에 대한 getters and setters 
//5. toString() overriding
//선택 : equals(), clone() 등 오버라이딩, 그 외의 메소드
public class Reserve implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	
	private int rsrvNum;
	private String rsrvDate;
	private String rsrvTime;
	private String rsrvName;
	private String rsrvTelno;
	private int rsrvInwon;
	private String rsrvSubject;
	private String rsrvMemo;
	private int writer;
	private java.sql.Date writeDate;
	
	private int id;
	private String sid;
	
	public Reserve() {
		super();
	}

	public Reserve(int rsrvNum, String rsrvDate, String rsrvTime, String rsrvName, String rsrvTelno, int rsrvInwon,
			String rsrvSubject, String rsrvMemo, int writer, Date writeDate, int id) {
		super();
		this.rsrvNum = rsrvNum;
		this.rsrvDate = rsrvDate;
		this.rsrvTime = rsrvTime;
		this.rsrvName = rsrvName;
		this.rsrvTelno = rsrvTelno;
		this.rsrvInwon = rsrvInwon;
		this.rsrvSubject = rsrvSubject;
		this.rsrvMemo = rsrvMemo;
		this.writer = writer;
		this.writeDate = writeDate;
		this.id = id;
		this.sid = Integer.toString(id);  //// id를 문자로 변환함
	}

	public int getRsrvNum() {
		return rsrvNum;
	}

	public void setRsrvNum(int rsrvNum) {
		this.rsrvNum = rsrvNum;
	}

	public String getRsrvDate() {
		return rsrvDate;
	}

	public void setRsrvDate(String rsrvDate) {
		this.rsrvDate = rsrvDate;
	}

	public String getRsrvTime() {
		return rsrvTime;
	}

	public void setRsrvTime(String rsrvTime) {
		this.rsrvTime = rsrvTime;
	}

	public String getRsrvName() {
		return rsrvName;
	}

	public void setRsrvName(String rsrvName) {
		this.rsrvName = rsrvName;
	}

	public String getRsrvTelno() {
		return rsrvTelno;
	}

	public void setRsrvTelno(String rsrvTelno) {
		this.rsrvTelno = rsrvTelno;
	}

	public int getRsrvInwon() {
		return rsrvInwon;
	}

	public void setRsrvInwon(int rsrvInwon) {
		this.rsrvInwon = rsrvInwon;
	}

	public String getRsrvSubject() {
		return rsrvSubject;
	}

	public void setRsrvSubject(String rsrvSubject) {
		this.rsrvSubject = rsrvSubject;
	}

	public String getRsrvMemo() {
		return rsrvMemo;
	}

	public void setRsrvMemo(String rsrvMemo) {
		this.rsrvMemo = rsrvMemo;
	}

	public int getWriter() {
		return writer;
	}

	public void setWriter(int writer) {
		this.writer = writer;
	}

	public java.sql.Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(java.sql.Date writeDate) {
		this.writeDate = writeDate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
		this.sid = Integer.toString(id);  //// 추가 작업
	}

	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Reserve [rsrvNum=" + rsrvNum + ", rsrvDate=" + rsrvDate + ", rsrvTime=" + rsrvTime + ", rsrvName="
				+ rsrvName + ", rsrvTelno=" + rsrvTelno + ", rsrvInwon=" + rsrvInwon + ", rsrvSubject=" + rsrvSubject
				+ ", rsrvMemo=" + rsrvMemo + ", writer=" + writer + ", writeDate=" + writeDate + ", id=" + id + ", sid="
				+ sid + "]";
	}
	
}
