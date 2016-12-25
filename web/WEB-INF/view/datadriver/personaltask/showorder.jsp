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
    <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        $(function () {
            var options = {};
            if (showResponse) {
                options.success = showResponse;
            }
            var frm = $('#datacentreForm').form();
            $("#dataFormSave").click(function () {
                frm.setData();
                frm.ajaxForm(options);
                if (frm.valid()) {
                    form.submit();
                }
            });
        });

        function showResponse(responseText) {
            var obj = new com.hotent.form.ResultMessage(responseText);
            if (obj.isSuccess()) {
                $.ligerMessageBox.confirm("提示信息", obj.getMessage() + ",是否继续操作", function (rtn) {
                    if (rtn) {
                        this.close();
                    } else {
                        window.location.href = "${ctx}/cloud/account/AccountInfo/list.ht";
                    }
                });
            } else {
                $.ligerMessageBox.error("提示信息", obj.getMessage());
            }
        }

    </script>
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
        <li class="layui-this">订阅数据列表</li>
    </ul>
    <div class="layui-tab-content">
        <blockquote class="layui-elem-quote">
            <div style="height: 40px;">
                <form id="searchForm" method="post" action="list.ht">
                            <span class="fl">
                            <%--<span class="label">项目编号:</span><input type="text" name="Q_id_SL" class="inputText"--%>
                            <%--value="${param['Q_id_SL']}"/>--%>
                            <input type="text" name="ddDataName " class="layui-input"
                                   value="${param['ddDataName']}" placeholder="数据名称"/>
                            <%--<span class="label">创建日期 从:</span> <input name="Q_createStartDate_SL" class="inputText date"--%>
                            <%--value="${param['Q_createStartDate_DL']}"/>--%>
                            <%--<span class="label">至: </span><input name="Q_createEndData_SL" class="inputText date"--%>
                            <%--value="${param['Q_createEndData_DL']}"/>--%>

                            </span>
                    <span class="fr">
                        <a class="layui-btn layui-btn-normal" id="Search"><i class="layui-icon">&#xe615;</i> 查询</a>
                    <a class="layui-btn layui-btn-primary" onclick="location.reload()"><i class="layui-icon">&#x1002;</i> 刷新</a>
                    <a class="layui-btn layui-btn-normal" id="back"><i class="layui-icon">&#xe603;</i> 返回</a>
                    </span>


                </form>
            </div>
        </blockquote>
        <!--20161202-->
        <c:set var="checkAll">
            <input type="checkbox" id="chkall"/>
        </c:set>
        <display:table name="privateDataList" id="privateDataList" requestURI="submitpublish.ht" sort="external" cellpadding="1"
                       cellspacing="1" export="false" class="layui-table" pagesize="10">
            <display:column title="${checkAll}" media="html" style="width:3%;">
                <input type="checkbox" class="pk" name="id" value="${taskList.ddTaskId}">
            </display:column>
            <display:column property="ddDataId" title="数据编号" sortable="true" maxLength="80"></display:column>
            <display:column property="ddDataName" title="数据名称" sortable="true"></display:column>
            <display:column property="ddDataType" title="数据类型" maxLength="80"></display:column>
            <display:column property="ddDataLastestValue" title="最新数据" sortable="true"></display:column>
            <display:column property="ddDataDescription" title="数据描述" sortable="true"></display:column>
            <display:column property="ddDataTaskId" title="数据所属任务" sortable="true"></display:column>
            <%--<display:column title="操作" media="html" style="width:350px">--%>
                <%--<a href="submitpublish.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-mini"><i--%>
                        <%--class="layui-icon">&#xe642;</i> 更新发布数据</a>--%>
                <%--<a href="showorder.ht?id=${taskList.ddTaskId}" class="layui-btn layui-btn-normal layui-btn-mini"><i--%>
                        <%--class="layui-icon">&#xe615;</i> 查看订阅数据</a>--%>
                <%--<a href="#" class="layui-btn layui-btn-normal layui-btn-mini"><i--%>
                        <%--class="layui-icon">&#xe639;</i> 任务办理</a>--%>
            <%--</display:column>--%>
        </display:table>
        <%--<form id="datacentreForm" name="datacentreForm" method="post" action="submitpublish.ht"--%>
              <%--enctype="multipart/form-data">--%>
            <%--<div class="layui-tab-item layui-show">--%>
                <%--<table id="PrivateData" class="layui-table" cellpadding="1" cellspacing="1">--%>
                    <%--<thead>--%>
                    <%--<th style="text-align:center !important;">数据编号</th>--%>
                    <%--<th style="text-align:center !important;">数据名称</th>--%>
                    <%--<th style="text-align:center !important;">数据类型</th>--%>
                    <%--<th style="text-align:center !important;">最新数据</th>--%>
                    <%--<th style="text-align:center !important;">数据描述</th>--%>
                    <%--<th style="text-align:center !important;">数据所属任务</th>--%>
                    <%--</thead>--%>
                    <%--<tbody id="gridtbody">--%>
                    <%--<c:forEach items="${privateDataList}" var="privateDataItem">--%>
                        <%--<tr style="cursor:pointer">--%>
                        <%--<tr style="cursor:pointer">--%>
                            <%--<td style="text-align: center;">--%>
                                <%--<input name="ddDataId" type="hidden" value="${privateDataItem.ddDataId}">--%>
                                    <%--${privateDataItem.ddDataId}--%>
                            <%--</td>--%>
                            <%--<td style="text-align: center;">--%>
                                <%--<input type="hidden" name="ddDataName" value="${privateDataItem.ddDataName}">--%>
                                    <%--${privateDataItem.ddDataName}--%>
                            <%--</td>--%>
                            <%--<td style="text-align: center;">--%>
                                <%--<input type="hidden" name="ddDataType" value="${privateDataItem.ddDataType}">--%>
                                    <%--${privateDataItem.ddDataType}--%>
                            <%--</td>--%>
                            <%--<td style="text-align: center;">--%>
                                <%--<input type="hidden" name="ddDataDescription"--%>
                                       <%--value="${privateDataItem.ddDataLastestValue}">--%>
                                <%--<font color="red">${privateDataItem.ddDataLastestValue}</font>--%>
                            <%--</td>--%>
                            <%--<td style="text-align: center;">--%>
                                <%--<input type="hidden" name="ddDataDescription"--%>
                                       <%--value="${privateDataItem.ddDataDescription}">--%>
                                    <%--${privateDataItem.ddDataDescription}--%>
                            <%--</td>--%>
                            <%--<td style="text-align: center;">--%>
                                <%--<input type="hidden" name="ddDataTaskId" value="${privateDataItem.ddDataTaskId}">--%>
                                    <%--${privateDataItem.ddDataTaskId}--%>
                            <%--</td>--%>


                        <%--</tr>--%>
                    <%--</c:forEach>--%>
                    <%--</tbody>--%>
                <%--</table>--%>
            <%--</div>--%>
        <%--</form>--%>
    </div>
</div>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</body>
</html>
