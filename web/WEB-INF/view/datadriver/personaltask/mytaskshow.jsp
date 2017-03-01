<!DOCTYPE html>
<%--
  Created by IntelliJ IDEA.
  User: dodo
  Date: 2016/12/25
  Time: 下午1:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <title>我的任务主页</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <style>
        .site-doc-color li {
            display: inline-block;
            vertical-align: middle;
            width: 180px;
            margin-left: 20px;
            margin-bottom: 20px;
            padding: 20px 10px;
            color: #fff;
            text-align: center;
            border-radius: 2px;
            line-height: 22px;
            font-size: 14px;
        }

        .site-doc-color li p[tips] {
            opacity: 0.8;
            font-size: 12px;
        }
    </style>
</head>
<body>
<div class="layui-tab layui-tab-card">
    <ul class="layui-tab-title">
        <li class="layui-this">概览</li>
    </ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">
            <ul class="site-doc-color">
                <li style="background-color: #009688;"><p>任务名称</p>
                    <p tips>内容</p></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>
        </div>
    </div>
</div>
</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</html>
