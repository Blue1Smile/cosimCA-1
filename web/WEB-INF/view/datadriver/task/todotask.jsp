<%--
  Created by IntelliJ IDEA.
  User: dodo
  Date: 2016/12/25
  Time: 下午9:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>办理任务</title>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <style>
        #iframe_tab {
            margin-top: 0px;
        }
    </style>
</head>
<body>
<div class="layui-tab layui-tab-card">
    <ul class="layui-tab-title">
        <li class="layui-this">任务控制台</li>
    </ul>
    <div class="layui-tab-content">
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" id="iframe_tab">
            <ul class="layui-tab-title">
                <li class="layui-this">任务概述</li>
                <li>私有数据</li>
                <li>订阅数据</li>
                <li>任务工具</li>
            </ul>
            <div class="layui-tab-content">

            </div>
        </div>
    </div>
</div>
</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</html>
