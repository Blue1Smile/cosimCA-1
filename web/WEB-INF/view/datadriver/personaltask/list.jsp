<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
    <title>个人任务</title>
    <%@include file="/commons/include/get.jsp" %>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <style>
        .fl {
            float: left;
        }

        .fr {
            float: right;
        }
    </style>
</head>
<body>

<div class="layui-tab layui-tab-card">
    <ul class="layui-tab-title">
        <li class="layui-this">个人任务列表</li>
    </ul>
    <div class="layui-tab-content">
        <div style="height: 50px;">
                <span class="fl">
                <form id="searchForm" method="post" action="list.ht">

                        <input type="text" name="Q_name_SL" class="layui-input"
                               value="${param['Q_name_SL']}" placeholder="任务名称"/>

                </form>
                    </span>
            <span class="fr"><a class="layui-btn layui-btn-normal" id="Search">查询</a>
                            <a class="layui-btn layui-btn-warm" href="edit.ht">添加</a>

                            <a class="layui-btn" action="edit.ht">修改</a>

                            <a class="layui-btn layui-btn-danger" action="del.ht">删除</a>
                            </span>
        </div>

        <c:set var="checkAll">
            <input type="checkbox" id="chkall"/>
        </c:set>
        <display:table name="taskList" id="taskList" requestURI="list.ht" sort="external" cellpadding="1"
                       cellspacing="1" export="false" class="layui-table" pagesize="10">
            <display:column title="${checkAll}" media="html" style="width:30px;">
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

            <display:column title="操作" media="html" style="width:350px">
                <a href="submitpublish.ht?id=${taskList.ddTaskId}" class="layui-btn">更新发布数据</a>
                <a href="showorder.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-normal">查看订阅数据</a>

            </display:column>
        </display:table>
        <%--<hotent:paging tableId="taskList"/>--%>

    </div>
</div>

</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</html>


