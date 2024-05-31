package com.sdm.ssm.subscribe.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdm.ssm.subscribe.model.vo.Subscribe;
import com.sdm.ssm.subscribe.model.vo.SubscribePayments;
import com.sdm.ssm.subscribe.model.vo.UserSubscribe;

@Repository("subscribeDao")
public class SubscribeDao {
	private static final Logger logger = LoggerFactory.getLogger(SubscribeDao.class);
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	public ArrayList<Subscribe> selectList() {
		List<Subscribe> list = sqlSessionTemplate.selectList("subscribeMapper.selectList");
		return (ArrayList<Subscribe>)list;
	}
	public int updateUserServiceDate(UserSubscribe userSubscribe) {
		return sqlSessionTemplate.update("subscribeMapper.updateUserServiceDate", userSubscribe);
	}
	public int insertSubscribePayment(UserSubscribe userSubscribe) {
		return sqlSessionTemplate.insert("subscribeMapper.insertSubscribePayment", userSubscribe);
	}
	public int updateUserServiceDate2(UserSubscribe userSubscribe) {
		return sqlSessionTemplate.update("subscribeMapper.updateUserServiceDate2", userSubscribe);
	}
	public int updateSubscribe(Subscribe subscribe) {
		return sqlSessionTemplate.update("subscribeMapper.updateSubscribe", subscribe);
	}
	public int deleteSubscribe(Subscribe subscribe) {
		return sqlSessionTemplate.delete("subscribeMapper.deleteSubscribe", subscribe);
	}
	public int insertSubscribe(Subscribe subscribe) {
		return sqlSessionTemplate.insert("subscribeMapper.insertSubscribe", subscribe);
	}
	public Subscribe selectSub(int subscribeNo) {
		
		return sqlSessionTemplate.selectOne("subscribeMapper.selectSub", subscribeNo);
	}
	public ArrayList<SubscribePayments> selectSubscribePaymentsByUserId(int id) {
		List<SubscribePayments> list =  sqlSessionTemplate.selectList("subscribeMapper.selectSubscribePaymentsByUserId", id);
		return (ArrayList<SubscribePayments>)list;
	}

}
