package kr.happyjob.study.scm.controller;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/scm/")
public class StockInfoController {
	  
	 // Set logger
	  private final Logger logger = LogManager.getLogger(this.getClass());
	  
	  // Get class name for logger
	  private final String className = this.getClass().toString();
	  
	    // 창고별 재고현황 초기화면
	  	@RequestMapping("/scmStockInfo.do")
	      public String showCompanyInfo() {
	  		
	          return "/scm/scmStockInfo"; 
	      } 
	  
}
