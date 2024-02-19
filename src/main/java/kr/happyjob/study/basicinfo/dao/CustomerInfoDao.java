package kr.happyjob.study.basicinfo.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.basicinfo.dto.CustomerDto;

public interface CustomerInfoDao {
	
	/* 기업고객 리스트 불러오기 */
	public List<CustomerDto> customerList(Map<String, Object> paramMap);
	
	/* 기업고객 수 */
	public int customerCount(Map<String, Object> paramMap);
	
	/* 고객 정보 디테일 들고오기 */
	public CustomerDto selectCustomerDetail(Map<String, Object> paramMap);
	
	/* 고객 정보 수정 */
	public void updateCustomerInfo(Map<String, Object> paramMap);
	
	/* 고객 정보 삭제 */
	public void deleteCustomerInfo(Map<String, Object> paramMap);
	
}
