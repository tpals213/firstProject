package com.sdm.ssm.Inconvinience.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdm.ssm.Inconvinience.model.vo.InconvinienceBoard;
import com.sdm.ssm.Inconvinience.model.vo.InconvinienceBoardReply;
import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.common.SearchDate;

@Repository("inconvDao")
public class InconvinienceDao {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public InconvinienceBoard selectInconv(int inconvNo) {
		
		return sqlSessionTemplate.selectOne("inconvMapper.selectInconv", inconvNo);
	}

	public int selectListCount() {
		return sqlSessionTemplate.selectOne("inconvMapper.selectListCount");
	}

	public ArrayList<InconvinienceBoard> selectList(Paging paging) {
		List<InconvinienceBoard> list = sqlSessionTemplate.selectList("inconvMapper.selectList", paging);
		return (ArrayList<InconvinienceBoard>)list;
	}

	public int selectSearchTitleCount(String keyword) {
		return sqlSessionTemplate.selectOne("inconvMapper.selectSearchTitleCount");
	}

	public ArrayList<InconvinienceBoard> selectSearchTitle(Search search) {
		List<InconvinienceBoard> list = sqlSessionTemplate.selectList("inconvMapper.selectSearchTitle", search);
		return (ArrayList<InconvinienceBoard>)list;
	}

	public int selectSearchWriterCount(String keyword) {
		return sqlSessionTemplate.selectOne("inconvMapper.selectSearchWriterCount", keyword);
	}

	public ArrayList<InconvinienceBoard> selectSearchWriter(Search search) {
		List<InconvinienceBoard> list = sqlSessionTemplate.selectList("inconvMapper.selectSearchWriter", search);
		return (ArrayList<InconvinienceBoard>)list;
	}

	public int selectSearchDateCount(SearchDate searchDate) {
		return sqlSessionTemplate.selectOne("inconvMapper.selectSearchDateCount", searchDate);
	}

	public ArrayList<InconvinienceBoard> selectSearchDate(Search search) {
		List<InconvinienceBoard> list = sqlSessionTemplate.selectList("inconvMapper.selectSearchDate", search);
		return (ArrayList<InconvinienceBoard>)list;
	}

	public int insertInconvBoard(InconvinienceBoard inconvBoard) {
		return sqlSessionTemplate.insert("inconvMapper.insertInconvBoard", inconvBoard);
	}

	public int selectMostResentInconvNo(int id) {
		return sqlSessionTemplate.selectOne("inconvMapper.selectMostResentInconvNo", id);
	}

	public int deleteInconvBoard(int inconvNo) {
		sqlSessionTemplate.delete("inconvMapper.deleteInconvBoardReply", inconvNo);
		return sqlSessionTemplate.delete("inconvMapper.deleteInconvBoard", inconvNo);
	}

	public int updateinconvBoard(InconvinienceBoard inconvBoard) {
		return sqlSessionTemplate.update("inconvMapper.updateinconvBoard", inconvBoard);
	}

	public void updateinconvStatus(InconvinienceBoard inconvBoard) {
		sqlSessionTemplate.update("inconvMapper.updateinconvStatus", inconvBoard);
		
	}

	public int insertInconvBoardReply(InconvinienceBoardReply inconvBoardReply) {
		
		return sqlSessionTemplate.insert("inconvMapper.insertInconvBoardReply", inconvBoardReply);
	}

	public int deleteInconvBoardReply(int boardNo) {
		
		return sqlSessionTemplate.delete("inconvMapper.deleteInconvBoardReply", boardNo);
	}

	public int updateinconvBoardReply(InconvinienceBoardReply inconvinienceBoardReply) {
		
		return sqlSessionTemplate.update("inconvMapper.updateinconvBoardReply", inconvinienceBoardReply);
	}

	public InconvinienceBoardReply selectInconvReply(int inconvNo) {
		return sqlSessionTemplate.selectOne("inconvMapper.selectInconvReply", inconvNo);
	}

	public ArrayList<InconvinienceBoard> selectTop10() {
		List<InconvinienceBoard> list = sqlSessionTemplate.selectList("inconvMapper.selectTop10");
		return (ArrayList<InconvinienceBoard>)list;
	}

	public ArrayList<InconvinienceBoard> selectTop5(int id) {
		List<InconvinienceBoard> list = sqlSessionTemplate.selectList("inconvMapper.selectTop5",id);
		return (ArrayList<InconvinienceBoard>)list;
	}

}
