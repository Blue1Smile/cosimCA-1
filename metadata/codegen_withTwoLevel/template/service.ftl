<#import "function.ftl" as func>
<#assign subtables=model.subTableList>
<#assign classVar=model.variables.classVar>
<#assign table=model.subTableList>
<#assign pk=func.getPk(model) >
<#assign pkVar=func.convertUnderLine(pk)>

<#assign org=vars.org >
<#assign system=vars.system>
<#assign module=model.variables.module>
<#assign saas=model.variables.saas>
<#assign class=model.variables.class>
<#assign classVar=model.variables.classVar>
package com.${org}.${system}.service.${module}.${saas};

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import com.hotent.core.util.BeanUtils;
import com.hotent.core.util.UniqueIdUtil;
import com.${org}.${system}.model.${module}.${saas}.${class};
import com.${org}.${system}.dao.${module}.${saas}.${class}Dao;
<#if subtables?exists && subtables?size != 0>
	<#list subtables as table>
import com.${org}.${system}.model.${module}.${table.variables.saas}.${table.variables.class};
import com.${org}.${system}.dao.${module}.${table.variables.saas}.${table.variables.class}Dao;
	</#list>
</#if>
<#if model.variables.flowFlag?exists && model.variables.flowFlag=='true'>
import com.hotent.core.bpm.model.ProcessCmd;
import com.hotent.platform.webservice.api.ProcessService;
</#if>

/**
 *<pre>
 * 对象功能:${model.tabComment} Service类
 <#if vars.company?exists>
 * 开发公司:${vars.company}
 </#if>
 <#if vars.developer?exists>
 * 开发人员:${vars.developer}
 </#if>
 * 创建时间:${date?string("yyyy-MM-dd HH:mm:ss")}
 *</pre>
 */
@Service
public class ${class}Service extends BaseService<${class}>
{
	@Resource
	private ${class}Dao dao;
	
	<#if subtables?exists && subtables?size != 0>
		<#list subtables as table>
	@Resource
	private ${table.variables.class}Dao ${table.variables.classVar}Dao;
		</#list>
	</#if>
	
	<#--直接绑定工作流生成-->
	<#if model.variables.flowFlag?exists && model.variables.flowFlag=='true'>
	@Resource
	private ProcessService processService;
	</#if>
	
	public ${class}Service()
	{
	}
	
	@Override
	protected IEntityDao<${class}, Long> getEntityDao() 
	{
		return dao;
	}
	
	<#if subtables?exists && subtables?size != 0>
	private void delByPk(Long ${pkVar}){
	    <#list model.subTableList as table>
		${table.variables.classVar}Dao.delByMainId(${pkVar});
	    </#list>
	}
	
	public void delAll(Long[] lAryId) {
		for(Long id:lAryId){	
			delByPk(id);
			dao.delById(id);	
		}	
	}
	
	public void addAll(${class} ${classVar}) throws Exception{
		add(${classVar});
		addSubList(${classVar});
	}
	
	public void updateAll(${class} ${classVar}) throws Exception{
		update(${classVar});
		delByPk(${classVar}.get${pkVar?cap_first}());
		addSubList(${classVar});
	}
	
	public void addSubList(${class} ${classVar}) throws Exception{
	<#list subtables as table>
	<#assign vars=table.variables>
	<#assign foreignKey=func.convertUnderLine(table.foreignKey) >
	<#assign subPk=func.getPk(table)>
	<#assign subPkVar=func.convertUnderLine(subPk)>
		List<${vars.class}> ${vars.classVar}List=${classVar}.get${vars.classVar?cap_first}List();
		if(BeanUtils.isNotEmpty(${vars.classVar}List)){
			for(${vars.class} ${vars.classVar}:${vars.classVar}List){
				${vars.classVar}.set${foreignKey?cap_first}(${classVar}.get${pkVar?cap_first}());
				${vars.classVar}.set${subPkVar?cap_first}(UniqueIdUtil.genId());
				${vars.classVar}Dao.add(${vars.classVar});
			}
		}
	</#list>
	}
	
	<#list subtables as table>
	<#assign vars=table.variables>
	public List<${vars.class}> get${vars.classVar?cap_first}List(Long ${pkVar}) {
		return ${vars.classVar}Dao.getByMainId(${pkVar});
	}
	</#list>
	
	</#if>
	
	<#--直接绑定工作流生成-->
	<#if model.variables.flowFlag?exists && model.variables.flowFlag=='true'>
	/**
	 * 设置 cmd 启动流程
	 * @param defKey 流程定义key
	 * @param businessKey  数据id
	 * @return
	 */
	public void setCmdtoStart(String defKey, String businessKey) throws Exception{
		ProcessCmd processCmd = new ProcessCmd();
		processCmd.setFlowKey(defKey);
		processCmd.setBusinessKey(businessKey);
		processService.start(processCmd);
	}
	
	/**
	 * 设置 cmd 完成任务
	 * @param taskId 任务id
	 * @param voteAgree 流程动作
	 * @return
	 */
	public void setCmdtoComplete(String taskId, String voteAgree) throws Exception{
		ProcessCmd processCmd = new ProcessCmd();
		processCmd.setTaskId(taskId);
		processCmd.setVoteAgree(new Short(voteAgree));
		processService.doNext(processCmd);
	}
	</#if>
}
