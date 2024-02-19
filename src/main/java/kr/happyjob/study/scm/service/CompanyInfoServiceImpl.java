package kr.happyjob.study.scm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.CompanyInfoDao;
import kr.happyjob.study.scm.model.CompanyInfoModel;


@Service
public class CompanyInfoServiceImpl implements CompanyInfoService {
	
	    // Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		private final String className = this.getClass().toString();

		@Autowired
		CompanyInfoDao dao;
		
		
		
		// 납품업체조회
	    public List<CompanyInfoModel> companyInfo(){
	    	
	    	List<CompanyInfoModel> companyInfo = dao.companyInfo();
	    	
	    	logger.info("   - companyInfo : " + companyInfo);
	    	
	    	return companyInfo;
	    	
	    }
		
		
		// 납품업체명 검색
		public List<CompanyInfoModel> searchCompany(String searchKey, String sname) {
			
			logger.info("   - searchCompanyImpl !!!!!! ");
			logger.info("   - searchKey : " + searchKey);
	   	    logger.info("   - sname : " + sname);
	   		
			
			// .xml에 넘길 조건이 많을 때는 paramMap에 정보를 넣어주고 List에 담아서 보내야함
			// mapper가 인식을 못함
	   	    Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("searchKey", searchKey);
			paramMap.put("sname", sname);
			
			List<CompanyInfoModel> searchCompany = dao.searchCompany(paramMap);
			
			return searchCompany;
		}
		
		
		// 납품업체조회디테일
	    public List<CompanyInfoModel> detailCompany(String company_class_name){
	    	
	    	List<CompanyInfoModel> detailCompany = dao.detailCompany(company_class_name);
	    	
	    	logger.info("   - detailCompany : " + detailCompany);
	    	
	    	return detailCompany;
	    	
	    }
		
		
}
