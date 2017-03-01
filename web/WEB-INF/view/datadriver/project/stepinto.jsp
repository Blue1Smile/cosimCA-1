<%--
  Created by IntelliJ IDEA.
  User: d
  Date: 2017/1/19
  Time: 上午10:51
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="hotent" uri="http://www.jee-soft.cn/paging" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html lang="zh-CN" style="height: 100%; margin: 0px">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />

    <title>进入任务页面</title>
    <%--<%@include file="/commons/include/get.jsp" %>--%>
    <%--<link rel="stylesheet" href="${ctx}/resources/skin/base.css"/>--%>
    <%--<link rel="stylesheet" href="${ctx}/resources/skin/content.css"/>--%>
    <%--<link rel="stylesheet" href="${ctx}/resources/skin/blue.css"/>--%>
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/slide/css/default.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/slide/css/component.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/newtable/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/check/font-awesome.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/check/build.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/fourpanel/fourpanel.css"/>
    <script src="${ctx}/newtable/jquery.js"></script>
    <script src="${ctx}/styles/slide/js/modernizr.custom.js"></script>
    <script src="${ctx}/newtable/bootstrap.js"></script>
    <script src="${ctx}/styles/layui/jquery.dragsort-0.5.2.min.js"></script>
</head>
<body style="height: 100%; margin: 0px">
<div class="container-fluid" style="height: 100%">
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                ${Project.ddProjectName} <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
                <c:forEach var="projectListbyUserItem" items="${projectListbyUser}">
                    <li>
                        <a href="stepinto.ht?id=${projectListbyUserItem.ddProjectId}">${projectListbyUserItem.ddProjectName}</a>
                    </li>
                </c:forEach>
            </ul>
        </li>
        <li role="presentation" class="active" id="switch_attr_task"><a href="#task" data-toggle="tab" role="tab">任务</a>
        </li>
        <li role="presentation" id="switch_attr_index"><a href="#indextab" data-toggle="tab" role="tab">指标</a></li>
        <li role="presentation"><a href="#calendar" data-toggle="tab" role="tab" title="暂不可用">日程</a></li>
        <div class="pull-right">
            <%--<a id="statis_btn" class="btn btn-warning" data-toggle="modal"--%>
               <%--data-remote="statis.ht?id=${Project.ddProjectId}"--%>
               <%--data-target="#statis"><span class="glyphicon glyphicon-stats"></span> 统计--%>
            <%--</a>--%>
            <a id="statis_btn" class="btn btn-warning" onclick="showStatis(${Project.ddProjectId})"><span class="glyphicon glyphicon-stats"></span> 流程统计</a>
            <%--<a class="btn btn-success" href="#" data-toggle="modal" id="create_task"--%>
               <%--data-remote="${ctx}/datadriver/task/addtask.ht?id=${Project.ddProjectId}"--%>
               <%--data-target="#addtask"><span class="glyphicon glyphicon-plus"></span> 创建任务</a>--%>
            <a class="btn btn-success" href="#" id="create_task" onclick="createTask(${Project.ddProjectId})"><span class="glyphicon glyphicon-plus"></span> 创建任务</a>

            <%--<a class="btn btn-info" href="#" data-toggle="modal" id="create_index"--%>
               <%--data-remote="${ctx}/datadriver/index/indexedit.ht?id=${Project.ddProjectId}"--%>
               <%--data-target="#addindex1"><span class="glyphicon glyphicon-plus"></span> 创建指标</a>--%>
            <a class="btn btn-info" href="#" id="create_index" onclick="createIndex(${Project.ddProjectId})"><span class="glyphicon glyphicon-plus"></span> 创建指标</a>
        </div>
    </ul>

    <br>
    <div class="tab-content board-view">
        <div role="tabpanel" class="tab-pane active board-scrum-view" id="task" style="height: 100%">
            <div class="row paneldocker" style="height: 100%">
                <div class="col-xs-3" style="height: 100%">
                    <div class="panel panel-default task-panel">
                        <div class="panel-heading">
                            新创建
                        </div>
                        <div class="panel-body panelheight" style="overflow-y:auto; overflow-x: hidden;">
                            <ul id="createpanel" class="scrum-stage-tasks">
                                <c:forEach var="taskListbyUserItem" items="${taskListbyUser}">
                                    <li class="task task-card ui-sortable-handle "
                                        onclick="showTaskContent(${taskListbyUserItem.ddTaskId})">
                                        <%--<div class="checkbox checkbox-primary">--%>
                                            <%--<input id="${taskListbyUserItem.ddTaskId}" type="checkbox">--%>
                                            <%--<label for="${taskListbyUserItem.ddTaskId}">--%>
                                                    <%--${taskListbyUserItem.ddTaskName}--%>
                                            <%--</label>--%>
                                        <%--</div>--%>
                                                ${taskListbyUserItem.ddTaskName}
                                        <input value="${taskListbyUserItem.ddTaskId}" type="hidden">
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3" style="height: 100%">
                    <div class="panel panel-info task-panel">
                        <div class="panel-heading">
                            已发布
                        </div>
                        <div class="panel-body panelheight" style="overflow-y:auto; overflow-x: hidden">
                            <ul id="publishpanel" class="scrum-stage-tasks">
                                <c:forEach var="publishtaskListbyUserItem" items="${publishtaskListbyUser}">
                                    <li class="task task-card ui-sortable-handle"
                                        onclick="showTaskContent(${publishtaskListbyUserItem.ddTaskId})">
                                        <%--<div class="checkbox checkbox-primary">--%>
                                            <%--<input id="${publishtaskListbyUserItem.ddTaskId}" type="checkbox">--%>
                                            <%--<label for="${publishtaskListbyUserItem.ddTaskId}">--%>
                                                    <%--${publishtaskListbyUserItem.ddTaskName}--%>
                                            <%--</label>--%>
                                        <%--</div>--%>
                                                ${publishtaskListbyUserItem.ddTaskName}
                                        <input value="${publishtaskListbyUserItem.ddTaskId}" type="hidden">
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3" style="height: 100%">
                    <div class="panel panel-success task-panel">
                        <div class="panel-heading">
                            待审核
                        </div>
                        <div class="panel-body panelheight" style="overflow-y:auto; overflow-x: hidden">
                            <ul id="checkpanel" class="scrum-stage-tasks">
                                <c:forEach var="checkTaskInfoListItem" items="${checkTaskInfoList}">
                                    <li class="task task-card ui-sortable-handle"
                                        onclick="showTaskContent(${checkTaskInfoListItem.ddTaskId})">
                                        <%--<div class="checkbox checkbox-primary">--%>
                                            <%--<input id="${checkTaskInfoListItem.ddTaskId}" type="checkbox">--%>
                                            <%--<label for="${checkTaskInfoListItem.ddTaskId}">--%>
                                                    <%--${checkTaskInfoListItem.ddTaskName}--%>
                                            <%--</label>--%>
                                        <%--</div>--%>
                                                ${checkTaskInfoListItem.ddTaskName}
                                        <input value="${checkTaskInfoListItem.ddTaskId}" type="hidden">
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3" style="height: 100%">
                    <div class="panel panel-warning task-panel">
                        <div class="panel-heading">
                            已完成
                        </div>
                        <div class="panel-body panelheight" style="overflow-y:auto; overflow-x: hidden;">
                            <ul id="completepanel" class="scrum-stage-tasks">
                                <c:forEach var="completeTaskInfoListItem" items="${completeTaskInfoList}">
                                    <li class="task task-card ui-sortable-handle"
                                        onclick="showTaskContent(${completeTaskInfoListItem.ddTaskId})">
                                        <%--<div class="checkbox checkbox-primary">--%>
                                            <%--<input id="${completeTaskInfoListItem.ddTaskId}" type="checkbox">--%>
                                            <%--<label for="${completeTaskInfoListItem.ddTaskId}">--%>
                                                    <%--${completeTaskInfoListItem.ddTaskName}--%>
                                            <%--</label>--%>
                                        <%--</div>--%>
                                                ${completeTaskInfoListItem.ddTaskName}
                                        <input value="${completeTaskInfoListItem.ddTaskId}" type="hidden">
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div role="tabpanel" class="tab-pane" id="indextab">
        </div>
        <div role="tabpanel" class="tab-pane" id="calendar">
            <%--<iframe src="${ctx}/platform/calendar/calendar.ht" style="height: 600px"></iframe>--%>
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
<%--index--%>
<div class="modal fade" id="addindex1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

        </div>
    </div>
</div>
<%--统计--%>
<div class="modal fade" id="statis" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">

        </div>
    </div>
</div>
<%--任务详细--%>
<div class="modal fade" id="taskdetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="overflow: auto" id="taskdetailcontent">

        </div>
    </div>
</div>
</body>
<script src="${ctx}/styles/slide/js/classie.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#createpanel,#publishpanel").dragsort({
            itemSelector: "li",
            dragSelector: "li",
            dragBetween: true,
            dragEnd: saveOrder,
            placeHolderTemplate: '<li class="task task-card ui-sortable-handle dropdown-color"></li>'
        });

        $("#checkpanel,#completepanel").dragsort({
            itemSelector: "li",
            dragSelector: "li",
            dragBetween: true,
            dragEnd: saveOrder,
            placeHolderTemplate: '<li class="task task-card ui-sortable-handle dropdown-color"></li>'
        });

        function saveOrder() {
            var data = $(this).children('input').val();
            var parentid = $(this).parent().attr("id");
            $.post("movetask.ht?id=" + data + "&parent=" + parentid);
        }
        $("#create_task").show();
        $("#create_index").hide();
    });

    var switch_attr_index = document.getElementById('switch_attr_index'),
            switch_attr_task = document.getElementById('switch_attr_task');
//显示任务详情
    function showTaskContent(taskId) {
        $('#taskdetail').modal({
            keyboard: true,
            remote: "${ctx}/datadriver/task/edit.ht?id=" + taskId
        });}
    //创建任务
    function createTask(projectId) {
        $('#addtask').modal({
            keyboard: true,
            remote: "${ctx}/datadriver/task/addtask.ht?id=" + projectId
        });}
    //创建指标
    function createIndex(projectId) {
        $('#addindex1').modal({
            keyboard: true,
            remote: "${ctx}/datadriver/index/indexedit.ht?id=" + projectId
        });}
    //监控信息
    function showStatis(projectId){
        $('#statis').modal({
            keyboard: true,
            remote: "statis.ht?id=" + projectId
        });}
    //关闭任务详情模态框
    $("#taskdetail").on("hidden.bs.modal", function() {
        $(this).removeData("bs.modal");
    });
    //关闭任务详情模态框
//    $("#addindex1").on("hidden.bs.modal", function() {
//        $(this).removeData("bs.modal");
//    });
    //关闭统计模态框
    $("#statis").on("hidden.bs.modal", function() {
        $(this).removeData("bs.modal");
    });
    switch_attr_index.onclick = function () {
        $("#create_task").hide();
        $("#create_index").show();
        $.get("${ctx}/datadriver/index/indexlist.ht?id=${Project.ddProjectId}", function (data) {
            $('#indextab').html(data);
        });
    }
    switch_attr_task.onclick = function () {
        $("#create_index").hide();
        $("#create_task").show();
    }
</script>
</html>
