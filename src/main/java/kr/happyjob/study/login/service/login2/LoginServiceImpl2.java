package kr.happyjob.study.login.service.login2;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.login.dao.LoginDao;
import kr.happyjob.study.login.model.dto.LoginDto;
import kr.happyjob.study.login.model.dto.UserMenuChildDto;
import kr.happyjob.study.login.model.dto.UserMenuDto;

@Service("loginService2")
public class LoginServiceImpl2 implements LoginService2{
	
	// Set Logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	private LoginDao loginDao;

	/** 사용자 회원가입 */
	@Override
	public int registerUser(Map<String, Object> paramMap) {
		
		String tel1 = paramMap.get("tel1").toString();
		String tel2 = paramMap.get("tel2").toString();
		String tel3 = paramMap.get("tel3").toString();
		String tel = tel1 + '-' + tel2 + '-' + tel3;
		
		//휴대폰 번호 만들기
		paramMap.put("tel", tel);
	
		int result = loginDao.registerUser(paramMap);
		
		return result;
	}

	/** 사용자 회원아이디 중복체크 */
	@Override
	public int loginID_validateCheck(LoginDto data) {
		int result = loginDao.validate_loginID(data);
		return result;
	}
	
	/** 사용자 로그인 */
	@Override
	public LoginDto loginUser(Map<String, Object> paramMap) {
	
		return loginDao.loginUser(paramMap);
	}

	/** 사용자 메뉴 */
	@Override
	public List<UserMenuDto> listUserMenu(Map<String, Object> paramMap) {
		
		return loginDao.listUserMenu(paramMap);
	}

	/** 사용자 자식 메뉴 */
	@Override
	public List<UserMenuChildDto> listUserChildMenu(Map<String, Object> paramMap) {
		return loginDao.listUserChildMenu(paramMap);
	}
}