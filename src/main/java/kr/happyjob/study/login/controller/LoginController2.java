package kr.happyjob.study.login.controller;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.login.model.dto.LoginDto;
import kr.happyjob.study.login.model.dto.UserMenuDto;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.login.model.dto.LoginDto;
import kr.happyjob.study.login.service.login2.LoginService2;

@Controller
public class LoginController2 {

	// logger setting
	private final Logger logger = LogManager.getLogger(this.getClass());
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	LoginService2 loginService2;
	
	/*
	 * index 접속 시 로그인 페이지로 이동한다.
	 */
	@RequestMapping("/index")
	public String loginPage(Model model) {
		logger.info("====> Start LoginController2");
		
		logger.info("====> End LoginController2");
		
		return "/login/login2";
	}
	
	/*
	 * 회원가입 
	 */
	@RequestMapping("/registerUser")
	@ResponseBody
	public Map<String, Object> registerUser(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
											HttpServletResponse response) {
		
		logger.info("==== Start + " + className + ".registerUser");
		logger.info(" ===== paramMap : " + paramMap);
		
		String action = (String) paramMap.get("action");
		String result = "SUCCESS";
		String resultMessage;
		
		if("I".equals(action)) {
			loginService2.registerUser(paramMap);
			resultMessage = "가입 요청 완료";
		} else {
			result = "FAIL";
			resultMessage = "가입 요청 실패";
		}
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMessage", resultMessage);
		
		logger.info("=====> result" + result);
		logger.info("=====> resultMessage" + resultMessage);
		
		logger.info("=====> End " + className + ".registerUser");
		
		
		return resultMap;
	}
	
	/*
	 * 아이디 중복 체크
	 */
	@RequestMapping(value = "loginID_validateCheck", method = RequestMethod.POST)
	@ResponseBody
	public int validateCheck_loginID(LoginDto data) {
		
		logger.info("===== Start " + className + ".loginID_validateCheck");
		
		int result = loginService2.loginID_validateCheck(data);
		
		logger.info("===== Start " + className + ".loginID_validateCheck");
		
		return result;
	}
	
	/*
	 * 사용자 로그인
	 */
	@RequestMapping("/loginUser")
	@ResponseBody
	public Map<String, String> loginUser(@RequestParam Map<String, Object> paramMap, 
														HttpServletRequest request,
														HttpSession session) {
		
		Map<String, String> resultMap = new HashMap<String, String>();
		
		logger.info("=====> Start LoginController.loginUser");
		logger.info("=====> ParamMap : " + paramMap);
		
		// 사용자 로그인
		LoginDto loginData = loginService2.loginUser(paramMap);
		
		String result;
		String resultMessage;
		
		if(loginData != null) {
			
			if("n".equals(loginData.getApproval_cd())) {
				result = "FALSE";
				resultMessage = "승인되지 않은 아이디 입니다.";
			} else {
				result = "SUCCESS";
				resultMessage = "사용자 로그인 정보가 일치 합니다.";
				
				// 사용자 유저 타입 추가
				paramMap.put("user_type", loginData.getUser_type());
				
				List<UserMenuDto> listUserMenuDto = loginService2.listUserMenu(paramMap);
				
				for(UserMenuDto list : listUserMenuDto) {
					Map<String, Object> listMap = new HashMap<String, Object>();
					listMap.put("login_ID", paramMap.get("lgn_Id"));
					listMap.put("parent_menu_id", list.getParent_menu_id());
					listMap.put("user_type", loginData.getUser_type());
					list.setChildList(loginService2.listUserChildMenu(listMap));
				}
				
				logger.info("=====> listUserMenuDto : " + listUserMenuDto);
				session.setAttribute("loginID", loginData.getLoginID()); // 로그인 ID
				session.setAttribute("userName", loginData.getUser_name()); // 유저 이름
				
				session.setAttribute("userMenuList", listUserMenuDto);
				session.setAttribute("serverName", request.getServerName()); // 서버이름
				session.setAttribute("userType", loginData.getUser_type()); // 유저 타입
			}
			
		} else {
			result = "FALSE";
			resultMessage = "사용자 로그인 정보가 일치하지 않습니다.";
		}
		
		resultMap.put("result", result);
		resultMap.put("resultMessage", resultMessage);
		resultMap.put("serverName", request.getServerName());
		
		logger.info("=====> End LoginController2.loginUser");
		
		return resultMap;
	}
}
