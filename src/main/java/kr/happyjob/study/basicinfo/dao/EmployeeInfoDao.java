package kr.happyjob.study.basicinfo.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.basicinfo.dto.EmployeeDto;

public interface EmployeeInfoDao {
	
	/* 직원정보 리스트 불러오기 */
	public List<EmployeeDto> employeeList(Map<String, Object> paramMap);
	
	/* 직원정보 수 */
	public int employeeCount(Map<String, Object> paramMap);
	
	/* 직원 정보 디테일 들고오기 */
	public EmployeeDto selectEmployeeDetail(Map<String, Object> paramMap);
	
	/* 직원 정보 데이터 수정 */
	public void updateEmployeeInfo(Map<String, Object> paramMap);
	
	/* 직원 정보 데이터 삭제 */
	public void deleteEmployeeInfo(Map<String, Object> paramMap);
}
