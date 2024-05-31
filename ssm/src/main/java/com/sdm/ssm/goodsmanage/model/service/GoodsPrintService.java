package com.sdm.ssm.goodsmanage.model.service;

import java.util.ArrayList;

import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.goodsmanage.model.vo.GoodsPrint;

public interface GoodsPrintService {

	// 전체보기
	int selectListCount(int id);

	ArrayList<GoodsPrint> selectGoodsPrint(Paging paging);

	// 상품명 검색
	int selectSearchGoodsNameCount(Search search);

	ArrayList<GoodsPrint> selectSearchGoodsName(Search search);
	
	// 발주처 검색
	int selectSearchPdNameCount(Search search);

	ArrayList<GoodsPrint> selectSearchPdName(Search search);

	// 상품 등록
	int insertGoods(GoodsPrint goodsPrint);

	// 상품 삭제
	int deleteGoods(GoodsPrint goodsPrint);

	// 발주처 리스트
	ArrayList<GoodsPrint> selectProducePrint(Paging paging);

	// 명세서 - 상품명
	ArrayList<GoodsPrint> selectSSearchGoodsName(Search search);

	// 명세서 - 발주처
	ArrayList<GoodsPrint> selectSSearchpdName(Search search);

	// 발주처 등록
	int insertProduce(GoodsPrint goodsPrint);

	// 발주처 삭제
	int deleteProduce(GoodsPrint goodsPrint);

	// 상품 수정 - 상품 테이블
	int updateGoodsGT(GoodsPrint goodsPrint);

	// 상품 수정 - 재고 테이블
	int updateGoodsIT(GoodsPrint goodsPrint);

	// 발주처 수정 - 상품 테이블
	int updateProduceGT(GoodsPrint goodsPrint);

	// 발주처 수정 - 발주처 테이블
	int updateProducePT(GoodsPrint goodsPrint);

	// 상품 등록 - 첫번째
	int firstGoods(int id);

	int insertFirstGoods(GoodsPrint goodsPrint);

	int searchId(GoodsPrint goodsPrint);

	int updatePdQuantity(GoodsPrint goodsPrint);

	int originQuantity(GoodsPrint goodsPrint);
	

}
