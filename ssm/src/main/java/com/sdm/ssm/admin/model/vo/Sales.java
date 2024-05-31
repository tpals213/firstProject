package com.sdm.ssm.admin.model.vo;

public class Sales implements java.io.Serializable {

	private static final long serialVersionUID = -1063615515318544469L;
	private String month;
	private int sales;
	
	public Sales() {
		super();
	}
	public Sales(String month, int sales) {
		super();
		this.month = month;
		this.sales = sales;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getSales() {
		return sales;
	}
	public void setSales(int sales) {
		this.sales = sales;
	}
	@Override
	public String toString() {
		return "Sales [month=" + month + ", sales=" + sales + "]";
	}
	
}
