package kr.happyjob.study.scm.dao;

import java.util.*;

import kr.happyjob.study.scm.model.CompanyInfoModel;

public interface CompanyInfoDao {
	
	
	// 납품업체 조회
	public List<CompanyInfoModel> companyInfo();
	
	// 납품업체명 검색
	public List<CompanyInfoModel> searchCompany(Map<String, Object> paramMap);
	
	// 납품업체조회 디테일
	public List<CompanyInfoModel> detailCompany(String company_class_name);

}