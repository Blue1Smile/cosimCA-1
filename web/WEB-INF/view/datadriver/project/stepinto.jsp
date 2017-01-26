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
    <title>进入任务页面</title>
    <%@include file="/commons/include/get.jsp" %>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <script src="${ctx}/newtable/jquery.js"></script>
    <script src="${ctx}/newtable/bootstrap.js"></script>
    <style>
        .task.task-card {
            margin: 0 8px 8px;
        }

        .task.task-card {
            padding: 0;
            margin-left: 3px;
            background-color: #f0f0f0;
            border-radius: 3px;
            box-shadow: 0 1px 2px rgba(0, 0, 0, .1);
            cursor: pointer;
        }


        .task {
            display: flex;
            -webkit-flex-direction: row;
            -ms-flex-direction: row;
            flex-direction: row;
            -webkit-align-items: flex-start;
            -ms-flex-align: start;
            align-items: flex-start;
            position: relative;
            white-space: normal;
        }

    </style>
</head>
<body>
<div class="container-fluid">
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                ${Project.ddProjectName} <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
                <c:forEach var="projectListbyUserItem" items="${projectListbyUser}">
                    <li><a href="#">${projectListbyUserItem.ddProjectName}</a></li>
                </c:forEach>
            </ul>
        </li>
        <li role="presentation" class="active"><a href="#task" data-toggle="tab" role="tab">任务</a></li>
        <li role="presentation"><a href="#index" data-toggle="tab" role="tab">指标</a></li>
        <li role="presentation"><a href="#calendar" data-toggle="tab" role="tab">日程</a></li>
        <div class="pull-right">
            <button id="static" class="btn btn-warning"><span class="glyphicon glyphicon-stats"></span> 统计</button>
            <a class="btn btn-success" href="#" data-toggle="modal" data-remote="${ctx}/datadriver/task/addtask.ht?id=${Project.ddProjectId}"
               data-target="#addtask"><span class="glyphicon glyphicon-plus"></span> 创建</a>
        </div>
    </ul>

    <br>
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="task">
            <div class="row">
                <div class="col-xs-3">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            新创建
                        </div>
                        <div class="panel-body">
                                <ul class="scrum-stage-tasks">
                                    <li class="task task-card">
                                        111111
                                    </li>
                                </ul>
                            </section>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            已发布
                        </div>
                        <div class="panel-body">
                            <section></section>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            已完成
                        </div>
                        <div class="panel-body">
                            <section></section>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="panel panel-warning">
                        <div class="panel-heading">
                            已审核
                        </div>
                        <div class="panel-body">
                            <section></section>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div role="tabpanel" class="tab-pane" id="index">
        </div>
        <div role="tabpanel" class="tab-pane" id="calendar">
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
<%--<script>--%>
<%--$(function(){--%>
<%--$(".dropdown-toggle").dropdown('toggle');--%>
<%--});--%>
<%--</script>--%>
</html>
