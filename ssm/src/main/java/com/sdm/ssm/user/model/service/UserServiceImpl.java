package com.sdm.ssm.user.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.user.model.dao.UserDao;
import com.sdm.ssm.user.model.vo.User;
import com.sdm.ssm.user.model.vo.UserFinkOut;

@Service("userService")
public class UserServiceImpl implements UserService{
	
	@Autowired
	private UserDao userDao;

	@Override
	public User selectUserById(String userId) {
		return userDao.selectUserById(userId);
		
	}

	@Override
	public int selectUserCountById(String userId) {
		return userDao.selectUserCountById(userId);
	}

	@Override
	public int insertUser(User user) {
		return userDao.insertUser(user);
	}

	@Override
	public int updateUser(User user) {
		return userDao.updateUser(user);
	}

	@Override
	public User searchIdByEmailBName(User user) {
		return userDao.searchIdByEmailBName(user);
	}

	@Override
	public User selectUserByEmailId(User user) {
		return userDao.selectUserByEmailId(user);
	}

	@Override
	public int updateUserPw(User user) {
		return userDao.updateUserPw(user);
	}

	@Override
	public int updateUserLoginOkToNByUserId(String userId) {
		return userDao.updateUserLoginOkToNByUserId(userId);
	}

	@Override
	public int insertUserFinkOut(UserFinkOut userFO) {
		return userDao.insertUserFinkOut(userFO);
	}



	
}	
