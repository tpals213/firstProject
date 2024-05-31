package com.sdm.ssm.goodsmanage.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdm.ssm.goodsmanage.model.vo.Specify;

@Repository
public class SpecifyDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int insertSpeicfy(Specify specify) {
		return sqlSessionTemplate.insert("specifyMapper.insertSpecify", specify);
	}

	public int calMonthlyPdPrice(Specify specify) {
		return sqlSessionTemplate.selectOne("specifyMapper.calMonthlyPdPrice", specify);
	}

}
