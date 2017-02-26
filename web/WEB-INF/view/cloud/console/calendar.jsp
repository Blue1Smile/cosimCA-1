<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commons/cloud/global.jsp" %>
<%--<%@taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>--%>
<%--<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>--%>
<html lang="zh">
<head>
    <title>协同设计</title>
    <%--<%@include file="/commons/cloud/meta.jsp" %>--%>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        .head_title {
            /*position: fixed;*/
            /*top: 0;*/
            /*left: 0;*/
            /*right: 0;*/
            font-size: 40px;
            font-weight: 600;
            float: left;
            line-height: 36px;
            margin: 0 8px 10px 15px;
            color: #1976D2;
        }
        iframe {
            margin: 0px 0px !important;
            width: 100% !important;
            height: 600px !important;
            border: none;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <br>
    <div class="row">
        <h1 class="head_title"><strong style="color: orange">Cosim</strong>协同设计平台</h1>
    </div>
    <%@include file="/commons/cloud/top_console.jsp" %>

    <div class="container-fluid" style="height: 100%">

        <div class="col-xs-8 col-xs-offset-2">
            <div class="panel panel-default" style="height: 100%">
                <div class="panel-heading">个人看板
                    <p class="pull-right">
                        <a href="#" onclick="window.location.reload()" title="刷新看板">
                            <span class="glyphicon glyphicon-refresh"></span>
                        </a>
                    </p>
                </div>
                <div class="panel-body" style="height: 95%">
                    <div class="row">
                        <c:forEach var="projectItem" items="${projectList}">
                            <div class="col-xs-4">
                                <div class="thumbnail">
                                    <div class="caption">
                                        <h4>${projectItem.ddProjectName}</h4>
                                        <p style="white-space:nowrap;overflow:hidden;text-overflow:ellipsis;"><em>${projectItem.ddProjectDescription}</em></p>
                                        <div class="btn-group btn-group-xs col-xs-offset-6" role="group">
                                            <a href="#" type="button" class="btn btn-info">任务</a>
                                            <a id="statis_btn" class="btn btn-warning" onclick="showStatis(${projectItem.ddProjectId})">进度</a>
                                            <a href="#" type="button" class="btn btn-primary">讨论</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
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
</body>
<script src="${ctx}/newtable/jquery.js"></script>
<script src="${ctx}/newtable/bootstrap.js"></script>
<script>
    //监控信息
    function showStatis(projectId){
        $('#statis').modal({
            keyboard: true,
            remote: "${ctx}/datadriver/project/statis.ht?id=" + projectId
        });}
    //关闭统计模态框
    $("#statis").on("hidden.bs.modal", function() {
        $(this).removeData("bs.modal");
    });
</script>
<%--<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>--%>
</html>