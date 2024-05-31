package com.sdm.ssm.user.model.vo;

import java.sql.Date;

public class User implements java.io.Serializable {
	private static final long serialVersionUID = -6769960477240315696L;

	private int id;
	private String userId;
	private String passWd;
	private String email;
	private String userNo;
	private String phone;
	private String accountNumber;
	private String bankName;
	private String profileUrl;
	private String isQuit;
	private String adminOk;
	private String loginOk;
	private java.sql.Date lastModified;
	private java.sql.Date serviceDate;
	private String businessNo;
	private String businessStoreName;

	public User() {
		super();
	}

	public User(int id, String userId, String passWd, String email, String userNo, String phone, String accountNumber,
			String bankName, String profileUrl, String isQuit, String adminOk, String loginOk, Date lastModified,
			Date serviceDate, String businessNo, String businessStoreName) {
		super();
		this.id = id;
		this.userId = userId;
		this.passWd = passWd;
		this.email = email;
		this.userNo = userNo;
		this.phone = phone;
		this.accountNumber = accountNumber;
		this.bankName = bankName;
		this.profileUrl = profileUrl;
		this.isQuit = isQuit;
		this.adminOk = adminOk;
		this.loginOk = loginOk;
		this.lastModified = lastModified;
		this.serviceDate = serviceDate;
		this.businessNo = businessNo;
		this.businessStoreName = businessStoreName;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassWd() {
		return passWd;
	}

	public void setPassWd(String passWd) {
		this.passWd = passWd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUserNo() {
		return userNo;
	}

	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getProfileUrl() {
		return profileUrl;
	}

	public void setProfileUrl(String profileUrl) {
		this.profileUrl = profileUrl;
	}

	public String getIsQuit() {
		return isQuit;
	}

	public void setIsQuit(String isQuit) {
		this.isQuit = isQuit;
	}

	public String getAdminOk() {
		return adminOk;
	}

	public void setAdminOk(String adminOk) {
		this.adminOk = adminOk;
	}

	public String getLoginOk() {
		return loginOk;
	}

	public void setLoginOk(String loginOk) {
		this.loginOk = loginOk;
	}

	public java.sql.Date getLastModified() {
		return lastModified;
	}

	public void setLastModified(java.sql.Date lastModified) {
		this.lastModified = lastModified;
	}

	public java.sql.Date getServiceDate() {
		return serviceDate;
	}

	public void setServiceDate(java.sql.Date serviceDate) {
		this.serviceDate = serviceDate;
	}

	public String getBusinessNo() {
		return businessNo;
	}

	public void setBusinessNo(String businessNo) {
		this.businessNo = businessNo;
	}

	public String getBusinessStoreName() {
		return businessStoreName;
	}

	public void setBusinessStoreName(String businessStoreName) {
		this.businessStoreName = businessStoreName;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", userId=" + userId + ", passWd=" + passWd + ", email=" + email + ", userNo="
				+ userNo + ", phone=" + phone + ", accountNumber=" + accountNumber + ", bankName=" + bankName
				+ ", profileUrl=" + profileUrl + ", isQuit=" + isQuit + ", adminOk=" + adminOk + ", loginOk=" + loginOk
				+ ", lastModified=" + lastModified + ", serviceDate=" + serviceDate + ", businessNo=" + businessNo
				+ ", businessStoreName=" + businessStoreName + "]";
	}

}
