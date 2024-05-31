package com.sdm.ssm.employee.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdm.ssm.employee.model.vo.Calendar;

@Repository("calentdarDao")
public class CalendarDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<Calendar> getAllcalendar(int id) {
		return sqlSessionTemplate.selectList("employeeMapper.selectCalendar",id);
	}
	
}
