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
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        $(function () {
            var frm = $('#taskInfoForm').form();
            $("#dataFormSave").click(function () {
                frm.setData();
                frm.ajaxForm(options);
                if (frm.valid()) {
                    form.submit();
                }
            });
        });
    </script>
    <style>
        .panel {
            margin: 0px;
        }

        .panel-heading {
            padding: 10px 15px;
            border-bottom: 1px solid #ddd;
            border-top-left-radius: 1px;
            border-top-right-radius: 1px;
            background-color: #f5f5f5;
        }

        #card1, #card2, #card3 {
            padding-right: 0px;
            padding-left: 0px;
        }

        #row {
            margin-right: 0px !important;
            margin-left: 0px !important;
        }
    </style>
</head>
<body>
<div class="panel">
    <div class="panel-heading">
        111
    </div>
    <div class="panel-body">
        <div class="row" id="row">
            <div class="col-xs-4" id="card1">
                <div class="panel panel-default">
                    <div class="panel-body">
                        执行者
                    </div>
                </div>
            </div>
            <div class="col-xs-4" id="card2">
                <div class="panel panel-default">
                    <div class="panel-body">
                        截止时间
                    </div>
                </div>
            </div>
            <div class="col-xs-4" id="card3">
                <div class="panel panel-default">
                    <div class="panel-body">
                        优先级
                    </div>
                </div>
            </div>
        </div>
        <ul class="list-group">
            <li class="list-group-item"><a>添加备注</a></li>
            <li class="list-group-item"><a>添加子任务</a></li>
            <li class="list-group-item"><a>添加标签</a></li>
            <li class="list-group-item"><a>添加提醒</a></li>
            <li class="list-group-item"><a>里程碑</a></li>
        </ul>
        <div class="panel panel-default">
            <div class="panel-body"><a>动态</a></div>
        </div>
        <%--<form id="taskInfoForm" name="taskInfoForm" method="post" action="save.ht"--%>
        <%--enctype="multipart/form-data">--%>

        <%--<a class="btn btn-default" id="dataFormSave" href="#"> 保存</a>--%>

        <%--<table id="AddHandlingFee" class="table table-striped" cellpadding="0" cellspacing="0"--%>
        <%--border="0"--%>
        <%--type="main">--%>
        <%--<tr>--%>
        <%--<th width="20%">任务名称:</th>--%>
        <%--<td><input type="text" id="ddTaskName" name="ddTaskName"--%>
        <%--value="${TaskInfo.ddTaskName}" class="form-control"/></td>--%>
        <%--<th width="20%">任务所属项目:</th>--%>
        <%--<td><input type="text" id="ddTaskProjectName" name="ddTaskProjectName"--%>
        <%--value="${TaskInfo.ddTaskProjectName}" class="form-control"/></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
        <%--<th width="20%">任务基本描述:</th>--%>
        <%--<td><input type="text" id="ddTaskDescription" name="ddTaskDescription"--%>
        <%--value="${TaskInfo.ddTaskDescription}" class="form-control"/></td>--%>
        <%--<th width="20%">计划工期:</th>--%>
        <%--<td><input type="text" id="ddTaskPlanDuration" name="ddTaskPlanDuration"--%>
        <%--value="${TaskInfo.ddTaskPlanDuration}" class="form-control"/></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
        <%--<th width="20%">任务负责人:</th>--%>
        <%--<td>--%>
        <%--<select name="ddTaskResponsiblePerson" class="form-control"--%>
        <%--id="personSelect">--%>
        <%--<c:forEach var="personItem" items="${sysUserList}">--%>
        <%--<option value="${personItem.userId}"--%>
        <%--<c:if test="${personItem.fullname == TaskInfo.ddTaskPerson}">selected</c:if>>${personItem.fullname}</option>--%>
        <%--</c:forEach>--%>
        <%--</select>--%>
        <%--</td>--%>

        <%--<th width="20%">任务是否固化:</th>--%>
        <%--<td><input type="text" id="ddTaskFixedPattern" name="ddTaskFixedPattern"--%>
        <%--value="${TaskInfo.ddTaskFixedPattern}" class="form-control"/></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
        <%--<th width="20%">任务类型:</th>--%>
        <%--<td><input type="text" id="ddTaskType" name="ddTaskType"--%>
        <%--value="${TaskInfo.ddTaskType}" class="form-control"/></td>--%>
        <%--<th width="20%">任务子类型:</th>--%>
        <%--<td><input type="text" id="ddTaskChildType" name="ddTaskChildType"--%>
        <%--value="${TaskInfo.ddTaskChildType}" class="form-control"/></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
        <%--<th width="20%">优先级:</th>--%>
        <%--<td><input type="text" id="ddTaskPriority" name="ddTaskPriority"--%>
        <%--value="${TaskInfo.ddTaskPriority}" class="form-control"/></td>--%>
        <%--<th width="20%">是否里程碑任务:</th>--%>
        <%--<td><input type="text" id="ddTaskMilestone" name="ddTaskMilestone"--%>
        <%--value="${TaskInfo.ddTaskMilestone}" class="form-control"/></td>--%>
        <%--</tr>--%>

        <%--<tr>--%>
        <%--<th width="20%">任务计划工时:</th>--%>
        <%--<td><input type="text" id="ddTaskEstimateTime" name="ddTaskEstimateTime"--%>
        <%--value="${TaskInfo.ddTaskEstimateTime}" class="form-control"/></td>--%>
        <%--<th width="20%">任务计划开始时间:</th>--%>
        <%--<td><input type="text" id="ddTaskPlanStartTime" name="ddTaskPlanStartTime"--%>
        <%--value="${TaskInfo.ddTaskPlanStartTime}" class="form-control"/></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
        <%--<th width="20%">任务计划结束时间:</th>--%>
        <%--<td><input type="text" id="ddTaskPlanEndTime" name="ddTaskPlanEndTime"--%>
        <%--value="${TaskInfo.ddTaskPlanEndTime}" class="form-control"/></td>--%>
        <%--<th width="20%">任务完成率:</th>--%>
        <%--<td><input type="text" id="ddTaskCompleteRate" name="ddTaskCompleteRate"--%>
        <%--value="${TaskInfo.ddTaskCompleteRate}" class="form-control"/></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
        <%--<th width="20%">实际工时:</th>--%>
        <%--<td><input type="text" id="ddTaskActualTime" name="ddTaskActualTime"--%>
        <%--value="${TaskInfo.ddTaskActualTime}" class="form-control"/></td>--%>
        <%--<th width="20%">计划工时:</th>--%>
        <%--<td><input type="text" id="ddTaskPlanTime" name="ddTaskPlanTime"--%>
        <%--value="${TaskInfo.ddTaskPlanTime}" class="form-control"/></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
        <%--<th width="20%">实际开始日期:</th>--%>
        <%--<td><input type="text" id="ddTaskActualStartTime" name="ddTaskActualStartTime"--%>
        <%--value="${TaskInfo.ddTaskActualStartTime}" class="form-control"/></td>--%>
        <%--<th width="20%">实际结束日期:</th>--%>
        <%--<td><input type="text" id="ddTaskActualEndTime" name="ddTaskActualEndTime"--%>
        <%--value="${TaskInfo.ddTaskActualEndTime}" class="form-control"/></td>--%>
        <%--</tr>--%>
        <%--<input type="hidden" id="ddTaskId" name="ddTaskId" value="${TaskInfo.ddTaskId}"--%>
        <%--class="layui-input"/>--%>
        <%--<input type="hidden" id="ddTaskCreatorId" name="ddTaskCreatorId"--%>
        <%--value="${TaskInfo.ddTaskCreatorId}" class="layui-input"/>--%>
        <%--<input type="hidden" id="ddTaskProjectId" name="ddTaskProjectId"--%>
        <%--value="${TaskInfo.ddTaskProjectId}" class="layui-input"/>--%>
        <%--<input type="hidden" id="ddTaskCompleteState" name="ddTaskCompleteState"--%>
        <%--value="${TaskInfo.ddTaskCompleteState}" class="layui-input"/>--%>
        <%--<input type="hidden" id="ddTaskResourceId" name="ddTaskResourceId"--%>
        <%--value="${TaskInfo.ddTaskResourceId}" class="layui-input"/>--%>
        <%--<input type="hidden" id="ddTaskPerson" name="ddTaskPerson"--%>
        <%--value="${TaskInfo.ddTaskPerson}" class="layui-input"/>--%>
        <%--</table>--%>

        <%--</form>--%>
    </div>
    <div class="panel-footer">
        333
    </div>
</div>

</body>

<script>
    $("#personSelect").change(function () {
        var taskPerson = $("#personSelect").find("option:selected").text();
        $("#ddTaskPerson").val(taskPerson);
    });
</script>
</html>
