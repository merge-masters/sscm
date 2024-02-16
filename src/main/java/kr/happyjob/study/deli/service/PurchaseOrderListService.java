package kr.happyjob.study.deli.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.deli.model.PurchaseOrderListModel;
import kr.happyjob.study.order.model.PurchasePaper;

public interface PurchaseOrderListService {
	// 발주지시서 목록 조회
	public List<PurchaseOrderListModel> selectPurchaseOrderList (Map<String, Object> param) throws Exception;
	
	// 발주지시서 갯수 조회
	public int countPurchaseOrderList(Map<String, Object> param) throws Exception;
}
