<%--
	time:2013-04-11 11:48:44
	desc:edit the 业务定义，如邀标采购这样的大业务。
--%>
<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@page import="com.hotent.core.util.ContextUtil" %>
<html>
<head>
    <title>任务数据中心</title>
    <%@include file="/commons/include/form.jsp" %>
    <%@include file="/newtable/tablecontext.jsp" %>
    <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
    <%--<link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>--%>
</head>
<body>
<table id="tablelist"
       data-height="300"
       data-search="true"
       data-show-refresh="true"
       data-show-toggle="false"
       data-show-columns="false"
       data-show-export="false"
       data-sort-stable="true"
       data-detail-view="true"
       data-detail-formatter="detailFormatter"
       data-minimum-count-columns="2"
       data-show-pagination-switch="true"
       data-pagination="true"
       data-id-field="id"
       data-show-header="true"
       data-page-size="5"
       data-page-list="[10, 25, 50, 100, ALL]"
       data-show-footer="false"
       data-side-pagination="server"
       data-url="submitpublishjson.ht?id=${taskId}"
       data-response-handler="responseHandler"
       class="table table-hover"
       style="margin-bottom: -81px;">
</table>
<%--<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>--%>
<script src="${ctx}/newtable/customtable.js"></script>
</body>
</html>
