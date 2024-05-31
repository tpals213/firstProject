package com.sdm.ssm.employee.model.service;

import java.util.ArrayList;
import java.util.List;

import com.sdm.ssm.common.Search;
import com.sdm.ssm.employee.model.vo.CommuteInfo;
import com.sdm.ssm.employee.model.vo.Employee;

public interface EmployeeService {

	// 직원 목록
	List<Employee> getAllEmployees(int id);

	Employee getEmployeeDetails(int id,int empId);

	int insertEmployee(Employee employee);

	int deleteEmployee(Employee employee);

	List<Employee> employeeSearchMethod(Search search);

	List<Employee> searchEmployeeByName(String username);

	List<Employee> selectEmpList();

	ArrayList<Employee> employeeListMethod();

	int updateEmployee(Employee employee);

	Employee selectEmpInfo(Employee emp);

	List<Employee> selectemployee(int id);




}
