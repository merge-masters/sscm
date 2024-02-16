package kr.happyjob.study.basicinfo.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.basicinfo.dto.CustomerDto;
import kr.happyjob.study.basicinfo.service.CustomerInfoService;

@Controller
public class CustomerController {
	
	// Logger Setting
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	CustomerInfoService customerInfoService;

	/*
	 * 고객 관리 페이지
	 */
	@RequestMapping("/scm/cusinfo.do")
	public String customerInfoPage(Model model ) {
		logger.info("=====> START CustomerController - /scm/cusinfo.do ");
		logger.info("=====> END CustomerController - /scm/cusinfo.do ");
		
		return "/scm/customerInfo";
	}
	
	/**
	 * 고객정보 리스트 불러오기
	 */
	@RequestMapping("/basic/customerList")
	public String customerList(Model model, @RequestParam Map<String, Object> paramMap, HttpSession session) {
		logger.info("=====> Start customerList" );
		logger.info("=====> paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String)paramMap.get("customerPageSize")); // 페이지 사이즈
		int pageIndex = (currentPage - 1) * pageSize;
		
		logger.info("=====> currentPage : " + currentPage);
		logger.info("=====> pageIndex : " + pageIndex);
		logger.info("=====> pageSize : " + pageSize);
		logger.info("=====> searchCustomerType : " + paramMap.get("searchCustomerType"));
		logger.info("=====> customerInput : " + paramMap.get("customerInput"));
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<CustomerDto> customerList = customerInfoService.customerList(paramMap);
		
		int customerCount = customerInfoService.customerCount(paramMap);
		
		logger.info("=====> customerCount" + customerCount);
		
		model.addAttribute("customerList", customerList);
		model.addAttribute("customerCount", customerCount);
		model.addAttribute("customerCurrentPage", currentPage);
		model.addAttribute("pageSize", pageSize);
		
		
		logger.info("=====> End customerList" );
		return "/scm/customerDetailList";
	}
	
	/**
	 * 고객 정보 디테일 들고오기
	 */
	@RequestMapping("/basic/selectCustomerDetail")
	@ResponseBody
	public Map<String, Object> selectCustomerDetail(@RequestParam Map<String, Object> paramMap) {
		
		logger.info("=====> Start selectCustomerDetail");
		logger.info("=====> paramMap : " + paramMap);
		
		CustomerDto detailCustomerInfo = customerInfoService.selectCustomerDetail(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("selectCustomerDetail", detailCustomerInfo);
		
		logger.info("=====> End selectCustomerDetail");
		
		return resultMap;
	}
	
	/**
	 * 고객 정보 수정하기
	 */
	@RequestMapping("/basic/updateCustomerInfo")
	@ResponseBody
	public Map<String, Object> updateCustomerInfo(@RequestParam Map<String, Object> paramMap) {
		logger.info("=====> Start updateCustomerInfo");
		logger.info("=====> paramMap : " + paramMap);
		
		String result = "N";
		
		customerInfoService.updateCustomerInfo(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		result = "Y";
		String resultMessage = "고객의 정보가 수정되었습니다.";
		
		resultMap.put("result", result);
		resultMap.put("resultMessage", resultMessage);
		
		logger.info("=====> End updateCustomerInfo");
		
		return resultMap;
	}
	
	
	/**
	 * 고객 정보 삭제하기
	 */
	@RequestMapping("/basic/deleteCustomerInfo")
	@ResponseBody
	public Map<String, Object> deleteCustomerInfo(Model model, @RequestParam Map<String, Object> paramMap) {
		
		logger.info("=====> Start deleteCustomerInfo");
		
		String result = "N";
		
		customerInfoService.deleteCustomerInfo(paramMap);
		
		result = "Y";
		String resultMessage = "고객의 정보가 삭제되었습니다.";
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", result);
		resultMap.put("resultMessage", resultMessage);
		
		logger.info("=====> End deleteCustomerInfo");
		
		return resultMap;
	}
}
