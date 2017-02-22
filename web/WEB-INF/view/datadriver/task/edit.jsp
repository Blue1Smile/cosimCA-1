<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html style="height: 100%;">
<head>
    <title>任务基础信息添加</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <%--<%@include file="/commons/include/form.jsp" %>--%>
    <%--<script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>--%>
    <%--<script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>--%>
    <%--<script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>--%>

    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/newtable/bootstrap-editable.css">
    <link href="${ctx}/styles/check/build.css" rel="stylesheet" type="text/css"/>

    <script src="${ctx}/newtable/bootstrap-editable.js"></script>
    <script src="${ctx}/timeselect/moment.js"></script>
    <style>
        .panel {
            margin: 0px;
            height: 100%;
        }

        #card1, #card2, #card3 {
            padding-right: 2px;
            padding-left: 2px;
        }

        #row {
            margin: 5px !important;
        }

        .detail-info {
            margin-bottom: 4px;
        }

        .task-info-title {
            margin: 5px 16px 10px;
            line-height: 12px;
            color: grey;
        }

        .panel .card {
            background: #FFFFFF;
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

        .activities-list {
            padding: 0;
            position: relative;
        }

        .activity {
            position: relative;
            overflow: hidden;
            margin: 15px;
        }

        .activity .activity-type-icon {
            width: 36px;
            text-align: center;
            font-size: 16px;
        }

        .activity .activity-body-coyness {
            font-size: 12px;
            margin: 0 0 0 46px;
        }

        .muted {
            color: #A6A6A6;
        }
    </style>
</head>
<body style="height: 100%; margin: 0px;">
<div class="panel panel-primary">
    <div class="panel-heading">
        ${TaskInfo.ddTaskName}
        <div class="btn-group pull-right">
            <button type="button" class="btn btn-xs btn-primary dropdown-toggle" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false">
                更多 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu dropdown-menu-right">
                <li><a href="#">
                    <center>任务菜单</center>
                </a></li>
                <li role="separator" class="divider"></li>
                <li><a href="#"><span class="glyphicon glyphicon-download-alt"></span> 固化</a></li>
                <li><a href="${ctx}/datadriver/task/del.ht?id=${TaskInfo.ddTaskId}"><span
                        class="glyphicon glyphicon-trash"></span> 删除</a></li>
            </ul>
        </div>
    </div>
    <div class="panel-body" style="overflow: auto">
        <div class="row" id="row">
            <div class="col-xs-4" id="card1">
                <div class="panel panel-default">
                    <div class="panel-body card">
                        <h5 class="task-info-title">
                            执行者
                        </h5>
                        <a class="task-detail-executor" id="executorSelect" data-type="select" data-pk="1" href="#">
                            ${executorName.fullname}
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
                        <a class="task-detail-executor" href="#" id="dob" data-type="combodate" data-pk="1"
                           data-value="2017年12月10日">
                            <%--<span class="glyphicon glyphicon-calendar"></span>--%>
                            ${endtime}</a>
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
                           href="#">
                            <c:choose>
                                <c:when test="${TaskInfo.ddTaskPriority==3}"><span
                                        class="label label-danger">紧急</span></c:when>
                                <c:when test="${TaskInfo.ddTaskPriority==2}"><span
                                        class="label label-warning">重要</span></c:when>
                                <c:otherwise><span class="label label-primary">一般</span></c:otherwise>
                            </c:choose>
                            点击设置
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" id="row">
            <div class="panel panel-default">
                <div class="list-group">
                    <a class="list-group-item" href="#" id="comments" data-type="textarea" data-pk="1" href="#">
                        <c:choose>
                            <c:when test="${empty TaskInfo.ddTaskDescription}">
                                <h5 class="task-info-title">添加描述</h5>
                            </c:when>
                            <c:otherwise>
                                <p>${TaskInfo.ddTaskDescription}</p>
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <a class="list-group-item" href="#">添加子任务</a>
                    <a class="list-group-item" href="#">添加标签</a>
                    <a class="list-group-item" href="#">里程碑
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
        <div class="row" id="row">
            <div class="panel panel-default">
                <div class="panel-body"><h5 class="task-info-title">活动</h5>
                    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                        <%--<div class="panel panel-default">--%>
                        <%--<div class="panel-heading" role="tab" id="headingOne">--%>
                        <%--<h5 class="panel-title">--%>
                        <%--<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne"--%>
                        <%--aria-expanded="true" aria-controls="collapseOne">--%>
                        <%--基本动态--%>
                        <%--</a>--%>
                        <%--</h5>--%>
                        <%--</div>--%>
                        <%--<div id="collapseOne" class="panel-collapse collapse in" role="tabpanel"--%>
                        <%--aria-labelledby="headingOne">--%>
                        <%--<div class="panel-body">--%>
                        <%--<ul class="activities-list">--%>
                        <%--<li class="activity">--%>
                        <%--<span class="glyphicon glyphicon-pencil pull-left activity-type-icon muted"></span>--%>
                        <%--<div class="activity-body-coyness muted pull-right"><span>2017年1月16日</span>--%>
                        <%--</div>--%>
                        <%--<div class="activity-body-coyness muted">--%>
                        <%--<span>设计师一 更新了 截止时间</span>--%>
                        <%--</div>--%>
                        <%--</li>--%>
                        <%--<li class="activity">--%>
                        <%--<span class="glyphicon glyphicon-pencil pull-left activity-type-icon muted"></span>--%>
                        <%--<div class="activity-body-coyness muted pull-right"><span>2017年1月22日</span>--%>
                        <%--</div>--%>
                        <%--<div class="activity-body-coyness muted">--%>
                        <%--<span>设计师一 更新了 优先级</span>--%>
                        <%--</div>--%>
                        <%--</li>--%>
                        <%--</ul>--%>
                        <%--</div>--%>
                        <%--</div>--%>
                        <%--</div>--%>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingTwo">
                                <h5 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion"
                                       href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                        订阅数据
                                    </a>
                                </h5>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel"
                                 aria-labelledby="headingTwo">
                                <div class="panel-body">
                                    <ul class="activities-list">
                                        <c:forEach items="${orderDataList}" var="orderDataItem">
                                            <li class="activity">
                                                <span class="glyphicon glyphicon-pencil pull-left activity-type-icon muted"></span>
                                                <div class="activity-body-coyness muted pull-right">
                                                    <span>${privateDataItem.ddDataCreateTime}</span>
                                                </div>
                                                <div class="activity-body-coyness muted">
                                                    <span>订阅了 ${orderDataItem.ddDataName} 来自 ${orderDataItem.ddTaskId}</span>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingThree">
                                <h5 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion"
                                       href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                        发布数据
                                    </a>
                                </h5>
                            </div>
                            <div id="collapseThree" class="panel-collapse collapse" role="tabpanel"
                                 aria-labelledby="headingThree">
                                <div class="panel-body">
                                    <ul class="activities-list">
                                        <c:forEach items="${publishDataList}" var="publishDataItem">
                                            <li class="activity">
                                                <span class="glyphicon glyphicon-pencil pull-left activity-type-icon muted"></span>
                                                <div class="activity-body-coyness muted pull-right">
                                                    <span>${privateDataItem.ddDataCreateTime}</span>
                                                </div>
                                                <div class="activity-body-coyness muted">
                                                    <span>本任务 发布了 ${publishDataItem.ddDataName}</span>
                                                </div>
                                            </li>

                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
    <div class="panel-footer" style="position: relative; width: 100%; bottom: 1px;">
        <div class="input-group">
            <input type="text" class="form-control" placeholder="输入@选择提醒人员">
            <span class="input-group-btn">
                <button class="btn btn-success" type="button">发送</button>
            </span>
        </div><!-- /input-group -->
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
            type: 'post',
            url: "${ctx}/datadriver/task/onchangetaskinfo.ht?taskId=${TaskInfo.ddTaskId}",
            data: {strJson: JSON.stringify(curRow)}
//                    success: function (data, textStatus, jqXHR) {
//                        alert('保存成功！');
//                    },
//                    error: function () { alert("error");}
        });
    }
    $(function () {
        $('#executorSelect').editable({
            showbuttons: false,
            value: ${executorName.userId},
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
                {value: 3, text: '紧急'},
                {value: 2, text: '重要'},
                {value: 1, text: '一般'}
            ],
            url: function (params) {
                taskItem = 1;
                onChangeTaskInfo(params, taskItem);
            }
        });

        $('#dob').editable({
            showbuttons: true,
            placement: 'bottom',
            format: 'YYYY-MM-DD',
            viewformat: 'YYYY年 MM月 DD日',
            template: 'YYYY年 MMMM月 DD日',
            combodate: {
                minYear: 2000,
                maxYear: 2030,
                minuteStep: 1
            },
            url: function (params) {
                taskItem = 2;
                onChangeTaskInfo(params, taskItem);
            }
        });
        $('#comments').editable({
            showbuttons: true,
            placement: 'bottom',
            rows: 5,
            url: function (params) {
                taskItem = 3;
                onChangeTaskInfo(params, taskItem);
            }
        });

    })
    ;
</script>
</html>
