package com.sdm.ssm.admin.service;

import java.util.ArrayList;

import com.sdm.ssm.admin.model.vo.Notice;
import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.common.SearchDate;

public interface NoticeService {
	int selectListCount();

	ArrayList<Notice> selectList(Paging paging);

	int selectSearchTitleCount(String keyword);

	int selectSearchWriterCount(String keyword);

	int selectSearchDateCount(SearchDate searchDate);

	ArrayList<Notice> selectSearchTitle(Search search);

	ArrayList<Notice> selectSearchWriter(Search search);

	ArrayList<Notice> selectSearchDate(Search search);

	void updateAddReadCount(int noticeNo);

	Notice selectNotice(int noticeNo);

	int insertNotice(Notice notice);

	int selectMostResentNoticeNo(int id);

	int deleteNotice(int noticeNo);

	int updateNotice(Notice notice);

	ArrayList<Notice> selectTop5();

}
