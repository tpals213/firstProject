package com.sdm.ssm.admin.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdm.ssm.admin.model.vo.Notice;
import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.common.SearchDate;

@Repository("noticeDao")
public class NoticeDao {
	private static final Logger logger = LoggerFactory.getLogger(NoticeDao.class);
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	public int selectListCount() {
		return sqlSessionTemplate.selectOne("noticeMapper.selectListCount");
	}
	public ArrayList<Notice> selectList(Paging paging) {
		List<Notice> list = sqlSessionTemplate.selectList("noticeMapper.selectList",paging);
		return (ArrayList<Notice>)list;
	}
	public int selectSearchTitleCount(String keyword) {

		return sqlSessionTemplate.selectOne("noticeMapper.selectSearchTitleCount", keyword);
	}
	public int selectSearchWriterCount(String keyword) {
		return sqlSessionTemplate.selectOne("noticeMapper.selectSearchWriterCount", keyword);
	}
	public int selectSearchDateCount(SearchDate searchDate) {
		return sqlSessionTemplate.selectOne("noticeMapper.selectSearchDateCount", searchDate);
	}
	public ArrayList<Notice> selectSearchTitle(Search search) {
		List<Notice> list =sqlSessionTemplate.selectList("noticeMapper.selectSearchTitle", search);
		return (ArrayList<Notice>)list;
	}
	public ArrayList<Notice> selectSearchWriter(Search search) {
		List<Notice> list =sqlSessionTemplate.selectList("noticeMapper.selectSearchWriter", search);
		return (ArrayList<Notice>)list;
	}
	public ArrayList<Notice> selectSearchDate(Search search) {
		List<Notice> list =sqlSessionTemplate.selectList("noticeMapper.selectSearchDate", search);
		return (ArrayList<Notice>)list;
	}
	public void updateAddReadCount(int noticeNo) {
		sqlSessionTemplate.update("noticeMapper.updateAddReadCount", noticeNo);
	}
	public Notice selectNotice(int noticeNo) {
		return sqlSessionTemplate.selectOne("noticeMapper.selectNotice", noticeNo);
	}
	public int insertNotice(Notice notice) {
				
		return sqlSessionTemplate.insert("noticeMapper.insertNotice", notice);
	}
	public int selectMostResentNoticeNo(int id) {
		return sqlSessionTemplate.selectOne("noticeMapper.selectMostResentNoticeNo", id);
	}
	public int deleteNotice(int noticeNo) {
		return sqlSessionTemplate.delete("noticeMapper.deleteNotice", noticeNo);
	}
	public int updateNotice(Notice notice) {
		return sqlSessionTemplate.update("noticeMapper.updateNotice", notice);
	}
	public ArrayList<Notice> selectTop5() {
		List<Notice> list = sqlSessionTemplate.selectList("noticeMapper.selectTop5");
		return (ArrayList<Notice>)list;
	}

}
