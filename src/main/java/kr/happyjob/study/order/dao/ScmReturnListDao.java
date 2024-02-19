package kr.happyjob.study.order.dao;

import java.util.List;

import kr.happyjob.study.order.model.ScmReturnListModel;

public interface ScmReturnListDao {

	// 반품신청목록 조회
	public List<ScmReturnListModel> scmReturnList();

}
