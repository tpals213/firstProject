package com.sdm.ssm.employee.model.dao;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdm.ssm.common.Search;
import com.sdm.ssm.employee.model.vo.SalaryInfo;

@Repository("salaryInfoDao")
public class SalaryInfoDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public ArrayList<SalaryInfo> selectSalaryInfoMethod(int empId) {
		List<SalaryInfo> list = sqlSessionTemplate.selectList("employeeMapper.selectAllSalaryInfos", empId);
		return (ArrayList<SalaryInfo>) list;
	}

	public boolean insertSalaryInfo(SalaryInfo salaryInfo) { 
		int rowsAffected = sqlSessionTemplate.insert("employeeMapper.insertSalaryInfo", salaryInfo);
	 return rowsAffected > 0;	
	 }
	public SalaryInfo selectSalaryInfoByEmpId(int id) {
		return sqlSessionTemplate.selectOne("employeeMapper.selectAllSalaryInfos", id);
	}

	public List<SalaryInfo> getSalaryDate(int id) {
		return sqlSessionTemplate.selectList("employeeMapper.selectAllSalaryInfos", id);
	}

	public int insertSalary(int id) {
		return sqlSessionTemplate.insert("employeeMapper.insertSalaryInfo", id);
	}

	public int updateSalary(int id) {
		return sqlSessionTemplate.update("employeeMapper.insertSalaryInfo", id);
	}

	public int insertSalaryPage(int id) {
		return sqlSessionTemplate.insert("employeeMapper.insertSalaryInfo", id);
	}

	public List<SalaryInfo> searchSalary(Search search) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("employeeMapper.selectAllSalaryInfos",search);
	}
}
