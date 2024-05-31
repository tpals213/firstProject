package com.sdm.ssm.goodsmanage.controller;

import java.util.ArrayList;

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
import org.springframework.web.servlet.ModelAndView;

import com.sdm.ssm.common.Paging;
import com.sdm.ssm.common.Search;
import com.sdm.ssm.goodsmanage.model.service.GoodsPrintService;
import com.sdm.ssm.goodsmanage.model.vo.GoodsPrint;

@Controller
public class GoodsPrintController {

	private static final Logger logger = LoggerFactory.getLogger(GoodsPrintController.class);

	@Autowired
	private GoodsPrintService goodsPrintService;

	
	@RequestMapping(value = "glist.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String goodsListMethod(@RequestParam(name = "id", required = false) int id,
			@RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit, Model model) {


		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		
		int limit = 10;
		if (slimit != null) {
			limit = Integer.parseInt(slimit); 
		}

		
		int listCount = goodsPrintService.selectListCount(id);

		
		Paging paging = new Paging(listCount, currentPage, limit, "glist.do");
		paging.calculate();
		
		paging.setId(id);
		ArrayList<GoodsPrint> list = goodsPrintService.selectGoodsPrint(paging);
		
		if (list != null && list.size() > 0) {
			model.addAttribute("list", list);
			model.addAttribute("paging", paging);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("limit", limit);
			return "goods/goodsListView";
		} else {
			model.addAttribute("message", " 재고가 없습니다. 등록을 먼저 해주세요 ");
			return "goods/goodsListError";
		}
	}

	
	@RequestMapping(value = "gsearch.do", method = RequestMethod.GET)
	public String goodsNameSearch(@RequestParam(name = "id", required = false) int id,
			@RequestParam("action") String action, Search search,
			@RequestParam(name = "page", required = false) String page, Model model) {

		
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		
		int listCount = 0;
		Paging paging = new Paging(listCount, currentPage, 10, "gsearch.do");
		paging.calculate();
		search.setId(id);
		ArrayList<GoodsPrint> list = null;

		if (action.equals("goodsName")) {
			listCount = goodsPrintService.selectSearchGoodsNameCount(search);
			paging.setListCount(listCount);
			paging.calculate();

			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			list = goodsPrintService.selectSearchGoodsName(search);

		} else if (action.equals("pdName")) {
			listCount = goodsPrintService.selectSearchPdNameCount(search);
			paging.setListCount(listCount);
			paging.calculate();
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			list = goodsPrintService.selectSearchPdName(search);
		}

		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("action", action);
		model.addAttribute("keyword", search.getKeyword());

		if (list != null && list.size() > 0) {
			return "goods/goodsListView";
		} else {
			model.addAttribute("message", search.getKeyword() + "해당 상품 없음");
			return "common/error";
		}
	}

	
	@RequestMapping(value = "gdelete.do", method = RequestMethod.POST)
	public ResponseEntity<String> goodsdeleteMethod(@RequestBody String param) throws ParseException {

		JSONParser jparser = new JSONParser();
		JSONArray jarr = (JSONArray) jparser.parse(param);

		for (int i = 0; i < jarr.size(); i++) {
			JSONObject job = (JSONObject) jarr.get(i);

			GoodsPrint goodsPrint = new GoodsPrint();
			goodsPrint.setId(Integer.parseInt(job.get("id").toString()));
			goodsPrint.setGoodsNo(Integer.parseInt(job.get("goodsNo").toString()));
			
			int result = goodsPrintService.deleteProduce(goodsPrint);

			
			if (result <= 0) {
				return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
			}
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

	
	@RequestMapping("gmoveinsert.do")
	public String moveGoodsInsertPage2() {
		return "goods/goodsInsert";
	}

	

	
	@RequestMapping(value = "gupdate.do", method = RequestMethod.POST)
	public ResponseEntity<String> goodsupdateMethod(@RequestBody String param) throws ParseException {

		JSONParser jparser = new JSONParser();
		JSONArray jarr = (JSONArray) jparser.parse(param);

		for (int i = 0; i < jarr.size(); i++) {
			JSONObject job = (JSONObject) jarr.get(i);

			GoodsPrint goodsPrint = new GoodsPrint();
			goodsPrint.setId(Integer.parseInt(job.get("id").toString()));
			goodsPrint.setGoodsNo(Integer.parseInt(job.get("goodsNo").toString()));
			goodsPrint.setGoodsPrice(Integer.parseInt(job.get("goodsPrice").toString()));
			goodsPrint.setMinOrderQuantity(Integer.parseInt(job.get("minOrderQuantity").toString()));
			goodsPrint.setMinAlarmQuantity(Integer.parseInt(job.get("minAlarmQuantity").toString()));
			goodsPrint.setPdQuantity(Integer.parseInt(job.get("pdQuantity").toString()));
			goodsPrint.setSalePrice(Integer.parseInt((job.get("salePrice").toString())));
			
			int result1 = goodsPrintService.updateGoodsGT(goodsPrint);
			int result2 = goodsPrintService.updateGoodsIT(goodsPrint);

			
			if (result1 <= 0 && result2 <= 0) {
				return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
			}
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

	@RequestMapping(value = "gupdatebyname.do", method = RequestMethod.POST)
	public ResponseEntity<String> goodsupdatebynameMethod(@RequestBody String param) throws ParseException {

		JSONParser jparser = new JSONParser();
		JSONArray jarr = (JSONArray) jparser.parse(param);

		for (int i = 0; i < jarr.size(); i++) {
			JSONObject job = (JSONObject) jarr.get(i);

			GoodsPrint goodsPrint = new GoodsPrint();
			goodsPrint.setId(Integer.parseInt(job.get("id").toString()));
			goodsPrint.setGoodsName(job.get("name").toString());
			
			int no = goodsPrintService.searchId(goodsPrint);
			goodsPrint.setGoodsNo(no);
			
			int a = goodsPrintService.originQuantity(goodsPrint);
			goodsPrint.setPdQuantity(a - Integer.parseInt(job.get("quantity").toString()));
			
			int result1= goodsPrintService.updatePdQuantity(goodsPrint);

			
			if (result1 <= 0 ) {
				return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
			}
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	
	@RequestMapping(value = "ginsert.do", method = RequestMethod.POST)
	public ResponseEntity<String> goodsinsertMethod(@RequestBody String param) throws ParseException {

		JSONParser jparser = new JSONParser();
		JSONArray jarr = (JSONArray) jparser.parse(param);

		for (int i = 0; i < jarr.size(); i++) {
			JSONObject job = (JSONObject) jarr.get(i);

			GoodsPrint goodsPrint = new GoodsPrint();
			goodsPrint.setId(Integer.parseInt(job.get("id").toString()));
			goodsPrint.setGoodsName(job.get("goodsName").toString());
			goodsPrint.setGoodsUnit(job.get("goodsUnit").toString());
			goodsPrint.setGoodsPrice(Integer.parseInt(job.get("goodsPrice").toString()));
			goodsPrint.setMinOrderQuantity(Integer.parseInt(job.get("minOrderQuantity").toString()));
			goodsPrint.setMinAlarmQuantity(Integer.parseInt(job.get("minAlarmQuantity").toString()));
			goodsPrint.setPdName(job.get("pdName").toString());
			goodsPrint.setPdPhone(job.get("pdPhone").toString());
			goodsPrint.setNation(job.get("nation").toString());
			goodsPrint.setPdQuantity(Integer.parseInt(job.get("pdQuantity").toString()));
			
			int result = goodsPrintService.insertGoods(goodsPrint);

			
			if (result <= 0 ) {
				return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
			}
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

	
	@RequestMapping(value = "plist.do", method = RequestMethod.GET)
	public String produceListMethod(@RequestParam(name = "id", required = false) int id,
			@RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit, Model model) {


		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		
		int limit = 10;
		if (slimit != null) {
			limit = Integer.parseInt(slimit); 
		}

		
		int listCount = goodsPrintService.selectListCount(id);

		
		Paging paging = new Paging(listCount, currentPage, limit, "plist.do");
		paging.calculate(); 
		paging.setId(id);
		ArrayList<GoodsPrint> list = goodsPrintService.selectProducePrint(paging);
		
		if (list != null && list.size() > 0) {
			model.addAttribute("list", list);
			model.addAttribute("paging", paging);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("limit", limit);
			return "goods/produceListView";
		} else {
			model.addAttribute("message", currentPage + " 해당 발주처 없음!");
			return "common/error";
		}
	}

	
	@RequestMapping("pmoveinsert.do")
	public String moveProduceInsertPage() {
		return "goods/produceInsert";
	}

	
		@RequestMapping(value = "pinsert.do", method = RequestMethod.POST)
		public ResponseEntity<String> produceinsertMethod(@RequestBody String param) throws ParseException {

			JSONParser jparser = new JSONParser();
			JSONArray jarr = (JSONArray) jparser.parse(param);

			for (int i = 0; i < jarr.size(); i++) {
				JSONObject job = (JSONObject) jarr.get(i);

				GoodsPrint goodsPrint = new GoodsPrint();
				goodsPrint.setId(Integer.parseInt(job.get("id").toString()));
				goodsPrint.setPdName(job.get("pdName").toString());
				goodsPrint.setPdPhone(job.get("pdPhone").toString());
				goodsPrint.setPdAddress(job.get("pdAddress").toString());
				goodsPrint.setGoodsName(job.get("goodsName").toString());
				goodsPrint.setGoodsPrice(Integer.parseInt(job.get("goodsPrice").toString()));
				goodsPrint.setGoodsUnit(job.get("goodsUnit").toString());
				goodsPrint.setPdQuantity(Integer.parseInt(job.get("pdQuantity").toString()));	
				goodsPrint.setNation(job.get("nation").toString());
				
				int result = goodsPrintService.insertGoods(goodsPrint);

				
				if (result <= 0 ) {
					return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
				}
			}
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}

	
	@RequestMapping(value = "pupdate.do", method = RequestMethod.POST)
	public ResponseEntity<String> produceupdateMethod(@RequestBody String param) throws ParseException {

		JSONParser jparser = new JSONParser();
		JSONArray jarr = (JSONArray) jparser.parse(param);

		for (int i = 0; i < jarr.size(); i++) {
			JSONObject job = (JSONObject) jarr.get(i);

			GoodsPrint goodsPrint = new GoodsPrint();
			goodsPrint.setId(Integer.parseInt(job.get("id").toString()));
			goodsPrint.setGoodsNo(Integer.parseInt(job.get("goodsNo").toString()));
			goodsPrint.setPdPhone(job.get("pdPhone").toString());
			goodsPrint.setPdAddress(job.get("pdAddress").toString());
			goodsPrint.setGoodsUnit(job.get("goodsUnit").toString());
			goodsPrint.setNation(job.get("nation").toString());
			
			int result1 = goodsPrintService.updateProduceGT(goodsPrint);
			int result2 = goodsPrintService.updateProducePT(goodsPrint);

			
			if (result1 <= 0 && result2 <= 0) {
				return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
			}
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

	
	@RequestMapping(value = "pdelete.do", method = RequestMethod.POST)
	public ResponseEntity<String> producedeleteMethod(@RequestBody String param) throws ParseException {

		JSONParser jparser = new JSONParser();
		JSONArray jarr = (JSONArray) jparser.parse(param);

		for (int i = 0; i < jarr.size(); i++) {
			JSONObject job = (JSONObject) jarr.get(i);

			GoodsPrint goodsPrint = new GoodsPrint();
			goodsPrint.setId(Integer.parseInt(job.get("id").toString()));
			goodsPrint.setGoodsNo(Integer.parseInt(job.get("goodsNo").toString()));
			
			int result = goodsPrintService.deleteProduce(goodsPrint);

			
			if (result <= 0) {
				return new ResponseEntity<String>("failed", HttpStatus.REQUEST_TIMEOUT);
			}
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

	
	@RequestMapping("specify.do")
	public String moveSpecifyPage() {
		return "goods/specify";
	}

	
	@RequestMapping(value = "goodsNameSearch.do")
	public String goodsNameSearchMethod(@RequestParam(name = "id", required = false) String id,
			@RequestParam("action") String action, Model model, Search search) {

		int userId = 0;
		userId = Integer.parseInt(id);
		search.setId(userId);

		ArrayList<GoodsPrint> list = null;
		list = goodsPrintService.selectSSearchGoodsName(search);
		model.addAttribute("list", list);

		return "goods/specify";

	}

	
	@RequestMapping(value = "pdNameSearch.do")
	public String pdNameSearchMethod(@RequestParam(name = "id", required = false) int id,
			@RequestParam("action") String action, Model model, Search search) {

		search.setId(id);

		ArrayList<GoodsPrint> list = null;
		list = goodsPrintService.selectSSearchpdName(search);
		model.addAttribute("list", list);

		return "goods/specify";

	}
	
	
	
	@RequestMapping(value = "psearch.do", method = RequestMethod.GET)
	public String produceNameSearch(@RequestParam(name = "id", required = false) int id,
			@RequestParam("action") String action, Search search,
			@RequestParam(name = "page", required = false) String page, Model model) {

		
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		
		int listCount = 0;
		Paging paging = new Paging(listCount, currentPage, 10, "gsearch.do");
		paging.calculate();
		search.setId(id);
		ArrayList<GoodsPrint> list = null;

		if (action.equals("goodsName")) {
			listCount = goodsPrintService.selectSearchGoodsNameCount(search);
			paging.setListCount(listCount);
			paging.calculate();

			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			list = goodsPrintService.selectSearchGoodsName(search);

		} else if (action.equals("pdName")) {
			listCount = goodsPrintService.selectSearchPdNameCount(search);
			paging.setListCount(listCount);
			paging.calculate();
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			list = goodsPrintService.selectSearchPdName(search);
		}

		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("action", action);

		if (list != null && list.size() > 0) {
			return "goods/produceListView";
		} else {
			model.addAttribute("message", search.getKeyword() + "해당 상품 없음");
			return "common/error";
		}
	}
	
}
