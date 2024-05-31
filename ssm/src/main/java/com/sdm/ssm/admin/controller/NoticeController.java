package com.sdm.ssm.admin.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sdm.ssm.admin.model.vo.Notice;
import com.sdm.ssm.admin.service.NoticeService;
import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.common.SearchDate;

@Controller
public class NoticeController {
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

	@Autowired
	private NoticeService noticeService;

	// 커스텀 바인딩 설정
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	// 뷰 페이지 내보내기용 메소드 작성부-------------------------------------------
	@RequestMapping("mvupdaten.do")
	public String moveNoticeUpdateMethod(@RequestParam("page") String page,@RequestParam("noticeNo") int noticeNo, Model model) {
		Notice notice=noticeService.selectNotice(noticeNo);
		model.addAttribute("notice", notice);
		model.addAttribute("page", page);
		return "notice/noticeUpdateForm";
	}
	
	
	// 새 게시글 등록 페이지 내보내기용 메소드
	@RequestMapping("nwform.do")
	public String moveNoticeWritePage(@RequestParam("page") String page, Model model) {
		model.addAttribute("page", page);
		return "notice/noticeWriteForm";
	}
	@RequestMapping("ndetail.do")
	public String moveNoticeDetailPage(
			@RequestParam("nno") int noticeNo,
			@RequestParam(name="page", required=false) String page, Model model) {
		int currentPage = 1;
		if(page != null) {
			currentPage = Integer.parseInt(page);
		}
		noticeService.updateAddReadCount(noticeNo);
		Notice notice = noticeService.selectNotice(noticeNo);
		
		if(notice != null) {
			model.addAttribute("notice", notice);
			model.addAttribute("currentPage", currentPage);
			return "notice/noticeDetailView";
		} else {
			model.addAttribute("message", noticeNo + "번 글이 존재하지 않습니다.");
			return "common/error";
		}
	
	}
	//noticeTop5
	@RequestMapping(value="ntop5.do", method=RequestMethod.POST)
	@ResponseBody
	public String noticeNewTop5Method() throws UnsupportedEncodingException {
		//ajax 요청시 리턴방법은 여러가지가 있음
		//response 객체 이용시에는 2가지중 선택 가능
		//1. 출력스트림으로 응답하는 방법 (아이디 중복 체크 예)
		//2. 뷰리졸버로 리턴하는 방법 : response body 에 내보낼 값을 저장함
		//	JSONView 클래스 등록 처리되어 있어야 함 : servlet-context.xml  
		
		//최근 등록된 공지글5개 조회해 옴
		ArrayList<Notice> list = noticeService.selectTop5();
		
		//전송용 json 객체 준비
		JSONObject sendJson = new JSONObject();
		//list 저장할 json 배열 객체 준비
		JSONArray jarr = new JSONArray();
		
		//list 를 jarr 로 옮기기
		for(Notice notice : list) {
			//notice 의 각 필드값 저장할 json 객체 생성
			JSONObject job = new JSONObject();
			
			job.put("noticeNo", notice.getNoticeNo());
			//한글에 대해서는 인코딩해서 json에 담음 (한글 깨짐 방지)
			job.put("noticeTitle", URLEncoder.encode(notice.getNoticeTitle(), "utf-8"));			
			//job 를 jarr 에 추가함
			jarr.add(job);
		}
		
		//전송용 객체에 jarr 을 담음
		sendJson.put("nlist", jarr);
		
		//전송용 json 을 json string 으로 바꿔서 전송되게 함
		return sendJson.toJSONString();  //뷰리졸버로 리턴함
		//servlet-context.xml 에 jsonString 내보내는 JSONView 라는 뷰리졸버를 추가 등록해야 함
	}
	
	// 리스트내보내기
	@RequestMapping(value="nlist.do", method= {RequestMethod.POST, RequestMethod.GET})
	public String noticeListMethod(@RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit, Model model) {
		int currentPage = 1;
		if (page != null && page.length()>0) {
			currentPage = Integer.parseInt(page);
		}

		// 한 페이지에 게시글 10개씩 출력되게 한다면
		int limit = 10;
		if (slimit != null) {
			limit = Integer.parseInt(slimit);
		}

		// 총 페이지수 계산을 위해 게시글 전체 갯수 조회해 옴
		int listCount = noticeService.selectListCount(); // 페이징 계산 처리 실행
		Paging paging = new Paging(listCount, currentPage, limit, "nlist.do");
		paging.calculate();
		// 출력할 페이지에 대한 목록 조회
		ArrayList<Notice> list = noticeService.selectList(paging);
		logger.info("리스트카운트 : " + listCount);
		// 받은 결과로 성공/실패 페이지 내보냄
			model.addAttribute("list", list);
			model.addAttribute("paging", paging);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("limit", limit);

			return "notice/noticeListView";
	}
	// 검색용

	@RequestMapping("nsearch.do")
	public String noticeSearch(@RequestParam("action") String action, Search search,
			@RequestParam(name = "page", required = false) String page, Model model) {
		int currentPage = 1;
		if (page != null&& page.length()>0) {
			currentPage = Integer.parseInt(page);
		}
		int listCount = 0;
		Paging paging = new Paging(0,currentPage, 10, "nsearch.do");
		ArrayList<Notice> list =null;
		switch (action) {
		case "title":
			listCount = noticeService.selectSearchTitleCount(search.getKeyword());
			paging.setListCount(listCount);
			paging.calculate();
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			list = noticeService.selectSearchTitle(search);
			break;
		case "writer":
			listCount = noticeService.selectSearchWriterCount(search.getKeyword());
			paging.setListCount(listCount);
			paging.calculate();
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			list = noticeService.selectSearchWriter(search);
			break;
		case "date":
			SearchDate searchDate = new SearchDate(search.getBegin(),search.getEnd());
			listCount = noticeService.selectSearchDateCount(searchDate);
			paging.setListCount(listCount);
			paging.calculate();
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			list = noticeService.selectSearchDate(search);
			break;
		}

		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("search", search);
		model.addAttribute("limit", 10);
		model.addAttribute("action", action);
		model.addAttribute("keyword", search.getKeyword());
		
		return "notice/noticeListView";
	}
	@RequestMapping(value="nwrite.do", method=RequestMethod.POST)
	public String noticeWriteMethod(Model model, Notice notice,@RequestParam(name = "page", required = false) String page ) {
		logger.info(notice.toString());
		if(noticeService.insertNotice(notice)>0) {
			//게시글 등록 성공시 방금 작성한 글로 이동
			int noticeNo = noticeService.selectMostResentNoticeNo(Integer.parseInt(notice.getWriter()));
			model.addAttribute("nno", noticeNo);
			return "redirect:ndetail.do";
	}else {
			model.addAttribute("message", "공지사항 등록 실패");
			return "common/error";
	}
	}
	@RequestMapping("deleten.do")
	public String noticeDeleteMethod(@RequestParam("noticeNo") int noticeNo,
			@RequestParam("page") String page, Model model) {
		int currentPage = 1;
		if(page!=null&&page.length()>0) {
			currentPage=Integer.parseInt(page);
		}
		
		if(noticeService.deleteNotice(noticeNo)>0) {
			model.addAttribute("currentPage", page);
			return "redirect:nlist.do";
		}{
			model.addAttribute("message", "공지사항 삭제 실패!");
			return "common/error";}

	}
	@RequestMapping(value="nupdate.do", method=RequestMethod.POST)
	public String noticeUpdateMethod(Notice notice, @RequestParam("page") String page, Model model)
	{
		if(noticeService.updateNotice(notice)>0) {	
			//게시글 수정 성공시 방금 작성한 글로 이동
			model.addAttribute("nno", notice.getNoticeNo());
			model.addAttribute("page", page);
			return "redirect:ndetail.do";
	}else {
			model.addAttribute("message", "공지사항 수정 실패");
			return "common/error";
	}
	}
	
	
	}


