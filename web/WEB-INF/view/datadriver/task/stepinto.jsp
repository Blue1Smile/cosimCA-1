<%--
  Created by IntelliJ IDEA.
  User: d
  Date: 2017/1/19
  Time: 上午10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
    <title>进入数据页面</title>
    <%@include file="/commons/include/get.jsp" %>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/styles/check/font-awesome.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/styles/check/build.css" rel="stylesheet" type="text/css"/>
    <script src="${ctx}/newtable/jquery.js"></script>
    <script src="${ctx}/newtable/bootstrap.js"></script>
    <script src="${ctx}/styles/layui/jquery.dragsort-0.5.2.min.js"></script>
    <style>
        .scrum-stage .task.task-card {
            margin: 0 8px 8px;
        }

        .task.task-card {
            padding: 0;
            background-color: #fff;
            border-radius: 3px;
            box-shadow: 0 1px 2px rgba(0, 0, 0, .1);
            cursor: pointer;
            margin-left: -42px;
        }

        .checkbox label {
            margin: 12px;
        }

        li {
            list-style-type: none;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                ${TaskInfo.ddTaskName} <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
                <c:forEach var="taskListItem" items="${taskList}">
                    <li><a href="#">${taskListItem.ddTaskName}</a></li>
                </c:forEach>
            </ul>
        </li>
        <li role="presentation" class="active"><a href="#task" data-toggle="tab" role="tab">数据</a></li>
        <li role="presentation" id="switch_attr_index"><a href="#index" data-toggle="tab" role="tab">任务概述</a></li>
        <li role="presentation" id="switch_attr_calendar"><a href="#calendar" data-toggle="tab" role="tab">更新发布</a></li>
        <li role="presentation" id="switch_attr_three"><a href="#index" data-toggle="tab" role="tab">查看订阅</a></li>
        <li role="presentation" id="switch_attr_four"><a href="#calendar" data-toggle="tab" role="tab">任务工具</a></li>
        <%--<li role="presentation" class="active"><a href="#date" data-toggle="tab" role="tab">数据</a></li>--%>
        <%--<li role="presentation" ><a href="${ctx}/datadriver/personaltask/dashboard.ht?id=${TaskInfo.ddTaskId}#index" data-toggle="tab" role="tab">更新发布</a></li>--%>
        <%--<li role="presentation" ><a href="${ctx}/datadriver/personaltask/submitpublish.ht?id=${TaskInfo.ddTaskId}#calendar" data-toggle="tab" role="tab">查看订阅</a></li>--%>

        <div class="pull-right">
            <button id="static" class="btn btn-warning"><span class="glyphicon glyphicon-stats"></span> 统计</button>
            <%--<a class="btn btn-success" href="" data-toggle="modal"--%>
               <%--data-remote="${ctx}/datadriver/privatedata/edit.ht?id=${TaskInfo.ddTaskId}"--%>
               <%--data-target="#adddata"><span class="glyphicon glyphicon-plus"></span> 新建数据</a>--%>
            <a class="btn btn-success" id="newData" href="${ctx}/datadriver/privatedata/edit.ht?id=${TaskInfo.ddTaskId}">新建数据</a>
        </div>
        </div>
    </ul>

    <br>
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="task">
            <div class="row">
                <div class="col-xs-3">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            未发布
                        </div>
                        <%--<div class="panel-body">--%>
                            <%--<ul id="createpanel" class="scrum-stage-tasks">--%>
                                <%--<c:forEach var="taskListbyUserItem" items="${taskListbyUser}">--%>
                                    <%--<li class="task task-card ui-sortable-handle" id="showRightPush"--%>
                                        <%--onclick="showTaskContent(this ,${taskListbyUserItem.ddTaskId})">--%>
                                        <%--<div class="checkbox checkbox-primary">--%>
                                            <%--<input id="${taskListbyUserItem.ddTaskId}" type="checkbox">--%>
                                            <%--<label for="${taskListbyUserItem.ddTaskId}">--%>
                                                    <%--${taskListbyUserItem.ddTaskName}--%>
                                            <%--</label>--%>
                                        <%--</div>--%>
                                        <%--<input type="hidden" value="${taskListbyUserItem.ddTaskId}" name="release"/>--%>
                                    <%--</li>--%>
                                <%--</c:forEach>--%>
                            <%--</ul>--%>
                        <%--</div>--%>
                        <div class="panel-body">
                            <ul id="privatepanel" class="scrum-stage-tasks">
                                <c:forEach var="privateDataListbyTaskItem" items="${privateDataListbyTask}">
                                    <li class="task task-card ui-sortable-handle" id="showRightPush"
                                        onclick="showTaskContent(this ,${privateDataListbyTaskItem.ddDataId})">
                                        <div class="checkbox checkbox-primary">
                                            <input id="checkbox2" class="styled" type="checkbox">
                                            <label for="${privateDataListbyTaskItem.ddDataId}">
                                                    ${privateDataListbyTaskItem.ddDataName}
                                            </label>
                                        </div>
                                        <input type="hidden" value="${privateDataListbyTaskItem.ddDataId}" name="release"/>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="publishpanel panel-primary">
                        <div class="panel-heading">
                            已发布
                        </div>
                        <div class="panel-body">
                            <%--<form id="publishDataForm" method="post" action="savepublish.ht">--%>
                                <%--<input type="submit" class="layui-btn layui-btn-small" value="提交">--%>
                            <ul id="publishpanel" class="scrum-stage-tasks">
                                <c:forEach var="publishDataListbyUserItem" items="${publishDataList}">
                                    <li class="task task-card ui-sortable-handle" id="showRightPush"
                                        onclick="showTaskContent(this ,${publishDataListbyUserItem.ddDataId})">
                                        <div class="checkbox checkbox-primary">
                                            <input id="checkbox" class="styled" type="checkbox">
                                            <label for="${publishDataListbyUserItem.ddDataId}">
                                                    ${publishDataListbyUserItem.ddDataName}
                                            </label>
                                        </div>
                                        <input type="hidden" value="${publishDataListbyUserItem.ddDataId}" name="release"/>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            可订阅数据
                        </div>
                        <div class="panel-body">
                            <ul id="canorderpanel" class="scrum-stage-tasks">
                                <c:forEach var="canBeOrderPrivatedataListItem" items="${canBeOrderPrivatedataList}">
                                    <li class="task task-card ui-sortable-handle">
                                        <div class="checkbox checkbox-primary">
                                            <input id="checkbox3" class="styled" type="checkbox">
                                            <label for="checkbox3">
                                                    ${canBeOrderPrivatedataListItem.ddDataName}
                                            </label>
                                        </div>
                                        <input type="hidden" value="${canBeOrderPrivatedataListItem.ddDataId}" name="release"/>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="panel panel-warning">
                        <div class="panel-heading">
                            已订阅数据
                        </div>
                        <div class="panel-body">
                            <ul id="orderpanel" class="scrum-stage-tasks">
                                <c:forEach var="OrderPrivatedataListItem" items="${OrderPrivatedataList}">
                                    <li class="task task-card ui-sortable-handle">
                                        <div class="checkbox checkbox-primary">
                                            <input id="checkbox4" class="styled" type="checkbox">
                                            <label for="checkbox4">
                                                    ${OrderPrivatedataListItem.ddDataName}
                                            </label>
                                        </div>
                                        <input type="hidden" value="${OrderPrivatedataListItem.ddDataId}" name="release"/>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div role="tabpanel" class="tab-pane" id="index">
        </div>
        <div role="tabpanel" class="tab-pane" id="calendar">
        </div>
        <div role="tabpanel" class="tab-pane" id="three">
        </div>
        <div role="tabpanel" class="tab-pane" id="four">
        </div>
    </div>
</div>
<%--任务创建--%>
<div class="modal fade" id="addtask" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">

        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        $("#privatepanel,#publishpanel").dragsort({
            itemSelector: "li",
            dragSelector: "li",
            dragBetween: true,
            dragEnd: savePublish,
            placeHolderTemplate: '<li class="task task-card ui-sortable-handle"></li>'
        });
        function savePublish() {
            var data = $(this).children('input').val();
            var parentid = $(this).parent().attr("id");
            $.get("savepublishdata.ht?id=" + data + "&parent=" + parentid + "&taskId=${TaskInfo.ddTaskId}");
//            $.get("createtopublish.ht?id=" + data + "&parent=" + parentid);
        }
    });
    switch_attr_index.onclick = function () {
        $("#create_task").hide();
        $("#create_index").show();
        $.get("${ctx}/datadriver/personaltask/dashboard.ht?id=${TaskInfo.ddTaskId}", function (data) {
            $('#index').html(data);
        });
    }
    switch_attr_calendar.onclick = function () {
        $("#create_task").hide();
        $("#create_calendar").show();
        $.get("${ctx}/datadriver/personaltask/submitpublish.ht?id=${TaskInfo.ddTaskId}", function (data) {
            $('#calendar').html(data);
        });
    }
    switch_attr_three.onclick = function () {
        $("#create_task").hide();
        $("#create_three").show();
        $.get("${ctx}/datadriver/personaltask/showorder.ht?id=${taskInfo.ddTaskId}", function (data) {
            $('#three').html(data);
        });
    }
    switch_attr_four.onclick = function () {
        $("#create_task").hide();
        $("#create_four").show();
        $.get("", function (data) {
            $('#four').html(data);
        });
    }

</script>
</html>
