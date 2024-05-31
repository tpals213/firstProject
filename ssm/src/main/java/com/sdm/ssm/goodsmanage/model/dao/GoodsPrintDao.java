package com.sdm.ssm.goodsmanage.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.goodsmanage.controller.GoodsPrintController;
import com.sdm.ssm.goodsmanage.model.vo.GoodsPrint;

@Repository
public class GoodsPrintDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public int selectListCount(int id) {
		return sqlSessionTemplate.selectOne("goodsMapper.selectListCount", id);
	}

	public ArrayList<GoodsPrint> selectGoodsPrint(Paging paging){
		List<GoodsPrint>list =sqlSessionTemplate.selectList("goodsMapper.selectGoodsPrint", paging);
		return (ArrayList<GoodsPrint>)list;
	}

	// 상품명 검색
	public int selectSearchGoodsNameCount(Search search) {
		return sqlSessionTemplate.selectOne("goodsMapper.selectSearchGoodsNameCount", search);
	}

	public ArrayList<GoodsPrint> selecSearchGoodsName(Search search) {
		List<GoodsPrint>list =sqlSessionTemplate.selectList("goodsMapper.selectSearchGoodsName", search);
		return (ArrayList<GoodsPrint>)list;
	}

	// 발주처 검색
	public int selectSearchPdNameCount(Search search) {
		return sqlSessionTemplate.selectOne("goodsMapper.selectSearchPdNameCount", search);
	}

	public ArrayList<GoodsPrint> selectSearchPdName(Search search) {
		List<GoodsPrint>list =sqlSessionTemplate.selectList("goodsMapper.selectSearchPdName", search);
		return (ArrayList<GoodsPrint>)list;
	}

	// 상품 등록
	public int insertGoods(GoodsPrint goodsPrint) {
		return sqlSessionTemplate.insert("goodsMapper.insertGoods", goodsPrint);
	}

	// 상품 삭제
	public int deleteGoods(GoodsPrint goodsPrint) {
		return sqlSessionTemplate.delete("goodsMapper.deleteGoods", goodsPrint);
	}

	// 발주처 보기
	public ArrayList<GoodsPrint> selectProducePrint(Paging paging) {
		List<GoodsPrint>list =sqlSessionTemplate.selectList("goodsMapper.selectProducePrint", paging);
		return (ArrayList<GoodsPrint>)list;
	}

	// 명세서 - 상품 이름 검색
	public ArrayList<GoodsPrint> selectSSearchGoodsName(Search search) {
		List<GoodsPrint>list =sqlSessionTemplate.selectList("goodsMapper.selectSSearchGoodsName", search);
		return (ArrayList<GoodsPrint>)list;
	}

	// 명세서 - 발주처 이름 검색
	public ArrayList<GoodsPrint> selectSSearchpdName(Search search) {
		List<GoodsPrint>list =sqlSessionTemplate.selectList("goodsMapper.selectSSearchpdName", search);
		return (ArrayList<GoodsPrint>)list;
	}

	// 발주처 등록
	public int insertProduce(GoodsPrint goodsPrint) {
		return sqlSessionTemplate.insert("goodsMapper.insertProduce", goodsPrint);
	}

	public int deleteProduce(GoodsPrint goodsPrint) {
		return sqlSessionTemplate.delete("goodsMapper.deleteProduce", goodsPrint);
	}

	// 상품 수정 - 상품 테이블
	public int updateGoodsGT(GoodsPrint goodsPrint) {
		return sqlSessionTemplate.update("goodsMapper.updateGoodsGT", goodsPrint);
	}

	// 상품 수정 - 재고 테이블
	public int updateGoodsIT(GoodsPrint goodsPrint) {
		return sqlSessionTemplate.update("goodsMapper.updateGoodsIT", goodsPrint);
	}

	public int updateProduceGT(GoodsPrint goodsPrint) {
		return sqlSessionTemplate.update("goodsMapper.updateProduceGT", goodsPrint);
	}

	public int updateProducePT(GoodsPrint goodsPrint) {
		return sqlSessionTemplate.update("goodsMapper.updateProducePT", goodsPrint);
	}

	// 상품 등록 - 첫번째
	public int firstGoods(int id) {
		return sqlSessionTemplate.selectOne("goodsMapper.firstGoods", id);
	}

	public int insertFirstGoods(GoodsPrint goodsPrint) {
		return sqlSessionTemplate.insert("goodsMapper.insertFirstGoods", goodsPrint);
	}

	

	public int searchId(GoodsPrint goodsPrint) {
		return sqlSessionTemplate.selectOne("goodsMapper.searchId", goodsPrint);
	}

	public int updatePdQuantity(GoodsPrint goodsPrint) {
		return sqlSessionTemplate.update("goodsMapper.updatePdQuantity", goodsPrint);
	}

	public int originQuantity(GoodsPrint goodsPrint) {
		return sqlSessionTemplate.selectOne("goodsMapper.originQuantity", goodsPrint);
	}

	
	

	
}
