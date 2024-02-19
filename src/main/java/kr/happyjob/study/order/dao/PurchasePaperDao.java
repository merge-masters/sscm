package kr.happyjob.study.order.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.order.model.PurchasePaper;

public interface PurchasePaperDao {
	
		public List<PurchasePaper> selectPurchasePaperList(Map<String, Object> param);
		
		public int countPurchasePaperList(Map<String, Object> param);
		
		public int checkDeposit(Map<String, Object>param);
		
		public int checkDuplicate(Map<String, Object> param) throws Exception;
		
		public int startDelivery(Map<String, Object> param) throws Exception;
		
		public int deliveryStartDate(Map<String, Object>param) throws Exception;
		
		public int updatePurchasePaperYn(Map<String, Object>param) throws Exception;
}
