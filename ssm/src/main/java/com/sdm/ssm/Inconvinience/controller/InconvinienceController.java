package com.sdm.ssm.Inconvinience.controller;

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

import com.sdm.ssm.Inconvinience.model.service.InconvinienceService;
import com.sdm.ssm.Inconvinience.model.vo.InconvinienceBoard;
import com.sdm.ssm.Inconvinience.model.vo.InconvinienceBoardReply;
import com.sdm.ssm.admin.controller.NoticeController;
import com.sdm.ssm.admin.model.vo.Notice;
import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.common.SearchDate;

@Controller
public class InconvinienceController {
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	@Autowired
	private InconvinienceService inconvService;
	// 새 게시글 등록 페이지 내보내기용 메소드
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	@RequestMapping("mvupdatei.do")
	public String moveNoticeUpdateMethod(@RequestParam("page") String page,@RequestParam("boardNo") int boardNo, Model model) {
		InconvinienceBoard inconvBoard=inconvService.selectInconv(boardNo);
		model.addAttribute("inconvBoard", inconvBoard);
		model.addAttribute("page", page);
		return "inconvinienceboard/inconvUpdateForm";
	}
		@RequestMapping("iwform.do")
		public String moveInconvWritePage() {
			return "inconvinienceboard/inconvWriteForm";
		}
		@RequestMapping("inconvdetail.do")
		public String moveNoticeDetailPage(
				@RequestParam("ino") int inconvNo,
				@RequestParam(name="page", required=false) String page, Model model) {
			int currentPage = 1;
			if(page != null && page.length()>0) {
				currentPage = Integer.parseInt(page);
			}
			InconvinienceBoard inconvBoard = inconvService.selectInconv(inconvNo);
			InconvinienceBoardReply inconvBoardReply = inconvService.selectInconvReply(inconvNo);
			
			if(inconvBoard != null) {
				model.addAttribute("inconvBoard", inconvBoard);
				model.addAttribute("inconvBoardReply", inconvBoardReply);
				model.addAttribute("currentPage", currentPage);
				return "inconvinienceboard/inconvDetailView";
			} else {
				model.addAttribute("message", inconvNo + "번 글이 존재하지 않습니다.");
				return "common/error";
			}
		
		}
		//inconv5개 유저용
		@RequestMapping(value="inconvtop5.do", method=RequestMethod.POST)
		@ResponseBody
		public String inconvTop5Method(@RequestParam("id") int id) throws UnsupportedEncodingException {
			
			//해당 유저의 가장 최근 불편사항 5개
			ArrayList<InconvinienceBoard> list = inconvService.selectTop5(id);
			
			for(InconvinienceBoard ib : list) {
			logger.info(ib.toString());};
			//전송용 json 객체 준비
			JSONObject sendJson = new JSONObject();
			//list 저장할 json 배열 객체 준비
			JSONArray jarr = new JSONArray();
			
			//list 를 jarr 로 옮기기
			for(InconvinienceBoard inconv : list) {
				//notice 의 각 필드값 저장할 json 객체 생성
				JSONObject job = new JSONObject();
				
				job.put("ino", inconv.getBoardNo());
				job.put("iwriter", inconv.getWriter());
				job.put("status", inconv.getStatus());
				//한글에 대해서는 인코딩해서 json에 담음 (한글 깨짐 방지)
				job.put("ititle", URLEncoder.encode(inconv.getBoardTitle(), "utf-8"));			
				//job 를 jarr 에 추가함
				jarr.add(job);
			}
			
			//전송용 객체에 jarr 을 담음
			sendJson.put("ilist", jarr);
			
			//전송용 json 을 json string 으로 바꿔서 전송되게 함
			return sendJson.toJSONString();  //뷰리졸버로 리턴함
			//servlet-context.xml 에 jsonString 내보내는 JSONView 라는 뷰리졸버를 추가 등록해야 함
		}
		//inconv10개 관리자용
		@RequestMapping(value="inconvtop10.do", method=RequestMethod.POST)
		@ResponseBody
		public String inconvTop10Method() throws UnsupportedEncodingException {
			
			//조치안된 불편사항 오래된거 10개
			ArrayList<InconvinienceBoard> list = inconvService.selectTop10();
			
			for(InconvinienceBoard ib : list) {
			logger.info(ib.toString());};
			//전송용 json 객체 준비
			JSONObject sendJson = new JSONObject();
			//list 저장할 json 배열 객체 준비
			JSONArray jarr = new JSONArray();
			
			//list 를 jarr 로 옮기기
			for(InconvinienceBoard inconv : list) {
				//notice 의 각 필드값 저장할 json 객체 생성
				JSONObject job = new JSONObject();
				
				job.put("ino", inconv.getBoardNo());
				job.put("iwriter", inconv.getWriter());
				job.put("status", inconv.getStatus());
				//한글에 대해서는 인코딩해서 json에 담음 (한글 깨짐 방지)
				job.put("ititle", URLEncoder.encode(inconv.getBoardTitle(), "utf-8"));			
				//job 를 jarr 에 추가함
				jarr.add(job);
			}
			
			//전송용 객체에 jarr 을 담음
			sendJson.put("ilist", jarr);
			
			//전송용 json 을 json string 으로 바꿔서 전송되게 함
			return sendJson.toJSONString();  //뷰리졸버로 리턴함
			//servlet-context.xml 에 jsonString 내보내는 JSONView 라는 뷰리졸버를 추가 등록해야 함
		}
		
		// 리스트내보내기
		@RequestMapping("inconvlist.do")
		public String noticeListMethod(@RequestParam(name = "page", required = false) String page,
			 Model model) {
			int currentPage = 1;
			if (page != null && page.length()>0) {
				currentPage = Integer.parseInt(page);
			}

			// 한 페이지에 게시글 10개씩 출력되게 한다면
			int limit = 10;

			// 총 페이지수 계산을 위해 게시글 전체 갯수 조회해 옴
			int listCount = inconvService.selectListCount(); // 페이징 계산 처리 실행
			Paging paging = new Paging(listCount, currentPage, limit, "inconvlist.do");
			paging.calculate();
			// 출력할 페이지에 대한 목록 조회
			ArrayList<InconvinienceBoard> list = inconvService.selectList(paging);
			// 받은 결과로 성공/실패 페이지 내보냄
				model.addAttribute("list", list);
				model.addAttribute("paging", paging);
				model.addAttribute("currentPage", currentPage);
				model.addAttribute("limit", limit);

				return "inconvinienceboard/inconvListView";
	
		}
		// 검색용

		@RequestMapping("inconvsearch.do")
		public String noticeSearch(@RequestParam("action") String action, Search search,
				@RequestParam(name = "page", required = false) String page, Model model) {
			int currentPage = 1;
			if (page != null) {
				currentPage = Integer.parseInt(page);
			}
			int listCount = 0;
			Paging paging = new Paging(0,currentPage, 10, "inconvsearch.do");
			ArrayList<InconvinienceBoard> list =null;
			logger.info("sadfasdf"+ search.toString());
			switch (action) {
			case "title":
				listCount = inconvService.selectSearchTitleCount(search.getKeyword());
				paging.setListCount(listCount);
				paging.calculate();
				search.setStartRow(paging.getStartRow());
				search.setEndRow(paging.getEndRow());
				list = inconvService.selectSearchTitle(search);
				break;
			case "writer":
				listCount = inconvService.selectSearchWriterCount(search.getKeyword());
				paging.setListCount(listCount);
				paging.calculate();
				search.setStartRow(paging.getStartRow());
				search.setEndRow(paging.getEndRow());
				list = inconvService.selectSearchWriter(search);
				break;
			case "date":
				SearchDate searchDate = new SearchDate(search.getBegin(),search.getEnd());
				listCount = inconvService.selectSearchDateCount(searchDate);
				paging.setListCount(listCount);
				paging.calculate();
				search.setStartRow(paging.getStartRow());
				search.setEndRow(paging.getEndRow());
				list = inconvService.selectSearchDate(search);
				break;
			}

			model.addAttribute("list", list);
			model.addAttribute("paging", paging);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("search", search);

			return "inconvinienceboard/inconvListView";
		}
		@RequestMapping(value="iwrite.do", method=RequestMethod.POST)
		public String inconvWriteMethod(Model model, InconvinienceBoard inconvBoard,@RequestParam(name = "page", required = false) String page ) {
			logger.info(inconvBoard.toString());
			if(inconvService.insertInconvBoard(inconvBoard)>0) {
				//게시글 등록 성공시 방금 작성한 글로 이동
				int inconvNo = inconvService.selectMostResentInconvNo(inconvBoard.getId());
				model.addAttribute("ino", inconvNo);
				return "redirect:inconvdetail.do";
		}else {
				model.addAttribute("message", "불편사항 등록 실패");
				return "common/error";
		}
		}
		@RequestMapping("deletei.do")
		public String inconvDeleteMethod(@RequestParam("inconvNo") int inconvNo,
				@RequestParam("page") String page, Model model) {
			int currentPage = 1;
			if(page!=null&&page.length()>0) {
				currentPage=Integer.parseInt(page);
			}
			
			if(inconvService.deleteInconvBoard(inconvNo)>0) {
				model.addAttribute("page", currentPage);
				return "redirect:inconvlist.do";
			}{
				model.addAttribute("message", "불편사항 삭제 실패!");
				return "common/error";}

		}
		@RequestMapping(value="iupdate.do", method=RequestMethod.POST)
		public String inconvUpdateMethod(InconvinienceBoard inconvBoard, @RequestParam(value="page" , required=false) String page, Model model)
		{
			int currentPage = 1;
			if(page != null && page.length()>0) {
				currentPage = Integer.parseInt(page);
			}
			if(inconvService.updateinconvBoard(inconvBoard)>0) {	
				//게시글 수정 성공시 방금 작성한 글로 이동
				model.addAttribute("ino", inconvBoard.getBoardNo());
				
				return "redirect:inconvdetail.do";
		}else {
				model.addAttribute("message", "불편사항 수정 실패");
				return "common/error";
		}
		}
		@RequestMapping(value="stchange.do", method=RequestMethod.POST)
		@ResponseBody
		public void inconvStatusChangeMethod(InconvinienceBoard inconvBoard) 
		{
			inconvService.updateInconvStatus(inconvBoard);
		}
		//댓글 
		
		
		@RequestMapping(value="iconvreply.do", method=RequestMethod.GET)
		public String inconvReplyWriteMethod(Model model, InconvinienceBoardReply inconvBoardReply,@RequestParam(name = "page", required = false) String page ) {
			logger.info(inconvBoardReply.toString());
			if(inconvService.insertInconvBoardReply(inconvBoardReply)>0) {
				//댓글 등록 성공시 방금 작성한 글로 이동
				model.addAttribute("ino", inconvBoardReply.getBoardNo());

				return "redirect:inconvdetail.do";
		}else {
				model.addAttribute("message", "댓글 등록 실패");
				return "common/error";
		}
		}
		@RequestMapping("deleteire.do")
		public String inconvReplyDeleteMethod(@RequestParam("boardNo") int boardNo,
				@RequestParam("page") String page, Model model) {
			int currentPage = 1;
			if(page!=null&&page.length()>0) {
				currentPage=Integer.parseInt(page);
			}
			
			if(inconvService.deleteInconvBoardReply(boardNo)>0) {
				model.addAttribute("page", currentPage);
				model.addAttribute("ino",boardNo);
				return "redirect:inconvdetail.do";
			}{
				model.addAttribute("message", "댓글 삭제 실패!");
				return "common/error";}
		}
		@RequestMapping(value="iupdatere.do", method=RequestMethod.POST)
		public String inconvReplyUpdateMethod(InconvinienceBoardReply inconvinienceBoardReply, @RequestParam(value="page" , required=false) String page, Model model)
		{
			int currentPage = 1;
			if(page != null && page.length()>0) {
				currentPage = Integer.parseInt(page);
			}
			if(inconvService.updateinconvBoardReply(inconvinienceBoardReply)>0) {	
				//댓글 수정 성공시 방금 작성한 글로 이동
				model.addAttribute("ino", inconvinienceBoardReply.getBoardNo());
				return "redirect:inconvdetail.do";
		}else {
				model.addAttribute("message", "댓글 수정 실패");
				return "common/error";
		}
		}
		
}
