<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/commons/cloud/global.jsp" %>
<%@taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<html lang="zh-CN" style="height: 100%">
<head>
    <title>协同设计</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/newtable/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
    <script src="${ctx}/newtable/jquery.js"></script>
    <script src="${ctx}/newtable/bootstrap.js"></script>
    <script>
        $(function () {
            $(".nav li a").each(function (index) {
                $this = $(this);
                if ($this[0].href == String(window.location)) {
                    $this.addClass("active");
                }
            });
            $("#mainframe").height(getHeight());
        });

        function getHeight() {
            return $(window).height() - $('.layui-nav').outerHeight(true) - 80;
        }
    </script>
    <style>
        body {
            min-height: 2000px;
            padding-top: 70px;
        }
    </style>
</head>
<body style="height: 100%">
<%@include file="/commons/cloud/top_console.jsp" %>

    <%--<br>--%>
    <%--<div class="row">--%>
    <%--<h1 class="head_title"><strong style="color: orange">Cosim</strong>协同设计平台</h1>--%>
    <%--</div>--%>
    <%--<div class="col-xs-2">--%>
    <%--<decorator:body/>--%>
    <%--</div>--%>
    <iframe src="main.ht" frameborder="0" scrolling="no" id="mainframe" style="width: 100%;"></iframe>
    <%--<%@include file="/commons/cloud/foot.jsp" %>--%>

</body>
</html>
