<!DOCTYPE html>
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
<html lang="zh-CN" style="height: 100%; margin: 0px">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>
    <title>进入任务页面</title>
    <style>
        .panelheight {
            overflow: auto;
        }
    </style>
</head>

<body style="height: 100%;">
<%--<div class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-right entity-well" id="cbp-spmenu-s2"--%>
     <%--style="padding-right: 0px">--%>
<%--</div>--%>
<div class="container-fluid">
    <ul class="nav nav-tabs" role="tablist">
        <li class="active" role="presentation" id="switch_attr_Release"><a href="#Release" data-toggle="tab"
                                                                           role="tab">发布数据</a></li>
        <li role="presentation" id="switch_attr_Order"><a href="#Order" data-toggle="tab" role="tab">订阅数据</a></li>
    </ul>
    <div class="tab-content board-view">
        <div role="tabpanel" class="tab-pane active panelheight" id="Release">
        </div>
        <div role="tabpanel" class="tab-pane panelheight" id="Order">
        </div>
    </div>
</div>

</body>
<script type="text/javascript">
    $(document).ready(function () {
        $("#create_task").hide();
        $("#create_Release").show();
        $.get("${ctx}/datadriver/datacenter/Releasedata.ht?id=${taskId}", function (data) {
            $('#Release').html(data);
        });
    });
    var switch_attr_Release = document.getElementById('switch_attr_Release'),
        switch_attr_Order = document.getElementById('switch_attr_Order');
    switch_attr_Release.onclick = function () {
        $("#create_task").hide();
        $("#create_Release").show();
        $.get("${ctx}/datadriver/datacenter/Releasedata.ht?id=${taskId}", function (data) {
            $('#Release').html(data);
        });
    }

    switch_attr_Order.onclick = function () {
        $("#create_task").hide();
        $("#create_Order").show();
        $.get("${ctx}/datadriver/datacenter/Orderdata.ht?id=${taskId}", function (data) {
            $('#Order').html(data);
        });
    }
</script>
</html>
