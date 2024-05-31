package com.sdm.ssm.admin.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.admin.dao.NoticeDao;
import com.sdm.ssm.admin.model.vo.Notice;
import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.common.SearchDate;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao noticeDao;
	
	@Override
	public int selectListCount() {
		return noticeDao.selectListCount();
	}

	@Override
	public ArrayList<Notice> selectList(Paging paging) {
		return noticeDao.selectList(paging);
	}

	@Override
	public int selectSearchTitleCount(String keyword) {
		return noticeDao.selectSearchTitleCount(keyword);
	}

	@Override
	public int selectSearchWriterCount(String keyword) {
		// TODO Auto-generated method stub
		return noticeDao.selectSearchWriterCount(keyword);
	}

	@Override
	public int selectSearchDateCount(SearchDate searchDate) {
		return noticeDao.selectSearchDateCount(searchDate);
	}

	@Override
	public ArrayList<Notice> selectSearchTitle(Search search) {
		return noticeDao.selectSearchTitle(search);
	}

	@Override
	public ArrayList<Notice> selectSearchWriter(Search search) {
		return noticeDao.selectSearchWriter(search);
	}

	@Override
	public ArrayList<Notice> selectSearchDate(Search search) {
		return noticeDao.selectSearchDate(search);
	}

	@Override
	public void updateAddReadCount(int noticeNo) {
		noticeDao.updateAddReadCount(noticeNo);
	}

	@Override
	public Notice selectNotice(int noticeNo) {
		return noticeDao.selectNotice(noticeNo);
	}

	@Override
	public int insertNotice(Notice notice) {
		
		return noticeDao.insertNotice(notice);
	}

	@Override
	public int selectMostResentNoticeNo(int id) {
		return noticeDao.selectMostResentNoticeNo(id);
	}

	@Override
	public int deleteNotice(int noticeNo) {
		return noticeDao.deleteNotice(noticeNo);
	}

	@Override
	public int updateNotice(Notice notice) {

		return noticeDao.updateNotice(notice);
	}

	@Override
	public ArrayList<Notice> selectTop5() {
		
		return noticeDao.selectTop5();
	}
	
}
