package com.sdm.ssm.common;

public class SerachDateStr {
	
	private String sdate;
	private String edate;
	
	private int id;

	private String start;
	private String end;
	private String title;
	private int groupid;
	
	public SerachDateStr() {
		super();
	}

	public SerachDateStr(String sdate, String edate, int id, String start, String end, String title, int groupid) {
		super();
		this.sdate = sdate;
		this.edate = edate;
		this.id = id;
		this.start = start;
		this.end = end;
		this.title = title;
		this.groupid = groupid;
	}

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	public String getEdate() {
		return edate;
	}

	public void setEdate(String edate) {
		this.edate = edate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getGroupid() {
		return groupid;
	}

	public void setGroupid(int groupid) {
		this.groupid = groupid;
	}

	@Override
	public String toString() {
		return "SerachDateStr [sdate=" + sdate + ", edate=" + edate + ", id=" + id + ", start=" + start + ", end=" + end
				+ ", title=" + title + ", groupid=" + groupid + "]";
	}


}
