package kr.happyjob.study.basicinfo.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.basicinfo.dto.CustomerDto;
import kr.happyjob.study.basicinfo.dto.EmployeeDto;
import kr.happyjob.study.basicinfo.service.EmployeeInfoService;

@Controller
public class EmployeeController {
	
	// Logger Setting
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	EmployeeInfoService employeeInfoService;
	
	/**
	 * 직원 관리 페이지
	 */
	@RequestMapping("/scm/employeeinfo.do")
	public String employeeInfoPage() {
		logger.info("=====> START EmployeeController - /scm/employeeinfo.do");
		logger.info("=====> END EmployeeController - /scm/employeeinfo.do");
		
		return "/scm/employeeInfo";
	}
	
	/**
	 * 직원정보 리스트 불러오기
	 */
	@RequestMapping("/basic/employeeList")
	public String employeeList(Model model, @RequestParam Map<String, Object> paramMap) {
		logger.info("=====> Start employeeList");
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재 페이지
		int pageSize = Integer.parseInt((String) paramMap.get("employeePageSize")); // 페이지 사이즈
		int pageIndex = (currentPage - 1) * pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<EmployeeDto> employeeList = employeeInfoService.employeeList(paramMap);
		
		int employeeCount = employeeInfoService.employeeCount(paramMap);
		
		model.addAttribute("employeeList", employeeList);
		model.addAttribute("employeeCount", employeeCount);
		model.addAttribute("employeeCurrentPage", currentPage);
		model.addAttribute("pageSize", pageSize);
		
		
		logger.info("=====> End employeeList");
		
		return "/scm/employeeDetailList";
	}
	
	/**
	 * 직원 정보 디테일 들고오기
	 */
	@RequestMapping("/basic/selectEmployeeDetail")
	@ResponseBody
	public Map<String, Object> selectEmployeeDetail(@RequestParam Map<String, Object> paramMap) {
		
		logger.info("=====> Start selectEmployeeDetail");
		logger.info("=====> paramMap : " + paramMap);
		
		EmployeeDto detailEmployeeInfo = employeeInfoService.selectEmployeeDetail(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("selectEmployeeDetail", detailEmployeeInfo );
		
		logger.info("=====> End selectEmployeeDetail");
		
		return resultMap;
	}
	
	/**
	 * 직원 정보 수정하기
	 */
	@RequestMapping("/basic/updateEmployeeInfo")
	@ResponseBody
	public Map<String, Object> updateEmployeeInfo(@RequestParam Map<String, Object> paramMap) {
		logger.info("=====> Start updateEmployeeInfo");
		logger.info("=====> paramMap : " + paramMap);
		
		String result = "N";
		
		employeeInfoService.updateEmployeeInfo(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		result = "Y";
		String resultMessage = "직원의 정보가 수정되었습니다.";
		
		resultMap.put("result", result);
		resultMap.put("resultMessage", resultMessage);
		
		logger.info("=====> End updateEmployeeInfo");
		
		return resultMap;
	}
	
	/**
	 * 직원 데이터 삭제하기
	 */
	@RequestMapping("/basic/deleteEmployeeInfo")
	@ResponseBody
	public Map<String, Object> deleteEmployeeInfo(Model model, @RequestParam Map<String, Object> paramMap) {
		
		logger.info("=====> Start deleteEmployeeInfo");
		
		String result = "N";
		
		employeeInfoService.deleteEmployeeInfo(paramMap);
		
		result = "Y";
		String resultMessage = "직원의 정보가 삭제되었습니다.";
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", result);
		resultMap.put("resultMessage", resultMessage);
		
		logger.info("=====> End deleteEmployeeInfo");
		
		return resultMap;
	}
}
