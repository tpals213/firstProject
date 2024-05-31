package com.sdm.ssm.admin.model.vo;

import java.sql.Date;

public class Notice implements java.io.Serializable{

	private static final long serialVersionUID = -5801673614160852016L;
	private int noticeNo;
	private String writer;
	private String noticeTitle;
	private String noticeContent;
	private Date writeDate;
	private Date modifyDate;
	private int readCount;
	private String importancy;
	private int id;
	public Notice(int noticeNo, String writer, String noticeTitle, String noticeContent, Date writeDate, Date modifyDate,
			int readCount, String importancy) {
		super();
		this.noticeNo = noticeNo;
		this.writer = writer;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.writeDate = writeDate;
		this.modifyDate = modifyDate;
		this.readCount = readCount;
		this.importancy = importancy;
	}
	public Notice() {
		super();
	}
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public String getImportancy() {
		return importancy;
	}
	public void setImportancy(String importancy) {
		this.importancy = importancy;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "Notice [noticeNo=" + noticeNo + ", writer=" + writer + ", noticeTitle=" + noticeTitle
				+ ", noticeContent=" + noticeContent + ", writeDate=" + writeDate + ", modifyDate=" + modifyDate
				+ ", readCount=" + readCount + ", importancy=" + importancy +", id ="+id + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
}
