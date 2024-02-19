package kr.happyjob.study.system.controller;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.system.dto.NoticeDto;
import kr.happyjob.study.system.model.NoticeModel;
import kr.happyjob.study.system.service.NoticeService;

@Controller
@RequestMapping("/system/")
public class NoticeController {
  
  @Autowired
  NoticeService noticeService;
  
  // 파일 업로드에 사용 될 property
  // 물리경로(상위)
  @Value("${fileUpload.rootPath}")
  private String rootPath;
  
  // 물리경로(하위)-공지사항 이미지 저장용 폴더
  @Value("${fileUpload.noticePath}")
  private String noticePath;
  
  // 상대경로
  @Value("${fileUpload.noticeRelativePath}")
  private String fileRelativePath;
  
  // logger
  private final Logger log = LogManager.getLogger(this.getClass());

  
  // 공지사항 화면
  @RequestMapping(value="notice.do", method=RequestMethod.GET)
    public String notice() throws Exception {
    
    return "system/notice";
  }
  
  /* 공지사항 목록 조회(기본,검색) */
  @RequestMapping(value="notice.do", method=RequestMethod.POST)
  public String selectNotice(@RequestParam(required = false) Map<String, Object> param, Model model, HttpSession session)throws Exception {
    
	log.info("=====> START selectNotice ");
	  
	  
    // 현재 페이지 번호
    int currentPage = Integer.parseInt((String) param.get("currentPage"));
    
    // 한 페이지에 보일 로우의 개수
    int pageSize = Integer.parseInt((String)param.get("pageSize"));
    
    // 페이지 시작 로우 번호
    int pageIndex = (currentPage - 1) * pageSize;
    
    // 구분 정보
    int categoryCode = 1;
    
    log.info("=====> currentPage : " + currentPage);
    log.info("=====> pageIndex : " + pageIndex);
    log.info("=====> pageSize : " + pageSize);
    
    param.put("pageIndex", pageIndex);
    param.put("pageSize", pageSize);
    param.put("categoryCode", categoryCode);
    
    // 총 로우의 개수
    int totalCount;
    String userType = (String) session.getAttribute("userType");
    
    // 권한 설명
    // 0(전체)
    // 1(직원)  E = SCM, F = PCS, F = DLV 
    int auth;
    
    switch(userType) {
      case "E" :
      case "F" :
      case "G" :
        auth = 1;
        break;
        
       default:
        auth = 0;
        break;
    }
    
    param.put("auth", auth);
    log.info("selectNotice - param:"+ param);
    // 검색어 유무 확인
    if(param.containsKey("option")) {
      String option = (String) param.get("option");
      String keyword = (String) param.get("keyword");
      String formerDate = (String) param.get("formerDate");
      String latterDate = (String) param.get("latterDate");
      
      param.put("option", option);
      param.put("keyword", keyword);
      param.put("formerDate", formerDate);
      param.put("latterDate", latterDate);
      
    }
    else {
      // 검색어가 없는 경우     
    }
    
    List<NoticeDto> noticeList = noticeService.selectNoticeList(param); 
    
    totalCount = noticeService.noticeTotalCount();
    
//    totalCount = 13;
    model.addAttribute("noticeList", noticeList);
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPage", currentPage);
    model.addAttribute("totalCount", totalCount);
    
    log.info(noticeList);
    log.info(totalCount);
    
    log.info("=====> End selectNotice ");
    
    return "/system/noticeList";
 } 
  
  @RequestMapping("detailNotice.do")
  @ResponseBody
  public Map<String, Object> selectNoticeDetail(@RequestParam Map<String, Object> paramMap) {
	  
	  log.info("=====> START selectNoticeDetail");
	 
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  
	  resultMap.put("test", "test1");
	 
	  log.info("=====> test data : " + resultMap.get("test").toString());
	  log.info("=====> END selectNoticeDetail");
	  
	  return resultMap;
  }
  
  
}