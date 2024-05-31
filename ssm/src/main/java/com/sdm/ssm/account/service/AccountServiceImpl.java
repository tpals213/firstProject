package com.sdm.ssm.account.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.account.dao.AccountDao;
import com.sdm.ssm.account.model.vo.Account;
import com.sdm.ssm.goodsmanage.model.service.GoodsPrintService;

@Service
public class AccountServiceImpl implements AccountService{

	@Autowired	//자동 DI 처리됨; 자동 객체 생성됨
	private AccountDao accountDao;

	@Override
	public int countNull(Account account) {
		return accountDao.countNull(account);
	}

	@Override
	public int insertAccount(Account account) {
		return accountDao.insertAccount(account);
		
	}

	@Override
	public int updateAccount(Account account) {
		return accountDao.updateAccount(account);
	}

	@Override
	public int calCost(Account account) {
		return accountDao.calCost(account);
	}

	@Override
	public int calTax(Account account) {
		return accountDao.calTax(account);
	}

	@Override
	public int calRent(Account account) {
		return accountDao.calRent(account);
	}

	@Override
	public int calSale(Account account) {
		return accountDao.calSale(account);
	}
	
	
	
	
}
