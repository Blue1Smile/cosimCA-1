<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/commons/cloud/global.jsp" %>
<%@taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<html lang="zh-CN">
<head>
    <title>协同设计</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <%--<%@include file="/commons/cloud/meta.jsp" %>--%>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/newtable/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
    <script src="${ctx}/newtable/jquery.js"></script>

    <script>
        $(function(){
            $(".layui-nav li a").each(function(index){
                $this = $(this);
                if($this[0].href==String(window.location)){
                    $this.addClass("layui-this");
                }
            });
        })
    </script>

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
            margin: 0 8px 10px 30px;
            color: #1976D2;
        }
        .row {
             margin-right: 0px !important;
             margin-left: 0px !important;
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
    <%--<div class="col-xs-2">--%>
        <%--<decorator:body/>--%>
    <%--</div>--%>
    <div class="row">
    <%--<div class="row">--%>
        <iframe src="main.ht" frameborder="0" scrolling="no" id="mainframe" style="width: 100%;height: 650px"></iframe>
    </div>
    <%--<%@include file="/commons/cloud/foot.jsp" %>--%>
</div>
</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</html>
