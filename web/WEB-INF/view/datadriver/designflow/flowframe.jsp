<%--
  Created by IntelliJ IDEA.
  User: dodo
  Date: 2016/12/26
  Time: 下午10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/commons/include/get.jsp" %>
<html>
<head>
    <title>项目流程绘制</title>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="layui-tab layui-tab-card">
    <ul class="layui-tab-title">
        <li class="layui-this">项目流程绘制</li>
    </ul>
    <div class="layui-tab-contentignflow/projectflow.ht?id=${projectId}&processFlowXml=${processFlowXml}" style="width: 100%;height: 800px" frameborder="no"></iframe>
    </div>">
        <iframe src="${ctx}/datadriver/designflow/projectflow.ht?id=${projectId}&processFlowXml=${processFlowXml}" style="width: 100%;height: 800px" frameborder="no"></iframe>
    </div>
</div>
</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</html>
