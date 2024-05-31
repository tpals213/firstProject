package com.sdm.ssm.pos.controller;

import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sdm.ssm.common.Paging;
import com.sdm.ssm.goodsmanage.model.service.GoodsPrintService;
import com.sdm.ssm.goodsmanage.model.vo.GoodsPrint;
import com.sdm.ssm.pos.model.service.PosService;
import com.sdm.ssm.pos.model.vo.Table;


@Controller
public class PosController2 {
	private static final Logger logger = LoggerFactory.getLogger(PosController2.class);
	
	@Autowired
	private GoodsPrintService goodsPrintService;
	
	@Autowired
	private PosService posService;
	
	
	@RequestMapping("mvTablePos.do")
	public String moveTablePos(@RequestParam("id") String id,Model model) {
		ArrayList<Table> list = posService.selectTableList(id);
		model.addAttribute("list", list);
		return "pos/table";
	}
	@RequestMapping("mvNoTablePos.do")
	public String moveNoTablePos(@RequestParam(name = "id", required = false) int id,
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
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("limit", limit);
		
		
		return "pos/notable";
	}
	@RequestMapping("mvPosSetting.do")
	public String movePosSettingPage(Model model,@RequestParam("id") String id) {
		ArrayList<Table> list = posService.selectTableList(id);
		model.addAttribute("list", list);
		return "pos/posSetting";
	}
	@RequestMapping("saveTableXY.do")
	public void saveTableMethod(@RequestBody String tableArray) throws ParseException{
		JSONParser jparser = new JSONParser();
		JSONArray jarr = (JSONArray)jparser.parse(tableArray);
		for(int i=0; i<jarr.size(); i++) {
			JSONObject job = (JSONObject)jarr.get(i);
			Table table = new Table();
			table.setTableName((String)job.get("tableName"));
			String strX = (String) job.get("tableX");
			String strY = (String)job.get("tableY");
			String strX2 = strX.substring(0, strX.length()-2);  //px 자르기
			String strY2= strY.substring(0, strY.length()-2);  //px 자르기
			
			table.setTableX(Double.parseDouble(strX2));
			table.setTableY(Double.parseDouble(strY2));
			table.setId(Integer.parseInt((String) job.get("userId")));
			
			int result = posService.insertTableInfo(table);
			}
	}
	@RequestMapping("deleteTable.do")
	public String deleteTable(Table table, Model model) {
		int result = posService.deleteTable(table);
		model.addAttribute("id", table.getId());
		return "redirect:mvPosSetting.do";
	}
}
