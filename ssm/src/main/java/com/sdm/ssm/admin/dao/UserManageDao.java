package com.sdm.ssm.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdm.ssm.admin.model.vo.CountUser;
import com.sdm.ssm.admin.model.vo.Notice;
import com.sdm.ssm.admin.model.vo.Sales;
import com.sdm.ssm.admin.model.vo.Suspension;
import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.user.model.vo.User;

@Repository("userManagerDao")
public class UserManageDao {
	private static final Logger logger = LoggerFactory.getLogger(UserManageDao.class);
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	public int selectListCount() {
		
		return sqlSessionTemplate.selectOne("userMapper.selectListCount");
	}
	public ArrayList<User> selectList(Paging paging) {
		List<User> list = sqlSessionTemplate.selectList("userMapper.selectList", paging);
		return (ArrayList<User>)list;
	}
	public int updateUserAccountSuspendMethod(int id) {
		return sqlSessionTemplate.update("userManageMapper.updateUserAccountSuspendMethod", id);
	}
	public int updateUserAccountActivateMethod(int id) {
		return sqlSessionTemplate.update("userManageMapper.updateUserAccountActivateMethod", id);
	}
	public void insertSuspension(Suspension suspension) {
		sqlSessionTemplate.insert("userManageMapper.insertSuspension", suspension);
	}
	public void updateSuspension(int id) {
		sqlSessionTemplate.update("userManageMapper.updateSuspension",id);
	}
	public ArrayList<Suspension> selectSuspenseList(String userId) {
		List<Suspension> list = sqlSessionTemplate.selectList("userManageMapper.selectSuspenseList", userId);
		return (ArrayList<Suspension>)list;
	}
	public int selectSearchIdCount(String keyword) {
		
		return sqlSessionTemplate.selectOne("userManageMapper.selectSearchIdCount", keyword);
	}
	public int selectSearchStoreCount(String keyword) {

		return sqlSessionTemplate.selectOne("userManageMapper.selectSearchStoreCount", keyword);
	}
	public ArrayList<User> selectSearchId(Search search) {
		List<User> list = sqlSessionTemplate.selectList("userManageMapper.selectSearchId", search);
		return (ArrayList<User>)list;
	}
	public ArrayList<User> selectSearchStore(Search search) {
		List<User> list = sqlSessionTemplate.selectList("userManageMapper.selectSearchStore", search);
		return (ArrayList<User>)list;
	}
	public String selectSuspenseNo(int targetAccount) {
		
		return sqlSessionTemplate.selectOne("userManageMapper.selectSuspenseNo", targetAccount);
	}
	public ArrayList<CountUser> selectCountUserByEnrollDate(int year) {
		List<CountUser> list = sqlSessionTemplate.selectList("userManageMapper.selectCountUserByEnrollDate", year);
		return (ArrayList<CountUser>)list;
	}
	public ArrayList<CountUser> selectCountUserByServiceDate(int year) {
		List<CountUser> list = sqlSessionTemplate.selectList("userManageMapper.selectCountUserByServiceDate", year);
		return (ArrayList<CountUser>)list;
	}
	public ArrayList<Sales> selectSalesList(int year) {
		List<Sales> list = sqlSessionTemplate.selectList("userManageMapper.selectSalesList", year);
		return (ArrayList<Sales>)list;
	}

	
}
