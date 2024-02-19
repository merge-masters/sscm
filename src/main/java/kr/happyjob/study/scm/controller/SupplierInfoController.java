package kr.happyjob.study.scm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/scm/")
public class SupplierInfoController {
	
	@RequestMapping("/supplierInfo.do")
	public String startSupplierInfo(){
		return "/scm/supplierInfo";
	}
}
