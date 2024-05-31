package com.sdm.ssm.admin.service;

import java.util.ArrayList;

import com.sdm.ssm.admin.model.vo.CountUser;
import com.sdm.ssm.admin.model.vo.Notice;
import com.sdm.ssm.admin.model.vo.Sales;
import com.sdm.ssm.admin.model.vo.Suspension;
import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.user.model.vo.User;

public interface UserManageService {

	int selectListCount();

	ArrayList<User> selectList(Paging paging);

	int updateUserAccountSuspendMethod(int id);

	int updateUserAccountActivateMethod(int id);

	void insertSuspension(Suspension suspension);

	void updateSuspension(int id);

	ArrayList<Suspension> selectSuspenseList(String userId);

	int selectSearchIdCount(String keyword);

	int selectSearchStoreCount(String keyword);

	ArrayList<User> selectSearchId(Search search);

	ArrayList<User> selectSearchStore(Search search);

	String selectSuspenseNo(int targetAccount);

	ArrayList<CountUser> selectCountUserByEnrollDate(int year);

	ArrayList<CountUser> selectCountUserByServiceDate(int year);

	ArrayList<Sales> selectSalesList(int year);



}
