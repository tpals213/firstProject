package com.sdm.ssm.employee.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.employee.model.dao.RecordTimeDao;
import com.sdm.ssm.employee.model.vo.Employee;

@Service
public class RecordTimeServiceImpl implements RecordTimeService{
	
	@Autowired
	private RecordTimeDao recordTimeDao;

	@Override
	public void insertTime(Employee emp) {
		recordTimeDao.insertTime(emp);
		
	}

	@Override
	public void updateTime(Employee emp) {
		recordTimeDao.updateTime(emp);
		
	}
}
