package kr.happyjob.study.scm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.WarehouseInfoDao;
import kr.happyjob.study.scm.model.WarehouseInfoModel;

@Service
public class WarehouseInfoServiceImpl implements WarehouseInfoService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	WarehouseInfoDao dao;

	// 창고조회
	public List<WarehouseInfoModel> listWarehouse() {

		List<WarehouseInfoModel> listWarehouse = dao.listWarehouse();

		return listWarehouse;
	}

	// 창고상세 조회
	public List<WarehouseInfoModel> detailWarehouse(String warehouse_code) {

		List<WarehouseInfoModel> detailWarehouse = dao.detailWarehouse(warehouse_code);
		return detailWarehouse;
	}

	// 창고검색
	public List<WarehouseInfoModel> searchWarehouse(String searchKey, String sname) {
		
		
		// .xml에 넘길 조건이 많을 때는 paramMap에 정보를 넣어주고 List에 담아서 보내야함
		// mapper가 인식을 못함
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("searchKey", searchKey);
		paramMap.put("sname", sname);
		
		List<WarehouseInfoModel> searchWarehouse = dao.searchWarehouse(paramMap);
		
		return searchWarehouse;
	}

	// 창고등록
	public boolean insertWarehouse(Map<String, Object> paramMap) throws Exception {
		
		
		int result = dao.insertWarehouse(paramMap);
		
		return result > 0;
		
	}

	// 창고수정
	public boolean updateWarehouse(WarehouseInfoModel warehouseInfo) throws Exception {

		int result = dao.updateWarehouse(warehouseInfo);
		
		return result > 0;
	}

	// 창고삭제
	public boolean deleteWarehouse(WarehouseInfoModel warehouseInfo) throws Exception {

		int result = dao.deleteWarehouse(warehouseInfo);

		return result > 0;
	}

}
