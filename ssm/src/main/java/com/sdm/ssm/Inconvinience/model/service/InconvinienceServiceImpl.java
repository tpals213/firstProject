package com.sdm.ssm.Inconvinience.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.Inconvinience.model.dao.InconvinienceDao;
import com.sdm.ssm.Inconvinience.model.vo.InconvinienceBoard;
import com.sdm.ssm.Inconvinience.model.vo.InconvinienceBoardReply;
import com.sdm.ssm.admin.model.vo.Notice;
import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.common.SearchDate;

@Service("inconvService")
public class InconvinienceServiceImpl implements InconvinienceService {
	@Autowired
	private InconvinienceDao inconvDao;

	@Override
	public InconvinienceBoard selectInconv(int inconvNo) {
		return inconvDao.selectInconv(inconvNo);
	}

	@Override
	public int selectListCount() {
		return inconvDao.selectListCount();
	}

	@Override
	public ArrayList<InconvinienceBoard> selectList(Paging paging) {
		return inconvDao.selectList(paging);
	}

	@Override
	public int selectSearchTitleCount(String keyword) {

		return inconvDao.selectSearchTitleCount(keyword);
	}

	@Override
	public ArrayList<InconvinienceBoard> selectSearchTitle(Search search) {

		return inconvDao.selectSearchTitle(search);
	}

	@Override
	public int selectSearchWriterCount(String keyword) {

		return inconvDao.selectSearchWriterCount(keyword);
	}

	@Override
	public ArrayList<InconvinienceBoard> selectSearchWriter(Search search) {

		return inconvDao.selectSearchWriter(search);
	}

	@Override
	public int selectSearchDateCount(SearchDate searchDate) {

		return inconvDao.selectSearchDateCount(searchDate);
	}

	@Override
	public ArrayList<InconvinienceBoard> selectSearchDate(Search search) {

		return inconvDao.selectSearchDate(search);
	}

	@Override
	public int insertInconvBoard(InconvinienceBoard inconvBoard) {
		return inconvDao.insertInconvBoard(inconvBoard);
	}

	@Override
	public int selectMostResentInconvNo(int id) {
		return inconvDao.selectMostResentInconvNo(id);
	}

	@Override
	public int deleteInconvBoard(int inconvNo) {
		return inconvDao.deleteInconvBoard(inconvNo);
	}

	@Override
	public int updateinconvBoard(InconvinienceBoard inconvBoard) {
		return inconvDao.updateinconvBoard(inconvBoard);
	}

	@Override
	public void updateInconvStatus(InconvinienceBoard inconvBoard) {
			inconvDao.updateinconvStatus(inconvBoard);
	}

	@Override
	public int insertInconvBoardReply(InconvinienceBoardReply inconvBoardReply) {
		return inconvDao.insertInconvBoardReply(inconvBoardReply);
	}

	@Override
	public int deleteInconvBoardReply(int boardNo) {
		return inconvDao.deleteInconvBoardReply(boardNo);
	}

	@Override
	public int updateinconvBoardReply(InconvinienceBoardReply inconvinienceBoardReply) {
		return inconvDao.updateinconvBoardReply(inconvinienceBoardReply);
	}

	@Override
	public InconvinienceBoardReply selectInconvReply(int inconvNo) {
		
		return inconvDao.selectInconvReply(inconvNo);
	}

	@Override
	public ArrayList<InconvinienceBoard> selectTop10() {
		
		return inconvDao.selectTop10();
	}

	
	@Override
	public ArrayList<InconvinienceBoard> selectTop5(int id) {
		return inconvDao.selectTop5(id);
	}
}
