package com.hotent.platform.controller.system;

import java.io.File;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.hotent.core.annotion.Action;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import com.hotent.core.util.AppUtil;
import com.hotent.core.util.ContextUtil;
import com.hotent.core.util.ExceptionUtil;
import com.hotent.core.util.FileUtil;
import com.hotent.core.util.StringUtil;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.util.RequestUtil;
import com.hotent.core.web.controller.BaseController;
import com.hotent.core.web.query.QueryFilter;
import com.hotent.platform.auth.ISysUser;
import com.hotent.platform.model.system.SysOfficeTemplate;
import com.hotent.platform.service.bpm.thread.MessageUtil;
import com.hotent.platform.service.system.SysOfficeTemplateService;
import com.hotent.core.web.ResultMessage;

/**
 * 对象功能:office模版 控制器类
 * 开发公司:
 * 开发人员:zyp
 * 创建时间:2012-05-25 10:16:16
 */
@Controller
@RequestMapping("/platform/system/sysOfficeTemplate/")
public class SysOfficeTemplateController extends BaseController
{
	@Resource
	private SysOfficeTemplateService sysOfficeTemplateService;
	
	@RequestMapping("selector")
	@Action(description="查看系统模版分页列表")
	public ModelAndView selector(HttpServletRequest request,HttpServletResponse response) throws Exception
	{	
		QueryFilter filter = new QueryFilter(request,"sysOfficeTemplateItem");
		List<SysOfficeTemplate> list=sysOfficeTemplateService.getAll(filter);
		ModelAndView mv=this.getAutoView().addObject("sysOfficeTemplateList",list)
				.addObject("templatetype",RequestUtil.getString(request, "templatetype"));
		return mv;
	}
	
	/**
	 * 取得office模版分页列表
	 * @param request
	 * @param response
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("list")
	@Action(description="查看系统模版分页列表")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response) throws Exception
	{	
		List<SysOfficeTemplate> list=sysOfficeTemplateService.getAll(new QueryFilter(request,"sysOfficeTemplateItem"));
		ModelAndView mv=this.getAutoView().addObject("sysOfficeTemplateList",list);
		
		return mv;
	}
	
	/**
	 * 删除office模版
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("del")
	@Action(description="删除系统模版")
	public void del(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String preUrl= RequestUtil.getPrePage(request);
		ResultMessage message=null;
		try{
			Long[] lAryId =RequestUtil.getLongAryByStr(request, "id");
			sysOfficeTemplateService.delByIds(lAryId);
			message=new ResultMessage(ResultMessage.Success, "删除系统模版成功!");
		}
		catch(Exception ex){
			message=new ResultMessage(ResultMessage.Fail, "删除失败:" + ex.getMessage());
		}
		addMessage(message, request);
		response.sendRedirect(preUrl);
	}

	@RequestMapping("edit")
	@Action(description="编辑系统模版")
	public ModelAndView edit(HttpServletRequest request) throws Exception
	{
		Long id=RequestUtil.getLong(request,"id");
		String returnUrl=RequestUtil.getPrePage(request);
		SysOfficeTemplate sysOfficeTemplate=null;
		if(id!=0){
			 sysOfficeTemplate= sysOfficeTemplateService.getById(id);
		}else{
			sysOfficeTemplate=new SysOfficeTemplate();
		}
		return getAutoView().addObject("sysOfficeTemplate",sysOfficeTemplate).addObject("returnUrl", returnUrl);
	}

	/**
	 * 取得office模版明细
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("get")
	@Action(description="查看系统模版明细")
	public ModelAndView get(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		long id=RequestUtil.getLong(request,"id");
		SysOfficeTemplate sysOfficeTemplate = sysOfficeTemplateService.getById(id);		
		return getAutoView().addObject("sysOfficeTemplate", sysOfficeTemplate);
	}
	
	@RequestMapping("saveTemplate")
	@Action(description="保存更新系统模板")
	public void saveTemplate(MultipartHttpServletRequest request,HttpServletResponse response) throws Exception {
		String resultMsg="";
		try{
			ISysUser user =  ContextUtil.getCurrentUser();// 获取当前用户
			String memo=RequestUtil.getString(request, "memo");
			String subject=RequestUtil.getString(request, "subject");
			int templatetype=RequestUtil.getInt(request, "templatetype");
			long id=RequestUtil.getLong(request, "id");
			
			SysOfficeTemplate sysOfficeTemplate=new SysOfficeTemplate();
			sysOfficeTemplate.setCreatetime(new Date());
			sysOfficeTemplate.setCreator(user.getFullname());
			sysOfficeTemplate.setCreatorid(user.getUserId());
			sysOfficeTemplate.setMemo(memo);
			sysOfficeTemplate.setSubject(subject);
			sysOfficeTemplate.setTemplatetype(templatetype);
			
			
			Map<String, MultipartFile> files = request.getFileMap();
			Iterator<MultipartFile> it = files.values().iterator();
			
			if(it.hasNext()) {
				Long fileId=UniqueIdUtil.genId();
				MultipartFile f = it.next();
				String oriFileName = f.getOriginalFilename();
			    String extName=FileUtil.getFileExt(oriFileName);
			    String doc=configproperties.getProperty("officedoc");
			    
			    if(isOfficeFile(extName)==false){
			    	writeResultMessage(response.getWriter(),new ResultMessage(ResultMessage.Fail,"上传的模板文件格式必须为："+doc));
			    	return;
			    }
				    
			    String fileName= fileId + "." + extName;
				//开始写入物理文件
				String filePath = createFilePath(AppUtil.getRealPath("/attachFiles/temp") , fileName);
			   
				FileUtil.writeByte(filePath, f.getBytes()) ;
				// end 写入物理文件
			    // 向数据库中添加数据 
				Calendar cal = Calendar.getInstance(); 
				Integer year = cal.get(Calendar.YEAR); // 当前年份
				Integer month = cal.get(Calendar.MONTH) + 1; // 当前月份
				
			    sysOfficeTemplate.setPath("attachFiles/temp/" + year + "/" + month + "/" +  fileName);
			    
			    if(id==0){
			    	//  向数据库中添加数据
			    	sysOfficeTemplate.setId(UniqueIdUtil.genId());
			    	sysOfficeTemplateService.add(sysOfficeTemplate);
			    	resultMsg="添加系统模板成功";
			    }else{
			    	sysOfficeTemplate.setId(id);
			    	sysOfficeTemplateService.update(sysOfficeTemplate);
			    	resultMsg="更新系统模板成功";
			    }
			    
			}else{
				sysOfficeTemplate.setId(id);
				sysOfficeTemplate.setPath(sysOfficeTemplateService.getById(id).getPath());
				sysOfficeTemplateService.update(sysOfficeTemplate);
		    	resultMsg="更新系统模板成功";
			}
			writeResultMessage(response.getWriter(),new ResultMessage(ResultMessage.Success,resultMsg));
		}catch (Exception e) {
			String str = MessageUtil.getMessage();
			if (StringUtil.isNotEmpty(str)) {
				ResultMessage resultMessage = new ResultMessage(ResultMessage.Fail,"操作系统模板失败:" + str);
				response.getWriter().print(resultMessage);
			} else {
				String message = ExceptionUtil.getExceptionMessage(e);
				ResultMessage resultMessage = new ResultMessage(ResultMessage.Fail, message);
				response.getWriter().print(resultMessage);
			}
		}
	}
	
	/**
	 * 创建文件目录
	 * @param tempPath
	 * @param fileName 文件名称
	 * @return 文件的完整目录
	 */
	private String createFilePath(String tempPath, String fileName){
		File one = new File(tempPath);
		Calendar cal = Calendar.getInstance(); 
		Integer year = cal.get(Calendar.YEAR); // 当前年份
		Integer month = cal.get(Calendar.MONTH) + 1; // 当前月份
		one = new File(tempPath + "/" + year + "/" + month);
		if(!one.exists()){
			one.mkdirs();
		}
		return one.getPath() + File.separator+ fileName;
	}
	
	/**
	 * 判断上传的模板文件是否为DOC,DOCX,XLS格式
	 * @param extName
	 * @return
	 */
	private boolean isOfficeFile(String extName){
		 String doc=configproperties.getProperty("officedoc");
		    String [] fileExts=doc.split(",");
		    boolean isOfficeFile=true;
		    for(String ext:fileExts){
		    	if(extName.equals(ext)){
		    		return true;
		    	}else{
		    		isOfficeFile=false;
		    	}
		    }
		    return isOfficeFile;
	}
	
	@RequestMapping("dialog")
	@Action(description="跳转到dialog")
	public ModelAndView dialog(HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		return this.getAutoView().addObject("type", RequestUtil.getString(request, "type"));
	}

}
