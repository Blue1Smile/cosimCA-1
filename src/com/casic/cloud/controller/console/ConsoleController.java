package com.casic.cloud.controller.console;

import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.casic.cloud.model.cloudEnterpriseVisited.CloudEnterpriseVisited;
import com.casic.cloud.model.cloudUseRes.CloudUseRes;
import com.casic.cloud.model.config.aptitude.Aptitude;
import com.casic.cloud.model.config.capability.Capability;
import com.casic.cloud.model.config.info.Info;
import com.casic.cloud.model.console.businessAreaGroup.BusinessAreaGroup;
import com.casic.cloud.model.console.cloudMessage.CloudMessage;
import com.casic.cloud.model.system.news.News;
import com.casic.cloud.service.cloudEnterpriseVisited.CloudEnterpriseVisitedService;
import com.casic.cloud.service.cloudUseRes.CloudUseResService;
import com.casic.cloud.service.config.aptitude.AptitudeService;
import com.casic.cloud.service.config.capability.CapabilityService;
import com.casic.cloud.service.config.info.InfoService;
import com.casic.cloud.service.console.busiarea.BusiareaService;
import com.casic.cloud.service.console.businessAreaGroup.BusinessAreaGroupService;
import com.casic.cloud.service.console.cloudMessage.CloudMessageService;
import com.casic.cloud.service.system.news.NewsService;
import com.hotent.core.page.PageBean;
import com.hotent.core.util.ContextUtil;
import com.hotent.core.web.controller.BaseController;
import com.hotent.core.web.query.QueryFilter;
import com.hotent.core.web.util.RequestUtil;
import com.hotent.platform.auth.ISysUser;
import com.hotent.platform.dao.system.MessageSendDao;
import com.hotent.platform.model.system.MessageSend;
import com.hotent.platform.model.system.Resources;
import com.hotent.platform.model.system.SubSystem;
import com.hotent.platform.model.system.SysOrgInfo;
import com.hotent.platform.model.system.SysOrgRole;
import com.hotent.platform.service.bpm.BpmService;
import com.hotent.platform.service.system.DictionaryService;
import com.hotent.platform.service.system.MessageSendService;
import com.hotent.platform.service.system.ResourcesService;
import com.hotent.platform.service.system.SubSystemService;
import com.hotent.platform.service.system.SysOrgInfoService;
import com.hotent.platform.service.system.SysOrgRoleService;

@Controller
@RequestMapping("/cloud/console/")
public class ConsoleController extends BaseController {
	@Resource
	private ResourcesService resourcesService;
	@Resource
	private SubSystemService subSystemService;
	@Resource
	private SysOrgInfoService sysOrgInfoService;
	@Resource
	private InfoService infoService;
	@Resource
	private CloudMessageService cloudMessageService;
	@Resource
	private BusiareaService busiareaService;
	@Resource
	private NewsService newsService;
	@Resource
	private CloudEnterpriseVisitedService cloudEnterpriseVisitedService;
	@Resource
	private CapabilityService capabilityService;
	@Resource
	private AptitudeService aptitudeService;
	@Resource
	private CloudUseResService cloudUseResService;
	@Resource
	private DictionaryService dictionaryService;
	@Resource
	private BusinessAreaGroupService businessAreaGroupService;
	@Resource
	private BpmService bpmService;
	@Resource
	private MessageSendService sendService;
	@Resource
	private MessageSendDao messageSendDao;
	@Resource
	private SysOrgRoleService sysOrgRoleService;
	
	/**
	 * 获取商机类型
	 * 
	 * @return
	 */
	public String getBusinessChangeType() {
		// 判断当前用户角色
		Collection<GrantedAuthority> authorities = ContextUtil.getCurrentUser()
				.getAuthorities();
		String type = "";
		if (authorities.contains(new GrantedAuthorityImpl(
				"cloud_ROLE_PUR_MANAGER"))) {
			// 采购主管
			type = "采购商机";
		} else if (authorities.contains(new GrantedAuthorityImpl(
				"cloud_ROLE_SALE_MANAGER"))) {
			// 营销主管
			type = "营销商机";
		} else if (authorities.contains(new GrantedAuthorityImpl(
				"cloud_ROLE_MANUF_MANAGER"))) {
			// 生产主管
			type = "生产商机";
		} else if (authorities.contains(new GrantedAuthorityImpl(
				"cloud_ROLE_AFTERSALE"))) {
			// 服务主管
			type = "服务商机";
		} else if (authorities.contains(new GrantedAuthorityImpl(
				"cloud_ROLE_RESEARCH"))) {
			// 研发主管
			type = "研发商机";
		} else {
			type = "其它";

		}
		return type;
	}

	/**
	 * 个人主页
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("home")
	public ModelAndView home(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String saas = (String)request.getSession().getAttribute("saas");

		// 新闻
		List<News> newsList = newsService.getLastNews();

		// 获得最近使用资源
		String resName = RequestUtil.getString(request, "name");
		List<CloudUseRes> cloudUseResList = null;
/*		List<CloudUseRes> cloudUseResList = cloudUseResService.getUseRes(
				ContextUtil.getCurrentOrgInfoFromSession().getSysOrgInfoId(),
				resName);
*/
		// 获得我的企业
		Long myEntID = ContextUtil.getCurrentOrgInfoFromSession()
				.getSysOrgInfoId();

		// 获取消息列表
		QueryFilter queryFilter = new QueryFilter(request, "cloudMessageList");
		queryFilter.getFilters().put("receiveentId", myEntID);
		queryFilter.getPageBean().setPagesize(5);
		List<CloudMessage> cloudMessages = cloudMessageService
				.getAll(queryFilter);

		Map<String, Object> m = new HashMap<String, Object>();
		// 商圈分组
		m.put("entid", ContextUtil.getCurrentOrgInfoFromSession()
				.getSysOrgInfoId());
		String userName = ContextUtil.getCurrentUser().getFullname();
		String roleName = ContextUtil.getCurrentUser().getShortAccount();
		
		List<BusinessAreaGroup> businessAreaGroupList = businessAreaGroupService
				.getAllByEntid(m);
		// 获取当前企业信息
		Info info = infoService.getById(myEntID);
		
		SysOrgInfo myCompany = sysOrgInfoService.getById(myEntID);
		ModelAndView mav = new ModelAndView("/cloud/console/calendar.jsp")
//		ModelAndView mav = new ModelAndView("/datadriver/datacenter/list.jsp")
				.addObject("cloudMessages", cloudMessages)
				.addObject("saas", saas)
				.addObject("myCompany", myCompany)
				.addObject("newsList", newsList)
				.addObject("type", getBusinessChangeType())
				.addObject("info", info)
				.addObject("userName", userName)
				.addObject("roleName", roleName)
				.addObject("businessAreaGroupList", businessAreaGroupList)
				.addObject("cloudUseResList", cloudUseResList);
		this.getResources(mav, request);
		return mav;
	}
	
	//获取我的待办任务列表
	@ResponseBody
	@RequestMapping("getMyTask")
	public List<TaskEntity> getMyTask(HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		//获取我的待办消息
		QueryFilter filter = new QueryFilter(request);
		//最多显示十条
		filter.getPageBean().setPagesize(10);
		List<TaskEntity> list = bpmService.getMyTasks(filter);
		
		return list;
	}
	
	//获取我的待办消息列表
	@ResponseBody
	@RequestMapping("getMyMessage")
	public List<MessageSend> getMyMessage(HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		PageBean pb = new PageBean();
		pb.setCurrentPage(1);
		pb.setPagesize(10);
		List<MessageSend> list = messageSendDao.getNotReadMsgByUserId(
				ContextUtil.getCurrentUserId(), pb);
		return list;
		
//		QueryFilter queryFilter=new QueryFilter(request,"messageReceiverItem");
//		//最多显示十条
//		queryFilter.getPageBean().setPagesize(10);
//		queryFilter.addFilter("receiverId", ContextUtil.getCurrentUserId());
//		List<MessageSend> list=sendService.getReceiverByUser(queryFilter);
//		
//		return list;
	}
	
	/**
	 * 布局页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("outline")
	public ModelAndView outline(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = this.getAutoView();
		this.getResources(mav, request);
		return mav;
	}

	/**
	 * 我的日程
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("calendar")
	public ModelAndView calendar(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Long entid = ContextUtil.getCurrentOrgInfoFromSession()
				.getSysOrgInfoId();
		Info info = infoService.getById(entid);
		ModelAndView mav = getAutoView().addObject("info", info).addObject(
				"type", getBusinessChangeType());

		this.getResources(mav, request);
		return mav;
	}

	/**
	 * 个人信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("userInfo")
	public ModelAndView userInfo(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = this.getAutoView()
				.addObject("user", ContextUtil.getCurrentUser())
				.addObject("type", getBusinessChangeType());
		this.getResources(mav, request);
		return mav;
	}

	/**
	 * 修改密码
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("modifyPassword")
	public ModelAndView modifyPassword(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = this.getAutoView()
				.addObject("user", ContextUtil.getCurrentUser())
				.addObject("type", getBusinessChangeType());
		this.getResources(mav, request);
		return mav;
	}

	/**
	 * 业务统计量
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("statics")
	public ModelAndView statics(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = this.getAutoView();
		this.getResources(mav, request);
		return mav;
	}

	/**
	 * 获取我的资源
	 * 
	 * @param mav
	 * @param request
	 */
	public void getResources(ModelAndView mav, HttpServletRequest request) {
		// 查询资源菜单
		SubSystem currentSystem = subSystemService.getById(1L);
		ISysUser sysUser = ContextUtil.getCurrentUser();
		List<Resources> resourcesList = resourcesService.getCloudTopMenu(
				currentSystem, sysUser);
		Long resId = RequestUtil.getLong(request, "resId");
		if (resId.longValue() == 0L && resourcesList.size() > 0) {
			resId = resourcesList.get(0).getResId();
		}
		if (resId.longValue() > 0L) {
			List<Resources> leftResourcesList = resourcesService
					.getChildrenByParentId(resId, true);
			mav.addObject("leftResourcesList", leftResourcesList);
		}
		mav.addObject("resourcesList", resourcesList);
	}

	/**
	 * 查找商友
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("companyList")
	public ModelAndView companyList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 获取企业名称
		String enterpriseName = RequestUtil.getString(request, "username");
		QueryFilter queryFilter = new QueryFilter(request, "enterpriseItem");
		queryFilter.getFilters().put("name", "%" + enterpriseName + "%");
		queryFilter.addFilter("state", 2);
		// 最新加入，点击更多时企业列表分页
		queryFilter.getPageBean().setPagesize(5);
		List<Info> list = infoService.getAllInfos("getAll", queryFilter);
		ModelAndView mav = this.getAutoView().addObject("enterpriseList", list);
		return mav;
	}

	/**
	 * 企业首页
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("enterprise")
	public ModelAndView enterprise(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Long id = RequestUtil.getLong(request, "EntId");
		Info enterprise = infoService.getById(id);

		if (enterprise == null)
			return this.getAutoView();

		// 最近来访
		List<CloudEnterpriseVisited> list = cloudEnterpriseVisitedService
				.getByInterventId(id);
		boolean flag = false;
		if (ContextUtil.getCurrentOrg() != null
				&& id.longValue() != ContextUtil.getCurrentOrgInfoFromSession()
						.getSysOrgInfoId().longValue()) {
			CloudEnterpriseVisited entVisited = new CloudEnterpriseVisited();
			if (list.size() > 0) {
				int cont;
				if (list.size() > 5) {
					cont = 5;
				} else
					cont = list.size();
				for (int i = 0; i < cont; i++) {
					if (list.get(i).getVisitentId().longValue() == ContextUtil
							.getCurrentOrgInfoFromSession().getSysOrgInfoId()
							.longValue()) {
						list.get(i).setVisitdate(new Date());
						cloudEnterpriseVisitedService.update(list.get(i));
						flag = true;
					}
				}
			}
			if (flag == false || list.size() == 0) {
				entVisited.setInterventId(id);
				entVisited.setVisitentId(ContextUtil
						.getCurrentOrgInfoFromSession().getSysOrgInfoId());
				entVisited.setVisitdate(new Date());
				cloudEnterpriseVisitedService.add(entVisited);
				flag = false;
			}
		}

		List<Aptitude> aptitudes = infoService.getAptitudeList(enterprise
				.getSysOrgInfoId());
		// 获得企业能力
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("publish_state", "发布");
		m.put("ent_id", RequestUtil.getLong(request, "EntId"));
		List<Capability> capabilitylist = capabilityService.getTop(m);

		ModelAndView mav = this.getAutoView()
				.addObject("enterprise", enterprise)
				.addObject("capabilitylist", capabilitylist)
				.addObject("aptitudeList", aptitudes)
				.addObject("enterpriseVisitedList", list);
		return mav;
	}

	/**
	 * 查看更多来访企业
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("visitMore")
	public ModelAndView visitMore(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Long id = RequestUtil.getLong(request, "entId");
		String entName = sysOrgInfoService.getById(id).getName();
		QueryFilter queryFilter = new QueryFilter(request, "visitMoreList");
		queryFilter.getFilters().put("interventId", id);
		queryFilter.getPageBean().setPagesize(10);
		List<CloudEnterpriseVisited> list = cloudEnterpriseVisitedService
				.getAll(queryFilter);
		ModelAndView mav = this.getAutoView().addObject("entName", entName)
				.addObject("visitMoreList", list);
		return mav;
	}

	/**
	 * 云标签进入现实行业内的企业好友
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	/*
	 * 2013.06.09注释
	 * 
	 * @RequestMapping("showIndustry") public ModelAndView
	 * showIndustry(HttpServletRequest request, HttpServletResponse response)
	 * throws Exception { String industry = RequestUtil.getString(request,
	 * "industry"); String industryName = new
	 * String(industry.getBytes("iso-8859-1"),"UTF-8");
	 * System.out.println("********************************************");
	 * System.out.println(industryName);
	 * 
	 * Map params=new HashMap(); List<Dictionary> industrys =
	 * dictionaryService.getByItemKey("industry"); for(int
	 * x=0;x<industrys.size();x++){ params.put(industrys.get(x).getItemName(),
	 * x); } String fileName = params.get(industryName).toString();
	 * 
	 * String path = request.getRealPath("/applet/showIndustry");
	 * busiareaService.generateIndustryXML(industryName,fileName,path,request);
	 * 
	 * ModelAndView mav = this.getAutoView().addObject("fileName", fileName);
	 * return mav; }
	 */
	/**
	 * 云标签进入现实行业内的企业好友
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("showIndustry")
	public ModelAndView showIndustry(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String industry = RequestUtil.getString(request, "industry");
		Map params=new HashMap();
//		List<Dictionary> industrys = dictionaryService.getByItemKey("industry");
//		for(int x=0;x<industrys.size();x++){
//			params.put(industrys.get(x).getItemName(), x);
//		}
		//String fileName = params.get(industry).toString();
		String path = request.getRealPath("/applet/showIndustry");
		String industryFormat = new String(industry.getBytes("ISO8859_1"), "UTF8");
		params.put("电气机械及器材制造业", 1);
		params.put("通信设备、计算机及其他电子设备制造业", 2);
		params.put("仪器仪表及文化、办公用机械制造业", 3);
		params.put("金属制造业", 4);
		params.put("通用设备制造业", 5);
		params.put("工艺品及其他制造业", 6);
		params.put("服务业", 7);
		params.put("专用设备", 8);
		params.put("纺织业", 9);
		params.put("家具制造业", 10);
		params.put("塑料制品业", 11);
		params.put("非金属矿物制品", 12);
		
		int industryId=0;
		Iterator iter = params.entrySet().iterator();
		while (iter.hasNext()) {
			Map.Entry entry = (Map.Entry) iter.next();
			Object key = entry.getKey();
			Object val = entry.getValue();
			if(industryFormat.equals(key)){
				industryId = Integer.valueOf(String.valueOf(val)).intValue();
			}
		}
		busiareaService.generateIndustryXML(industryFormat,industryId,path,request);
		
		
		
		ModelAndView mav = this.getAutoView().addObject("industry", industryId);
		return mav;
	}
	
	@RequestMapping("personalReg")
	public ModelAndView personalReg(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		ModelAndView mav = this.getAutoView();
		return mav;
	}
}


