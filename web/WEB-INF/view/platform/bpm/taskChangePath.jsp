<%
	//任务设置执行路径
%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
	<head>
		<title>更改任务执行的路径</title>
		<%@include file="/commons/include/get.jsp" %>
		<link rel="stylesheet" href="${ctx}/js/tree/v35/zTreeStyle.css" type="text/css" />
		<script type="text/javascript" src="${ctx}/js/hotent/platform/system/SysDialog.js"></script>
		<script type="text/javascript">
			//更改任务执行路径
			function saveTaskChangePath(){
				var deskTask=$('#destTask').val();
				if(deskTask==''){
					$.ligerMessageBox.confirm("提示信息","请选择更换的目标节点!");
					return;
				}
				var params=$('#taskForm').serialize();
				$.post('${ctx}/platform/bpm/taskInfo/saveChangePath.ht',params,function(data){
					window.opener.location.href="${ctx}/platform/bpm/taskInfo/list.ht";
					window.close();
				});
			}
			
			//更改
			function changeDestTask(sel){
				var nodeId=sel.value;
				$('#lastDestTaskId').val(nodeId);
				if(nodeId==""){
					$("#jumpUserDiv").html('');
					return;
				}
				var url="${ctx}/platform/bpm/taskInfo/getTaskUsers.ht?taskId=${taskEntity.id}&nodeId="+nodeId;
				$.getJSON(url, function(dataJson){
					var data=eval(dataJson);
					var aryHtml=[];
					for(var i=0;i<data.length;i++){
						aryHtml.push("<input type='checkbox' name='" + nodeId + "_userId' checked='checked' value='"+data[i].userId+"'/>&nbsp;"+data[i].fullname );
					}
					$("#jumpUserDiv").html(aryHtml.join(''));
				});
			}
			
			//为目标节点选择执行的人员列表
			function selectExeUsers(nodeId){
				UserDialog({callback:function(uIds,uNames){
					if(uIds.isEmpty()) return;
					var aryHtml=[];
					var ids=uIds.split(',');
					var names=uNames.split(',');
					for(var i=0;i<ids.length;i++){
						aryHtml.push("<input type='checkbox' name='" + nodeId + "_userId' checked='checked' value='"+ids[i]+"'/>&nbsp;"+names[i]);
					}
					$("#jumpUserDiv").html(aryHtml.join(''));
				}});
			}
		</script>
	</head>
	<body>
	<div class="panel">
		<div class="panel-top">
		   <div class="tbar-title">
		    	<span class="tbar-label">任务设置执行路径</span>
		   </div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="btnSearch" onclick="saveTaskChangePath()">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link del" onclick="javasrcipt:window.close()">关闭</a></div>
			    </div>
			</div>
		</div>
	 <div class="panel-body">
		<form id="taskForm">
			<div class="panel-detail">
				<table class="table-detail">
					<tr>
						<th nowrap="nowrap">当前任务</th>
						<td>
							<input type="hidden" id="taskId"  name="taskId" value="${taskEntity.id}"/>
							${taskEntity.name}
						</td>
					</tr>
					<tr>
						<th nowrap="nowrap">目标节点</th>
						<td>
							<select name="destTask" id="destTask" onchange="changeDestTask(this)">
								<option value="">请选择目标节点..</option>
								<c:forEach items="${taskNodeMap}" var="map" varStatus="i">
									<option value="${map.key}">${map.value}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th nowrap="nowrap">
							节点对应的执行人
						</th>
						<td>
							<input type="hidden" id="lastDestTaskId" name="lastDestTaskId" value="">
							<div id="jumpUserDiv"></div>
							<a href="javascript:void(0)" id="jumpUserLink" class="link get" onclick="selectExeUsers('${nodeUserMap.nodeId}')">&nbsp;&nbsp;</a>
						</td>
					</tr>
					<tr>
						<th>更改备注</th>
						<td>
							<textarea rows="5" cols="60" id="voteContent" name="voteContent" maxlength="512">${curUser.fullname}进行任务路径更改!</textarea>
						</td>
					</tr>
					<tr>
						<th nowrap="nowrap">通知</th>
						<td>
							<input name="informType" type="checkbox" value="1" checked="checked">手机短信 &nbsp;<input name="informType" type="checkbox" value="2" checked="checked"> 邮件
						</td>
					</tr>
				</table>
				<input type="hidden" id="voteAgree" name="voteAgree" value="8"/> 
			</div>
		</form>
	 </div>
	</div>
	</body>
</html>