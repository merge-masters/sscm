package kr.happyjob.study.system.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.dto.NoticeDto;
import kr.happyjob.study.system.model.NoticeModel;

public interface NoticeDao {
  
  // 공지사항 목록 조회
  public List<NoticeDto> selectNoticeList(Map<String, Object> param);
   
  // 공지사항 count
  public int noticeTotalCount();
}
