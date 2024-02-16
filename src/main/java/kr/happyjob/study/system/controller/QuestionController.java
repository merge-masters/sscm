package kr.happyjob.study.system.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.system.dto.NoticeDto;
import kr.happyjob.study.system.service.NoticeService;

@Controller
@RequestMapping("/system/")
public class QuestionController {
	
	@Autowired
	NoticeService noticeService;

	// logger
	private final Logger log = Logger.getLogger(this.getClass());
	
	/*
	 * 1:1 문의사항 화면
	 */
	@RequestMapping("question.do")
	public String question() {
		
		log.info("=====> START QuestionController - question");
		log.info("=====> END QuestionController - question");
		
		return "system/users/question";
	}
	
	/*
	 * 1:1 문의사항 목록 조회
	 */
	@RequestMapping(value="question.do", method=RequestMethod.POST)
	public String selectQuestion(@RequestParam Map<String, Object> param,
								Model model, HttpSession session) throws Exception {
		
		log.info("=====> START selectQuestion");
		
		  // 현재 페이지 번호
	    int currentPage = Integer.parseInt((String) param.get("currentPage"));
	    
	    // 한 페이지에 보일 로우의 개수
	    int pageSize = Integer.parseInt((String)param.get("pageSize"));
	    
	    // 페이지 시작 로우 번호
	    int pageIndex = (currentPage - 1) * pageSize;
	    
	    // 구분 정보
	    int categoryCode = 7;
	    
	    param.put("pageIndex", pageIndex);
	    param.put("pageSize", pageSize);
	    param.put("categoryCode", categoryCode);
	    
	    // 총 로우 개수
	    int totalCount;
	    String userType = (String) session.getAttribute("userType");
	    
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
	    
	    List<NoticeDto> questionList = noticeService.selectNoticeList(param);
	    
	    totalCount = 10;
	    
	    model.addAttribute("questionList", questionList);
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("totalCount", totalCount);
	    
	    log.info(questionList);
	    
		return "/system/users/questionList";
	}
}
