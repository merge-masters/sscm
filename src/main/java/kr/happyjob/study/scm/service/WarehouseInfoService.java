package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.WarehouseInfoModel;

public interface WarehouseInfoService {
	
	// 창고조회 
	public List<WarehouseInfoModel> listWarehouse();
	
	// 창고상세조회
    public List<WarehouseInfoModel> detailWarehouse(String warehouse_code);
    
    // 창고검색
    public List<WarehouseInfoModel> searchWarehouse(String searchKey, String sname);
    
    // 창고등록 
    public boolean insertWarehouse(Map<String, Object> paramMap) throws Exception;
	
	// 창고수정
	public boolean updateWarehouse(WarehouseInfoModel warehouseInfo) throws Exception;
	
	// 창고삭제
	public boolean deleteWarehouse(WarehouseInfoModel warehouseInfo) throws Exception;

}
