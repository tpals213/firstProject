package com.sdm.ssm.subscribe.model.vo;

import java.sql.Date;

public class SubscribePayments implements java.io.Serializable {

	private static final long serialVersionUID = 4236789149721708552L;
	private int payNo;
	private String SubscribeName;
	private int amount;
	private int userId;
	private String payMethod;
	private Date payDate;
	
	public SubscribePayments() {
		super();
	}
	public int getPayNo() {
		return payNo;
	}
	public void setPayNo(int payNo) {
		this.payNo = payNo;
	}
	public String getSubscribeName() {
		return SubscribeName;
	}
	public void setSubscribeName(String subscribeName) {
		SubscribeName = subscribeName;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getPayMethod() {
		return payMethod;
	}
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}
	public Date getPayDate() {
		return payDate;
	}
	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}
	@Override
	public String toString() {
		return "SubscribePayments [payNo=" + payNo + ", SubscribeName=" + SubscribeName + ", amount=" + amount
				+ ", userId=" + userId + ", payMethod=" + payMethod + ", payDate=" + payDate + "]";
	}
	
	
}
