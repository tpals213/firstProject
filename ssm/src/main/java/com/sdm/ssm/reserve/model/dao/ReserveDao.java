package com.sdm.ssm.reserve.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdm.ssm.common.SerachDateStr;
import com.sdm.ssm.reserve.model.vo.DateData;
import com.sdm.ssm.reserve.model.vo.Reserve;
import com.sdm.ssm.reserve.model.vo.ScheduleDto;

@Repository("reserveDao")
public class ReserveDao {
	private static final Logger logger = LoggerFactory.getLogger(ReserveDao.class);

	@Autowired //root-context.xml 에서 생성한 객체를 자동 연결함
	private SqlSessionTemplate sqlSessionTemplate;

	public int insertReserve(Reserve reserve) {
		return sqlSessionTemplate.insert("reserveMapper.insertReserve", reserve);
	}

	public int updateReserve(Reserve reserve) {
		return sqlSessionTemplate.update("reserveMapper.updateReserve", reserve);
	}

	public int deleteReserve(Reserve reserve) {
		return sqlSessionTemplate.delete("reserveMapper.deleteReserve", reserve);
	}
	
	/// 예약 내용 조회 상세
	public Reserve selectRsrvDetail(Reserve reserve) {
		return sqlSessionTemplate.selectOne("reserveMapper.selectRsrvDetail", reserve);
	}

	//// 목록 조회(2024.04.04)
	public ArrayList<Reserve> selectRsrvList(SerachDateStr serachDateStr) {
		List<Reserve> list = sqlSessionTemplate.selectList("reserveMapper.selectRsrvList", serachDateStr);
		return (ArrayList<Reserve>)list;
	}

}
