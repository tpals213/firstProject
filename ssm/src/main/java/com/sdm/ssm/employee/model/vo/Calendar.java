package com.sdm.ssm.employee.model.vo;

public class Calendar implements java.io.Serializable {

	private static final long serialVersionUID = 6683630568867121080L;

	private int empId;
	private String remarks;
	private int id;
	
	public Calendar() {
		super();
	}

	public Calendar(int empId, String remarks, int id) {
		super();
		this.empId = empId;
		this.remarks = remarks;
		this.id = id;
	}

	public int getEmpId() {
		return empId;
	}

	public void setEmpId(int empId) {
		this.empId = empId;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
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
		return "Calendar [empId=" + empId + ", remarks=" + remarks + ", id=" + id + "]";
	}

	
}