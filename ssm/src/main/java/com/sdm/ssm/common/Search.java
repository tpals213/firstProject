package com.sdm.ssm.common;

import java.sql.Date;

public class Search {
	
	private String keyword;
	private int age;		// 나이 검색 시
	private int startRow;	// 페이지의 시작행
	private int endRow;	// 페이지의 끝행
	private Date begin;	// 가입 날짜 검색 시 시작 날짜 ,java.sql.date 임포트
	private Date end;		// 가입 날짜 검색 시 끝 날짜
	private int id;       // 사용자 id
	private String sid;   // 사용자 id 문자
	
	public Search() {
		super();
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public Date getBegin() {
		return begin;
	}

	public void setBegin(Date begin) {
		this.begin = begin;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
		this.sid = Integer.toString(id); // 추가
	}
	
	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	@Override
	public String toString() {
		return "Search [keyword=" + keyword + ", age=" + age + ", startRow=" + startRow + ", endRow=" + endRow
				+ ", begin=" + begin + ", end=" + end + ", id=" + id + ", sid=" + sid + "]";
	}

}
