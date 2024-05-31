package com.sdm.ssm.account.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdm.ssm.account.model.vo.Account;

@Repository
public class AccountDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public int countNull(Account account) {
		return sqlSessionTemplate.selectOne("accountMapper.countNull", account);
	}

	public int insertAccount(Account account) {
		return sqlSessionTemplate.insert("accountMapper.insertAccount", account);
	}

	public int updateAccount(Account account) {
		return sqlSessionTemplate.insert("accountMapper.updateAccount", account);
	}

	public int calCost(Account account) {
		return sqlSessionTemplate.selectOne("accountMapper.calCost", account);
	}

	public int calTax(Account account) {
		return sqlSessionTemplate.selectOne("accountMapper.calTax", account);
	}

	public int calRent(Account account) {
		return sqlSessionTemplate.selectOne("accountMapper.calRent", account);
	}

	public int calSale(Account account) {
		return sqlSessionTemplate.selectOne("accountMapper.calSale", account);
	}
	
}
