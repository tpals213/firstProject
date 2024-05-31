package com.sdm.ssm.admin.model.vo;

import java.sql.Date;

public class Suspension {
	private int suspensionNo;
	private int targetAccount;
	private Date suspensionStart;
	private Date suspensionEnd;
	private String suspensionTitle;
	private String suspensionContent;
	
	public Suspension() {
		super();
	}

	public Suspension(int suspensionNo, int targetAccount, int adminNo, Date suspensionStart, Date suspensionEnd,
			String suspensionTitle, String suspensionContent) {
		super();
		this.suspensionNo = suspensionNo;
		this.targetAccount = targetAccount;
		this.suspensionStart = suspensionStart;
		this.suspensionEnd = suspensionEnd;
		this.suspensionTitle = suspensionTitle;
		this.suspensionContent = suspensionContent;
	}

	public int getSuspensionNo() {
		return suspensionNo;
	}

	public void setSuspensionNo(int suspensionNo) {
		this.suspensionNo = suspensionNo;
	}

	public int getTargetAccount() {
		return targetAccount;
	}

	public void setTargetAccount(int targetAccount) {
		this.targetAccount = targetAccount;
	}


	public Date getSuspensionStart() {
		return suspensionStart;
	}

	public void setSuspensionStart(Date suspensionStart) {
		this.suspensionStart = suspensionStart;
	}

	public Date getSuspensionEnd() {
		return suspensionEnd;
	}

	public void setSuspensionEnd(Date suspensionEnd) {
		this.suspensionEnd = suspensionEnd;
	}

	public String getSuspensionTitle() {
		return suspensionTitle;
	}

	public void setSuspensionTitle(String suspensionTitle) {
		this.suspensionTitle = suspensionTitle;
	}

	public String getSuspensionContent() {
		return suspensionContent;
	}

	public void setSuspensionContent(String suspensionContent) {
		this.suspensionContent = suspensionContent;
	}

	@Override
	public String toString() {
		return "Suspension [suspensionNo=" + suspensionNo + ", targetAccount=" + targetAccount 
				+ ", suspensionStart=" + suspensionStart + ", suspensionEnd=" + suspensionEnd + ", suspensionTitle="
				+ suspensionTitle + ", suspensionContent=" + suspensionContent + "]";
	}
	
	
	
}
