package kr.happyjob.study.basicinfo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.basicinfo.dao.CustomerInfoDao;
import kr.happyjob.study.basicinfo.dto.CustomerDto;

@Service
public class CustomerInfoServiceImpl implements CustomerInfoService{
	
	@Autowired
	CustomerInfoDao customerInfoDao;

	@Override
	public List<CustomerDto> customerList(Map<String, Object> paramMap) {
		
		List<CustomerDto> customerList = customerInfoDao.customerList(paramMap);
		
		for(CustomerDto list : customerList) {
			String user_type = list.getUser_type();
			
			if("J".equals(user_type)) {
				list.setUser_type("기업고객");
			}
		}
	
		return customerList;
	}

	@Override
	public int customerCount(Map<String, Object> paramMap) {
		
		int customerCount = customerInfoDao.customerCount(paramMap);
		
		return customerCount;
	}

	/**
	 * 고객 정보 디테일 들고오기
	 */
	@Override
	public CustomerDto selectCustomerDetail(Map<String, Object> paramMap) {
		
		CustomerDto selectCustomerDetail = customerInfoDao.selectCustomerDetail(paramMap);
		
		return selectCustomerDetail;
	}
	
	/**
	 * 고객 정보 데이터 수정
	 */
	
	@Override
	public void updateCustomerInfo(Map<String, Object> paramMap) {
		
		customerInfoDao.updateCustomerInfo(paramMap);
		
	}

	/**
	 * 고객 정보 데이터 삭제
	 */
	@Override
	public void deleteCustomerInfo(Map<String, Object> paramMap) {
		
		customerInfoDao.deleteCustomerInfo(paramMap);
		
	}

	

}
