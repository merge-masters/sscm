package kr.happyjob.study.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.bouncycastle.math.raw.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.order.model.PurchasePaper;
import kr.happyjob.study.order.service.PurchasePaperService;

/**
* 학자금지급기준설정을 관리하는 비즈니스 구현 클래스
* @author 고아라
* <pre>
* 수정일                수정자       수정내용
* -------------- ---------- ---------------------------------------------
* 2022.02.21       고아라       최초 작성
* 2022.04.21       이지화       수정
* </pre>
*/
@Controller
@RequestMapping("/order/")
public class PurchasePaperController {
   
   @Autowired
   PurchasePaperService purchasePaperService;
     
     // Set logger
     private final Logger logger = LogManager.getLogger(this.getClass());
     
     // Get class name for logger
     private final String className = this.getClass().toString();
     
   
     @RequestMapping(value="purchasePaper.do", method=RequestMethod.GET)
       public String purchasePaper() throws Exception {
       
       return "order/purchasePaper";
     }
   
   @RequestMapping(value="purchasePaper.do", method=RequestMethod.POST)
   public String purchasePaperList(@RequestParam(required=false) Map<String, Object>param, Model model, HttpSession httpSession) throws Exception {
      
       logger.info("   - paramMap : " + param);
       
      int currentPage = Integer.parseInt((String) param.get("currentPage"));
      int pageSize = Integer.parseInt((String) param.get("pageSize"));
      
      int pageIndex = (currentPage - 1) * pageSize;
      
      param.put("pageIndex", pageIndex);
      param.put("pageSize", pageSize);
      
      List<PurchasePaper> purchasePaperList = purchasePaperService.selectPurchasePaperList(param);
      model.addAttribute("purchasePaperList", purchasePaperList);
      
      int totalCount = purchasePaperService.countPurchasePaperList(param);
      model.addAttribute("totalCount", totalCount);
      
       
       model.addAttribute("pageSize", pageSize);
       model.addAttribute("currentPage", currentPage);
       

       return "/order/purchasePaperList";
      
   }
   
   // 입금확인여부 변경   
   @RequestMapping("checkDeposit.do")
   public String checkDeposit(@RequestParam Map<String, Object>param, Model model, HttpSession httpSession) throws Exception {

       logger.info("   - checkDeposit : " + param);
       
       int result = purchasePaperService.checkDeposit(param);
       
          return "/order/purchasePaperList";
       
   }
   
   // 배송 테이블 삽입
   @RequestMapping("startDelivery.do")
   @ResponseBody
   public String startDelivery(Model model, @RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	    logger.info("   - param : " + param);
	    
	    // String result = "SUCCESS";
	    int duplicate = purchasePaperService.checkDuplicate(param);
	    
	    logger.info("   - duplicate : " + duplicate);
	    
	    if(duplicate >0) {
	    	return "DUPLICATE";
	    } else {
	    
	    	int result = purchasePaperService.startDelivery(param);
	    	
	    	if(result > 0) {
		    	int startDate = purchasePaperService.deliveryStartDate(param);
		    	
		    	if(startDate > 0) {
		    		int updatePaperYn = purchasePaperService.updatePurchasePaperYn(param);
		    		
		    		if(updatePaperYn > 0) {
		    			return "order/purchasePaper";
		    		} else {
		    		logger.info("   - updatePaperYn : " + updatePaperYn);
		    		}
		    	} else {
	    		logger.info("   - startDate : " + startDate);
	    	}
	    	logger.info("   - result : " + result);
	    	return "";
	    } 
   } return "";
}
}