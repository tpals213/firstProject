package com.sdm.ssm.reserve.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.common.SerachDateStr;
import com.sdm.ssm.reserve.model.dao.ReserveDao;
import com.sdm.ssm.reserve.model.vo.DateData;
import com.sdm.ssm.reserve.model.vo.Reserve;
import com.sdm.ssm.reserve.model.vo.ScheduleDto;

@Service("reserveService")
public class ReserveServiceImpl implements ReserveService {
	//dao 와 연결 처리 : DI(Dependency Injection : 의존성 주입)
	@Autowired //자동 DI 처리됨 ; 자동 객체 생성됨
	private ReserveDao reserveDao;

	@Override
	public int insertReserve(Reserve reserve) {
		return reserveDao.insertReserve(reserve);
	}

	@Override
	public int updateReserve(Reserve reserve) {
		return reserveDao.updateReserve(reserve);
	}

	@Override
	public int deleteReserve(Reserve reserve) {
		return reserveDao.deleteReserve(reserve);
	}

	@Override
	public Reserve selectRsrvDetail(Reserve reserve) {
		return reserveDao.selectRsrvDetail(reserve);
	}
	
	@Override //// 2024.04.04
	public ArrayList<Reserve> selectRsrvList(SerachDateStr serachDateStr) {
		return reserveDao.selectRsrvList(serachDateStr);
	}
}
