package com.sdm.ssm.employee.model.vo;

public class RecordTime {
	private String username;
	private CommuteInfo commuteInfo;

	public RecordTime(String username, CommuteInfo commuteInfo) {
		super();
		this.username = username;
		this.commuteInfo = commuteInfo;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public CommuteInfo getCommuteInfo() {
		return commuteInfo;
	}

	public void setCommuteInfo(CommuteInfo commuteInfo) {
		this.commuteInfo = commuteInfo;
	}

	@Override
	public String toString() {
		return "RecordTime [username=" + username + ", commuteInfo=" + commuteInfo + "]";
	}
}
