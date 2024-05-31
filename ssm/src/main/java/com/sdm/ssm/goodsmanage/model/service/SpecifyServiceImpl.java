package com.sdm.ssm.goodsmanage.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.goodsmanage.model.dao.GoodsPrintDao;
import com.sdm.ssm.goodsmanage.model.dao.SpecifyDao;
import com.sdm.ssm.goodsmanage.model.vo.Specify;

@Service
public class SpecifyServiceImpl implements SpecifyService{

	@Autowired	//자동 DI 처리됨; 자동 객체 생성됨
	private SpecifyDao specifyDao;
	
	@Override
	public int insertSpeify(Specify specify) {
		return specifyDao.insertSpeicfy(specify);
	}

	@Override
	public int calMonthlyPdPrice(Specify specify) {
		return specifyDao.calMonthlyPdPrice(specify);
	}

}
