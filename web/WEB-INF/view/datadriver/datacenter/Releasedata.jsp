<!DOCTYPE html>
<%--
  Created by IntelliJ IDEA.
  User: 忠
  Date: 2017/2/20
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@page import="com.hotent.core.util.ContextUtil" %>
<html lang="zh-CN">
<head>
    <%--<title>任务数据中心</title>--%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>
</head>
<body>
<table id="tb_department" data-url="getReleasedata.ht?id=<%=request.getParameter("id")%>">
</table>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
<script src="${ctx}/newtable/Releasedata.js"></script>
</body>
</html>