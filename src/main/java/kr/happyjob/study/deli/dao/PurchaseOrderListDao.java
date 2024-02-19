package kr.happyjob.study.deli.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.deli.model.PurchaseOrderListModel;

public interface PurchaseOrderListDao {
	
	public List<PurchaseOrderListModel> selectPurchaseOrderList(Map<String, Object> param);
	
	public int countPurchaseOrderList(Map<String, Object> param);

}
