<#import "function.ftl" as func>
<#assign class=model.variables.class>
<#assign tabcomment=model.tabComment>
<#assign classVar=model.variables.classVar>
<#assign system=vars.system>
<#assign module=model.variables.module>
<#assign commonList=model.commonList>
<#assign pk=func.getPk(model) >
<#assign pkVar=func.convertUnderLine(pk) >
<#assign subtables=model.subTableList>
<%--
	time:${date?string("yyyy-MM-dd HH:mm:ss")}
	desc:edit the ${tabcomment}
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 ${tabcomment}</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="<#noparse>${ctx}</#noparse>/js/hotent/CustomValid.js"></script>
	<script type="text/javascript" src="<#noparse>${ctx}</#noparse>/js/hotent/formdata.js"></script>
	<#if subtables?exists && subtables?size!=0>
	<script type="text/javascript" src="<#noparse>${ctx}</#noparse>/js/hotent/subform.js"></script>
	</#if>
	<script type="text/javascript">
		$(function() {
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			var frm=<#noparse>$('#</#noparse>${classVar}Form').form();
			$("a.save").click(function() {
				frm.setData();
				frm.ajaxForm(options);
				if(frm.valid()){
					form.submit();
				}
			});
		});
		
		function showResponse(responseText) {
			var obj = new com.hotent.form.ResultMessage(responseText);
			if (obj.isSuccess()) {
				$.ligerMessageBox.confirm("提示信息", obj.getMessage()+",是否继续操作", function(rtn) {
					if(rtn){
						this.close();
					}else{
						window.location.href = "<#noparse>${ctx}</#noparse>/${system}/${module}/${classVar}/list.ht";
					}
				});
			} else {
				$.ligerMessageBox.error("提示信息",obj.getMessage());
			}
		}
		
		<#if model.variables.flowFlag?exists && model.variables.flowFlag=='true'>
		$("a.apply").click(function() {
			frm.setData();
			<#noparse>$('#</#noparse>${classVar}Form').attr('action','apply.ht');
			frm.ajaxForm(options);
			if(frm.valid()){
				form.submit();
			}
		});
		
		$("a.agree").click(function() {
			operatorType=1;
			var tmp = '1';
			/*if(isDirectComlete){//直接一票通过
				tmp = '5';
			}*/
			$('#voteAgree').val(tmp);
			$('#back').val("1");

			<#noparse>$('#</#noparse>${classVar}Form').attr("action","complete.ht");
			frm.setData();
			frm.ajaxForm(options);
			if(frm.valid()){
				form.submit();
			}
		});
		
		$("a.notAgree").click(function() {
			
			operatorType=2;
			var tmp = '2';
			/*if(isDirectComlete){//直接一票通过
				tmp = '6';
			}*/
			$('#voteAgree').val(tmp);
			$('#back').val("1");
			
			<#noparse>$('#</#noparse>${classVar}Form').attr("action","complete.ht");
			frm.setData();
			frm.ajaxForm(options);
			if(frm.valid()){
				form.submit();
			}
		});
		</#if>
	</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
		    <c:choose>
			    <c:when test="<#noparse>${</#noparse>${classVar}.${pkVar} !=null}">
			        <span class="tbar-label">编辑${tabcomment}</span>
			    </c:when>
			    <c:otherwise>
			        <span class="tbar-label">添加${tabcomment}</span>
			    </c:otherwise>			   
		    </c:choose>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<#if model.variables.flowFlag?exists && model.variables.flowFlag=='true'>
				<c:if test="<#noparse>${</#noparse>applyFlag==0}">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link apply" id="dataFormStart" href="#">申请</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</c:if>
				<c:if test="<#noparse>${</#noparse>applyFlag==1}">
					<div class="group"><a id="btnAgree" class="link agree">同意</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a id="btnNotAgree" class="link notAgree">反对</a></div>
				</c:if>
				<#else>
				<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</#if>
			</div>
		</div>
	</div>
	<div class="panel-body">
		<form id="${classVar}Form" method="post" action="save.ht">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0" type="main">
				<#list commonList as col>
				<#assign colName=func.convertUnderLine(col.columnName)>
				<#if (col.colType=="java.util.Date") >
				<tr>
					<th width="20%">${col.comment}: <#if (col.isNotNull) > <span class="required">*</span></#if></th>
					<td><input type="text" id="${colName}" name="${colName}" value="<fmt:formatDate value='<#noparse>${</#noparse>${classVar}.${colName}}' pattern='yyyy-MM-dd'/>" class="inputText date" validate="{date:true<#if col.isNotNull>,required:true</#if>}" /></td>
				</tr>
				<#else>
				<tr>
					<th width="20%">${col.comment}: <#if (col.isNotNull) > <span class="required">*</span></#if></th>
					<td><input type="text" id="${colName}" name="${colName}" value="<#noparse>${</#noparse>${classVar}.${colName}}"  class="inputText" validate="{<#if col.isNotNull>required:true<#else>required:false</#if><#if col.colType=='String'&& col.length<1000>,maxlength:${col.length}</#if><#if col.colType=='Integer'|| col.colType=='Long'||col.colType=='Float'>,number:true </#if>}"  /></td>
				</tr>
				</#if>
				</#list>
			</table>
			<#if subtables?exists && subtables?size != 0>
			<#list subtables as table>
			<#assign foreignKey=func.convertUnderLine(table.foreignKey) >
			<table class="table-grid table-list" cellpadding="1" cellspacing="1" id="${table.variables.classVar}" formType="window" type="sub">
				<tr>
					<td colspan="${table.columnList?size-1}">
						<div class="group" align="left">
				   			<a id="btnAdd" class="link add">添加</a>
			    		</div>
			    		<div align="center">
						${table.tableName } : ${table.tabComment }
			    		</div>
		    		</td>
				</tr>
				<tr>
					<#list table.columnList as col>
					<#assign colName=func.convertUnderLine(col.columnName?lower_case)>
					<#if !(col.isPK)&& colName?lower_case!=(foreignKey)?lower_case>							                              
					<th>${col.comment}</th>
					</#if>									
					</#list>
					<th>操作</th>
				</tr>
				<c:forEach items="<#noparse>${</#noparse>${table.variables.classVar}List}" var="${table.variables.classVar}Item" varStatus="status">
				    <tr type="subdata">
				        <#list table.columnList as col>												
					    <#assign colName=func.convertUnderLine(col.columnName)>
					    <#if ( !col.isPK && colName?lower_case!=foreignKey?lower_case)>
					    <#if (col.colType=="java.util.Date")>
						<td style="text-align: center" name="${colName}"><fmt:formatDate value='<#noparse>${</#noparse>${table.variables.classVar}Item.${colName}}' pattern='yyyy-MM-dd'/></td>								
					    <#else >
					    <td style="text-align: center" name="${colName}"><#noparse>${</#noparse>${table.variables.classVar}Item.${colName}}</td>
					    </#if>
					  	</#if>
					    </#list>
					    <td style="text-align: center">
					    	<a href="#" class="link del">删除</a>
					    	<a href="#" class="link edit">编辑</a>
					    </td>
					     <#list table.columnList as col>												
					    <#assign colName=func.convertUnderLine(col.columnName)>
					    <#if ( !col.isPK && colName?lower_case!=foreignKey?lower_case)>
					    <#if (col.colType=="java.util.Date")>
					    <input type="hidden" name="${colName}" value="<fmt:formatDate value='<#noparse>${</#noparse>${table.variables.classVar}Item.${colName}}' pattern='yyyy-MM-dd'/>" class="inputText date"/>
					    <#else >
						<input type="hidden" name="${colName}" value="<#noparse>${</#noparse>${table.variables.classVar}Item.${colName}}"/>
					    </#if>
					  	</#if>
					    </#list>
				    </tr>
				</c:forEach>
				<tr type="append">
		        <#list table.columnList as col>												
			    <#assign colName=func.convertUnderLine(col.columnName)>
			    <#assign foreignKey=func.convertUnderLine(table.foreignKey) >
		   		<#if ( !col.isPK && colName?lower_case!=foreignKey?lower_case)>
		    	<#if (col.colType=="java.util.Date")>
					<td style="text-align: center" name="${colName}"></td>								
			    <#else >
			    	<td style="text-align: center" name="${colName}"></td>
			    </#if>
			  	</#if>
			    </#list>
			    	<td style="text-align: center">
			    		<a href="#" class="link del">删除</a>
			    		<a href="#" class="link edit">编辑</a>
			    	</td>
			    	<#list table.columnList as col>												
			    <#assign colName=func.convertUnderLine(col.columnName)>
			    <#assign foreignKey=func.convertUnderLine(table.foreignKey) >
		   		<#if ( !col.isPK && colName?lower_case!=foreignKey?lower_case)>
		    	<#if (col.colType=="java.util.Date")>
			    	<input type="hidden" name="${colName}" value="" class="inputText date"/>
			    <#else >
			    	<input type="hidden" name="${colName}" value=""/>
			    </#if>
			  	</#if>
			    </#list>
		 		</tr>
		    </table>
			</#list>
			</#if>
			<input type="hidden" name="${pkVar}" value="<#noparse>${</#noparse>${classVar}.${pkVar}<#noparse>}</#noparse>" />
			<#if model.variables.flowFlag?exists && model.variables.flowFlag=='true'>
			<input type="hidden" id="back" name="back" value=""/>
			<input type="hidden" name="formData" id="formData" />
			<input type="hidden" id="voteAgree" name="voteAgree" value="1"/> 
			<input type="hidden" id="taskId" name="taskId" value="<#noparse>${</#noparse>taskId}"/>
			</#if>			
		</form>
		
	</div>
	<#if subtables?exists && subtables?size != 0>
	<#list subtables as table>
	<#assign foreignKey=func.convertUnderLine(table.foreignKey) >
	<form id="${table.variables.classVar}Form" style="display:none">
		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
			<#list table.columnList as col>	
			<#assign colName=func.convertUnderLine(col.columnName)>
			<#if !col.isPK && colName?lower_case!=foreignKey?lower_case>
			<#if (col.colType=="java.util.Date")>
			<tr>
				<th width="20%">${col.comment}: <#if col.isNotNull> <span class="required">*</span></#if></th>
				<td><input type="text" name="${colName}" value="" class="inputText date" validate="{date:true<#if col.isNotNull>,required:true</#if>}"/></td>
			</tr>
			
			<#else>
			<tr>
				<th width="20%">${col.comment}: <#if col.isNotNull> <span class="required">*</span></#if></th>
				<td><input type="text" name="${colName}" value=""  class="inputText" validate="{<#if col.isNotNull>required:true<#else>required:false</#if><#if col.colType=='String' && col.length<1000>,maxlength:${col.length}</#if><#if col.colType=='Integer'|| col.colType=='Long'||col.colType=='Float'>,number:true </#if>}"/></td>
			</tr>
			</#if>
			</#if>
			</#list>
		</table>
	</form>
	</#list>
	</#if>
</div>
</body>
</html>
