package com.sdm.ssm.employee.model.vo;

import java.sql.Date;

public class CommuteInfo implements java.io.Serializable{

	private static final long serialVersionUID = 7612326093915794134L;
	
	private int empId;
	private Date startTime;
	private Date workDay;
	private Date endTime;
	private String workingHours;
	private String lateFlag;
	private String leaveEarly;
	private String absenteeism;
	
	private int id;
	
	public CommuteInfo() {
		super();
	}

	public CommuteInfo(int empId, Date startTime, Date workDay, Date endTime, String workingHours, String lateFlag,
			String leaveEarly, String absenteeism, int id) {
		super();
		this.empId = empId;
		this.startTime = startTime;
		this.workDay = workDay;
		this.endTime = endTime;
		this.workingHours = workingHours;
		this.lateFlag = lateFlag;
		this.leaveEarly = leaveEarly;
		this.absenteeism = absenteeism;
		this.id = id;
	}

	public int getEmpId() {
		return empId;
	}

	public void setEmpId(int empId) {
		this.empId = empId;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getWorkDay() {
		return workDay;
	}

	public void setWorkDay(Date workDay) {
		this.workDay = workDay;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getWorkingHours() {
		return workingHours;
	}

	public void setWorkingHours(String workingHours) {
		this.workingHours = workingHours;
	}

	public String getLateFlag() {
		return lateFlag;
	}

	public void setLateFlag(String lateFlag) {
		this.lateFlag = lateFlag;
	}

	public String getLeaveEarly() {
		return leaveEarly;
	}

	public void setLeaveEarly(String leaveEarly) {
		this.leaveEarly = leaveEarly;
	}

	public String getAbsenteeism() {
		return absenteeism;
	}

	public void setAbsenteeism(String absenteeism) {
		this.absenteeism = absenteeism;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "CommuteInfo [empId=" + empId + ", startTime=" + startTime + ", workDay=" + workDay + ", endTime="
				+ endTime + ", workingHours=" + workingHours + ", lateFlag=" + lateFlag + ", leaveEarly=" + leaveEarly
				+ ", absenteeism=" + absenteeism + ", id=" + id + "]";
	}
	
	

}
