package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.dto.NoticeDto;
import kr.happyjob.study.system.model.NoticeModel;

public interface NoticeService {
  
  // 공지사항 목록 조회
  public List<NoticeDto> selectNoticeList(Map<String, Object> param) throws Exception;

  // 공지사항 수
  public int noticeTotalCount() throws Exception;

}
