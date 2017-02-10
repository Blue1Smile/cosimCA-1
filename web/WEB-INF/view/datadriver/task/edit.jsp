<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@page import="com.hotent.core.util.ContextUtil" %>
<html style="height: 100%;">
<head>
    <title>任务基础信息添加</title>
    <%@include file="/commons/include/form.jsp" %>
    <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
    <script src="${ctx}/newtable/jquery.js"></script>
    <script src="${ctx}/newtable/bootstrap.js"></script>

    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/newtable/bootstrap-editable.css">
    <link href="${ctx}/styles/check/build.css" rel="stylesheet" type="text/css"/>
    <%--<script type="text/javascript">--%>
    <%--$(function () {--%>
    <%--var frm = $('#taskInfoForm').form();--%>
    <%--$("#dataFormSave").click(function () {--%>
    <%--frm.setData();--%>
    <%--frm.ajaxForm(options);--%>
    <%--if (frm.valid()) {--%>
    <%--form.submit();--%>
    <%--}--%>
    <%--});--%>
    <%--});--%>
    <%--</script>--%>
    <script src="${ctx}/newtable/bootstrap-editable.js"></script>
    <style>
        .panel {
            margin: 0px;
            height: 100%;
        }

        .panel-heading {
            padding: 10px 15px;
            border-bottom: 1px solid #ddd;
            border-top-left-radius: 1px;
            border-top-right-radius: 1px;
            background-color: #f5f5f5;
        }

        #card1, #card2, #card3 {
            padding-right: 2px;
            padding-left: 2px;
        }

        #row {
            margin-right: 0px !important;
            margin-left: 0px !important;
        }

        button.panel-button {
            -webkit-appearance: none;
            padding: 0;
            cursor: pointer;
            background: transparent;
            border: 0;
        }

        .detail-info {
            margin-bottom: 4px;
        }

        .panel-button {
            float: right;
            font-size: 14px;
            font-weight: bold;
            line-height: 1;
            color: #000;
            text-shadow: 0 1px 0 #fff;
            filter: alpha(opacity=20);
            opacity: .2;
        }

        .task-info-title {
            margin: 5px 16px 10px;
            line-height: 12px;
            color: grey;
        }

        .card .task-detail-executor {
            margin: 10px 16px 14px;
            line-height: 24px;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .editable-pre-wrapped {
            white-space: normal !important;
        }

    </style>
</head>
<body style="height: 100%; margin: 0px;">
<div class="panel">
    <div class="panel-heading">
        <%--<button type="button" class="panel-button">更多<span aria-hidden="true" class="glyphicon glyphicon-chevron-down"></span></button>--%>
        ${TaskInfo.ddTaskName}
        <div class="btn-group" style="float: right">
            <button type="button" class="panel-button dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
                    aria-expanded="false">
                更多 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu dropdown-menu-right">
                <center>任务菜单</center>
                <li role="separator" class="divider"></li>
                <li><a href="#"><span class="glyphicon glyphicon-download-alt"></span> 固化</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-trash"></span> 删除</a></li>
            </ul>
        </div>
    </div>
    <div class="panel-body">
        <div class="col-xs-12 detail-info">
            <div class="row" id="row">
                <div class="col-xs-4" id="card1">
                    <div class="panel panel-default">
                        <div class="panel-body card">
                            <h5 class="task-info-title">
                                执行者
                            </h5>
                            <a class="task-detail-executor" id="executorSelect" data-type="select" data-pk="1">
                                ${executorName}
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-xs-4" id="card2">
                    <div class="panel panel-default">
                        <div class="panel-body card">
                            <h5 class="task-info-title">
                                截止时间
                            </h5>

                            <a class="task-detail-executor" id="dob" data-type="date" data-pk="1" data-url="/post"><span
                                    class="glyphicon glyphicon-calendar"></span>点击设置</a>
                        </div>
                    </div>
                </div>
                <div class="col-xs-4" id="card3">
                    <div class="panel panel-default">
                        <div class="panel-body card">
                            <h5 class="task-info-title">
                                优先级
                            </h5>

                            <a class="task-detail-executor" id="taskPrioritySelect" data-type="select" data-pk="1"
                               data-url="/post">
                                <span class="label label-danger">紧急</span>
                                点击设置
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xs-12 detail-info">
            <div class="panel panel-default">
                <div class="list-group">
                    <a class="list-group-item" href="#" id="comments" data-type="textarea" data-pk="1">
                        <c:choose>
                            <c:when test="${empty TaskInfo.ddTaskDescription}">
                                <h5 class="task-info-title">添加描述</h5>
                            </c:when>
                            <c:otherwise>
                                <p>${TaskInfo.ddTaskDescription}</p>
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <a class="list-group-item">添加子任务</a>
                    <a class="list-group-item">添加标签</a>
                    <a class="list-group-item">里程碑
                        <div class="radio radio-info radio-inline">
                            <input type="radio" name="ddTaskMilestone" id="ddTaskMilestone1" value="1" checked>
                            <label for="ddTaskMilestone1">
                                是
                            </label>
                        </div>
                        <div class="radio radio-info radio-inline">
                            <input type="radio" name="ddTaskMilestone" id="ddTaskMilestone0" value="0">
                            <label for="ddTaskMilestone0">
                                否
                            </label>
                        </div>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-xs-12">
            <div class="panel panel-default">
                <div class="panel-body"><a>动态</a></div>
            </div>
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
    var curRow = {};
    var taskItem = 0;
    $("#personSelect").change(function () {
        var taskPerson = $("#personSelect").find("option:selected").text();
        $("#ddTaskPerson").val(taskPerson);
    });

    function onChangeTaskInfo(params, taskItem) {
        curRow[taskItem] = params.value;
        $.ajax({
            type: 'get',
            url: "onchangetaskinfo.ht?taskId=${TaskInfo.ddTaskId}",
            data: { strJson: JSON.stringify(curRow) }
//                    success: function (data, textStatus, jqXHR) {
//                        alert('保存成功！');
//                    },
//                    error: function () { alert("error");}
        });
    }
    $(function () {
        $('#executorSelect').editable({
            showbuttons: false,
            value: ${TaskInfo.ddTaskResponsiblePerson},
            placement: 'bottom',
            source: [
                <c:forEach var="personItem" items="${sysUserList}">
                {value: ${personItem.userId}, text: '${personItem.fullname}'},
                </c:forEach>
            ],

            url: function (params) {
                taskItem = 0;
                onChangeTaskInfo(params, taskItem);
            }
        });
        $('#taskPrioritySelect').editable({
            showbuttons: false,
            value: 1,
            placement: 'left',
            source: [
                {value: 1, text: '紧急'},
                {value: 2, text: '重要'},
                {value: 3, text: '一般'}
            ],
            url: function (params) {
                taskItem = 1;
                onChangeTaskInfo(params, taskItem);
            }
        });

        $('#dob').editable({
            showbuttons: false,
            placement: 'bottom',
            format: 'yyyy-mm-dd',
            viewformat: 'dd/mm/yyyy',
            datepicker: {
                weekStart: 1
            },
            url: function (params) {
                taskItem = 2;
                onChangeTaskInfo(params, taskItem);
            }
        });
        $('#comments').editable({
            showbuttons: false,
            placement: 'bottom',
            rows: 5,
            url: function (params) {
                taskItem = 3;
                onChangeTaskInfo(params, taskItem);
            }
        });

    });
</script>
</html>
