<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commons/cloud/global.jsp" %>
<%@taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<html lang="zh">
<head>
    <title><decorator:title default="工作台"/>协同设计</title>
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
        <div class="col-xs-3" style="height: 100%">
            <div class="panel panel-primary" style="height: 100%">
                <div class="panel-heading">未办任务</div>
                <div class="panel-body" style="height: 93%">
                    <%--<ul id="demo2"></ul>--%>
                </div>

            </div>
        </div>
        <div class="col-xs-7">
            <div class="panel panel-primary" style="height: 100%">
                <div class="panel-heading">专业工具列表</div>
                <div class="panel-body" style="height: 93%">
                    <%--<div id="toolsListFrame" style="height: 100%"></div>--%>
                </div>
            </div>
        </div>
        <div class="col-xs-2">
            <div class="panel panel-primary" style="height: 100%">
                <div class="panel-heading">项目更新</div>
                <div class="panel-body" style="height: 93%">
                    <%--<div id="toolsListFrame" style="height: 100%"></div>--%>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
<%--<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>--%>
</html>