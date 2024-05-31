package com.sdm.ssm.employee.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.employee.model.dao.CommuteInfoDao;
import com.sdm.ssm.employee.model.vo.CommuteInfo;

@Service("CommuteInfoService")
public class CommuteInfoServiceImpl implements CommuteInfoService {
   
	@Autowired
    private CommuteInfoDao commuteInfoDao;

	@Override
	public List<CommuteInfo> searchCommuteInfoByName(String empName) {
        return commuteInfoDao.searchCommuteInfoByName(empName);
	}

	@Override
	public boolean recordCommuteInfo(CommuteInfo commuteInfo) {
		return commuteInfoDao.recordCommuteInfo(commuteInfo);
	}

	@Override
	public List<CommuteInfo> commuteInfoPage(int id) {
		return commuteInfoDao.commuteInfoPage(id);
	}
}
