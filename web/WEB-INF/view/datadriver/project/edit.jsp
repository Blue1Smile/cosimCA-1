<%--
	time:2013-04-11 11:48:44
	desc:edit the 业务定义，如邀标采购这样的大业务。
--%>
<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@page import="com.hotent.core.util.ContextUtil" %>
<html>
<head>
    <title>项目基础信息添加</title>
    <%@include file="/commons/include/form.jsp" %>
    <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        $(function () {
            var options = {};
            if (showResponse) {
                options.success = showResponse;
            }
            var frm = $('#projinfoForm').form();
            $("#dataFormSave").click(function () {
                frm.setData();
                frm.ajaxForm(options);
                if (frm.valid()) {
                    form.submit();
                }
            });
        });

        function showResponse(responseText) {
            var obj = new com.hotent.form.ResultMessage(responseText);
            if (obj.isSuccess()) {
                $.ligerMessageBox.confirm("提示信息", obj.getMessage() + ",是否继续操作", function (rtn) {
                    if (rtn) {
                        this.close();
                    } else {
                        window.location.href = "${ctx}/datadriver/project/list.ht";
                    }
                });
            } else {
                $.ligerMessageBox.error("提示信息", obj.getMessage());
            }
        }

    </script>

</head>
<body>
<div class="panel">
    <fieldset class="layui-elem-field">
        <legend>项目配置</legend>
        <div class="layui-field-box">
            <div class="panel-body">
                <form id="projinfoForm" name="projinfoForm" method="post" action="save.ht"
                      enctype="multipart/form-data">
                    <div class="layui-tab layui-tab-card">
                        <ul class="layui-tab-title">
                            <li class="layui-this">项目参数配置</li>
                            <%--<li>相关任务</li>--%>
                        </ul>
                        <div class="layui-tab-content" style="height: 100%;">
                            <div class="layui-tab-item layui-show">
                                <a class="layui-btn layui-btn-normal" id="dataFormSave" href="#">保存</a>

                                <table id="AddHandlingFee" class="layui-table" cellpadding="0" cellspacing="0"
                                       border="0"
                                       type="main">
                                    <th width="20%">项目名称:</th>
                                    <td><input type="text" id="ddProjectName" name="ddProjectName"
                                               value="${Project.ddProjectName}"
                                               class="layui-input"/></td>
                                    <th width="20%">项目研制阶段:</th>
                                    <td><input type="text" id="ddProjectScheduleState" name="ddProjectScheduleState"
                                               value="${Project.ddProjectScheduleState}"
                                               class="layui-input"/></td>
                                    </tr>
                                    <tr>
                                        <th width="20%">项目责任单位:</th>
                                        <td><input type="text" id="ddProjectResponsibleUnits"
                                                   name="ddProjectResponsibleUnits"
                                                   value="${Project.ddProjectResponsibleUnits}"
                                                   class="layui-input"/></td>
                                        <th width="20%">项目阶段:</th>
                                        <td><input type="text" id="ddProjectPhaseId" name="ddProjectPhaseId"
                                                   value="${Project.ddProjectPhaseId}"
                                                   class="layui-input"/></td>
                                    </tr>
                                    <tr>
                                        <%--<th width="20%">项目创建日期:</th>--%>
                                        <%--<td><input type="text" id="ddProjectCreateDatatime"--%>
                                        <%--name="ddProjectCreateDatatime"--%>
                                        <%--value="${Project.ddProjectCreateDatatime}"--%>
                                        <%--class="layui-input"/></td>--%>
                                        <th width="20%">项目是否固化:</th>
                                        <td><input type="text" id="ddProjectFixedPattern" name="ddProjectFixedPattern"
                                                   value="${Project.ddProjectFixedPattern}"
                                                   class="layui-input"/></td>
                                        <th width="20%">项目基本描述:</th>
                                        <td><input type="text" id="ddProjectDescription" name="ddProjectDescription"
                                                   value="${Project.ddProjectDescription}"
                                                   class="layui-input"/></td>
                                    </tr>
                                    <tr>
                                        <th width="20%">项目所属系统:</th>
                                        <td><input type="text" id="ddProjectOwnerSystemId" name="ddProjectOwnerSystemId"
                                                   value="${Project.ddProjectOwnerSystemId}"
                                                   class="layui-input"/></td>
                                        <th width="20%">项目创建者id:</th>
                                        <td><input type="text" id="ddProjectCreatorId" name="ddProjectCreatorId"
                                                   value="${Project.ddProjectCreatorId}"
                                                   class="layui-input"/></td>
                                    </tr>


                                    <%--<th width="20%">项目负责人id:</th>--%>
                                    <%--<td><input type="text" id="ddProjectResponsiblePersonId"--%>
                                    <%--name="ddProjectResponsiblePersonId"--%>
                                    <%--value="${Project.ddProjectResponsiblePersonId}"--%>
                                    <%--class="layui-input"/></td>--%>

                                    <tr>
                                        <th width="20%">项目类型:</th>
                                        <td><input type="text" id="ddProjectType" name="ddProjectType"
                                                   value="${Project.ddProjectType}"
                                                   class="layui-input"/></td>
                                        <th width="20%">所属型号:</th>
                                        <td><input type="text" id="ddProjectBelongModel" name="ddProjectBelongModel"
                                                   value="${Project.ddProjectBelongModel}"
                                                   class="layui-input"/></td>
                                    </tr>
                                    <tr>
                                        <th width="20%">项目密级:</th>
                                        <td><input type="text" id="ddProjectSecretLevel" name="ddProjectSecretLevel"
                                                   value="${Project.ddProjectSecretLevel}"
                                                   class="layui-input"/></td>
                                        <%--<th width="20%">修改人id:</th>--%>
                                        <%--<td><input type="text" id="ddProjectChangePersonId"--%>
                                        <%--name="ddProjectChangePersonId"--%>
                                        <%--value="${Project.ddProjectChangePersonId}"--%>
                                        <%--class="layui-input"/></td>--%>
                                    </tr>
                                    <tr>
                                        <th width="20%">优先级:</th>
                                        <td><input type="text" id="ddProjectPriority" name="ddProjectPriority"
                                                   value="${Project.ddProjectPriority}"
                                                   class="layui-input"/></td>
                                        <th width="20%">备注:</th>
                                        <td><input type="text" id="ddProjectRemark" name="ddProjectRemark"
                                                   value="${Project.ddProjectRemark}"
                                                   class="layui-input"/></td>
                                    </tr>
                                    <tr>
                                        <%--<th width="20%">状态:</th>--%>
                                        <%--<td><input type="text" id="ddProjectState" name="ddProjectState"--%>
                                        <%--value="${Project.ddProjectState}"--%>
                                        <%--class="layui-input"/></td>--%>
                                        <th width="20%">计划开始日期:</th>
                                        <td><input type="text" id="ddProjectPlanStartDate" name="ddProjectPlanStartDate"
                                                   value="${Project.ddProjectPlanStartDate}"
                                                   class="layui-input"/></td>

                                        <th width="20%">计划完成日期:</th>
                                        <td><input type="text" id="ddProjectCompleteDate" name="ddProjectCompleteDate"
                                                   value="${Project.ddProjectCompleteDate}"
                                                   class="layui-input"/></td>
                                        <%--<th width="20%">实际开始日期:</th>--%>
                                        <%--<td><input type="text" id="ddProjectActualStartDate"--%>
                                        <%--name="ddProjectActualStartDate"--%>
                                        <%--value="${Project.ddProjectActualStartDate}"--%>
                                        <%--class="layui-input"/></td>--%>
                                    </tr>


                                    <%--<th width="20%">实际结束日期:</th>--%>
                                    <%--<td><input type="text" id="ddProjectActualCompleteData"--%>
                                    <%--name="ddProjectActualCompleteData"--%>
                                    <%--value="${Project.ddProjectActualCompleteData}"--%>
                                    <%--class="layui-input"/></td>--%>
                                    <%--<th width="20%">当前项目进度:</th>--%>
                                    <%--<td><input type="text" id="ddProjectCurrentStage" name="ddProjectCurrentStage"--%>
                                    <%--value="${Project.ddProjectCurrentStage}"--%>
                                    <%--class="layui-input"/></td>--%>

                                    <input type="hidden" name="ddProjectId" value="${Project.ddProjectId}">
                                    <input type="hidden" name="ddProjectResponsiblePersonId"
                                           value="${Project.ddProjectResponsiblePersonId}">
                                    <input type="hidden" name="ddProjectCreateDatatime"
                                           value="${Project.ddProjectCreateDatatime}">
                                    <input type="hidden" name="ddProjectChangePersonId"
                                           value="${Project.ddProjectChangePersonId}">
                                    <input type="hidden" name="ddProjectState" value="${Project.ddProjectState}">
                                    <input type="hidden" name="ddProjectActualStartDate"
                                           value="${Project.ddProjectActualStartDate}">
                                    <input type="hidden" name="ddProjectActualCompleteData"
                                           value="${Project.ddProjectActualCompleteData}">
                                    <input type="hidden" name="ddProjectCurrentStage"
                                           value="${Project.ddProjectCurrentStage}">
                                </table>
                            </div>
                            <%--<div class="layui-tab-item">--%>
                                <%--<iframe src="${ctx}/datadriver/task/list.ht?id=${Project.ddProjectId}" style="width: 100%;height: 500px" scrolling="auto" frameborder="no"></iframe>--%>
                            <%--</div>--%>
                            <%--<div class="layui-tab-item">--%>
                            <%--&lt;%&ndash;<iframe frameborder="no" scrolling="auto" style="width: 100%;height: 500px"&ndash;%&gt;--%>
                            <%--&lt;%&ndash;src="${ctx}/datadriver/task/list.ht?ddTaskProjectId=${Project.ddProjectId}"></iframe>&ndash;%&gt;--%>
                            <%--<table class="layui-table" cellpadding="1" cellspacing="1" id="taskInfo"--%>
                            <%--formType="window" type="sub">--%>
                            <%--<tr>--%>
                            <%--<td colspan="11">--%>
                            <%--<div class="group" align="left">--%>
                            <%--<a id="btnAdd" class="link add">添加</a>--%>
                            <%--</div>--%>
                            <%--<div align="center">--%>
                            <%--项目创建：添加任务--%>
                            <%--</div>--%>
                            <%--</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                            <%--<th>任务名称</th>--%>
                            <%--<th>任务类型</th>--%>
                            <%--<th>优先级</th>--%>
                            <%--<th>里程碑</th>--%>
                            <%--<th>计划工时</th>--%>
                            <%--<th>操作</th>--%>
                            <%--</tr>--%>
                            <%--<c:forEach items="${taskInfoList}" var="taskInfoList"--%>
                            <%--varStatus="status">--%>
                            <%--<tr type="subdata">--%>
                            <%--<td style="text-align: center"--%>
                            <%--name="ddTaskName">${taskInfoList.ddTaskName}</td>--%>
                            <%--<td style="text-align: center"--%>
                            <%--name="ddTaskType">${taskInfoList.ddTaskType}</td>--%>
                            <%--<td style="text-align: center"--%>
                            <%--name="ddTaskPriority">${taskInfoList.ddTaskPriority}</td>--%>
                            <%--<td style="text-align: center"--%>
                            <%--name="ddTaskMilestone">${taskInfoList.ddTaskMilestone}</td>--%>
                            <%--<td style="text-align: center"--%>
                            <%--name="ddTaskEstimateTime">${taskInfoList.ddTaskEstimateTime}</td>--%>
                            <%--&lt;%&ndash;<td style="text-align: center"&ndash;%&gt;--%>
                            <%--&lt;%&ndash;name="url2">${task.url2}</td>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<td style="text-align: center"&ndash;%&gt;--%>
                            <%--&lt;%&ndash;name="url2Name">${cloudResourceInstanceListItem.url2Name}</td>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<td style="text-align: center"&ndash;%&gt;--%>
                            <%--&lt;%&ndash;name="blank1">${cloudResourceInstanceListItem.blank1}</td>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<td style="text-align: center"&ndash;%&gt;--%>
                            <%--&lt;%&ndash;name="blank2">${cloudResourceInstanceListItem.blank2}</td>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<td style="text-align: center"&ndash;%&gt;--%>
                            <%--&lt;%&ndash;name="mode">${cloudResourceInstanceListItem.mode}</td>&ndash;%&gt;--%>
                            <%--<td style="text-align: center">--%>
                            <%--<a href="#" class="link del">删除</a>--%>
                            <%--<a href="#" class="link edit">编辑</a>--%>
                            <%--</td>--%>
                            <%--<input type="hidden" name="ddTaskId" value="${taskInfoList.ddTaskId}"/>--%>
                            <%--<input type="hidden" name="ddTaskName" value="${taskInfoList.ddTaskName}"/>--%>
                            <%--<input type="hidden" name="ddTaskDescription" value="${taskInfoList.ddTaskDescription}"/>--%>
                            <%--<input type="hidden" name="ddTaskCreatorId" value="${taskInfoList.ddTaskCreatorId}"/>--%>
                            <%--<input type="hidden" name="ddTaskResponsiblePerson" value="${taskInfoList.ddTaskResponsiblePerson}"/>--%>
                            <%--<input type="hidden" name="ddTaskFixedPattern" value="${taskInfoList.ddTaskFixedPattern}"/>--%>
                            <%--<input type="hidden" name="ddTaskType" value="${taskInfoList.ddTaskType}"/>--%>
                            <%--<input type="hidden" name="ddTaskChildType" value="${taskInfoList.ddTaskChildType}"/>--%>
                            <%--<input type="hidden" name="ddTaskPriority" value="${taskInfoList.ddTaskPriority}"/>--%>
                            <%--<input type="hidden" name="ddTaskMilestone" value="${taskInfoList.ddTaskMilestone}"/>--%>
                            <%--<input type="hidden" name="ddTaskEstimateTime" value="${taskInfoList.ddTaskEstimateTime}"/>--%>
                            <%--<input type="hidden" name="ddTaskPlanStartTime" value="${taskInfoList.ddTaskPlanStartTime}"/>--%>
                            <%--<input type="hidden" name="ddTaskPlanEndTime" value="${taskInfoList.ddTaskPlanEndTime}"/>--%>
                            <%--<input type="hidden" name="ddTaskCompleteRate" value="${taskInfoList.ddTaskCompleteRate}"/>--%>
                            <%--<input type="hidden" name="ddTaskCompleteState" value="${taskInfoList.ddTaskCompleteState}"/>--%>
                            <%--<input type="hidden" name="ddTaskResourceId" value="${taskInfoList.ddTaskResourceId}"/>--%>
                            <%--<input type="hidden" name="ddTaskActualTime" value="${taskInfoList.ddTaskActualTime}"/>--%>
                            <%--<input type="hidden" name="ddTaskPlanTime" value="${taskInfoList.ddTaskPlanTime}"/>--%>
                            <%--<input type="hidden" name="ddTaskActualStartTime" value="${taskInfoList.ddTaskActualStartTime}"/>--%>
                            <%--<input type="hidden" name="ddTaskActualEndTime" value="${taskInfoList.ddTaskActualEndTime}"/>--%>
                            <%--<input type="hidden" name="ddTaskPlanDuration" value="${taskInfoList.ddTaskPlanDuration}"/>--%>
                            <%--<input type="hidden" name="ddTaskProjectId" value="${taskInfoList.ddTaskProjectId}"/>--%>
                            <%--<input type="hidden" name="ddTaskPerson" value="${taskInfoList.ddTaskPerson}"/>--%>
                            <%--</tr>--%>
                            <%--</c:forEach>--%>
                            <%--<tr type="append">--%>
                            <%--<td style="text-align: center" name="ddTaskName"></td>--%>
                            <%--<td style="text-align: center" name="ddTaskType"></td>--%>
                            <%--<td style="text-align: center" name="ddTaskPriority"></td>--%>
                            <%--<td style="text-align: center" name="ddTaskMilestone"></td>--%>
                            <%--<td style="text-align: center" name="ddTaskEstimateTime"></td>--%>
                            <%--<td style="text-align: center">--%>
                            <%--<a href="#" class="link del">删除</a>--%>
                            <%--<a href="#" class="link edit">编辑</a>--%>
                            <%--</td>--%>
                            <%--<input type="hidden" name="ddTaskId" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskName" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskDescription" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskCreatorId" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskResponsiblePerson" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskFixedPattern" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskType" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskChildType" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskPriority" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskMilestone" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskEstimateTime" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskPlanStartTime" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskPlanEndTime" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskCompleteRate" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskCompleteState" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskResourceId" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskActualTime" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskPlanTime" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskActualStartTime" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskActualEndTime" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskPlanDuration" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskProjectId" value=""/>--%>
                            <%--<input type="hidden" name="ddTaskPerson" value=""/>--%>
                            <%--</tr>--%>
                            <%--</table>--%>
                            <%--</div>--%>
                        </div>
                    </div>
                </form>

                <%--<form id="taskInfoForm" style="display:none">--%>
                <%--<table class="layui-table" cellpadding="2" cellspacing="2">--%>
                <%--<colgroup>--%>
                <%--<col width="200">--%>
                <%--<col width="300">--%>
                <%--<col>--%>
                <%--</colgroup>--%>
                <%--<tr>--%>
                <%--<th width="20%">任务名称:</th>--%>
                <%--<td><input type="text" name="ddTaskName" value="" class="layui-input"--%>
                <%--validate="{required:false,maxlength:96}"/></td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<th width="20%">任务类型:</th>--%>
                <%--<td><input type="text" name="ddTaskType" value="" class="layui-input"--%>
                <%--validate="{required:false}"/>--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<th width="20%">优先级:</th>--%>
                <%--<td><input type="text" name="ddTaskPriority" value="" class="layui-input"--%>
                <%--validate="{required:false,maxlength:768}"/></td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<th width="20%">是否里程碑:</th>--%>
                <%--<td><input type="text" name="ddTaskMilestone" value="" class="layui-input"--%>
                <%--validate="{required:false,maxlength:768}"/></td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<th width="20%">计划工时:</th>--%>
                <%--<td><input type="text" name="ddTaskEstimateTime" value="" class="layui-input"--%>
                <%--validate="{required:false,maxlength:768}"/></td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<th width="20%">任务描述:</th>--%>
                <%--<td><input type="text" name="ddTaskDescription" value="" class="layui-input"--%>
                <%--validate="{required:false,maxlength:768}"/></td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<th width="20%">所需工具:</th>--%>
                <%--<td><input type="text" name="ddTaskResourceId" value="" class="layui-input"--%>
                <%--validate="{required:false,maxlength:768}"/></td>--%>
                <%--</tr>--%>
                <%--</table>--%>
                <%--</form>--%>
            </div>
        </div>
    </fieldset>
</div>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</body>
</html>
