package kr.happyjob.study.scm.dao;

import java.util.*;

import kr.happyjob.study.scm.model.WarehouseInfoModel;

public interface WarehouseInfoDao {
	// llllll
	
	// 창고목록 조회
	public List<WarehouseInfoModel> listWarehouse();
	
	// 창고상세 조회
	public List<WarehouseInfoModel> detailWarehouse(String warehouse_code);
	
	// 창고검색
	public List<WarehouseInfoModel> searchWarehouse(Map<String, Object> paramMap);
	
	// 창고등록
	public int insertWarehouse(Map<String, Object> paramMap);
	  
	// 창고수정
	public int updateWarehouse(WarehouseInfoModel warehouseInfo);
	  
	// 창고삭제
	public int deleteWarehouse(WarehouseInfoModel warehouseInfo);


}
