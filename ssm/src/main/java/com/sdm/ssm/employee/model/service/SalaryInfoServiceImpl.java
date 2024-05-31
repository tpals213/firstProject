package com.sdm.ssm.employee.model.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.common.Search;
import com.sdm.ssm.employee.model.dao.SalaryInfoDao;
import com.sdm.ssm.employee.model.vo.SalaryInfo;

@Service
public class SalaryInfoServiceImpl implements SalaryInfoService {
	
	@Autowired
	private SalaryInfoDao salaryInfoDao;

	@Override
	public ArrayList<SalaryInfo> selectSalaryInfoMethod(int empId) {
		return salaryInfoDao.selectSalaryInfoMethod(empId);
	}
	@Override
	public SalaryInfo selectSalaryInfoByEmpId(int Id) {
		return salaryInfoDao.selectSalaryInfoByEmpId(Id);
	}
	@Override
	public List<SalaryInfo> getSalaryDate(int Id) {
		return salaryInfoDao.getSalaryDate(Id);
	}
	@Override
	public int updateSalary(int id) {
		return salaryInfoDao.updateSalary(id);
	}
	@Override
	public int insertSalaryPage(int id) {
		return salaryInfoDao.insertSalaryPage(id);
	}
	@Override
	public List<SalaryInfo> searchSalary(Search search) {
		// TODO Auto-generated method stub
		return salaryInfoDao.searchSalary(search);
	}
	
}

