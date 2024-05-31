package com.sdm.ssm.goodsmanage.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.goodsmanage.model.dao.GoodsPrintDao;
import com.sdm.ssm.goodsmanage.model.vo.GoodsPrint;

@Service
public class GoodsPrintServiceImpl implements GoodsPrintService{

	@Autowired	//자동 DI 처리됨; 자동 객체 생성됨
	private GoodsPrintDao goodsPrintDao;

	// 전체 보기
	@Override
	public int selectListCount(int id) {
		return goodsPrintDao.selectListCount(id);
	}

	@Override
	public ArrayList<GoodsPrint> selectGoodsPrint(Paging paging) {
		return goodsPrintDao.selectGoodsPrint(paging);
	}

	
	// 상품명 검색
	@Override
	public int selectSearchGoodsNameCount(Search search) {
		return goodsPrintDao.selectSearchGoodsNameCount(search);
	}

	@Override
	public ArrayList<GoodsPrint> selectSearchGoodsName(Search search) {
		return goodsPrintDao.selecSearchGoodsName(search);
	}

	// 발주처 검색
	@Override
	public int selectSearchPdNameCount(Search search) {
		return goodsPrintDao.selectSearchPdNameCount(search);
	}

	@Override
	public ArrayList<GoodsPrint> selectSearchPdName(Search search) {
		return goodsPrintDao.selectSearchPdName(search);
	}

	// 상품 등록
	@Override
	public int insertGoods(GoodsPrint goodsPrint) {
		return goodsPrintDao.insertGoods(goodsPrint);
	}

	// 상픔 삭제
	@Override
	public int deleteGoods(GoodsPrint goodsPrint) {
		return goodsPrintDao.deleteGoods(goodsPrint);
	}

	// 발주처 보기
	@Override
	public ArrayList<GoodsPrint> selectProducePrint(Paging paging) {
		return goodsPrintDao.selectProducePrint(paging);
	}

	// 명세서 - 상품 이름 검색
	@Override
	public ArrayList<GoodsPrint> selectSSearchGoodsName(Search search) {
		return goodsPrintDao.selectSSearchGoodsName(search);
	}

	// 명세서 - 발주처 검색
	@Override
	public ArrayList<GoodsPrint> selectSSearchpdName(Search search) {
		return goodsPrintDao.selectSSearchpdName(search);
	}

	// 발주처 등록
	@Override
	public int insertProduce(GoodsPrint goodsPrint) {
		return goodsPrintDao.insertProduce(goodsPrint);
	}

	// 발주처 삭제
	@Override
	public int deleteProduce(GoodsPrint goodsPrint) {
		return goodsPrintDao.deleteProduce(goodsPrint);
	}

	// 상품 수정 - 상품 테이블
	@Override
	public int updateGoodsGT(GoodsPrint goodsPrint) {
		return goodsPrintDao.updateGoodsGT(goodsPrint);
	}

	// 상품 수정 - 재고 테이블
	@Override
	public int updateGoodsIT(GoodsPrint goodsPrint) {
		return goodsPrintDao.updateGoodsIT(goodsPrint);
	}

	// 발주처 수정 - 상품 테이블
	@Override
	public int updateProduceGT(GoodsPrint goodsPrint) {
		return goodsPrintDao.updateProduceGT(goodsPrint);
	}

	// 발주처 수정 - 발주처 테이블
	@Override
	public int updateProducePT(GoodsPrint goodsPrint) {
		return goodsPrintDao.updateProducePT(goodsPrint);
	}

	@Override
	public int firstGoods(int id) {
		return goodsPrintDao.firstGoods(id);
	}

	@Override
	public int insertFirstGoods(GoodsPrint goodsPrint) {
		return goodsPrintDao.insertFirstGoods(goodsPrint);
	}

	@Override
	public int searchId(GoodsPrint goodsPrint) {
		return goodsPrintDao.searchId(goodsPrint);
	}

	@Override
	public int updatePdQuantity(GoodsPrint goodsPrint) {
		return goodsPrintDao.updatePdQuantity(goodsPrint);
	}

	@Override
	public int originQuantity(GoodsPrint goodsPrint) {
		return goodsPrintDao.originQuantity(goodsPrint);
	}

	

	

	
	
	

	

}