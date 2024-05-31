package com.sdm.ssm.reserve.controller;

import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sdm.ssm.admin.model.vo.Notice;
import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.SerachDateStr;
import com.sdm.ssm.reserve.model.service.ReserveService;
import com.sdm.ssm.reserve.model.vo.Reserve;
import com.sdm.ssm.user.model.vo.User;

@Controller //설정 xml 에 해당 클래스를 Controller 로 자동 등록해 줌
public class ReserveController {
	//이 클래스 안에 메소드들이 잘 동작하는지 또는 전달값이나 리턴값을 확인하기 위한 용도로 로그객체를 생성함
	private static final Logger logger = LoggerFactory.getLogger(ReserveController.class);
	
	//서비스 연결 처리 : 자동 DI 처리
	@Autowired
	private ReserveService reserveService;
	
	//////////////////////////////////////////////////////////
	///// 예약정보 관리 페이지로 이동
	//////////////////////////////////////////////////////////
	@RequestMapping("moveRsrvCalPage.do")
	public String moveCalWritePage(
			HttpServletRequest request,
			HttpServletResponse res
			) {
		return "reserve/reservecalendarlist";
	}
	
	/////////////////////////////////////////////////////
	//// 달력 데이터 조회
	/////////////////////////////////////////////////////
	@RequestMapping(value= "rsrvlist.do", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public String reserveselectRsrvListMethod (
			@ModelAttribute("searchVO") SerachDateStr searchVO,
			HttpServletRequest request,
			HttpServletResponse res,
			ModelMap model) throws Exception {

		HttpSession session = request.getSession();
		User loginUser = (User)session.getAttribute("loginUser");

		String sdate = searchVO.getStart().replace("-", "");
		String edate = searchVO.getEnd().replace("-", "");
		
		//// 조회 조건을 설정하기 위한 방법
	    SerachDateStr serachDateStr = new SerachDateStr();
	    serachDateStr.setSdate(sdate);
	    serachDateStr.setEdate(edate);
	    
	    serachDateStr.setId(loginUser.getId());
	    
	    ArrayList<Reserve> list = reserveService.selectRsrvList(serachDateStr);
	    
		res.setContentType("text/html; charset=UTF-8");
		
		//// 리턴된 list 를 json 배열에 옮겨 담기
		JSONArray jarr = new JSONArray();
		
		int sortidx = 0;
		
		if (list.size() > 0) {
			sortidx = list.size(); 
		}
		
		for(Reserve reserve : list) {
			//reserve 값들을 저장할 js
			JSONObject job = new JSONObject();
			
			job.put("groupId", reserve.getRsrvNum());
			job.put("title", reserve.getRsrvSubject());
			
			//// 날짜는 반드시 문자열로 바꿔서 저장할 것(fullcalendar에서 받을 format으로 변경
			String start = reserve.getRsrvDate().substring(0, 4) + "-" 
							+ reserve.getRsrvDate().substring(4, 6) + "-" 
							+ reserve.getRsrvDate().substring(6, 8) + "T" + reserve.getRsrvTime() + ":00";
			
			String rsrvdate = reserve.getRsrvDate().substring(0, 4) + "-" 
							+ reserve.getRsrvDate().substring(4, 6) + "-" 
							+ reserve.getRsrvDate().substring(6, 8);

			job.put("start", start);
			job.put("sortIdx", sortidx);   /// 일정을 순서대로 보이게 하기 위함(2024.04.04)
			
			/////////////////////////////////////////////////////////////
			//// 추가(2024.04.05)
			/////////////////////////////////////////////////////////////
			job.put("rsrvdate", rsrvdate); //// 예약일자 2024.04.12
			job.put("rsrvname", reserve.getRsrvName());  //// 예약자명 2024.04.05
			job.put("rsrvtelno", reserve.getRsrvTelno());  //// 연락처 2024.04.05
			job.put("rsrvtime", reserve.getRsrvTime());  //// 예약시간 2024.04.05
			job.put("rsrvinwon", reserve.getRsrvInwon());  //// 인원 2024.04.05
			job.put("rsrvmemo", reserve.getRsrvMemo());  //// 메모 2024.04.05
			job.put("writedate", reserve.getWriteDate().toString());  //// 작성일자 2024.04.10 

			jarr.add(job);
			
			sortidx = sortidx - 1;
			
		} //// for

		JSONObject obj = new JSONObject();

	    PrintWriter out = res.getWriter();

	    obj.put("success", "ok");
	    
	    obj.put("list", jarr);
	    
	    out.print(obj);
	    out.close();
	    
	    return null;
	}
	
	/////////////////////////////////////////////////////
	//// 달력 데이터 등록
	/////////////////////////////////////////////////////
	@RequestMapping(value = "rsrvinsert.do", method = RequestMethod.POST)
	@ResponseBody
	public String reserveInsertMethod (
	        @RequestBody String filterJSON,
	        HttpServletRequest request,
	        HttpServletResponse res,
	        ModelMap model) throws Exception {
			
		HttpSession session = request.getSession();
		User loginUser = (User)session.getAttribute("loginUser");
			
	    JSONObject obj = new JSONObject();
	    
	    ////////////////////////////////////////////
	    ////////////////////////////////////////////
	    res.setContentType("text/html; charset=UTF-8");
	    
	    PrintWriter out = res.getWriter();
	 
	    //================================ json Object parse ============================
	    ///////////////////////////////////////////////////////////////////////////////////////////////////////
	    //// com.fasterxml.jackson.core/jackson-databind --> 사용 library import시 주의(2024.04.05)
	    ///////////////////////////////////////////////////////////////////////////////////////////////////////
	    ObjectMapper mapper = new ObjectMapper();            
	    Reserve rsrv = (Reserve)mapper.readValue(filterJSON, new TypeReference<Reserve>(){ });
	    //================================ json Object parse ============================
	    
	    String rsrvDate = rsrv.getRsrvDate().replace("-", "");   //// 예약일자 format 제거(2024.04.05)
	    rsrv.setRsrvDate(rsrvDate);
	    
	    int id = 0;
	    id = loginUser.getId();
	     
	    rsrv.setId(id);
	    rsrv.setWriter(id);

		if (reserveService.insertReserve(rsrv) > 0) {
		    obj.put("success", "ok");
		}else {
		    obj.put("success", "fail");
		}
			
	    out.print(obj);
	    
	    return null;
	}

	/////////////////////////////////////////////////////
	//// 달력 데이터 업데이트
	/////////////////////////////////////////////////////
	@RequestMapping(value="rsrvupdate.do", method=RequestMethod.POST)
	@ResponseBody
	public String reserveUpdateMethod (
	        @RequestBody String filterJSON,
	        HttpServletRequest request,
	        HttpServletResponse res,
	        ModelMap model) throws Exception {
		
		HttpSession session = request.getSession();
		User loginUser = (User)session.getAttribute("loginUser");

	    JSONObject obj = new JSONObject();
	    
	    res.setContentType("text/html; charset=UTF-8");
	    
	    PrintWriter out = res.getWriter();
	 
	    //================================ json Object parse ============================
	    ///////////////////////////////////////////////////////////////////////////////////////////////////////
	    //// com.fasterxml.jackson.core/jackson-databind --> 사용 library import시 주의(2024.04.05)
	    ///////////////////////////////////////////////////////////////////////////////////////////////////////
	    ObjectMapper mapper = new ObjectMapper();            
	    Reserve rsrv = (Reserve)mapper.readValue(filterJSON, new TypeReference<Reserve>(){ });
	    //================================ json Object parse ============================
	    
	    String rsrvDate = rsrv.getRsrvDate().replace("-", "");   //// 예약일자 format 제거(2024.04.05)
	    rsrv.setRsrvDate(rsrvDate);
	    
	    int id = 0;
	    id = loginUser.getId();
	     
	    rsrv.setId(id);
	    rsrv.setWriter(id);
    
		if(reserveService.updateReserve(rsrv) > 0) {
		    obj.put("success", "ok");
		}else {
		    obj.put("success", "fail");
		}

	    out.print(obj);
	    
	    return null;
	}

	/////////////////////////////////////////////////////
	//// 달력 데이터 삭제
	/////////////////////////////////////////////////////
	@RequestMapping(value = "rsrvdelete.do", method=RequestMethod.POST)
	@ResponseBody
	public String reserveDeleteMethod (
	        @RequestBody String filterJSON,
	        HttpServletRequest request,
	        HttpServletResponse res,
	        ModelMap model) throws Exception {
		
		HttpSession session = request.getSession();
		User loginUser = (User)session.getAttribute("loginUser");

	    JSONObject obj = new JSONObject();
	    
	    res.setContentType("text/html; charset=UTF-8");

	    PrintWriter out = res.getWriter();

	    //================================ json Object parse ============================
	    ///////////////////////////////////////////////////////////////////////////////////////////////////////
	    //// com.fasterxml.jackson.core/jackson-databind --> 사용 library import시 주의(2024.04.05)
	    ///////////////////////////////////////////////////////////////////////////////////////////////////////
	    ObjectMapper mapper = new ObjectMapper();
	    Reserve rsrv = (Reserve)mapper.readValue(filterJSON, new TypeReference<Reserve>(){ });
	    //================================ json Object parse ============================
	    
	    rsrv.setId(loginUser.getId());
	    
	    if (reserveService.deleteReserve(rsrv) > 0) {
	    	obj.put("success", "ok");
		}else {
			obj.put("success", "fail");
		}

	    out.print(obj);
	    
	    return null;
	}
}
