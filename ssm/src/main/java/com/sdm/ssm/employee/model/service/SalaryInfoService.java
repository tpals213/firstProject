package com.sdm.ssm.employee.model.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.sdm.ssm.common.Search;
import com.sdm.ssm.employee.model.vo.SalaryInfo;

public interface SalaryInfoService {

	ArrayList<SalaryInfo> selectSalaryInfoMethod(int empId);

	SalaryInfo selectSalaryInfoByEmpId(int Id);

	List<SalaryInfo> getSalaryDate(int Id);

	int updateSalary(int id);

	int insertSalaryPage(int id);

	List<SalaryInfo> searchSalary(Search search);
	
}
