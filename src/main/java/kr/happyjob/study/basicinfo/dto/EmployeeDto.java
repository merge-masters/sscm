package kr.happyjob.study.basicinfo.dto;

public class EmployeeDto {
	
	// 직원 아이디
	private String employee_id;
	
	// 직원 이름
	private String employee_name;
	
	// 직원 연락처
	private String phone_number;
	
	// 직원 타입
	private String employee_type;
	
	// 타입 이름
	private String type_name;
	
	// 이메일
	private String email;
	
	// 우편 번호
	private String post_code;
	
	// 주소
	private String user_address;
	
	// 주소 상세 주소
	private String user_address_detail;
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPost_code() {
		return post_code;
	}

	public void setPost_code(String post_code) {
		this.post_code = post_code;
	}

	public String getUser_address() {
		return user_address;
	}

	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}

	public String getUser_address_detail() {
		return user_address_detail;
	}

	public void setUser_address_detail(String user_address_detail) {
		this.user_address_detail = user_address_detail;
	}

	public String getEmployee_id() {
		return employee_id;
	}

	public void setEmployee_id(String employee_id) {
		this.employee_id = employee_id;
	}

	public String getEmployee_name() {
		return employee_name;
	}

	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}

	public String getPhone_number() {
		return phone_number;
	}

	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}

	public String getEmployee_type() {
		return employee_type;
	}

	public void setEmployee_type(String employee_type) {
		this.employee_type = employee_type;
	}
	
	public String getType_name() {
		return type_name;
	}

	public void setType_name(String type_name) {
		this.type_name = type_name;
	}
	
	
}
