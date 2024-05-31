package com.sdm.ssm.goodsmanage.controller;

import java.text.SimpleDateFormat;

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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sdm.ssm.goodsmanage.model.service.SpecifyService;
import com.sdm.ssm.goodsmanage.model.vo.GoodsPrint;
import com.sdm.ssm.goodsmanage.model.vo.Specify;

@Controller
public class SpeifyController {

	private static final Logger logger = LoggerFactory.getLogger(SpeifyController.class);

	@Autowired
	private SpecifyService specifyService;

	@RequestMapping(value = "sinsert.do", method = RequestMethod.POST)
	public ResponseEntity<String> specifyInsertMethod(@RequestBody String param) throws ParseException, java.text.ParseException {

		JSONParser jparser = new JSONParser();
		JSONArray jarr = (JSONArray) jparser.parse(param);
		
		for (int i = 0; i < jarr.size(); i++) {
			JSONObject job = (JSONObject) jarr.get(i);

			Specify specify = new Specify();
			specify.setId(Integer.parseInt(job.get("id").toString()));
			specify.setPdPrice(Integer.parseInt(job.get("pdPrice").toString()));
			specify.setPdDate(job.get("pdDate").toString());
			
	
			
			int result = specifyService.insertSpeify(specify);

			// 에러 발생 시
			if (result <= 0) {
				return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
			}
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

	
	
	


	
	// 월 매출 보기 
	@RequestMapping("monthlyPdPrice.do")
	public ResponseEntity<String> calMonthlyPdPriceMethod(
			@RequestBody String param) throws ParseException, java.text.ParseException
				 {
		int monthlyPdSum = 0;
		JSONParser jparser = new JSONParser();
		JSONArray jarr = (JSONArray) jparser.parse(param);
		
		for (int i = 0; i < jarr.size(); i++) {
			JSONObject job = (JSONObject) jarr.get(i);

			Specify specify = new Specify();
			specify.setId(Integer.parseInt(job.get("id").toString()));
			specify.setPdMonth(job.get("month").toString());
				
			// 상품 삭제 메소드 작성
			monthlyPdSum = specifyService.calMonthlyPdPrice(specify);
			
			// 에러 발생 시
			if (monthlyPdSum < 0) {
				return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
			}			
		}						
		return ResponseEntity.ok().body(String.valueOf(monthlyPdSum));
	}
	
	
	
}
