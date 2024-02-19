package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.model.CompanyInfoModel;

public interface  CompanyInfoService {
	
	
		// 납품업체조회
	    public List<CompanyInfoModel> companyInfo();
	
		// 납품업체명 검색
	    public List<CompanyInfoModel> searchCompany(String searchKey, String sname);
	    
	    // 납품업체조회디테일
	    public List<CompanyInfoModel> detailCompany(String company_class_name);
	    
	  
		

}

		