package com.sdm.ssm.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FooterController {
	
	@RequestMapping("goGoogleMap.do")
	public String goGoogleMapMethod() {
		return "common/googleMap";
	}
	
	@RequestMapping("goReady.do")
	public String goRreadyMethod() {
		return "common/ready";
	}
	
	
}
