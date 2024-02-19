package kr.happyjob.study.sample.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.sample.service.SampleComnCodService;

@Controller
@RequestMapping("/sample/")
public class SampleController {

	@Autowired
	SampleComnCodService sampleComnCodService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/**
	 * 공통코드 관리 초기화면
	 */
	@RequestMapping("sample.do")
	public String sample(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".initComnCod");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ End " + className + ".initComnCod");

		return "sample/sample";
	}
}