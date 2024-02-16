package kr.happyjob.study.scm.work.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.work.model.PurchaseModel;

public interface PurchaseService {
	// 발주지시서 목록 조회
	public List<PurchaseModel> selectPurchaseList(Map<String, Object>param) throws Exception;
	
	// 발주지시서 갯수 조회
	public int countPurchaseList(Map<String, Object>param) throws Exception;

}
