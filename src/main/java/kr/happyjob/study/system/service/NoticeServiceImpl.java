package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.system.dao.NoticeDao;
import kr.happyjob.study.system.dto.NoticeDto;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.system.model.NoticeModel;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	NoticeDao noticeDao;
  
	// 공지사항 목록 조회
	@Override
	public List<NoticeDto> selectNoticeList(Map<String, Object> param) throws Exception {
	  
		return noticeDao.selectNoticeList(param);
	}

	@Override
	public int noticeTotalCount() throws Exception {
		return noticeDao.noticeTotalCount();
	}
	
	
}
