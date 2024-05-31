package com.sdm.ssm.user.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.user.model.dao.UserDao;
import com.sdm.ssm.user.model.vo.User;
import com.sdm.ssm.user.model.vo.UserFinkOut;


public interface UserService {

	Object searchIdByEmailBName = null;

	User selectUserById(String userId);

	int selectUserCountById(String userId);

	int insertUser(User user);

	int updateUser(User user);

	User searchIdByEmailBName(User user);

	User selectUserByEmailId(User user);

	int updateUserPw(User user);

	int updateUserLoginOkToNByUserId(String userId);

	int insertUserFinkOut(UserFinkOut userFO);

}
