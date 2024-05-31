package com.sdm.ssm.subscribe.model.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sdm.ssm.admin.model.vo.Notice;
import com.sdm.ssm.subscribe.model.service.SubscribeService;
import com.sdm.ssm.subscribe.model.vo.Subscribe;
import com.sdm.ssm.subscribe.model.vo.UserSubscribe;
import com.sdm.ssm.user.model.service.UserService;
import com.sdm.ssm.user.model.vo.User;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@Controller
public class SubscribeController {
	private static final Logger logger = LoggerFactory.getLogger(SubscribeController.class);
	@Autowired
	private SubscribeService subscribeService;
	@Autowired
	private UserService userService;
	
	private final IamportClient iamportClient =new IamportClient("5271455441823787", "J4je27s9BI1PRE8YST4peycxpAqmTwfoDqH24Npm7bJTVcbc8vSx7pUqeDC0at58C9ZldYxwIQWSG0Sh");
		@RequestMapping(value="msubscribe.do")
		public String moveSubscribeManageMethod(Model model) {
			ArrayList<Subscribe> list = subscribeService.selectList();
			model.addAttribute("list", list);
			return "subscribe/subscribeAdminView";
		}
	
		// 리스트내보내기
		@RequestMapping(value="slist.do", method= {RequestMethod.POST, RequestMethod.GET})
		public String subscribeListMethod(Model model, @RequestParam(name="message", required = false) String message) {
			ArrayList<Subscribe> list = subscribeService.selectList();
				model.addAttribute("list", list);
				model.addAttribute("message", message);
				return "subscribe/subscribeListView";
		}
		//구독결제
		@RequestMapping(value="subsPayment.do", method= {RequestMethod.POST})
		@ResponseBody
		public IamportResponse<Payment> subscribePaymentMethod(UserSubscribe userSubscribe,
				@RequestParam("userId") String userId,
				@RequestParam("imp_uid") String impUid,
				HttpServletResponse response) throws IOException, IamportResponseException {
			User user = userService.selectUserById(userId);
			Subscribe subscribe = subscribeService.selectSub(userSubscribe.getSubscribeNo());
			userSubscribe.setAmount(subscribe.getPrice());
			userSubscribe.setSubscribeName(subscribe.getSubscribeName());
			Date nowDate = new Date();//현재시간
			String firstCheck = "n";
			if(user.getServiceDate()==null) {//유저가 첫 결재일때
				firstCheck = "o";
			}
			if(user.getServiceDate()==null || user.getServiceDate().compareTo(nowDate)<0) {//유저가 서비스기간이 지났는지 확인
				//유저가 처음 결제일때 or 유저의 서비스기간이 지났을때
				int upResult = subscribeService.updateUserServiceDate(userSubscribe);
				int inResult = subscribeService.insertSubscribePayment(userSubscribe);
				firstCheck += (upResult + inResult);
			}else {//이미 결제중으로 이용하고 있을 때
				//유저의 사용기한을 서비스만기 + 구매한상품의 개월수 만큼으로 바꿈
				int upResult2 = subscribeService.updateUserServiceDate2(userSubscribe);
				int inResult2 = subscribeService.insertSubscribePayment(userSubscribe);
				firstCheck += (upResult2 + inResult2);
			}
			 return iamportClient.paymentByImpUid(impUid);
		}
		@RequestMapping("firstcheck.do")
		public String firstCheckSubscribe(@RequestParam("userId") String userId) {
			//첫 결제인지 확인 후 메인페이지로 이동
			User user = userService.selectUserById(userId);
			if(user.getServiceDate()==null) {
				return "redirect:main.do?first=y";
			}else {
				return "redirect:main.do";
			}
		}
		@RequestMapping("updatesub.do")
		public String updateSubscribe(Subscribe subscribe, Model model) {
			logger.info(subscribe.toString());
			int result = subscribeService.updateSubscribe(subscribe);
			if(result>0) {
			return "redirect:msubscribe.do";}
			else {
				model.addAttribute("message", "구독상품업데이트 실패 !");
				return "common/error";
			}
		}
		
		 @RequestMapping("deletesub.do") 
		 public String deleteSubscribe(Subscribe subscribe,Model model) {
			 int result = subscribeService.deleteSubscribe(subscribe);
				if(result>0) {
				return "redirect:msubscribe.do";}
				else {
					model.addAttribute("message", "구독상품업데이트 실패 !");
					return "common/error";
				}
		 }
		@RequestMapping("insertsub.do")
		 public String insertSubscribe(Subscribe subscribe,Model model) {
			int result = subscribeService.insertSubscribe(subscribe);
			if(result>0) {
			return "redirect:msubscribe.do";}
			else {
				model.addAttribute("message", "구독상품업데이트 실패 !");
				return "common/error";
			}
		}
		
}
