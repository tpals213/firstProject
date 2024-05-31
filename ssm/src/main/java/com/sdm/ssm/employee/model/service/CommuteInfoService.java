package com.sdm.ssm.employee.model.service;

import java.util.List;

import com.sdm.ssm.employee.model.vo.CommuteInfo;

public interface CommuteInfoService {

	List<CommuteInfo> searchCommuteInfoByName(String empName);

	boolean recordCommuteInfo(CommuteInfo commuteInfo);

	List<CommuteInfo> commuteInfoPage(int id);

}
