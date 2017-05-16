<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commons/cloud/global.jsp" %>
<html lang="zh">
<head>
    <title>协同设计</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/newtable/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
    <script src="${ctx}/newtable/jquery.js"></script>
    <script src="${ctx}/newtable/bootstrap.js"></script>
    <style>
        body {
            min-height: 2000px;
            padding-top: 70px;
        }
    </style>
</head>
<body>

<%--<br>--%>
<%--<div class="row">--%>
<%--<h1 class="head_title"><strong style="color: orange">Cosim</strong>协同设计平台</h1>--%>
<%--</div>--%>
<%@include file="/commons/cloud/top_console.jsp" %>
<div class="container">
    <div class="panel panel-default" style="height: 100%">
        <div class="panel-heading">个人看板
            <p class="pull-right">
                <a href="javascript:void(0)" onclick="window.location.reload()" title="刷新看板">
                    <span class="glyphicon glyphicon-refresh"></span>
                </a>
            </p>
        </div>
        <div class="panel-body" style="height: 100%">
            <c:forEach var="projectItem" items="${projectList}">
                <div class="col-xs-4">
                    <div class="thumbnail">
                        <div class="caption">
                            <h4>${projectItem.ddProjectName}</h4>
                            <p style="white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">
                                <em>${projectItem.ddProjectDescription}</em></p>
                            <div class="btn-group btn-group-xs col-xs-offset-6" role="group">
                                <a href="javascript:void(0)" type="button" class="btn btn-info"
                                   onclick="showMyTask(${projectItem.ddProjectId})" title="待办任务列表">任务</a>
                                <a id="statis_btn" class="btn btn-warning"
                                   onclick="showStatis(${projectItem.ddProjectId})" title="项目进度情况">进度</a>
                                <a href="javascript:void(0)" type="button" class="btn btn-primary"
                                   title="进入项目讨论组" disabled="disabled" title="暂不可用">讨论</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
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
<%--我的任务--%>
<div class="modal fade" id="mytask" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">

        </div>
    </div>
</div>
</body>

<script>
    //监控信息
    function showStatis(projectId) {
        $('#statis').modal({
            keyboard: true,
            remote: "${ctx}/datadriver/project/statis.ht?id=" + projectId
        });
    }

    function showMyTask(projectId) {
        $('#mytask').modal({
            keyboard: true,
            remote: "mytasklist.ht?id=" + projectId
        });
    }
    $("#mytask").on("hidden.bs.modal", function () {
        $(this).removeData("bs.modal");
    });
</script>

</html>