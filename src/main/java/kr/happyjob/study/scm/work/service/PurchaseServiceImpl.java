package kr.happyjob.study.scm.work.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.work.dao.PurchaseDao;
import kr.happyjob.study.scm.work.model.PurchaseModel;

@Service
public class PurchaseServiceImpl implements PurchaseService{

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();	
	
	@Autowired
	PurchaseDao purchaseDao;
	
	// 발주지시서 목록 조회
	@Override
	public List<PurchaseModel> selectPurchaseList(Map<String, Object> param) throws Exception {
		logger.info("   - ServiceparamMap : " + param);
	return purchaseDao.selectPurchaseList(param);	
	}

	// 발주지시서 갯수 조회
	@Override
	public int countPurchaseList(Map<String, Object> param) throws Exception {
		logger.info("   - ServiceparamMap : " + param);
	return purchaseDao.countPurchaseList(param);
	}

}
