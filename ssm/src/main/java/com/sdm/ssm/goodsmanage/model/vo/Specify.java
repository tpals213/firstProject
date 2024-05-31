package com.sdm.ssm.goodsmanage.model.vo;

import java.util.Date;

public class Specify implements java.io.Serializable{

	private static final long serialVersionUID = -24672002857221168L;
	
	private int id;
	private String pdDate;
	private int pdPrice;
	private String pdMonth;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPdDate() {
		return pdDate;
	}
	public void setPdDate(String pdDate) {
		this.pdDate = pdDate;
	}
	public int getPdPrice() {
		return pdPrice;
	}
	public void setPdPrice(int pdPrice) {
		this.pdPrice = pdPrice;
	}
	public String getPdMonth() {
		return pdMonth;
	}
	public void setPdMonth(String pdMonth) {
		this.pdMonth = pdMonth;
	}
	public Specify(int id, String pdDate, int pdPrice, String pdMonth) {
		super();
		this.id = id;
		this.pdDate = pdDate;
		this.pdPrice = pdPrice;
		this.pdMonth = pdMonth;
	}
	public Specify() {
		super();
	}
	@Override
	public String toString() {
		return "Specify [id=" + id + ", pdDate=" + pdDate + ", pdPrice=" + pdPrice + ", pdMonth=" + pdMonth + "]";
	}
	
	
	
	
	
	
}
