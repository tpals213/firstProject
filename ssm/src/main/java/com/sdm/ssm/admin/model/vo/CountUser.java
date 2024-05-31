package com.sdm.ssm.admin.model.vo;

public class CountUser implements java.io.Serializable {
	private String month;
	private int Count;
	
	public CountUser() {
		super();
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getCount() {
		return Count;
	}
	public void setCount(int count) {
		Count = count;
	}
	@Override
	public String toString() {
		return "CountUser [month=" + month + ", Count=" + Count + "]";
	}
	
}
