package kr.happyjob.study.scm.controller;

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
@RequestMapping("/scm/")
public class WarehouseInfoController {
  
  @Autowired
  WarehouseInfoService svc;
  
  // Set logger
  private final Logger logger = LogManager.getLogger(this.getClass());
  
  // Get class name for logger
  private final String className = this.getClass().toString();
  
  
    // 창고초기화면
  	@RequestMapping("/warehouseInfo")
      public String showWarehouseInfo() {
  		
          return "/scm/warehouseInfo"; 
      } 
  	
  	
  	// 창고등록
  	@PostMapping("/insertWarehouse")
  	@ResponseBody
  	public Map<String, Object> insertWarehouse(@RequestParam Map<String, Object> paramMap) {
  	    
  		Map<String, Object> resultMap = new HashMap<>();

  	    try {
  	    	
  	        boolean inserted = svc.insertWarehouse(paramMap);
  	        resultMap.put("inserted", inserted);
  	        
  	    } catch (Exception e) {
  	        resultMap.put("error", "창고 등록 중 오류가 발생했습니다.");
  	    }

  	    return resultMap;
  	}
  	
  	
  	 // 창고조회	
  	 @GetMapping("/warehouseInfo")
  	 public String listWarehouse(Model model) {

  	     List<WarehouseInfoModel> listWarehouse = svc.listWarehouse();
  	     model.addAttribute("listWarehouse", listWarehouse);
  	     
  	     return "/scm/warehouseInfo"; 
  	 
  	 }
  	 
  
    // 창고상세조회	 
  	@GetMapping("/detailWarehouse")
  	public String detailWarehouse(@RequestParam("warehouse_code") String warehouse_code, 
  			                       Model model)
  		{
  		    List<WarehouseInfoModel> detailWarehouse = svc.detailWarehouse(warehouse_code);
  			model.addAttribute("detailWarehouse", detailWarehouse);
  			return "/scm/warehouseInfoDlt";
  		}
  	
  	
  	// 창고검색
  	@GetMapping("/searchWarehouse")
  	public String searchWarehouse(@RequestParam("searchKey") String searchKey, 
  			                      @RequestParam("sname") String sname, 
  			                      Model model) {
  		
  		logger.info("=====> Start searchWarehouse"  );
  	    logger.info("   - searchKey : " + searchKey);
  	    logger.info("   - sname : " + sname);
  		
  	    List<WarehouseInfoModel> searchWarehouse = svc.searchWarehouse(searchKey, sname);
  	    /*for(WarehouseInfoModel list :searchWarehouse) {
  	    	logger.info("=====> " + list.getWarehouse_name());
  	    }*/
  	    model.addAttribute("listWarehouse", searchWarehouse);
  	    
  	  logger.info("=====> End searchWarehouse"  );
  	    return "/scm/warehouseInfo"; 
  	}
  	
  
 	// 창고수정
    @PostMapping("/updateWarehouse")
  	@ResponseBody
  	public Map<String, Object> updateWarehouse(WarehouseInfoModel warehouseInfo) {
  			
  		Map<String, Object> resultMap = new HashMap<>();
  			
  		try {
  	  	    	
  	  	       boolean updated = svc.updateWarehouse(warehouseInfo);
  	  	       resultMap.put("updated", updated);
  	  	        
  	  	   } catch (Exception e) {
  	  		   
  	  	       resultMap.put("error", "창고 수정 중 오류가 발생했습니다.");
  	  	   }

  	  	   return resultMap;
  	}
  
  		
     // 창고삭제
  	 @PostMapping("/deleteWarehouse")
  	 @ResponseBody
  	 public Map<String, Object> deleteWarehouse(WarehouseInfoModel warehouseInfo) {
  		 
  		    Map<String, Object> resultMap = new HashMap<>();
  			
			try {
				
				 boolean deleted = svc.deleteWarehouse(warehouseInfo);
				 resultMap.put("deleted", deleted);
				 
			} catch (Exception e) {
				
				resultMap.put("error", "창고 삭제 중 오류가 발생했습니다.");
			}
				return resultMap;
  		}
  	
  
  }
 

 