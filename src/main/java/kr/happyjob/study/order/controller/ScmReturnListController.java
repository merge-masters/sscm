package kr.happyjob.study.order.controller;

import java.util.*;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.order.model.ScmReturnListModel;
import kr.happyjob.study.order.service.ScmReturnListService;
import kr.happyjob.study.scm.model.WarehouseInfoModel;
import kr.happyjob.study.scm.service.WarehouseInfoService;


	/**
	* 창고정보관리(등록, 조회, 수정, 삭제)
	* @author 강기림
	* <pre>
	*     수정일    	  수정자 		      수정내용
	* -------------- ---------- ---------------------------------------------
	*  2024.01.28 	  강기림 		     최초 작성
	* </pre>
	*/

	@Controller
	@RequestMapping("/order/")
	public class ScmReturnListController {
	  
	  @Autowired
	  ScmReturnListService svc;
	  
	  // Set logger
	  private final Logger logger = LogManager.getLogger(this.getClass());
	  
	  // Get class name for logger
	  private final String className = this.getClass().toString();
	  
	  
	    // 반품신청목록 초기화면
	  	@RequestMapping("/scmReturnList")
	      public String showscmReturnList() {
	  		
	          return "/scm/scmReturnList"; 
	      } 
	  	
	  	
	  	 // 반품신청목록 조회
	  	 @GetMapping("/scmReturnList")
	  	 public String scmReturnList(Model model) {

	  	     List<ScmReturnListModel> scmReturnList = svc.scmReturnList();
	  	     model.addAttribute("scmReturnList", scmReturnList);
	  	     
	  	     return "/scm/scmReturnList"; 
	  	 
	  	 }
	  	
}
