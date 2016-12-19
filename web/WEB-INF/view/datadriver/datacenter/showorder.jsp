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

</head>
<body>

<div class="layui-tab layui-tab-card">
    <ul class="layui-tab-title">
        <li class="layui-this">订阅数据列表</li>
    </ul>
    <div class="layui-tab-content">
        <div style="height: 50px;">
            <a class="layui-btn layui-btn-normal" id="dataFormSave" href="#">保存</a>

            <a class="layui-btn layui-btn-normal" href="list.ht">返回</a>

        </div>
        <!--20161202-->
        <form id="datacentreForm" name="datacentreForm" method="post" action="submitpublish.ht"
              enctype="multipart/form-data">
            <div class="layui-tab-item layui-show">
                <table id="PrivateData" class="layui-table" cellpadding="1" cellspacing="1">
                    <thead>
                    <th style="text-align:center !important;">数据编号</th>
                    <th style="text-align:center !important;">数据名称</th>
                    <th style="text-align:center !important;">数据类型</th>
                    <th style="text-align:center !important;">数据描述</th>
                    <th style="text-align:center !important;">数据所属任务</th>
                    </thead>
                    <tbody id="gridtbody">
                    <c:forEach items="${privateDataList}" var="privateDataItem">
                        <tr style="cursor:pointer">
                        <tr style="cursor:pointer">
                            <td style="text-align: center;">
                                <input name="ddDataId" type="hidden" value="${privateDataItem.ddDataId}">
                                    ${privateDataItem.ddDataId}
                            </td>
                            <td style="text-align: center;">
                                <input type="hidden" name="ddDataName" value="${privateDataItem.ddDataName}">
                                    ${privateDataItem.ddDataName}
                            </td>
                            <td style="text-align: center;">
                                <input type="hidden" name="ddDataType" value="${privateDataItem.ddDataType}">
                                    ${privateDataItem.ddDataType}
                            </td>
                            <td style="text-align: center;">
                                <input type="hidden" name="ddDataDescription"
                                       value="${privateDataItem.ddDataDescription}">
                                    ${privateDataItem.ddDataDescription}
                            </td>
                            <td style="text-align: center;">
                                <input type="hidden" name="ddDataTaskId" value="${privateDataItem.ddDataTaskId}">
                                    ${privateDataItem.ddDataTaskId}
                            </td>


                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </form>
    </div>
</div>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</body>
</html>
