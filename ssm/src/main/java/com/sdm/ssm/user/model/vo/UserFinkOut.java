package com.sdm.ssm.user.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class UserFinkOut implements Serializable {
	private static final long serialVersionUID = -7336146344188285434L;

	private int finkOutNo;
	private String fUserId;
	private String fEmail;
	private java.sql.Date finkOutDate;

	public UserFinkOut() {
		super();
	}

	public UserFinkOut(int finkOutNo, String fUserId, String fEmail, Date finkOutDate) {
		super();
		this.finkOutNo = finkOutNo;
		this.fUserId = fUserId;
		this.fEmail = fEmail;
		this.finkOutDate = finkOutDate;
	}

	public int getFinkOutNo() {
		return finkOutNo;
	}

	public void setFinkOutNo(int finkOutNo) {
		this.finkOutNo = finkOutNo;
	}

	public String getfUserId() {
		return fUserId;
	}

	public void setfUserId(String fUserId) {
		this.fUserId = fUserId;
	}

	public String getfEmail() {
		return fEmail;
	}

	public void setfEmail(String fEmail) {
		this.fEmail = fEmail;
	}

	public java.sql.Date getFinkOutDate() {
		return finkOutDate;
	}

	public void setFinkOutDate(java.sql.Date finkOutDate) {
		this.finkOutDate = finkOutDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "UserFinkOut [finkOutNo=" + finkOutNo + ", fUserId=" + fUserId + ", fEmail=" + fEmail + ", finkOutDate="
				+ finkOutDate + "]";
	}

}
