package com.sdm.ssm.subscribe.model.vo;

public class Subscribe implements java.io.Serializable {
	private static final long serialVersionUID = 9164753701746237327L;
	private int subscribeNo;
	private String subscribeName;
	private int price;
	private String subscribeDate;
	
	
	
	public Subscribe() {
		super();
	}
	public Subscribe(int subscribeNo, String subscribeName, int price, String subscribeDate) {
		super();
		this.subscribeNo = subscribeNo;
		this.subscribeName = subscribeName;
		this.price = price;
		this.subscribeDate = subscribeDate;
	}
	public int getSubscribeNo() {
		return subscribeNo;
	}
	public void setSubscribeNo(int subscribeNo) {
		this.subscribeNo = subscribeNo;
	}
	public String getSubscribeName() {
		return subscribeName;
	}
	public void setSubscribeName(String subscribeName) {
		this.subscribeName = subscribeName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getSubscribeDate() {
		return subscribeDate;
	}
	public void setSubscribeDate(String subscribeDate) {
		this.subscribeDate = subscribeDate;
	}
	@Override
	public String toString() {
		return "Subscribe [subscribeNo=" + subscribeNo + ", subscribeName=" + subscribeName + ", price=" + price
				+ ", subscribeDate=" + subscribeDate + "]";
	}
	
}
