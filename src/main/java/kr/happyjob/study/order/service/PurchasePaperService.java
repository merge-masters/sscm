package kr.happyjob.study.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.order.model.PurchasePaper;

public interface PurchasePaperService {
		/*발주지시서 목록 조회*/
		public List<PurchasePaper> selectPurchasePaperList (Map<String, Object> param) throws Exception;
		
		// 발주지시서 갯수 조회
		public int countPurchasePaperList(Map<String, Object> param) throws Exception;
		
		// 입금여부 변경
		public int checkDeposit(Map<String, Object>param) throws Exception; 
		
		// 배송시작 중복 여부 체크
		public int checkDuplicate(Map<String, Object>param) throws Exception;
		
		// 배송 테이블 insert
		public int startDelivery(Map<String, Object> param) throws Exception;
		
		public int deliveryStartDate(Map<String, Object> param) throws Exception;
		
		public int updatePurchasePaperYn(Map<String, Object> param) throws Exception;
		
		
		
}
