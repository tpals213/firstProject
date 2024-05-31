package com.sdm.ssm.subscribe.model.service;

import java.util.ArrayList;

import com.sdm.ssm.subscribe.model.vo.Subscribe;
import com.sdm.ssm.subscribe.model.vo.SubscribePayments;
import com.sdm.ssm.subscribe.model.vo.UserSubscribe;

public interface SubscribeService {

	ArrayList<Subscribe> selectList();

	int updateUserServiceDate(UserSubscribe userSubscribe);

	int insertSubscribePayment(UserSubscribe userSubscribe);

	int updateUserServiceDate2(UserSubscribe userSubscribe);

	int updateSubscribe(Subscribe subscribe);

	int deleteSubscribe(Subscribe subscribe);

	int insertSubscribe(Subscribe subscribe);

	Subscribe selectSub(int subscribeNo);

	ArrayList<SubscribePayments> selectSubscribePaymentsByUserId(int id);

}
