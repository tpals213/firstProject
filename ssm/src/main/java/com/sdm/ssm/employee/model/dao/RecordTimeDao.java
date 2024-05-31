package com.sdm.ssm.employee.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdm.ssm.employee.model.vo.Employee;

@Repository("recordTimeDao")
public class RecordTimeDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public void insertTime(Employee emp) {
		sqlSessionTemplate.insert("employeeMapper.insertStartTime", emp);
		
	}

	public void updateTime(Employee emp) {
		sqlSessionTemplate.update("employeeMapper.updateEndTime",emp);
		
	}
}
