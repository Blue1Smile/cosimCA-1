<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
    <title>私有数据列表</title>
    <%@include file="/commons/include/get.jsp" %>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="layui-tab layui-tab-card">
    <ul class="layui-tab-title">
        <li class="layui-this">任务管理列表</li>
    </ul>
    <div class="layui-tab-content">
<div class="layui-form-item">
    <div class="layui-inline">
        <label class="layui-form-label">日期选择</label>
        <div class="layui-input-block">
            <input type="text" name="date" id="date" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
        </div>
    </div>
    <div class="layui-inline">
        <label class="layui-form-label">行内表单</label>
        <div class="layui-input-inline">
            <input type="number" name="number" autocomplete="off" class="layui-input">
        </div>
    </div>
</div>
            私有数据列表

                <a class="link search" id="Search">查询</a>
                <a class="link add" href="edit.ht">添加</a>
                <a class="link update" id="btnUpd" action="edit.ht">修改</a>
                <a class="link del" action="del.ht">删除</a>
                <a class="link back" href="${ctx}/datadriver/task/list.ht">返回</a>


            <form id="searchForm" method="post" action="list.ht">

                    私有数据名称:<input type="text" name="Q_name_SL " class="inputText"
                                                             value="${param['Q_name_SL']}"/>
                    所属任务:<input type="text" name="Q_taskid_SL " class="inputText"
                                                           value="${param['Q_taskid_SL']}"/>

            </form>

        <c:set var="checkAll">
            <input type="checkbox" id="chkall"/>
        </c:set>
        <display:table name="privateDataList" id="PrivateDataItem" requestURI="list.ht" sort="external" cellpadding="1"
                       cellspacing="1" export="true" class="layui-table" pagesize="10">
            <display:column title="${checkAll}" media="html" style="width:30px;">
                <input type="checkbox" class="pk" name="id" value="${PrivateDataItem.ddDataId}">
            </display:column>
            <display:column property="ddDataId" title="数据编号" sortable="true" sortName="DD_DATA_ID"
                            maxLength="80"></display:column>
            <display:column property="ddDataName" title="数据名称" sortable="true" sortName="DD_DATA_NAME"
                            maxLength="80"></display:column>
            <display:column property="ddDataType" title="数据类型" maxLength="80"></display:column>
            <display:column property="ddDataDescription" title="数据描述"></display:column>
            <display:column property="ddDataTaskId" title="数据所属任务" sortable="true"></display:column>
            <display:column property="ddDataPublishType" title="数据可见性" maxLength="80"></display:column>
            <display:column property="ddDataLastestValue" title="数据最新值" maxLength="80"></display:column>
            <display:column property="ddDataSubmiteState" title="数据订阅状态" maxLength="80"></display:column>
            <display:column property="ddDataCreatePerson" title="创建人"></display:column>
            <display:column property="ddDataCreateTime" title="创建时间" sortable="true"></display:column>
            <display:column property="ddDataIsDelivery" title="是否交付" maxLength="80"></display:column>
            <display:column property="ddDataSensitiveness" title="灵敏阈" maxLength="80"></display:column>

            <display:column title="操作" media="html" style="width:260px">
                <a href="del.ht?id=${PrivateDataItem.ddDataId}" class="link del">删除</a>
                <a href="edit.ht?id=${PrivateDataItem.ddDataId}" class="link edit">编辑</a>
                <%--<a onclick="startBizInstance(${bizDefItem.bizDefId})" class="link run">启动</a>--%>
                <a href="get.ht?id=${PrivateDataItem.ddDataId}" class="link detail">明细</a>
                <a href="" class="link detail">引用</a>

            </display:column>
        </display:table>
        <%--<hotent:paging tableId="PrivateDataItem"/>--%>
</div>
    </div>
</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</html>


