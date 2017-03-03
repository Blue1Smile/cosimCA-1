<!DOCTYPE html>
<%--
  Created by IntelliJ IDEA.
  User: 忠
  Date: 2017/2/20
  Time: 16:38
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html lang="zh-CN">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>
</head>
<body>
<table id="tb_departments" data-url="getOrderdata.ht?id=<%=request.getParameter("id")%>">
</table>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
<script src="${ctx}/newtable/Orderdata.js"></script>
</body>
</html>