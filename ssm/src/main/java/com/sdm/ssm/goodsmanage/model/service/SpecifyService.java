package com.sdm.ssm.goodsmanage.model.service;

import com.sdm.ssm.goodsmanage.model.vo.Specify;

public interface SpecifyService {

	int insertSpeify(Specify specify);

	int calMonthlyPdPrice(Specify specify);

}
