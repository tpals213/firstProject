package com.sdm.ssm.account.model.vo;

public class Account implements java.io.Serializable{

	private static final long serialVersionUID = -1968223290914458935L;

	private int id;
	private String yearmonth;
	private String title;
	private int price;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getYearmonth() {
		return yearmonth;
	}
	public void setYearmonth(String yearmonth) {
		this.yearmonth = yearmonth;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Account(int id, String yearmonth, String title, int price) {
		super();
		this.id = id;
		this.yearmonth = yearmonth;
		this.title = title;
		this.price = price;
	}
	public Account() {
		super();
	}
	@Override
	public String toString() {
		return "Account [id=" + id + ", yearmonth=" + yearmonth + ", title=" + title + ", price=" + price + "]";
	}
	
	
	
	
	
	
	
	
	
}
