package com.sdm.ssm.employee.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.employee.model.dao.CalendarDao;
import com.sdm.ssm.employee.model.vo.Calendar;

@Service("CalendarService")
public class CalendarServiceImpl implements CalendarService {
	
	@Autowired
	private CalendarDao calendDao;

	@Override
	public List<Calendar> getAllcalendar(int id) {
		return calendDao.getAllcalendar(id);
	}
}
