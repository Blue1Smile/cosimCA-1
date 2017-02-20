<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
    <title>个人任务</title>
    <%@include file="/commons/include/get.jsp" %>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>

</head>
<body>

<div class="layui-tab layui-tab-card">
    <ul class="layui-tab-title">
        <li class="layui-this">我的工作台</li>
    </ul>
    <div class="layui-tab-content">
        <c:set var="checkAll">
            <input type="checkbox" id="chkall"/>
        </c:set>
        <display:table name="taskList" id="taskList" requestURI="list.ht" sort="external" cellpadding="1"
                       cellspacing="1" export="false" class="layui-table" pagesize="10">
            <display:column title="${checkAll}" media="html" style="width:3%;">
                <input type="checkbox" class="pk" name="id" value="${taskList.ddTaskId}">
            </display:column>
            <display:column property="ddTaskProjectName" title="任务所属项目" maxLength="80"></display:column>
            <display:column property="ddTaskName" title="任务名称" sortable="false" maxLength="80"></display:column>
            <display:column title="操作" media="html" style="width:15%">
                <c:choose><c:when test="${taskList.ddTaskState==0}">
                    <a href="todotask.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-normal layui-btn-mini"><i
                            class="layui-icon">&#xe639;</i> 办理</a>
                </c:when>
                    <c:otherwise>
                        <a href="recovertask.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-normal layui-btn-mini"><i
                                class="layui-icon">&#xe639;</i> 收回</a>
                    </c:otherwise></c:choose>
            </display:column>
        </display:table>
    </div>
</div>
</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</html>


