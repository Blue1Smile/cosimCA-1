package com.hotent.platform.controller.system;

import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.hotent.core.annotion.Action;
import org.springframework.web.servlet.ModelAndView;
import com.hotent.core.util.ContextUtil;
import com.hotent.core.web.util.RequestUtil;
import com.hotent.core.web.controller.BaseController;
import com.hotent.core.web.query.QueryFilter;
import com.hotent.platform.auth.ISysUser;
import com.hotent.platform.model.system.UserUnder;
import com.hotent.platform.service.system.UserUnderService;
import com.hotent.core.web.ResultMessage;

/**
 * 对象功能:下属管理 控制器类
 * 开发公司:
 * 开发人员:ray
 * 创建时间:2012-07-05 10:08:08
 */
@Controller
@RequestMapping("/platform/system/userUnder/")
public class UserUnderController extends BaseController
{
	@Resource
	private UserUnderService userUnderService;
	
	/**
	 * 取得下属管理分页列表
	 * @param request
	 * @param response
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("list")
	@Action(description="查看下属管理分页列表")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response) throws Exception
	{	
		boolean showMyleader=false;
		Long userId;
		userId = RequestUtil.getLong(request, "userId");
		if(userId==0){
			userId=ContextUtil.getCurrentUser().getUserId();
			showMyleader=true;
		}
		QueryFilter queryFilter=new QueryFilter(request,"userUnderItem");
		queryFilter.addFilter("userid", userId);
		List<UserUnder> list=userUnderService.getAll(queryFilter);
		ModelAndView mv=this.getAutoView().addObject("userUnderList",list);
					 mv.addObject("userId",userId)
					 	.addObject("showMyleader", showMyleader);
		return mv;
	}
	
	/**
	 * 删除下属管理
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("del")
	@Action(description="删除下属管理")
	public void del(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String preUrl= RequestUtil.getPrePage(request);
		ResultMessage message=null;
		try{
			Long[] lAryId =RequestUtil.getLongAryByStr(request, "id");
			userUnderService.delByIds(lAryId);
			message=new ResultMessage(ResultMessage.Success, "删除下属管理成功!");
		}
		catch(Exception ex){
			message=new ResultMessage(ResultMessage.Fail, "删除失败:" + ex.getMessage());
		}
		addMessage(message, request);
		response.sendRedirect(preUrl);
	}

	@RequestMapping("edit")
	@Action(description="编辑下属管理")
	public ModelAndView edit(HttpServletRequest request) throws Exception
	{
		Long id=RequestUtil.getLong(request,"id");
		String returnUrl=RequestUtil.getPrePage(request);
		UserUnder userUnder=null;
		if(id!=0){
			 userUnder= userUnderService.getById(id);
		}else{
			userUnder=new UserUnder();
		}
		return getAutoView().addObject("userUnder",userUnder).addObject("returnUrl", returnUrl);
	}
	
	@RequestMapping("myLeaders")
	@Action(description="编辑下属管理")
	public ModelAndView getMyLeaders(HttpServletRequest request) throws Exception
	{
		Long userId=ContextUtil.getCurrentUser().getUserId();
		List<ISysUser> list=userUnderService.getMyLeaders(userId);
		ModelAndView mv=this.getAutoView().addObject("sysUserList",list);
		
		return mv;
	}
	
	/**
	 * 取得下属管理明细
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("get")
	@Action(description="查看下属管理明细")
	public ModelAndView get(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		long id=RequestUtil.getLong(request,"id");
		UserUnder userUnder = userUnderService.getById(id);		
		return getAutoView().addObject("userUnder", userUnder);
	}
	
	@SuppressWarnings("unused")
	@RequestMapping("addUnderUser")
	@Action(description="添加下属")
	public void addUnderUser(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String userIds= RequestUtil.getSecureString(request, "userIds");
		String userNames=RequestUtil.getSecureString(request, "userNames");
		Long userId;
		userId = RequestUtil.getLong(request, "userId");
		if(userId==0){
			userId=ContextUtil.getCurrentUser().getUserId();
		}
		userUnderService.addMyUnderUser(userId, userIds, userNames);		
	}

}
