<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/commons/cloud/global.jsp" %>
<%@taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--<html lang="zh"  style="height: 100%; margin: 0px">--%>
<html lang="zh">
<head>
    <title><decorator:title default="工作台"/>协同设计</title>
    <%--<%@include file="/commons/cloud/meta.jsp" %>--%>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/newtable/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
    <%--<style type="text/css">--%>
        <%--body{--%>
            <%--overflow:scroll;--%>
            <%--overflow-y:hidden;--%>
        <%--}--%>
    <%--</style>--%>
</head>
<body>
<div class="container-fluid">
    <br>
    <div class="row">
        <svg width="500" height="60">
            <text x="20" y="45" fill="orange" font-weight="500" font-size="50" font-family="Impact"> Cosim</text>
            <text x="155" y="40" fill="#369" font-weight="900" font-size="45" font-family="SimHei">协同设计平台</text>
        </svg>
    </div>

    <%@include file="/commons/cloud/top_console.jsp" %>

    <div class="col-xs-2" padding-left: 0px">
        <decorator:body/>
    </div>
    <div class="col-xs-10">
        <iframe src="main.ht" frameborder="0" scrolling="no" id="mainframe" style="width: 100%;height: 650px"></iframe>
    </div>

    <%--<%@include file="/commons/cloud/foot.jsp" %>--%>
</div>
</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</html>
