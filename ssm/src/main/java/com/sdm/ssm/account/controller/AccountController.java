package com.sdm.ssm.account.controller;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sdm.ssm.account.model.vo.Account;
import com.sdm.ssm.account.service.AccountService;
import com.sdm.ssm.goodsmanage.controller.GoodsPrintController;
import com.sdm.ssm.goodsmanage.model.service.GoodsPrintService;
import com.sdm.ssm.goodsmanage.model.vo.GoodsPrint;
import com.sdm.ssm.goodsmanage.model.vo.Specify;

@Controller
public class AccountController {

	private static final Logger logger = LoggerFactory.getLogger(AccountController.class);

	@Autowired
	private AccountService accountService;

	// 회계 관리 페이지 이동
	// 월 매출 보기 페이지이동
	@RequestMapping("account.do")
	public String moveGoodsInsertPage() {
		return "account/accountListView";
	}

	// 월세 세금 기타비용 삽입 및 수정
	@RequestMapping("insertAccount.do")
	public ResponseEntity<String> insertAccountMethod(
			@RequestBody String param) throws ParseException, java.text.ParseException
					{
	
		JSONParser jparser = new JSONParser();
		JSONArray jarr = (JSONArray) jparser.parse(param);
		
		
		
		int result = 0;
		
		// 월세 
			// 삽입 수정 판단
			JSONObject jo1 = (JSONObject) jarr.get(0);
			Account ac1 = new Account();
			ac1.setId(Integer.parseInt(jo1.get("id").toString()));
			ac1.setYearmonth(jo1.get("yearmonth").toString());
			ac1.setPrice(Integer.parseInt(jo1.get("rent").toString()));
			ac1.setTitle("월세");
			
			result = accountService.countNull(ac1);
			if(result == 0) {
				accountService.insertAccount(ac1);
			}else {
				accountService.updateAccount(ac1);
			}	
		// 세금
			JSONObject jo2 = (JSONObject) jarr.get(1);
			Account ac2 = new Account();
			ac2.setId(Integer.parseInt(jo2.get("id").toString()));
			ac2.setYearmonth(jo2.get("yearmonth").toString());
			ac2.setPrice(Integer.parseInt(jo2.get("tax").toString()));
			ac2.setTitle("세금");
			
			result = accountService.countNull(ac2);
			if(result == 0) {
				accountService.insertAccount(ac2);
			}else {
				accountService.updateAccount(ac2);
			}				
		// 기타 비용
			JSONObject jo3 = (JSONObject) jarr.get(2);
			Account ac3 = new Account();
			ac3.setId(Integer.parseInt(jo3.get("id").toString()));
			ac3.setYearmonth(jo3.get("yearmonth").toString());
			ac3.setPrice(Integer.parseInt(jo3.get("cost").toString()));
			ac3.setTitle("기타비용");
			
			result = accountService.countNull(ac3);
			if(result == 0) {
				accountService.insertAccount(ac3);
			}else {
				accountService.updateAccount(ac3);
			}
		

			// 에러 발생 시
			if (result < 0) {
				return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
			}			
		return new ResponseEntity<String>("success",HttpStatus.OK);
		}

	// 월별 항목별 비용 보기 
	@RequestMapping("monthlyCost.do")
	public ResponseEntity<String> calMonthlyPdPriceMethod(
			@RequestBody String param) throws ParseException, java.text.ParseException
				 {
		int monthlycost = 0;
		int monthlytax = 0;
		int monthlyrent = 0;
		int monthlysale = 0;
		
		JSONParser jparser = new JSONParser();
		JSONArray jarr = (JSONArray) jparser.parse(param);
		JSONArray resultArray = new JSONArray();
		
		for (int i = 0; i < jarr.size(); i++) {
			JSONObject job = (JSONObject) jarr.get(i);

			Account account = new Account();
			account.setId(Integer.parseInt(job.get("id").toString()));
			account.setYearmonth(job.get("month").toString());
				
			// 항목별 비용 조회 메소드 작성
			monthlycost = accountService.calCost(account);
			monthlytax = accountService.calTax(account);
			monthlyrent = accountService.calRent(account);
			monthlysale = accountService.calSale(account);
			
			JSONObject resultObj = new JSONObject();
			
			resultObj.put("monthlycost", monthlycost);
	        resultObj.put("monthlytax", monthlytax);
	        resultObj.put("monthlyrent", monthlyrent);
			resultObj.put("monthlysale", monthlysale);
	        
	        resultArray.add(resultObj);
	        
			// 에러 발생 시
			if (monthlycost < 0 && monthlytax < 0 && monthlyrent < 0) {
				return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
			}			
		}						
		return ResponseEntity.ok().body(resultArray.toJSONString());
	}
	
	@RequestMapping(value = "saleinsert.do", method = RequestMethod.POST)
	public ResponseEntity<String> saleInsertMethod(@RequestBody String param) throws ParseException {

		JSONParser jparser = new JSONParser();
		JSONArray jarr = (JSONArray) jparser.parse(param);

		int[] arr = new int[jarr.size()];
		int x = 0;
		for(int k = 0; k <arr.length; k++) {
			JSONObject job = (JSONObject) jarr.get(k);
			arr[k] = Integer.parseInt(job.get("salePrice").toString());
			x += arr[k];
		}
		
		logger.info(x + "원");
		
		for (int i = 0; i < 1; i++) {
			JSONObject job = (JSONObject) jarr.get(i);

			Account account = new Account();
			account.setId(Integer.parseInt(job.get("id").toString()));
			account.setPrice(x);
			account.setTitle("매출");
			account.setYearmonth(job.get("date").toString());
						
			int result = accountService.insertAccount(account); 
				
			if (result <= 0) {
				return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
			}
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	
}
