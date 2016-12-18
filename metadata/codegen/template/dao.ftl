<#import "function.ftl" as func>
<#assign module=model.variables.module>
<#assign class=model.variables.class>
<#assign system=vars.system>
<#assign org=vars.org>
<#assign classVar=model.variables.classVar>
<#assign sub=model.sub>
<#assign foreignKey=func.convertUnderLine(model.foreignKey)>
<#assign pk=func.getPk(model) >
<#assign pkVar=func.convertUnderLine(pk) >
package com.${org}.${system}.dao.${module};

import java.util.List;
import org.springframework.stereotype.Repository;
import com.hotent.core.db.BaseDao;
<#if sub?exists && sub>
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.util.BeanUtils;
</#if>
import com.${org}.${system}.model.${module}.${class};
/**
 *<pre>
 * 对象功能:${model.tabComment} Dao类
 <#if vars.company?exists>
 * 开发公司:${vars.company}
 </#if>
 <#if vars.developer?exists>
 * 开发人员:${vars.developer}
 </#if>
 * 创建时间:${date?string("yyyy-MM-dd HH:mm:ss")}
 *</pre>
 */
@Repository
public class ${class}Dao extends BaseDao<${class}>
{
	@Override
	public Class<?> getEntityClass()
	{
		return ${class}.class;
	}

	<#if sub?exists && sub>
	public List<${class}> getByMainId(Long ${foreignKey}) {
		return this.getBySqlKey("get${class}List", ${foreignKey});
	}
	
	public void delByMainId(Long ${foreignKey}) {
		this.delBySqlKey("delByMainId", ${foreignKey});
	}
	</#if>	
}