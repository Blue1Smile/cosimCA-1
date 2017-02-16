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
        <%--<blockquote class="layui-elem-quote">--%>
            <%--<div style="height: 40px;">--%>
                <%--<div class="fl">--%>
                    <%--<form id="searchForm" method="post" action="list.ht">--%>
                        <%--<input type="text" name="Q_name_SL" class="layui-input"--%>
                               <%--value="${param['Q_name_SL']}" placeholder="任务名称"/>--%>
                    <%--</form>--%>
                <%--</div>--%>
                <%--<div class="fr"><a class="layui-btn layui-btn-normal" id="Search"><i class="layui-icon">&#xe615;</i> 查询</a>--%>
                    <%--<a class="layui-btn layui-btn-primary" onclick="location.reload()"><i class="layui-icon">--%>
                        <%--&#x1002;</i> 刷新</a>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</blockquote>--%>
        <c:set var="checkAll">
            <input type="checkbox" id="chkall"/>
        </c:set>
        <display:table name="taskList" id="taskList" requestURI="list.ht" sort="external" cellpadding="1"
                       cellspacing="1" export="false" class="layui-table" pagesize="10">
            <display:column title="${checkAll}" media="html" style="width:3%;">
                <input type="checkbox" class="pk" name="id" value="${taskList.ddTaskId}">
            </display:column>
            <%--<display:column property="ddTaskId" title="任务编号" sortable="true" sortName="DD_TASK_ID"--%>
            <%--maxLength="80"></display:column>--%>
            <display:column property="ddTaskName" title="任务名称" sortable="true" maxLength="80"></display:column>
            <%--<display:column property="ddTaskDescription" title="任务描述" maxLength="80"></display:column>--%>
            <%--<display:column property="ddTaskCreatorId" title="任务创建者id"></display:column>--%>
            <%--<display:column property="ddTaskResponsiblePerson" title="任务负责人ID" sortable="true"></display:column>--%>
            <display:column property="ddTaskPerson" title="任务负责人" sortable="true"></display:column>
            <display:column property="ddTaskProjectId" title="任务所属项目" maxLength="80"></display:column>


            <display:column title="操作" media="html" style="width:15%">


                <c:choose><c:when test="${taskList.ddTaskState==1}">
                    <a href="todotask.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-normal layui-btn-mini"><i
                            class="layui-icon">&#xe639;</i> 办理</a>
                    <%--<a href="submittask.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-normal layui-btn-mini"><i--%>
                            <%--class="layui-icon">&#xe639;</i> 任务提交</a>--%>
                    <a href="recovertask.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-disabled layui-btn-mini"><i
                            class="layui-icon">&#xe639;</i> 收回</a>
                </c:when>
                    <c:otherwise>
                        <%--<a href="todotask.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-normal layui-btn-mini"><i--%>
                                <%--class="layui-icon">&#xe639;</i> 办理</a>--%>
                        <a href=" ${ctx}/datadriver/task/stepinto.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-normal layui-btn-mini"><i
                        class="layui-icon">&#xe639;</i> 办理</a>

                        <%--<a href="submittask.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-disabled layui-btn-mini"><i--%>
                                <%--class="layui-icon">&#xe639;</i> 任务提交</a>--%>
                        <a href="recovertask.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-normal layui-btn-mini"><i
                                class="layui-icon">&#xe639;</i> 收回</a>
                    </c:otherwise></c:choose>

            </display:column>
        </display:table>
        <%--<hotent:paging tableId="taskList"/>--%>

    </div>
</div>

</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</html>


