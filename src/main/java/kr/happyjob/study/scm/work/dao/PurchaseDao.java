package kr.happyjob.study.scm.work.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.work.model.PurchaseModel;

public interface PurchaseDao {
	
	public List<PurchaseModel> selectPurchaseList(Map<String, Object> param);
	
	public int countPurchaseList(Map<String, Object> param);
}
