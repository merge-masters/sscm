package kr.happyjob.study.deli.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.deli.dao.PurchaseOrderListDao;
import kr.happyjob.study.deli.model.PurchaseOrderListModel;

@Service
public class PurchaseOrderListServiceImpl implements PurchaseOrderListService{
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	PurchaseOrderListDao purchaseOrderListDao;

	@Override
	public List<PurchaseOrderListModel> selectPurchaseOrderList(Map<String, Object> param) throws Exception {
		logger.info("   - ServiceparamMap : " + param);
		return purchaseOrderListDao.selectPurchaseOrderList(param);
	}

	@Override
	public int countPurchaseOrderList(Map<String, Object> param) throws Exception {
		logger.info("   - ServiceparamMap : " + param);
		int totalCount = purchaseOrderListDao.countPurchaseOrderList(param);
		
		return totalCount;
	}

}
