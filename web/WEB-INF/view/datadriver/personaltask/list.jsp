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
        .pages{
            float: right;
        }
        .page_line{
            display:inline;
        }
    </style>
</head>
<body>

<div class="layui-tab layui-tab-card">
    <ul class="layui-tab-title">
        <li class="layui-this">个人任务列表</li>
    </ul>
    <div class="layui-tab-content">
        <blockquote class="layui-elem-quote">
            <div style="height: 40px;">
                <span class="fl">
                <form id="searchForm" method="post" action="list.ht">

                        <input type="text" name="Q_name_SL" class="layui-input"
                               value="${param['Q_name_SL']}" placeholder="任务名称"/>

                </form>
                    </span>
                <span class="fr"><a class="layui-btn layui-btn-normal" id="Search"><i class="layui-icon">&#xe615;</i> 查询</a>
                            <a class="layui-btn" href="edit.ht"><i class="layui-icon">&#xe61f;</i> 添加</a>

                            <a class="layui-btn layui-btn-danger" action="del.ht"><i class="layui-icon">&#xe640;</i> 删除</a>
                    <a class="layui-btn layui-btn-primary" onclick="location.reload()"><i class="layui-icon">&#x1002;</i> 刷新</a>
                            </span>
            </div>
        </blockquote>
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

            <display:column title="操作" media="html" style="width:10%">
                <%--<a href="submitpublish.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-mini"><i--%>
                        <%--class="layui-icon">&#xe642;</i> 更新发布数据</a>--%>
                <%--<a href="showorder.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-normal layui-btn-mini"><i--%>
                        <%--class="layui-icon">&#xe615;</i> 查看订阅数据</a>--%>
                <a href="todotask.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-normal layui-btn-mini"><i
                        class="layui-icon">&#xe639;</i> 任务办理</a>
                <a href="submittask.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-normal layui-btn-mini"><i
                        class="layui-icon">&#xe639;</i> 任务提交</a>
                <a href="recovertask.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-normal layui-btn-mini"><i
                        class="layui-icon">&#xe639;</i> 任务收回</a>
            </display:column>
        </display:table>
        <%--<hotent:paging tableId="taskList"/>--%>

    </div>
</div>

</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</html>


