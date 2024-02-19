package kr.happyjob.study.scm.controller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.scm.model.CompanyInfoModel;
import kr.happyjob.study.scm.model.WarehouseInfoModel;
import kr.happyjob.study.scm.service.CompanyInfoService;


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
public class CompanyInfoController {
  
  @Autowired
  CompanyInfoService svc;
  
  // Set logger
  private final Logger logger = LogManager.getLogger(this.getClass());
  
  // Get class name for logger
  private final String className = this.getClass().toString();
  
  
    // 공급처초기화면
  	@RequestMapping("/companyInfo")
      public String showCompanyInfo() {
  		
          return "/scm/companyInfo"; 
      } 
  	
  	
     // 납품업체조회	
 	 @GetMapping("/companyInfo")
 	 public String companyInfo(Model model) {

 	     List<CompanyInfoModel> companyInfo = svc.companyInfo();
 	     model.addAttribute("companyInfo", companyInfo);
 	     
 	     logger.info("   - companyInfo : " + companyInfo);
 	     
 	     return "/scm/companyInfo"; 
 	 
 	 }
 
   	
  	// 납품업체명검색
  	@GetMapping("/searchCompany")
  	public String searchCompany(@RequestParam("searchKey") String searchKey, 
  			                    @RequestParam("sname") String sname, 
  			                    Model model) {
  		
  		logger.info("=====> Start searchCompany"  );
  	    logger.info("   - searchKey : " + searchKey);
  	    logger.info("   - sname : " + sname);
  		
  	    List<CompanyInfoModel> searchCompany = svc.searchCompany(searchKey, sname);
  	    model.addAttribute("companyInfo", searchCompany);
  	    
  	    logger.info("=====> End searchCompany"  );
  	    
		return "/scm/companyInfo";
  	     
  	}
  	
  	
     // 납품업체디테일
  	 @GetMapping("/detailCompany")
  	 public String detailCompany(@RequestParam("company_class_name") String company_class_name,
  			                            Model model) {

  		 logger.info("   - company_class_name : " + company_class_name);
  		 
  	     List<CompanyInfoModel> detailCompany = svc.detailCompany(company_class_name);
  	     model.addAttribute("detailCompany", detailCompany);
  	     
  	     return "/scm/companyInfoDlt"; 
  	 
  	 }
  	
 }
