package com.sdm.ssm.employee.model.vo;

import java.sql.Date;

public class Employee implements java.io.Serializable{

	private static final long serialVersionUID = -2506737202711282777L;
		
	private int empId;
	private String empName;
	private String position;
	private Date empHireDate;	
	private String empPhone;
	private String empEmail;
	private String empAddress;
	private String empBirthDate;
	private String empGender;
	
	private int id;

	public Employee() {
		super();
	}
	
	public Employee(int empId, String empName, String position, Date empHireDate, String empPhone, String empEmail,
			String empAddress, String empBirthDate, String empGender, int id) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.position = position;
		this.empHireDate = empHireDate;
		this.empPhone = empPhone;
		this.empEmail = empEmail;
		this.empAddress = empAddress;
		this.empBirthDate = empBirthDate;
		this.empGender = empGender;
		this.id = id;
	}
	public Employee(Long empId2, String string, String string2, String string3, String string4, String string5,
			String string6, String string7, String string8) {
		// TODO Auto-generated constructor stub
	}

	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public Date getEmpHireDate() {
		return empHireDate;
	}
	public void setEmpHireDate(Date empHireDate) {
		this.empHireDate = empHireDate;
	}
	public String getEmpPhone() {
		return empPhone;
	}
	public void setEmpPhone(String empPhone) {
		this.empPhone = empPhone;
	}
	public String getEmpEmail() {
		return empEmail;
	}
	public void setEmpEmail(String empEmail) {
		this.empEmail = empEmail;
	}
	public String getEmpAddress() {
		return empAddress;
	}
	public void setEmpAddress(String empAddress) {
		this.empAddress = empAddress;
	}
	public String getEmpBirthDate() {
		return empBirthDate;
	}
	public void setEmpBirthDate(String empBirthDate) {
		this.empBirthDate = empBirthDate;
	}
	public String getEmpGender() {
		return empGender;
	}
	public void setEmpGender(String empGender) {
		this.empGender = empGender;
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
		return "Employee [empId=" + empId + ", empName=" + empName + ", position=" + position + ", empHireDate="
				+ empHireDate + ", empPhone=" + empPhone + ", empEmail=" + empEmail + ", empAddress=" + empAddress
				+ ", empBirthDate=" + empBirthDate + ", empGender=" + empGender + ", id=" + id + "]";
	}

	
	
	
}
