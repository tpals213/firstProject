package com.sdm.ssm.user.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdm.ssm.user.model.vo.User;
import com.sdm.ssm.user.model.vo.UserFinkOut;

@Repository("userDao")
public class UserDao {
	private static final Logger logger = LoggerFactory.getLogger(UserDao.class);
	
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public User selectUserById(String userId) {
		logger.info(userId);
		
		return sqlSessionTemplate.selectOne("userMapper.selectUserById", userId);
	}

	public int selectUserCountById(String userId) {
		return sqlSessionTemplate.selectOne("userMapper.selectUserCountById", userId);
	}

	public int insertUser(User user) {
		logger.info(user.toString());
		return sqlSessionTemplate.insert("userMapper.insertUser", user);
	}

	public int updateUser(User user) {
		return sqlSessionTemplate.update("userMapper.updateUser", user);
	}

	public User searchIdByEmailBName(User user) {
		return sqlSessionTemplate.selectOne("userMapper.selectUserIdByEmailBName", user);
	}

	public User selectUserByEmailId(User user) {
		return sqlSessionTemplate.selectOne("userMapper.selectUserByEmailId", user);
	}

	public int updateUserPw(User user) {
		return sqlSessionTemplate.update("userMapper.updateUserPw", user);
	}

	public int updateUserLoginOkToNByUserId(String userId) {
		return sqlSessionTemplate.update("userMapper.updateUserLoginOkToNByUserId", userId);
	}

	public int insertUserFinkOut(UserFinkOut userFO) {
		return sqlSessionTemplate.insert("userMapper.insertUserFinkOut", userFO);
	}

}
