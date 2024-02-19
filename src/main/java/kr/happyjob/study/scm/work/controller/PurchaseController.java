package kr.happyjob.study.scm.work.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.order.service.PurchasePaperService;
import kr.happyjob.study.scm.work.model.PurchaseModel;
import kr.happyjob.study.scm.work.service.PurchaseService;

@Controller
@RequestMapping("/work/")
public class PurchaseController {
	
	@Autowired
	PurchaseService purchaseService;
	
    // Set logger
    private final Logger logger = LogManager.getLogger(this.getClass());
    
    // Get class name for logger
    private final String className = this.getClass().toString();
    
    @RequestMapping(value="purchase.do")
    public String purchase() throws Exception{
    	return "scm/work/purchase";
    }
    
    @RequestMapping(value = "purchaseList.do")
    public String purchaseList(@RequestParam(required=false) Map<String, Object>param, Model model, HttpSession httpSession) throws Exception {
        logger.info("   - paramMap : " + param);
        
        int currentPage = Integer.parseInt((String)param.get("currentPage"));
        int pageSize = Integer.parseInt((String)param.get("pageSize"));

        int pageIndex = (currentPage - 1) * pageSize;
        
        param.put("pageIndex", pageIndex);
        param.put("pageSize", pageSize);
        
        List<PurchaseModel> purchaseList = purchaseService.selectPurchaseList(param);
        model.addAttribute("purchaseList", purchaseList);
        
        int totalCount = purchaseService.countPurchaseList(param);
        model.addAttribute("totalCount", totalCount);
        
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        
        return "scm/work/purchaseList";
    }

}
