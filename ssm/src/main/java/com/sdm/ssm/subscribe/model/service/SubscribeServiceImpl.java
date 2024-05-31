package com.sdm.ssm.subscribe.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.subscribe.model.dao.SubscribeDao;
import com.sdm.ssm.subscribe.model.vo.Subscribe;
import com.sdm.ssm.subscribe.model.vo.SubscribePayments;
import com.sdm.ssm.subscribe.model.vo.UserSubscribe;

@Service("subscribeService")
public class SubscribeServiceImpl implements SubscribeService {

	@Autowired
	private SubscribeDao subscribeDao;
	
	@Override
	public ArrayList<Subscribe> selectList() {
		return subscribeDao.selectList();
	}

	@Override
	public int updateUserServiceDate(UserSubscribe userSubscribe) {
		return subscribeDao.updateUserServiceDate(userSubscribe);
	}

	@Override
	public int insertSubscribePayment(UserSubscribe userSubscribe) {
		
		return subscribeDao.insertSubscribePayment(userSubscribe);
	}

	@Override
	public int updateUserServiceDate2(UserSubscribe userSubscribe) {
		
		return subscribeDao.updateUserServiceDate2(userSubscribe);
	}

	@Override
	public int updateSubscribe(Subscribe subscribe) {
		return subscribeDao.updateSubscribe(subscribe);
	}

	@Override
	public int deleteSubscribe(Subscribe subscribe) {
		return subscribeDao.deleteSubscribe(subscribe);
	}

	@Override
	public int insertSubscribe(Subscribe subscribe) {
		return subscribeDao.insertSubscribe(subscribe);
	}

	@Override
	public Subscribe selectSub(int subscribeNo) {

		return subscribeDao.selectSub(subscribeNo);
	}

	@Override
	public ArrayList<SubscribePayments> selectSubscribePaymentsByUserId(int id) {

		return subscribeDao.selectSubscribePaymentsByUserId(id);
	}


	
}
