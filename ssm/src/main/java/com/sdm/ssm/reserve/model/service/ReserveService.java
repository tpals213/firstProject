package com.sdm.ssm.reserve.model.service;

import java.util.ArrayList;

import com.sdm.ssm.admin.model.vo.Notice;
import com.sdm.ssm.common.SerachDateStr;
import com.sdm.ssm.reserve.model.vo.DateData;
import com.sdm.ssm.reserve.model.vo.Reserve;
import com.sdm.ssm.reserve.model.vo.ScheduleDto;

public interface ReserveService {

	int insertReserve(Reserve reserve);

	int updateReserve(Reserve reserve);

	int deleteReserve(Reserve reserve);

	//// 예약 내용 조회-상세
	Reserve selectRsrvDetail(Reserve reserve);
	
	/// 예약목록 조회
	ArrayList<Reserve> selectRsrvList(SerachDateStr serachDateStr);
}
