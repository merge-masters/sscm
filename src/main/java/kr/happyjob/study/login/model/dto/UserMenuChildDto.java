package kr.happyjob.study.login.model.dto;

public class UserMenuChildDto {
	
	// 메뉴 ID
	private String menu_id;
	
	// 부모 메뉴 ID
	private String parent_menu_id;

	// 메뉴 명
	private String menu_name;
	
	// 메뉴 URL
	private String menu_url;
	
	// 메뉴 구분 코드
	private String menu_code;
	
	// 그룹 번호
	private String group_number;
	
	// 메뉴 순번
	private String menu_sequence;
	
	// 메뉴 레벨
	private String menu_level;

	public String getMenu_id() {
		return menu_id;
	}

	public void setMenu_id(String menu_id) {
		this.menu_id = menu_id;
	}

	public String getParent_menu_id() {
		return parent_menu_id;
	}

	public void setParent_menu_id(String parent_menu_id) {
		this.parent_menu_id = parent_menu_id;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public String getMenu_url() {
		return menu_url;
	}

	public void setMenu_url(String menu_url) {
		this.menu_url = menu_url;
	}

	public String getMenu_code() {
		return menu_code;
	}

	public void setMenu_code(String menu_code) {
		this.menu_code = menu_code;
	}

	public String getGroup_number() {
		return group_number;
	}

	public void setGroup_number(String group_number) {
		this.group_number = group_number;
	}

	public String getMenu_sequence() {
		return menu_sequence;
	}

	public void setMenu_sequence(String menu_sequence) {
		this.menu_sequence = menu_sequence;
	}

	public String getMenu_level() {
		return menu_level;
	}

	public void setMenu_level(String menu_level) {
		this.menu_level = menu_level;
	}
	
	
}
