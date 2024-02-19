package kr.happyjob.study.login.model.dto;

public class LoginDto {
	// 로그인 아이디
	private String loginID;
	
	// 로그인 패스워드
	private String password;
	
	// 회사이름
	private String company_name;
	
	// 유저 이름
	private String user_name;
	
	// 유저 이메일
	private String mail;

	// 유저 타입
	private String user_type;
	
	// 유저 승인 코드
	private String approval_cd;

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getCompany_name() {
		return company_name;
	}

	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}
	
	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getApproval_cd() {
		return approval_cd;
	}

	public void setApproval_cd(String approval_cd) {
		this.approval_cd = approval_cd;
	}
	
	
}
