package kr.happyjob.study.order.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import kr.happyjob.study.order.dao.PurchasePaperDao;
import kr.happyjob.study.order.model.PurchasePaper;

@Service
public class PurchasePaperServiceImpl implements PurchasePaperService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	PurchasePaperDao purchasePaperDao;

	@Override
	public List<PurchasePaper> selectPurchasePaperList(Map<String, Object> param) throws Exception {
		logger.info("   - ServiceparamMap : " + param);
		return purchasePaperDao.selectPurchasePaperList(param);
	}

	@Override
	public int countPurchasePaperList(Map<String, Object> param) throws Exception {
		logger.info("   - ServiceparamMap : " + param);
		int totalCount = purchasePaperDao.countPurchasePaperList(param);
		
		return totalCount;
	}

	@Override
	public int checkDeposit(Map<String, Object>param) throws Exception {
		logger.info("   - ServiceparamMap : " + param);
		
		int result = purchasePaperDao.checkDeposit(param);
		
		return result;
	}

	@Override
	public int startDelivery(Map<String, Object> param) throws Exception {
		logger.info("   - ServiceparamMap : " + param);


		int result = purchasePaperDao.startDelivery(param);
		
		return result;
	}

	@Override
	public int checkDuplicate(Map<String, Object> param) throws Exception {
		int result = purchasePaperDao.checkDuplicate(param);
		
		return result;
	}

	@Override
	public int deliveryStartDate(Map<String, Object> param) throws Exception {
		int update = purchasePaperDao.deliveryStartDate(param);
		
		return update;
	}

	@Override
	public int updatePurchasePaperYn(Map<String, Object> param) throws Exception {
		int update = purchasePaperDao.updatePurchasePaperYn(param);
		
		return update;
	}

}
