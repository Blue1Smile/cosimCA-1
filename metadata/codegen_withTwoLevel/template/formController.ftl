<#import "function.ftl" as func>
<#assign comment=model.tabComment>
<#assign pk=func.getPk(model) >
<#assign pkVar=func.convertUnderLine(pk) >
<#assign subtables=model.subTableList>

<#assign org=vars.org >
<#assign system=vars.system>
<#assign module=model.variables.module>
<#assign saas=model.variables.saas>
<#assign class=model.variables.class>
<#assign classVar=model.variables.classVar>

package com.hotent.${system}.controller.${package};


import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.hotent.core.annotion.Action;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.ResultMessage;
import com.hotent.core.web.util.RequestUtil;
import com.hotent.core.web.controller.BaseFormController;
import com.hotent.${system}.model.${package}.${class};
import com.hotent.${system}.service.${package}.${class}Service;

<#if subtables?exists && subtables?size!=0>
<#list subtables as table>
import com.hotent.${system}.model.${package}.${table.variables.class};
</#list>
</#if>
/**
 *<pre>
 * 对象功能:${comment} 控制器类
 <#if vars.company?exists>
 * 开发公司:${vars.company}
 </#if>
 <#if vars.developer?exists>
 * 开发人员:${vars.developer}
 </#if>
 * 创建时间:${date?string("yyyy-MM-dd HH:mm:ss")}
 *</pre>
 */
@Controller
@RequestMapping("/${system}/${path}/${classVar}/")
public class ${class}FormController extends BaseFormController
{
	@Resource
	private ${class}Service ${classVar}Service;
	
	
   
}
