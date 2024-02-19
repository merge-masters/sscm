package kr.happyjob.study.scm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/scm/")
public class SupplyInfoController {
	
	@RequestMapping("/supplyInfo.do")
	public String startSupplierInfo(){
		return "/scm/supplyInfo";
	}
}
