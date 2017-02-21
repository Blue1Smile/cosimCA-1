<%--
  Created by IntelliJ IDEA.
  User: d
  Date: 2017/1/19
  Time: 上午10:51
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="hotent" uri="http://www.jee-soft.cn/paging" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html style="height: 100%; margin: 0px">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>

    <title>进入任务页面</title>
    <%--<%@include file="/commons/include/get.jsp" %>--%>
    <%--<link rel="stylesheet" href="${ctx}/resources/skin/base.css"/>--%>
    <%--<link rel="stylesheet" href="${ctx}/resources/skin/content.css"/>--%>
    <%--<link rel="stylesheet" href="${ctx}/resources/skin/blue.css"/>--%>
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/slide/css/default.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/slide/css/component.css"/>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/styles/check/font-awesome.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/styles/check/build.css" rel="stylesheet" type="text/css"/>

    <script src="${ctx}/styles/slide/js/modernizr.custom.js"></script>
    <script src="${ctx}/newtable/jquery.js"></script>
    <script src="${ctx}/newtable/bootstrap.js"></script>
    <script src="${ctx}/styles/layui/jquery.dragsort-0.5.2.min.js"></script>
    <style>
        html, body {
            margin: 0px 0px !important;
            width: 100% !important;
            height: 100% !important;
        }

        iframe {
            margin: 0px 0px !important;
            width: 100% !important;
            height: 100% !important;
        }

        .scrum-stage .task.task-card {
            margin: 0 8px 8px !important;
        }

        .task.task-card {
            padding: 0 !important;
            background-color: #fff !important;
            border-radius: 3px !important;
            box-shadow: 0 1px 2px rgba(0, 0, 0, .1) !important;
            cursor: pointer !important;
            margin-left: -42px !important;
        }

        .checkbox label {
            margin: 12px !important;
        }

        li {
            list-style-type: none !important;
        }

        .paneldocker {
            position: relative;
            height: 100%;
            padding: 10px;
        }

        .panelheight {
            position: relative;
            height: 93%;
        }

        /*.cbp-spmenu-push{*/
        /*overflow:scroll !important;*/
        /*overflow-x:hidden !important;*/
        /*}*/
        .bs-callout-danger {
            border-left-color: #ce4844;
            border-left-width: 5px;
        }
        .board-view {
            position: fixed;
            top: 50px;
            right: 0;
            bottom: 0;
            left: 0;
            padding: 0;
            overflow: hidden;
            transition: all 218ms ease;
        }
        .task-panel {
            position: relative;
            height: 100%;
        }
        .board-scrum-view {
            position: relative;
            height: 100%;
            background-color: #FFF;
            border-style: solid;
            border-width: 0;
            border-color: #E5E5E5;
            overflow-y: auto;
            overflow-x: hidden;
        }

    </style>
</head>

<body style="height: 100%; margin: 0px">
<div class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-right entity-well" id="cbp-spmenu-s2"
     style="padding-right: 0px">
</div>
<div class="container-fluid" style="height: 100%">
    <ul class="nav nav-tabs" role="tablist">
        <li  class="active" role="presentation" id="switch_attr_Release"><a href="#Release" data-toggle="tab" role="tab">订阅数据</a></li>
        <li role="presentation" id="switch_attr_Order"><a href="#Order" data-toggle="tab" role="tab">发布数据</a></li>
        <%--<div class="pull-right">--%>
            <%--<a id="statis_btn" class="btn btn-warning" data-toggle="modal"--%>
               <%--data-remote="statis.ht?id=${Project.ddProjectId}"--%>
               <%--data-target="#statis"><span class="glyphicon glyphicon-stats"></span> 统计--%>
            <%--</a>--%>

            <%--<a class="btn btn-success" href="#" data-toggle="modal" id="create_task"--%>
               <%--data-remote="${ctx}/datadriver/task/addtask.ht?id=${Project.ddProjectId}"--%>
               <%--data-target="#addtask"><span class="glyphicon glyphicon-plus"></span> 创建</a>--%>

            <%--<a class="btn btn-info" href="#" data-toggle="modal" id="create_index"--%>
               <%--data-remote="${ctx}/datadriver/index/indexedit.ht?id=${Project.ddProjectId}"--%>
               <%--data-target="#addindex"><span class="glyphicon glyphicon-plus"></span> 创建</a>--%>
        <%--</div>--%>
    </ul>

    <br>
    <div class="tab-content board-view">
        <div role="tabpanel" class="tab-pane" id="Release">

        </div>
        <div role="tabpanel" class="tab-pane" id="Order">
        </div>
    </div>
</div>
</body>
<script src="${ctx}/styles/slide/js/classie.js"></script>
<script type="text/javascript">

    <%--$(document).ready(function () {--%>
        <%--$("#create_task").hide();--%>
        <%--$("#create_Release").show();--%>
        <%--$.get("${ctx}/datadriver/datacenter/Releasedata.ht?id=<%=request.getParameter("id")%>", function (data) {--%>
            <%--$('#index').html(data);--%>
        <%--});--%>
    <%--});--%>
    switch_attr_Release.onclick = function () {
        $("#create_task").hide();
        $("#create_Release").show();
        $.get("${ctx}/datadriver/datacenter/Releasedata.ht?id=<%=request.getParameter("id")%>", function (data) {
            $('#index').html(data);
        });
    }

   switch_attr_Order.onclick = function () {
    $("#create_task").hide();
    $("#create_Order").show();
    $.get("${ctx}/datadriver/datacenter/Orderdata.ht?id=<%=request.getParameter("id")%>", function (data) {
        $('#calendar').html(data);
    });
}


</script>
</html>
