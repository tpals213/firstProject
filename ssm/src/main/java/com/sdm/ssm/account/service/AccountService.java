package com.sdm.ssm.account.service;

import com.sdm.ssm.account.model.vo.Account;

public interface AccountService {

	int countNull(Account account);
	
	int insertAccount(Account account);

	int updateAccount(Account account);

	int calCost(Account account);

	int calTax(Account account);

	int calRent(Account account);

	int calSale(Account account);

}
