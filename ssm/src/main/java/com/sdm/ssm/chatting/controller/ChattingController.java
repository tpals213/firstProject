package com.sdm.ssm.chatting.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller("ChattingController")
public class ChattingController {
	
	private static final Logger logger = LoggerFactory.getLogger(ChattingController.class);
	
	@GetMapping("chat.do")
	public void chat(Model model) {
		
//		LoginUser user = (LoginUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		// 로그인한 id 받아서 model 담아서 뷰로 전달. 
//		
//		
//		logger.info("==================================");
//		logger.info("@ChatController, GET Chat / Username : " + user.getUsername());
//		
//		model.addAttribute("userid", user.getUsername());
	}
}
