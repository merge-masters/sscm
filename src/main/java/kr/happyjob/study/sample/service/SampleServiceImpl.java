package kr.happyjob.study.sample.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.sample.dao.SampleDao;
import kr.happyjob.study.sample.model.SampleModel;

@Service
public class SampleServiceImpl implements SampleService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	SampleDao sampleDao;

	/** 그룹코드 목록 조회 */
	public List<SampleModel> sampleList(Map<String, Object> paramMap) throws Exception {

		List<SampleModel> sampleList = sampleDao.sampleList(paramMap);

		return sampleList;
	}

}