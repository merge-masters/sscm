package kr.happyjob.study.basicinfo.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.basicinfo.dto.EmployeeDto;

public interface EmployeeInfoService {
	
	/*직원 정보 불러오기*/
	public List<EmployeeDto> employeeList(Map<String, Object> paramMap);
	
	/* 직원 정보 수 */
	public int employeeCount(Map<String, Object> paramMap);
	
	/* 직원 정보 디테일 */
	public EmployeeDto selectEmployeeDetail(Map<String, Object> paramMap);
	
	/* 직원 정보 수정*/
	public void updateEmployeeInfo(Map<String, Object> paramMap);
	
	/* 직원 정보 삭제 */
	public void deleteEmployeeInfo(Map<String, Object> paramMap);
}
