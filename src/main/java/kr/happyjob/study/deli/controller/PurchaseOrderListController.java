package kr.happyjob.study.deli.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.deli.model.PurchaseOrderListModel;
import kr.happyjob.study.deli.service.PurchaseOrderListService;
import kr.happyjob.study.order.service.PurchasePaperService;

@Controller
@RequestMapping("/deli/")
public class PurchaseOrderListController {
	
	@Autowired
	PurchaseOrderListService purchaseOrderListService;
	     
     // Set logger
     private final Logger logger = LogManager.getLogger(this.getClass());
     
     // Get class name for logger
     private final String className = this.getClass().toString();
     
   
     @RequestMapping("purchaseOrderList.do")
       public String purchasePaper() throws Exception {
       
       return "deli/purchaseOrder";
     }
     
     @RequestMapping("selectPurchaseOrderList.do")
     public String selectPurchaseOrderList(@RequestParam Map<String, Object> param, Model model, HttpSession httpSession) throws Exception{
         logger.info("   - paramMap : " + param);
         
         
         int currentPage = Integer.parseInt((String) param.get("currentPage"));
         int pageSize = Integer.parseInt((String) param.get("pageSize"));
         
         int pageIndex = (currentPage - 1) * pageSize;
         
         param.put("pageIndex", pageIndex);
         param.put("pageSize", pageSize);
         
         List<PurchaseOrderListModel> purchaseOrderList = purchaseOrderListService.selectPurchaseOrderList(param);
         model.addAttribute("purchaseOrderList",purchaseOrderList);
         
         int totalCount = purchaseOrderListService.countPurchaseOrderList(param);
         model.addAttribute("totalCount", totalCount);
         
         model.addAttribute("pageSize", pageSize);
         model.addAttribute("currentPage", currentPage);
         
         return "/deli/purchaseOrderList";
     }
     
     @RequestMapping("purchaseOrderDetail.do")
     public String purchaseOrderDetail(Model model,@RequestParam Map<String, Object>param, HttpServletRequest httpServletRequest, HttpServletResponse response, HttpSession session) throws Exception {
    	    
    	    logger.info("+ Start " + className + ".listComnDtlCod");
    	    logger.info("   - paramMap : " + param);
    	    
    	    int currentPage = Integer.parseInt((String)param.get("currentPage"));
    	    int pageSize = Integer.parseInt((String)param.get("pageSize"));
    	    int pageIndex = (currentPage - 1) * pageSize;
    	    
    	    param.put("pageIndex", pageIndex);
            param.put("pageSize", pageSize);
            
            List<PurchaseOrderListModel> purchaseOrderList = purchaseOrderListService.selectPurchaseOrderList(param);
            model.addAttribute("purchaseOrderList",purchaseOrderList);
            
            int totalCount = purchaseOrderListService.countPurchaseOrderList(param);
            model.addAttribute("totalCount", totalCount);
            
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("currentPage", currentPage);
            
            return "/deli/purchaseOrderDetailList";
     }
}
