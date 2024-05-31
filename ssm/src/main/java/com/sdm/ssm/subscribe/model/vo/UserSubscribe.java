package com.sdm.ssm.subscribe.model.vo;

public class UserSubscribe implements java.io.Serializable {


	private static final long serialVersionUID = -6823267026155174503L;
	private int id;
	private int addMonth;
	private int subscribeNo;
	private String payMethod;
	private String subscribeName;
	private int amount;
	
	
	public UserSubscribe() {
		super();
	}
	
	public UserSubscribe(int id, int addMonth, int subscribeNo) {
		super();
		this.id = id;
		this.addMonth = addMonth;
		this.subscribeNo = subscribeNo;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getAddMonth() {
		return addMonth;
	}
	public void setAddMonth(int addMonth) {
		this.addMonth = addMonth;
	}
	public int getSubscribeNo() {
		return subscribeNo;
	}
	public void setSubscribeNo(int subscribeNo) {
		this.subscribeNo = subscribeNo;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "userSubscribe [id=" + id + ", addMonth=" + addMonth + ", SubscribeNo=" + subscribeNo +",payMethod="+payMethod+ "]";
	}

	public String getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	public String getSubscribeName() {
		return subscribeName;
	}

	public void setSubscribeName(String subscribeName) {
		this.subscribeName = subscribeName;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}
	
}
