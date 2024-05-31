package com.sdm.ssm.Inconvinience.model.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.sdm.ssm.Inconvinience.model.vo.InconvinienceBoard;
import com.sdm.ssm.Inconvinience.model.vo.InconvinienceBoardReply;
import com.sdm.ssm.admin.model.vo.Notice;
import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.common.SearchDate;

@Service
public interface InconvinienceService {

	InconvinienceBoard selectInconv(int inconvNo);

	int selectListCount();

	ArrayList<InconvinienceBoard> selectList(Paging paging);

	int selectSearchTitleCount(String keyword);

	ArrayList<InconvinienceBoard> selectSearchTitle(Search search);

	int selectSearchWriterCount(String keyword);

	ArrayList<InconvinienceBoard> selectSearchWriter(Search search);

	int selectSearchDateCount(SearchDate searchDate);

	ArrayList<InconvinienceBoard> selectSearchDate(Search search);

	int insertInconvBoard(InconvinienceBoard inconvBoard);

	int selectMostResentInconvNo(int id);

	int deleteInconvBoard(int inconvNo);

	int updateinconvBoard(InconvinienceBoard inconvBoard);

	void updateInconvStatus(InconvinienceBoard inconvBoard);

	int insertInconvBoardReply(InconvinienceBoardReply inconvBoardReply);

	int deleteInconvBoardReply(int boardNo);

	int updateinconvBoardReply(InconvinienceBoardReply inconvinienceBoardReply);

	InconvinienceBoardReply selectInconvReply(int inconvNo);

	ArrayList<InconvinienceBoard> selectTop10();

	ArrayList<InconvinienceBoard> selectTop5(int id);

}
