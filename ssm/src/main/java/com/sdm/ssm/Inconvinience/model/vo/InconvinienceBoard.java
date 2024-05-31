package com.sdm.ssm.Inconvinience.model.vo;

import java.sql.Date;

public class InconvinienceBoard implements java.io.Serializable {

	private static final long serialVersionUID = 8963485125681541303L;
	
	private int boardNo;
	private String writer;
	private String boardTitle;
	private String boardContent;
	private Date writeDate;
	private Date modifyDate;
	private String status;
	private int id;
	public InconvinienceBoard(int boardNo, String writer, String boardTitle, String boardContent, Date writeDate,
			Date modifyDate, String status, int id) {
		super();
		this.boardNo = boardNo;
		this.writer = writer;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.writeDate = writeDate;
		this.modifyDate = modifyDate;
		this.status = status;
		this.id = id;
	}
	public InconvinienceBoard() {
		super();
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
	
}
