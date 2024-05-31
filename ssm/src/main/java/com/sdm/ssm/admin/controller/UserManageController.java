package com.sdm.ssm.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sdm.ssm.admin.model.vo.CountUser;
import com.sdm.ssm.admin.model.vo.Sales;
import com.sdm.ssm.admin.model.vo.Suspension;
import com.sdm.ssm.admin.service.UserManageService;
import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.subscribe.model.service.SubscribeService;
import com.sdm.ssm.subscribe.model.vo.SubscribePayments;
import com.sdm.ssm.user.model.service.UserService;
import com.sdm.ssm.user.model.vo.User;

@Controller
public class UserManageController {
	private static final Logger logger = LoggerFactory.getLogger(UserManageController.class);
	@Autowired
	private UserManageService umService;
	@Autowired
	private UserService userService;
	@Autowired
	private SubscribeService subscribeService;

	// 유저 전체 출력
	@RequestMapping(value = "ulist.do")
	public String userListMethod(@RequestParam(name = "page", required = false) String page, Model model) {
		int currentPage = 1;
		if (page != null && page.length() > 0) {
			currentPage = Integer.parseInt(page);
		}
		int listCount = umService.selectListCount();
		int limit = 10;
		Paging paging = new Paging(listCount, currentPage, limit, "ulist.do");
		paging.calculate();
		ArrayList<User> list = umService.selectList(paging);

		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("currentPage", currentPage);

		return "admin/usermanage";

	}

	@RequestMapping(value = "userManageDetail.do", method = RequestMethod.POST)
	@ResponseBody
	public String userManageDetailMethod(HttpServletResponse response, @RequestParam("userId") String userId)
			throws UnsupportedEncodingException {
		response.setContentType("application/json; charset=utf-8");
		User user = userService.selectUserById(userId);
		JSONObject job = new JSONObject();
		// 전송용 json 객체 생성
		JSONObject sendJson = new JSONObject();
		job.put("id", user.getId());
		job.put("userId", user.getUserId());
		job.put("passWd", user.getPassWd());
		job.put("email", user.getEmail());
		job.put("userNo", user.getUserNo());
		job.put("phone", user.getPhone());
		job.put("accountNumber", user.getAccountNumber());
		/* job.put("bankName", URLEncoder.encode(user.getBankName(), "utf-8")); */
		job.put("profileUrl", user.getProfileUrl());
		job.put("isQuit", user.getIsQuit());
		job.put("loginOk", user.getLoginOk());
		job.put("lastModified", user.getLastModified().toString());
		if (user.getServiceDate() != null) {
			job.put("serviceDate", user.getServiceDate().toString());
		} else {
			job.put("serviceDate", "이용중인 서비스가 없습니다.");
		}
		job.put("businessNo", user.getBusinessNo());
		job.put("businessStoreName", URLEncoder.encode(user.getBusinessStoreName(), "utf-8"));
		sendJson.put("objUser", job);
		// job == 유저객체 1개

		JSONArray suspensionJarray = new JSONArray();
		ArrayList<Suspension> suspensionList = umService.selectSuspenseList(user.getId() + "");
		if (suspensionList.size() > 0) {
			for (Suspension suspension : suspensionList) {
				// notice 값들을 저장할 json 객체 생성
				JSONObject suspensionJob = new JSONObject();
				suspensionJob.put("suspensionNo", suspension.getSuspensionNo());
				suspensionJob.put("targetAccount", suspension.getTargetAccount());
				suspensionJob.put("suspensionStart", suspension.getSuspensionStart().toString());
				if (suspension.getSuspensionEnd() != null) {
					suspensionJob.put("suspensionEnd", suspension.getSuspensionEnd().toString());
				} else {
					suspensionJob.put("suspensionEnd", "");
				}
				suspensionJob.put("suspensionTitle", URLEncoder.encode(suspension.getSuspensionTitle(), "utf-8"));
				suspensionJob.put("suspensionContent", URLEncoder.encode(suspension.getSuspensionContent(), "utf-8"));
				suspensionJarray.add(suspensionJob);
			} // for
		} // if
			// job == 유저객체 1개 , suspensionJarray 정지객체 리스트
			// 전송용 json 에 jarr 을 저장함
		sendJson.put("suspensionList", suspensionJarray);
		// job == 유저객체 1개 , suspensionJarray 정지객체 리스트, subscribepaments 결제내역 리스트
		JSONArray subsPaymentsJarray = new JSONArray();
		ArrayList<SubscribePayments> subsPayList = subscribeService.selectSubscribePaymentsByUserId(user.getId());
		if (subsPayList.size() > 0) {
			for (SubscribePayments subscribePayment : subsPayList) {
				// notice 값들을 저장할 json 객체 생성
				JSONObject subscribePaymentJob = new JSONObject();
				subscribePaymentJob.put("payNo", subscribePayment.getPayNo());
				subscribePaymentJob.put("SubscribeName",
						URLEncoder.encode(subscribePayment.getSubscribeName(), "utf-8"));
				subscribePaymentJob.put("amount", subscribePayment.getAmount());
				subscribePaymentJob.put("payMethod", subscribePayment.getPayMethod());
				subscribePaymentJob.put("payDate", subscribePayment.getPayDate().toString());
				subsPaymentsJarray.add(subscribePaymentJob);
			} // for
		} // if
		sendJson.put("subsPaymentsList", subsPaymentsJarray);
		return sendJson.toJSONString();
	}

	@RequestMapping(value = "ususpend.do", method = RequestMethod.POST)
	public void updateUserAccountSuspendMethod(Suspension suspension, HttpServletResponse response) throws IOException {
		int result = umService.updateUserAccountSuspendMethod(suspension.getTargetAccount());
		PrintWriter out = response.getWriter();
		logger.info(suspension.getTargetAccount() + "");
		if (result == 1) {
			umService.insertSuspension(suspension);
			String suspensionNo = umService.selectSuspenseNo(suspension.getTargetAccount());
			if (suspensionNo == null || suspensionNo.length() < 1) {
				suspensionNo = "1";
			}
			out.append(suspensionNo);
		} else {
			out.append("실패");
		}
		out.flush();
		out.close();
	}

	@RequestMapping(value = "uactivate.do", method = RequestMethod.POST)
	public void updateUserAccountActivateMethod(@RequestParam("Id") int id, HttpServletResponse response)
			throws IOException {
		int result = umService.updateUserAccountActivateMethod(id);
		String suspensionNo = umService.selectSuspenseNo(id);
		PrintWriter out = response.getWriter();
		if (result == 1) {
			out.append(suspensionNo);
			umService.updateSuspension(id);
		} else {
			out.append("실패");
		}
	}

	@RequestMapping("usearch.do")
	public String userSearch(@RequestParam("action") String action, Search search,
			@RequestParam(name = "page", required = false) String page, Model model) {
		int currentPage = 1;
		if (page != null && page.length() > 0) {
			currentPage = Integer.parseInt(page);
		}
		int listCount = 0;
		Paging paging = new Paging(0, currentPage, 10, "usearch.do");
		ArrayList<User> list = null;
		switch (action) {
		case "userId":
			listCount = umService.selectSearchIdCount(search.getKeyword());
			paging.setListCount(listCount);
			paging.calculate();
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			list = umService.selectSearchId(search);
			break;
		case "storeName":
			listCount = umService.selectSearchStoreCount(search.getKeyword());
			paging.setListCount(listCount);
			paging.calculate();
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			list = umService.selectSearchStore(search);
			break;
		}
		logger.info(paging.getStartPage() + "");
		logger.info("endPage : " + paging.getEndPage());
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("search", search);
		model.addAttribute("limit", 10);
		model.addAttribute("action", action);
		model.addAttribute("keyword", search.getKeyword());

		return "admin/usermanage";
	}

	@RequestMapping("countUser.do")
	@ResponseBody
	public String selectCountUserByEnrollDateMethod(@RequestParam("year") int year, HttpServletResponse response)
			throws UnsupportedEncodingException {
		// 전달받은 년도로 이용자수 조회해오기
		Map<String, Integer> countUserMap = new HashMap<>();
		ArrayList<CountUser> countUserList = umService.selectCountUserByEnrollDate(year);
		for (CountUser countUser : countUserList) {
			countUserMap.put(countUser.getMonth(), countUser.getCount());
		} // for
		JSONObject sendJson = new JSONObject();
		sendJson.put("countMap", countUserMap);
		Map<String, Integer> countSubMap = new HashMap<>();
		ArrayList<CountUser> countSubList = umService.selectCountUserByServiceDate(year);
		for (CountUser countUser : countSubList) {
			countSubMap.put(countUser.getMonth(), countUser.getCount());
		} // for
		// 전송용 json 객체 생성
		sendJson.put("countSubMap", countSubMap);

		Map<String, Integer> salesMap = new HashMap<>();
		ArrayList<Sales> salesList = umService.selectSalesList(year);
		for (Sales sales : salesList) {
			salesMap.put(sales.getMonth(), sales.getSales());
		} // for
		sendJson.put("salesMap", salesMap);

		return sendJson.toJSONString();
	}

	@RequestMapping("mvwelcom.do")
	public String moveWelcomePageMethod(@RequestParam(name="userId", required=false) String userId, Model model) {
		User user = userService.selectUserById(userId);
		if(user.getServiceDate()!=null) {
			LocalDate currentDate = LocalDate.now();
			LocalDate parsedServiceDate = LocalDate.parse(user.getServiceDate().toString());
			if(parsedServiceDate.isAfter(currentDate)) {
				return "common/welcome";
			}else {
				model.addAttribute("message","기간이 만료되었습니다! 결제후 이용해주세요!"); return "redirect:slist.do";
			}
		}else {
			model.addAttribute("message", "결제후 이용해주세요!");
			 return "redirect:slist.do";
		}
	}
}
