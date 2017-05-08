<%--
	time:2012-06-25 11:05:09
	desc:edit the 自定义表管理显示模板
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 自定义显示 显示模板</title>
	<%@include file="/commons/include/form.jsp" %>
		<link  rel="stylesheet" type="text/css" href="${ctx}/js/codemirror/lib/codemirror.css" >
	<script type="text/javascript" src="${ctx}/js/codemirror/lib/codemirror.js"></script>
	<script type="text/javascript" src="${ctx}/js/codemirror/mode/xml/xml.js"></script>
	<script type="text/javascript" src="${ctx}/js/codemirror/mode/javascript/javascript.js"></script>
    <script type="text/javascript" src="${ctx}/js/codemirror/mode/css/css.js"></script>
    <script type="text/javascript" src="${ctx}/js/codemirror/mode/htmlmixed/htmlmixed.js"></script>
	<script type="text/javascript">
		var editor=null;
		$(function() {
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			$('#dspTemplateForm').ajaxForm(options);
			$("a.save").click(function() {
				editor.save();
				$('#dspTemplateForm').submit();
			});
			
			var width = $("#dspTemplate").width();
			var height = $("#dspTemplate").height();
			editor = CodeMirror.fromTextArea(document.getElementById("dspTemplate"), {
				mode: "text/html",
				tabMode: "indent",
				lineNumbers: true
			 });
			editor.setSize(width,height);
		});
		
		function showResponse(responseText) {
			var obj = new com.hotent.form.ResultMessage(responseText);
			if (obj.isSuccess()) {
				$.ligerMessageBox.confirm("提示信息", obj.getMessage()+",是否继续操作", function(rtn) {
					if(rtn){
						this.close();
					}else{
						window.location.href = "${ctx}/platform/system/sysCustomDisplay/list.ht";
					}
				});
			} else {
				$.ligerDialog.err('出错信息',"编辑自定义显示显示模板失败",obj.getMessage());
			}
		}
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">编辑自定义表管理显示模板</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" href="javascript:void(0)">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="dspTemplateForm" method="post" action="saveTemplate.ht" >
					<table class="table-detail">
						<tr>
							<th width="20%">名称: </th>
							<td>${sysCustomDisplay.name}</td>
							<th width="20%">描述: </th>
							<td>${sysCustomDisplay.description}</td>
						</tr>
						<tr>
							<th>模板</th>
							<td colspan="3">
								<textarea id="dspTemplate"  name="dspTemplate" style="width: 99%;height: 320px;">${sysCustomDisplay.dspTemplate }</textarea>
							</td>
						</tr>
					</table>
					<input name="id" type="hidden" value="${sysCustomDisplay.id }"/>
				</form>
		</div>
</div>
</body>
</html>
