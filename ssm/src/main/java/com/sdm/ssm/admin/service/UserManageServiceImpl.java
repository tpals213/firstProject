package com.sdm.ssm.admin.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.admin.dao.UserManageDao;
import com.sdm.ssm.admin.model.vo.CountUser;
import com.sdm.ssm.admin.model.vo.Notice;
import com.sdm.ssm.admin.model.vo.Sales;
import com.sdm.ssm.admin.model.vo.Suspension;
import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.user.model.vo.User;

@Service("userManageService")
public class UserManageServiceImpl implements UserManageService{

	@Autowired
	private UserManageDao umDao;

	@Override
	public int selectListCount() {
		
		return umDao.selectListCount();
	}

	@Override
	public ArrayList<User> selectList(Paging paging) {
		
		return umDao.selectList(paging);
	}

	@Override
	public int updateUserAccountSuspendMethod(int id) {
		return umDao.updateUserAccountSuspendMethod(id);
		
	}

	@Override
	public int updateUserAccountActivateMethod(int id) {
		return umDao.updateUserAccountActivateMethod(id);
		
	}

	@Override
	public void insertSuspension(Suspension suspension) {
		umDao.insertSuspension(suspension);		
	}

	@Override
	public void updateSuspension(int id) {
		umDao.updateSuspension(id);
	}

	@Override
	public ArrayList<Suspension> selectSuspenseList(String userId) {
		
		return umDao.selectSuspenseList(userId);
	}

	@Override
	public int selectSearchIdCount(String keyword) {
		
		return umDao.selectSearchIdCount(keyword);
	}

	@Override
	public int selectSearchStoreCount(String keyword) {

		return umDao.selectSearchStoreCount(keyword);
	}

	@Override
	public ArrayList<User> selectSearchId(Search search) {

		return umDao.selectSearchId(search);
	}

	@Override
	public ArrayList<User> selectSearchStore(Search search) {

		return umDao.selectSearchStore(search);
	}

	@Override
	public String selectSuspenseNo(int targetAccount) {
		// TODO Auto-generated method stub
		return umDao.selectSuspenseNo(targetAccount);
	}

	@Override
	public ArrayList<CountUser> selectCountUserByEnrollDate(int year) {
		
		return umDao.selectCountUserByEnrollDate(year);
	}

	@Override
	public ArrayList<CountUser> selectCountUserByServiceDate(int year) {

		return umDao.selectCountUserByServiceDate(year);
	}

	@Override
	public ArrayList<Sales> selectSalesList(int year) {
		return umDao.selectSalesList(year);
	}


}
