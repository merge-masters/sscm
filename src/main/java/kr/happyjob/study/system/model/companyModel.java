package kr.happyjob.study.system.model;

public class companyModel {
	
	// 회사업체코드
	private int company_code;
	
	// 회사명
	private String company_class_name;
	
	// 회사구분코드
	private String company_class_code;
	
	// 입력날짜
	private String input_date;
		
	// 입력사용자
	private String input_user;
		
	// 입력프로그램
	private String input_program;
		
	// 변경날짜
	private String update_date;
		
	// 변경사용자
	private String update_user;
	
	// 변경프로그램
	private String update_program;
	
	
	

	public int getCompany_code() {
		return company_code;
	}

	public void setCompany_code(int company_code) {
		this.company_code = company_code;
	}

	public String getCompany_class_name() {
		return company_class_name;
	}

	public void setCompany_class_name(String company_class_name) {
		this.company_class_name = company_class_name;
	}

	public String getCompany_class_code() {
		return company_class_code;
	}

	public void setCompany_class_code(String company_class_code) {
		this.company_class_code = company_class_code;
	}

	public String getInput_date() {
		return input_date;
	}

	public void setInput_date(String input_date) {
		this.input_date = input_date;
	}

	public String getInput_user() {
		return input_user;
	}

	public void setInput_user(String input_user) {
		this.input_user = input_user;
	}

	public String getInput_program() {
		return input_program;
	}

	public void setInput_program(String input_program) {
		this.input_program = input_program;
	}

	public String getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}

	public String getUpdate_user() {
		return update_user;
	}

	public void setUpdate_user(String update_user) {
		this.update_user = update_user;
	}

	public String getUpdate_program() {
		return update_program;
	}

	public void setUpdate_program(String update_program) {
		this.update_program = update_program;
	}
}
