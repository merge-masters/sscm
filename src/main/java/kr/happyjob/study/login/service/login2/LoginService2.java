package kr.happyjob.study.login.service.login2;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.login.model.dto.LoginDto;
import kr.happyjob.study.login.model.dto.UserMenuChildDto;
import kr.happyjob.study.login.model.dto.UserMenuDto;

public interface LoginService2 {

	/** 회원가입 */
	public int registerUser(Map<String, Object> paramMap);
	
	/** 아이디 중복 체크 */
	public int loginID_validateCheck(LoginDto data);
	
	/** 사용자 로그인 */
	public LoginDto loginUser(Map<String, Object> paramMap);
	
	/** 사용자 메뉴 권한 */
	public List<UserMenuDto> listUserMenu(Map<String, Object> paramMap);
	
	/** 사용자 자식 메뉴 권한 */
	public List<UserMenuChildDto> listUserChildMenu(Map<String, Object> paramMap);
	
}


