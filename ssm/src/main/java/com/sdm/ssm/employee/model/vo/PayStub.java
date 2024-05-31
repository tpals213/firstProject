package com.sdm.ssm.employee.model.vo;

import java.sql.Date;

public class PayStub implements java.io.Serializable {
	private static final long serialVersionUID = 8828657696150860426L;
	private int payStubId;
	private int empId;
	private Date payDate;
	private int salaryAmount;
	private int id;
	public PayStub(int payStubId, int empId, Date payDate, int salaryAmount, int id) {
		super();
		this.payStubId = payStubId;
		this.empId = empId;
		this.payDate = payDate;
		this.salaryAmount = salaryAmount;
		this.id = id;
	}
	public PayStub() {
		super();
	}
	public int getPayStubId() {
		return payStubId;
	}
	public void setPayStubId(int payStubId) {
		this.payStubId = payStubId;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public Date getPayDate() {
		return payDate;
	}
	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}
	public int getSalaryAmount() {
		return salaryAmount;
	}
	public void setSalaryAmount(int salaryAmount) {
		this.salaryAmount = salaryAmount;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "PayStub [payStubId=" + payStubId + ", empId=" + empId + ", payDate=" + payDate + ", salaryAmount="
				+ salaryAmount + ", id=" + id + "]";
	}
	
}
