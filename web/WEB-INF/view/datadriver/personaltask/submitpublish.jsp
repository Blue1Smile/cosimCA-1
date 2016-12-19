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
            $("a.save").click(function () {
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
<%--<div class="tbar-title">--%>
    <%--<span class="tbar-label">发布数据编辑</span>--%>

<%--</div>--%>
<div class="panel">
    <%--<div class="panel-top">--%>
        <%--<div class="panel-toolbar">--%>
            <%--<div class="toolBar">--%>

                <%--<div class="l-bar-separator"></div>--%>
                <%--<div class="group"><a class="link back " href="list.ht">返回</a>--%>

                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
    <div class="panel-body">

        <!--20161202-->
        <form id="datacentreForm" name="datacentreForm" method="post" action="submitdatavalue.ht"
              enctype="multipart/form-data">
            <div class="layui-tab-item layui-show">
                <table id="PrivateData" class="table-grid table-list" cellpadding="1" cellspacing="1">
                    <thead>
                    <th style="text-align:center !important;">数据编号</th>
                    <th style="text-align:center !important;">数据名称</th>
                    <th style="text-align:center !important;">数据类型</th>
                    <th style="text-align:center !important;">数据描述</th>
                    <th style="text-align:center !important;">数据所属任务</th>
                    <th style="text-align:center !important;">发布数据</th>
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
                                <input type="text" name="ddDataLastestValue"
                                       value="${privateDataItem.ddDataLastestValue}">

                            </td>
                            <td style="text-align: center;">
                                <input type="hidden" name="ddDataTaskId" value="${privateDataItem.ddDataTaskId}">
                                    ${privateDataItem.ddDataTaskId}
                            </td>
                            <td style="text-align: center;">

                                    <%--<a href="submitdata?ddDataLastestValue=${privateDataItem.ddDataLastestValue}&ddDataId=${privateDataItem.ddDataId}" >发布</a>--%>


                            </td>

                        </tr>
                    </c:forEach>
                    <input type="submit" name="sumbit" value="发布"/>

                    </tbody>
                </table>
            </div>
        </form>
    </div>
</div>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</body>
</html>
