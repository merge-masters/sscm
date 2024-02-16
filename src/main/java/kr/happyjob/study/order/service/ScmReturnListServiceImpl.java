package kr.happyjob.study.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.order.dao.ScmReturnListDao;
import kr.happyjob.study.order.model.ScmReturnListModel;

@Service
public class ScmReturnListServiceImpl implements ScmReturnListService {
	
	@Autowired
	ScmReturnListDao dao;
	
	
	// 반품신청목록 조회
		public List<ScmReturnListModel> scmReturnList(){
			
			List<ScmReturnListModel> scmReturnList = dao.scmReturnList();
			return scmReturnList;
			
		}

}
