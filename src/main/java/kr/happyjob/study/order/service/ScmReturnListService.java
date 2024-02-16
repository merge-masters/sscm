package kr.happyjob.study.order.service;

import java.util.List;

import kr.happyjob.study.order.model.ScmReturnListModel;

public interface ScmReturnListService {

	// 반품신청목록 조회
	public List<ScmReturnListModel> scmReturnList();

}
