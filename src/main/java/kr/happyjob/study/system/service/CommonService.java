package kr.happyjob.study.system.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.happyjob.study.system.model.MnuMgrModel;

@Service("commonService")
public class CommonService {

	@SuppressWarnings("unused")
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	public String makeRootMenu(List<MnuMgrModel> subMenuList) {
		String strMenuList = "";
		for (MnuMgrModel item : subMenuList) {
			strMenuList += "<li onclick=\"fng_GoUrl('/hr/main/subMain.do?pageId=" + item.getMnu_id() + "')\" >"
					+ item.getMnu_nm() + "</li>";
		}
		return strMenuList;
	}

	public String makeRootMenuSub(List<MnuMgrModel> subMenuList) {
		String strMenuList = "";
		for (MnuMgrModel item : subMenuList) {
			strMenuList += "<li onclick=\"moveMenu('" + item.getMnu_id() + "')\" >" + item.getMnu_nm() + "</li>";
		}
		return strMenuList;
	}

}
