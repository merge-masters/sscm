package kr.happyjob.study.sample.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.sample.model.SampleModel;

public interface SampleDao {

	/** 그룹코드 목록 조회 */
	public List<SampleModel> sampleList(Map<String, Object> paramMap);

}