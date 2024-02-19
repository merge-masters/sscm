package kr.happyjob.study.basicinfo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.basicinfo.dao.EmployeeInfoDao;
import kr.happyjob.study.basicinfo.dto.EmployeeDto;

@Service
public class EmployeeServiceImpl implements EmployeeInfoService{

	@Autowired
	EmployeeInfoDao employeeInfoDao;
	
	@Override
	public List<EmployeeDto> employeeList(Map<String, Object> paramMap) {
		
		List<EmployeeDto> employeeList = employeeInfoDao.employeeList(paramMap);
		
		return employeeList;
	}
	
	@Override
	public int employeeCount(Map<String, Object> paramMap) {
		
		int employeeCount = employeeInfoDao.employeeCount(paramMap);
		
		return employeeCount;
	}

	/**
	 * 직원 정보 디테일 들고오기
	 */
	@Override
	public EmployeeDto selectEmployeeDetail(Map<String, Object> paramMap) {
		
		EmployeeDto selectEmployeeDetail = employeeInfoDao.selectEmployeeDetail(paramMap);
		
		
		return selectEmployeeDetail;
	}
	
	/**
	 * 고객 정보 데이터 수정
	 */
	@Override
	public void updateEmployeeInfo(Map<String, Object> paramMap) {
		
		employeeInfoDao.updateEmployeeInfo(paramMap);
		
	}

	/**
	 * 고객 정보 데이터 삭제
	 */
	@Override
	public void deleteEmployeeInfo(Map<String, Object> paramMap) {
		
		employeeInfoDao.deleteEmployeeInfo(paramMap);
		
	}

	


}
