<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
    <title>任务基础信息列表</title>
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

<div class="layui-tab layui-tab-card" id="iframe_tab">
    <ul class="layui-tab-title">
        <li class="layui-this" id="init">任务管理列表</li>
        <li>任务审核</li>
    </ul>
    <div class="layui-tab-content" style="height: 100%;">
        <!--任务管理-->
        <blockquote class="layui-elem-quote">
            <div style="height: 40px;">
                <span class="fl">
                    <form id="searchForm" method="post" action="list.ht">
                        <input type="text" name="Q_name_SL " class="layui-input"
                               value="${param['Q_name_SL']}" placeholder="任务名称"/>
                    </form>
                </span>
                <span class="fr">
                    <a class="layui-btn layui-btn-normal" id="Search"><i class="layui-icon">&#xe615;</i> 查询</a>
                            <a class="layui-btn" href="edit.ht" id="taskInfoForm"><i class="layui-icon">&#xe61f;</i> 添加</a>
                    <a class="layui-btn layui-btn-danger" action="del.ht"><i class="layui-icon">&#xe640;</i> 删除</a>
                            <a class="layui-btn layui-btn-primary" action="#" onclick="location.reload()"><i class="layui-icon">&#x1002;</i> 刷新</a>
                </span>
            </div>
        </blockquote>
        <div class="layui-tab-item">
            <c:set var="checkAll">
                <input type="checkbox" id="chkall"/>
            </c:set>
            <display:table name="taskList" id="TaskItem" requestURI="list.ht" sort="external" cellpadding="0"
                           cellspacing="0" export="false" class="layui-table lay-even" pagesize="10">
                <display:column title="${checkAll}" media="html" style="width:3%;">
                    <input type="checkbox" class="pk" name="id" value="${TaskItem.ddTaskId}">
                </display:column>
                <%--<display:column property="ddTaskId" title="任务ID" sortable="true" sortName="DD_TASK_ID"--%>
                <%--maxLength="80"></display:column>--%>
                <display:column property="ddTaskName" title="任务名称" sortable="true" maxLength="60"></display:column>
                <%--<display:column property="ddTaskDescription" title="任务描述" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskCreatorId" title="任务创建者id"></display:column>--%>
                <display:column property="ddTaskPerson" title="任务负责人" sortable="true"></display:column>
                <%--<display:column property="ddTaskFixedPattern" title="任务是否固化" maxLength="80"></display:column>--%>
                <display:column property="ddTaskType" title="任务类型" maxLength="80"></display:column>
                <%--<display:column property="ddTaskChildType" title="任务子类型" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskPriority" title="优先级" ></display:column>--%>
                <%--<display:column property="ddTaskMilestone" title="里程碑任务" sortable="true" ></display:column>--%>
                <%--<display:column property="ddTaskEstimateTime" title="任务计划工时" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskPlanStartTime" title="任务计划开始时间" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskPlanEndTime" title="任务计划结束时间" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskCompleteRate" title="任务完成率" ></display:column>--%>
                <%--<display:column property="ddTaskCompleteState" title="任务完成状态" sortable="true" ></display:column>--%>
                <%--<display:column property="ddTaskResourceId" title="任务资源id" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskActualTime" title="实际工时"  maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskPlanTime" title="计划工时" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskActualStartTime" title="实际开始日期" ></display:column>--%>
                <%--<display:column property="ddTaskActualEndTime" title="实际结束日期" ></display:column>--%>
                <%--<display:column property="ddTaskPlanDuration" title="计划工期" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskProjectId" title="任务所属项目" maxLength="80"></display:column>--%>
                <display:column property="ddTaskProjectName" title="所属项目" maxLength="80"></display:column>

                <display:column title="操作" media="html" style="width:320px">
                    <a href="edit.ht?id=${TaskItem.ddTaskId}" class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe642;</i> 编辑</a>
                    <%--<a href="get.ht?id=${TaskItem.ddTaskId}"--%>
                    <%--class="layui-btn layui-btn-normal layui-btn-small">明细</a>--%>
                    <a href="${ctx}/datadriver/privatedata/list.ht?id=${TaskItem.ddTaskId}"
                       class="layui-btn layui-btn-normal layui-btn-mini"><i class="layui-icon">&#xe612;</i> 私有</a>
                    <a href="publishconfig.ht?id=${TaskItem.ddTaskId}"
                       class="layui-btn layui-btn-normal layui-btn-mini"><i class="layui-icon">&#xe63c;</i> 发布</a>
                    <a href="orderconfig.ht?id=${TaskItem.ddTaskId}"
                       class="layui-btn layui-btn-normal layui-btn-mini"><i class="layui-icon">&#xe627;</i> 订阅</a>
                    <a href="del.ht?id=${TaskItem.ddTaskId}"
                       class="layui-btn layui-btn-danger layui-btn-mini"><i class="layui-icon">&#xe640;</i> 删除</a>
                    <%--<a href="" class="layui-btn layui-btn-small layui-btn-warm">引用</a>--%>
                    <%--<a href="del.ht?id=${TaskItem.ddTaskId}"--%>
                    <%--class="layui-btn layui-btn-small layui-btn-danger">删除</a>--%>
                </display:column>

            </display:table>
            <%--<hotent:paging tableId="TaskItem"/>--%>
        </div>
        <!--审核任务-->
        <div class="layui-tab-item">
            <c:set var="checkAll">
                <input type="checkbox" id="chkall"/>
            </c:set>
            <c:set var="checkAll">
                <input type="checkbox" id="chkall"/>
            </c:set>
            <display:table name="taskCheckList" id="TaskCheckItem" requestURI="taskcheck.ht" sort="external" cellpadding="0"
                           cellspacing="0" export="false" class="layui-table lay-even" pagesize="10">
                <display:column title="${checkAll}" media="html" style="width:3%;">
                    <input type="checkbox" class="pk" name="id" value="${TaskCheckItem.ddTaskId}">
                </display:column>
                <%--<display:column property="ddTaskId" title="任务ID" sortable="true" sortName="DD_TASK_ID"--%>
                <%--maxLength="80"></display:column>--%>
                <display:column property="ddTaskName" title="任务名称" sortable="true" maxLength="60"></display:column>
                <%--<display:column property="ddTaskDescription" title="任务描述" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskCreatorId" title="任务创建者id"></display:column>--%>
                <display:column property="ddTaskPerson" title="任务负责人" sortable="true"></display:column>
                <%--<display:column property="ddTaskFixedPattern" title="任务是否固化" maxLength="80"></display:column>--%>
                <display:column property="ddTaskType" title="任务类型" maxLength="80"></display:column>
                <%--<display:column property="ddTaskChildType" title="任务子类型" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskPriority" title="优先级" ></display:column>--%>
                <%--<display:column property="ddTaskMilestone" title="里程碑任务" sortable="true" ></display:column>--%>
                <%--<display:column property="ddTaskEstimateTime" title="任务计划工时" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskPlanStartTime" title="任务计划开始时间" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskPlanEndTime" title="任务计划结束时间" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskCompleteRate" title="任务完成率" ></display:column>--%>
                <%--<display:column property="ddTaskCompleteState" title="任务完成状态" sortable="true" ></display:column>--%>
                <%--<display:column property="ddTaskResourceId" title="任务资源id" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskActualTime" title="实际工时"  maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskPlanTime" title="计划工时" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskActualStartTime" title="实际开始日期" ></display:column>--%>
                <%--<display:column property="ddTaskActualEndTime" title="实际结束日期" ></display:column>--%>
                <%--<display:column property="ddTaskPlanDuration" title="计划工期" maxLength="80"></display:column>--%>
                <%--<display:column property="ddTaskProjectId" title="任务所属项目" maxLength="80"></display:column>--%>
                <display:column property="ddTaskProjectName" title="所属项目" maxLength="80"></display:column>

                <display:column title="审核" media="html" style="width:320px">
                    <a href="${ctx}/datadriver/datacenter/publishorderdata.ht?id=${TaskCheckItem.ddTaskId}" class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe642;</i> 审核</a>
                    <a href="rejecttask.ht"
                    class="layui-btn layui-btn-normal layui-btn-mini"><i class="layui-icon">&#xe612;</i> 驳回</a>
                    <%--<a href="get.ht?id=${TaskItem.ddTaskId}"--%>
                    <%--class="layui-btn layui-btn-normal layui-btn-small">明细</a>--%>
                    <%--<a href="${ctx}/datadriver/privatedata/list.ht?id=${TaskItem.ddTaskId}"--%>
                       <%--class="layui-btn layui-btn-normal layui-btn-mini"><i class="layui-icon">&#xe612;</i> 私有</a>--%>
                    <%--<a href="publishconfig.ht?id=${TaskItem.ddTaskId}"--%>
                       <%--class="layui-btn layui-btn-normal layui-btn-mini"><i class="layui-icon">&#xe63c;</i> 发布</a>--%>
                    <%--<a href="orderconfig.ht?id=${TaskItem.ddTaskId}"--%>
                       <%--class="layui-btn layui-btn-normal layui-btn-mini"><i class="layui-icon">&#xe627;</i> 订阅</a>--%>
                    <%--<a href="del.ht?id=${TaskItem.ddTaskId}"--%>
                       <%--class="layui-btn layui-btn-danger layui-btn-mini"><i class="layui-icon">&#xe640;</i> 删除</a>--%>
                    <%--<a href="" class="layui-btn layui-btn-small layui-btn-warm">引用</a>--%>
                    <%--<a href="del.ht?id=${TaskItem.ddTaskId}"--%>
                    <%--class="layui-btn layui-btn-small layui-btn-danger">删除</a>--%>
                </display:column>

            </display:table>
            <%--<hotent:paging tableId="TaskItem"/>--%>
            rejecttask
        </div>
    </div>
</div>








<script>
    $('#init').trigger('click');
</script>

<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</body>
<script>
    $('#taskInfoForm').on('click', function () {
        layer.open({
            type: 2,
            title: "任务信息配置", //不显示标题栏
            shadeClose: true,
            shade: 0.8,
            area: ['95%', '80%'],
            id: 'layer_taskinfo', //设定一个id，防止重复弹出
            moveType: 1,//拖拽模式，0或者1
            content: '${ctx}/datadriver/task/addtask.ht?id=${projectId}'
//            ,
//            success: function (layero) {
//                var btn = layero.find('.layui-layer-btn');
//                btn.css('text-align', 'center');
//                btn.find('.layui-layer-btn0').attr({
//                    href: 'save.ht'
//                });
//            }
        });
    });
</script>
</html>


