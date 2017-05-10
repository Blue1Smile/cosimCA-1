<%--
	time:2013-04-11 11:48:44
	desc:edit the 业务定义，如邀标采购这样的大业务。
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 业务定义，如邀标采购这样的大业务。</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js" ></script>
	<script type="text/javascript" src="${ctx}/js/hotent/formdata.js" ></script>
	<script type="text/javascript" src="${ctx}/js/hotent/subform.js" ></script>
	<script type="text/javascript">
		$(function() {
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			var frm=$('#businessDefinitionForm').form();
			$("a.save").click(function() {
				var form=$('#businessDefinitionForm').setData();
				form.ajaxForm(options);
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
						window.location.href = "${ctx}/platform/biz/businessDefinition/list.ht";
					}
				});
			} else {
				$.ligerMessageBox.error("提示信息",obj.getMessage());
			}
		}
	</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
		    <c:choose>
			    <c:when test="${businessDefinition.bizDefId !=null}">
			        <span class="tbar-label">编辑业务定义，如邀标采购这样的大业务。</span>
			    </c:when>
			    <c:otherwise>
			        <span class="tbar-label">添加业务定义，如邀标采购这样的大业务。</span>
			    </c:otherwise>			   
		    </c:choose>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group"><a class="link save" id="dataFormSave" href="javascript:void(0)">保存</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link back " href="list.ht">返回</a></div>
			</div>
		</div>
	</div>
	<div class="panel-body">
		<form id="businessDefinitionForm" method="post" action="save.ht">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0" type="main">
				<tr>
					<th width="20%">业务编号: </th>
					<td><input type="text" id="bizDefNo" name="bizDefNo" value="${businessDefinition.bizDefNo}" validate="{required:false,maxlength:768}" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">业务名称: </th>
					<td><input type="text" id="defName" name="defName" value="${businessDefinition.defName}" validate="{required:false,maxlength:768}" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">描述: </th>
					<td><input type="text" id="defDescription" name="defDescription" value="${businessDefinition.defDescription}" validate="{required:false}" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">版本号: </th>
					<td><input type="text" id="versionNo" name="versionNo" value="${businessDefinition.versionNo}" validate="{required:false}" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">主版本: </th>
					<td><input type="text" id="isMain" name="isMain" value="${businessDefinition.isMain}" validate="{required:false}" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">状态:: </th>
					<td><input type="text" id="status" name="status" value="${businessDefinition.status}" validate="{required:false}" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">创建人: </th>
					<td><input type="text" id="createBy" name="createBy" value="${businessDefinition.createBy}" validate="{required:false,number:true }" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">创建日期: </th>
					<td><input type="text" id="createTime" name="createTime" value="<fmt:formatDate value='${businessDefinition.createTime}' pattern='yyyy-MM-dd'/>" validate="{required:false,date:true}" class="inputText date"/></td>
				</tr>
				<tr>
					<th width="20%">更新人: </th>
					<td><input type="text" id="updateBy" name="updateBy" value="${businessDefinition.updateBy}" validate="{required:false,number:true }" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">更新日期: </th>
					<td><input type="text" id="updateTime" name="updateTime" value="<fmt:formatDate value='${businessDefinition.updateTime}' pattern='yyyy-MM-dd'/>" validate="{required:false,date:true}" class="inputText date"/></td>
				</tr>
			</table>
			<table class="table-grid table-list" cellpadding="1" cellspacing="1" type="sub" formType="page" id="BizDefSegment">
				<tr>
					<td colspan="7">
						<div class="group" align="left">
				   			<a id="btnAdd" class="link add">添加</a>
			    		</div>
			    		<div align="center">
						BIZ_DEF_SEGMENT : 业务环节
			    		</div>
		    		</td>
				</tr>
				<tr>
					<th>业务环节编号</th>
					<th>业务环节名称</th>
					<th>描述</th>
					<th>默认流程定义Key</th>
					<th>状态</th>
					<th>序号</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${BizDefSegmentList}" var="BizDefSegmentItem" varStatus="status">
				    <tr type="subdata">
					    <td style="text-align: center"><input type="text" name="bizDefSegmentNo" value="${BizDefSegmentItem.bizDefSegmentNo}" validate="{required:false,maxlength:150}" class="inputText"/></td>
					    <td style="text-align: center"><input type="text" name="segmentName" value="${BizDefSegmentItem.segmentName}" validate="{required:false,maxlength:768}" class="inputText"/></td>
					    <td style="text-align: center"><input type="text" name="segmentDescription" value="${BizDefSegmentItem.segmentDescription}" validate="{required:false}" class="inputText"/></td>
					    <td style="text-align: center"><input type="text" name="actDefKey" value="${BizDefSegmentItem.actDefKey}" validate="{required:false,maxlength:768}" class="inputText"/></td>
					    <td style="text-align: center"><input type="text" name="status" value="${BizDefSegmentItem.status}" validate="{required:false}" class="inputText"/></td>
					    <td style="text-align: center"><input type="text" name="sortOrder" value="${BizDefSegmentItem.sortOrder}" validate="{required:false,number:true }" class="inputText"/></td>
					    <td style="text-align: center"><a href="javascript:void(0)" class="link del">删除</a></td>
				    </tr>
				</c:forEach>
				<tr type="append">
				    <td style="text-align: center"><input type="text" name="bizDefSegmentNo" value="" validate="{required:false,maxlength:150}" class="inputText"/></td>
				    <td style="text-align: center"><input type="text" name="segmentName" value="" validate="{required:false,maxlength:768}" class="inputText"/></td>
				    <td style="text-align: center"><input type="text" name="segmentDescription" value="" validate="{required:false}" class="inputText"/></td>
				    <td style="text-align: center"><input type="text" name="actDefKey" value="" validate="{required:false,maxlength:768}" class="inputText"/></td>
				    <td style="text-align: center"><input type="text" name="status" value="" validate="{required:false}" class="inputText"/></td>
				    <td style="text-align: center"><input type="text" name="sortOrder" value="" validate="{required:false,number:true }" class="inputText"/></td>
				    <td style="text-align: center"><a href="javascript:void(0)" class="link del">删除</a></td>
			    </tr>
		    </table>
			<input type="hidden" name="bizDefId" value="${businessDefinition.bizDefId}" />					
		</form>
	</div>
</div>
</body>
</html>
