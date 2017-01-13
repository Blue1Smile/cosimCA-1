<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@page import="com.hotent.core.util.ContextUtil" %>
<html>
<head>
    <title>任务基础信息添加</title>
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
            var frm = $('#taskInfoForm').form();
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
                layer.alert("项目指标提交成功", {
                    title: '提交信息'
                })
            } else {
                layer.alert("项目指标提交失败", {
                    title: '提交信息'
                })
            }
        }

    </script>
    <style>
        .fr {
            float: right;
        }
    </style>
</head>
<body>
<form id="taskInfoForm" name="taskInfoForm" method="post" action="save.ht"
      enctype="multipart/form-data">
    <div class="layui-tab layui-tab-card">
        <ul class="layui-tab-title">
            <li class="layui-this">任务配置</li>
        </ul>
        <div class="layui-tab-content" style="height: 100%;">
            <div class="layui-tab-item layui-show">
                <blockquote class="layui-elem-quote">
                    <div style="height: 40px;">
                        <div class="fr">
                            <a class="layui-btn layui-btn-normal" id="dataFormSave" href="#"><i
                                    class="layui-icon">&#xe61e;</i> 保存</a>
                            <a class="layui-btn layui-btn-primary" id="back" href="list.ht"><i
                                    class="layui-icon">&#xe603;</i> 返回</a>
                        </div>
                    </div>
                </blockquote>
                <table id="AddHandlingFee" class="layui-table" cellpadding="0" cellspacing="0"
                       border="0"
                       type="main">
                    <tr>
                        <th width="20%">任务名称:</th>
                        <td><input type="text" id="ddTaskName" name="ddTaskName"
                                   value="${TaskInfo.ddTaskName}" class="layui-input"/></td>
                        <th width="20%">任务所属项目:</th>
                        <td><input type="text" id="ddTaskProjectName" name="ddTaskProjectName"
                                   value="${TaskInfo.ddTaskProjectName}" class="layui-input"/></td>
                    </tr>
                    <tr>
                        <th width="20%">任务基本描述:</th>
                        <td><input type="text" id="ddTaskDescription" name="ddTaskDescription"
                                   value="${TaskInfo.ddTaskDescription}" class="layui-input"/></td>
                        <th width="20%">计划工期:</th>
                        <td><input type="text" id="ddTaskPlanDuration" name="ddTaskPlanDuration"
                                   value="${TaskInfo.ddTaskPlanDuration}" class="layui-input"/></td>
                    </tr>
                    <tr>
                        <th width="20%">任务负责人:</th>
                        <td>
                            <select name="ddTaskResponsiblePerson" class="layui-input"
                                    id="personSelect">
                                <c:forEach var="personItem" items="${sysUserList}">
                                    <option value="${personItem.userId}"
                                            <c:if test="${personItem.fullname == TaskInfo.ddTaskPerson}">selected</c:if>>${personItem.fullname}</option>
                                </c:forEach>
                            </select>
                        </td>

                        <th width="20%">任务是否固化:</th>
                        <td><input type="text" id="ddTaskFixedPattern" name="ddTaskFixedPattern"
                                   value="${TaskInfo.ddTaskFixedPattern}" class="layui-input"/></td>
                    </tr>
                    <tr>
                        <th width="20%">任务类型:</th>
                        <td><input type="text" id="ddTaskType" name="ddTaskType"
                                   value="${TaskInfo.ddTaskType}" class="layui-input"/></td>
                        <th width="20%">任务子类型:</th>
                        <td><input type="text" id="ddTaskChildType" name="ddTaskChildType"
                                   value="${TaskInfo.ddTaskChildType}" class="layui-input"/></td>
                    </tr>
                    <tr>
                        <th width="20%">优先级:</th>
                        <td><input type="text" id="ddTaskPriority" name="ddTaskPriority"
                                   value="${TaskInfo.ddTaskPriority}" class="layui-input"/></td>
                        <th width="20%">是否里程碑任务:</th>
                        <td><input type="text" id="ddTaskMilestone" name="ddTaskMilestone"
                                   value="${TaskInfo.ddTaskMilestone}" class="layui-input"/></td>
                    </tr>

                    <tr>
                        <th width="20%">任务计划工时:</th>
                        <td><input type="text" id="ddTaskEstimateTime" name="ddTaskEstimateTime"
                                   value="${TaskInfo.ddTaskEstimateTime}" class="layui-input"/></td>
                        <th width="20%">任务计划开始时间:</th>
                        <td><input type="text" id="ddTaskPlanStartTime" name="ddTaskPlanStartTime"
                                   value="${TaskInfo.ddTaskPlanStartTime}" class="layui-input"/></td>
                    </tr>
                    <tr>
                        <th width="20%">任务计划结束时间:</th>
                        <td><input type="text" id="ddTaskPlanEndTime" name="ddTaskPlanEndTime"
                                   value="${TaskInfo.ddTaskPlanEndTime}" class="layui-input"/></td>
                        <th width="20%">任务完成率:</th>
                        <td><input type="text" id="ddTaskCompleteRate" name="ddTaskCompleteRate"
                                   value="${TaskInfo.ddTaskCompleteRate}" class="layui-input"/></td>
                    </tr>
                    <tr>
                        <th width="20%">实际工时:</th>
                        <td><input type="text" id="ddTaskActualTime" name="ddTaskActualTime"
                                   value="${TaskInfo.ddTaskActualTime}" class="layui-input"/></td>
                        <th width="20%">计划工时:</th>
                        <td><input type="text" id="ddTaskPlanTime" name="ddTaskPlanTime"
                                   value="${TaskInfo.ddTaskPlanTime}" class="layui-input"/></td>
                    </tr>
                    <tr>
                        <th width="20%">实际开始日期:</th>
                        <td><input type="text" id="ddTaskActualStartTime" name="ddTaskActualStartTime"
                                   value="${TaskInfo.ddTaskActualStartTime}" class="layui-input"/></td>
                        <th width="20%">实际结束日期:</th>
                        <td><input type="text" id="ddTaskActualEndTime" name="ddTaskActualEndTime"
                                   value="${TaskInfo.ddTaskActualEndTime}" class="layui-input"/></td>
                    </tr>
                    <input type="hidden" id="ddTaskId" name="ddTaskId" value="${TaskInfo.ddTaskId}"
                           class="layui-input"/>
                    <input type="hidden" id="ddTaskCreatorId" name="ddTaskCreatorId"
                           value="${TaskInfo.ddTaskCreatorId}" class="layui-input"/>
                    <input type="hidden" id="ddTaskProjectId" name="ddTaskProjectId"
                           value="${TaskInfo.ddTaskProjectId}" class="layui-input"/>
                    <input type="hidden" id="ddTaskCompleteState" name="ddTaskCompleteState"
                           value="${TaskInfo.ddTaskCompleteState}" class="layui-input"/>
                    <input type="hidden" id="ddTaskResourceId" name="ddTaskResourceId"
                           value="${TaskInfo.ddTaskResourceId}" class="layui-input"/>
                    <input type="hidden" id="ddTaskPerson" name="ddTaskPerson"
                           value="${TaskInfo.ddTaskPerson}" class="layui-input"/>
                </table>
            </div>
        </div>
    </div>
</form>
</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
<script>
    $("#personSelect").change(function () {
        var taskPerson = $("#personSelect").find("option:selected").text();
        $("#ddTaskPerson").val(taskPerson);
    });
</script>
</html>
