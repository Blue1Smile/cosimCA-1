<%--
	time:2013-04-11 11:48:44
	desc:edit the 业务定义，如邀标采购这样的大业务。
--%>
<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@page import="com.hotent.core.util.ContextUtil" %>
<html>
<head>
    <title>私有数据添加</title>
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
            var frm = $('#privateDataForm').form();
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

                        window.location.href = "${ctx}/datadriver/privatedata/list.ht?id=${taskId}";

            } else {

            }
        }

    </script>
    <style>
        .fr {
            float: right;
        }
    </style>
</head>
<body>
<div class="layui-tab layui-tab-card">
    <ul class="layui-tab-title">
        <c:choose>
            <c:when test="">
                <li class="layui-this">编辑私有数据信息</li>
            </c:when>
            <c:otherwise>
                <li class="layui-this">添加私有数据信息</li>
            </c:otherwise>
        </c:choose>
    </ul>
    <div class="layui-tab-content" style="height: 100%;">
        <blockquote class="layui-elem-quote">
            <div style="height: 40px;">
                <div class="fr">
                    <a class="layui-btn layui-btn-normal" id="dataFormSave" href="#"><i
                            class="layui-icon">&#xe61e;</i> 保存</a>
                    <a class="layui-btn layui-btn-normal" href="list.ht?id=${taskId}"><i
                            class="layui-icon">&#xe603;</i> 返回</a>
                </div>
            </div>
        </blockquote>
        <form id="privateDataForm" name="privateDataForm" method="post" action="save.ht" enctype="multipart/form-data">
            <table id="AddHandlingFee" class="layui-table" cellpadding="0" cellspacing="0" border="0" type="main">
                <tr>

                    <th width="20%">数据名称:</th>
                    <td><input type="text" id="ddDataName" name="ddDataName" value="${PrivateData.ddDataName}"
                               class="layui-input"/></td>
                    <th width="20%">灵敏阈:</th>
                    <td><input type="text" id="ddDataSensitiveness" name="ddDataSensitiveness"
                               value="${PrivateData.ddDataSensitiveness}" class="layui-input"/></td>
                </tr>
                <tr>
                    <th width="20%">数据类型:</th>
                    <td><input type="text" id="ddDataType" name="ddDataType" value="${PrivateData.ddDataType}"
                               class="layui-input"/></td>
                    <th width="20%">数据描述:</th>
                    <td><input type="text" id="ddDataDescription" name="ddDataDescription"
                               validate="{required:false}" class="layui-input"
                               value="${PrivateData.ddDataDescription}"/>
                    </td>
                </tr>
                <tr>
                    <th width="20%">所属任务:</th>
                    <td>
                        <c:choose>
                            <c:when test="${!empty taskInfo}">
                                <input type="text" id="ddDataTaskName" name="ddDataTaskName"
                                       value="${taskInfo.ddTaskName}"
                                       class="layui-input"/>
                            </c:when>
                            <c:otherwise>
                                <input type="text" id="ddDataTaskName" name="ddDataTaskName"
                                       value="${PrivateData.ddDataTaskName}"
                                       class="layui-input"/>
                            </c:otherwise>
                        </c:choose>

                    </td>
                    <th width="20%">数据可见性:</th>
                    <td><input type="text" id="ddDataPublishType" name="ddDataPublishType"
                               value="${PrivateData.ddDataPublishType}" class="layui-input"/></td>
                </tr>
                <tr>
                    <th width="20%">数据最新值:</th>
                    <td><input type="text" id="ddDataLastestValue" name="ddDataLastestValue"
                               value="${PrivateData.ddDataLastestValue}" class="layui-input"/></td>
                    <th width="20%">数据订阅状态:</th>
                    <td><input type="text" id="ddDataSubmiteState" name="ddDataSubmiteState"
                               value="${PrivateData.ddDataSubmiteState}" class="layui-input"/></td>
                </tr>
                <tr>
                    <th width="20%">创建人:</th>
                    <td><input type="text" id="ddDataCreatePerson" name="ddDataCreatePerson"
                               value="${PrivateData.ddDataCreatePerson}" class="layui-input"/></td>
                    <th width="20%">创建时间:</th>
                    <td><input type="text" id="ddDataCreateTime" name="ddDataCreateTime"
                               value="${PrivateData.ddDataCreateTime}" class="layui-input"/></td>
                </tr>
                <tr>
                    <th width="20%">是否交付:</th>
                    <td><input type="text" id="ddDataIsDelivery" name="ddDataIsDelivery"
                               value="${PrivateData.ddDataIsDelivery}" class="layui-input"/></td>

                </tr>
                <tr>
                    <th width="20%">模型文件1111:</th>
                    <td><input type="text" id="ddDataIsModel" name="ddDataIsModel"
                               value="${PrivateData.ddDataIsDelivery}" class="layui-input"/></td>

                </tr>
            </table>
            <input type="hidden" name="ddDataId" id="ddDataId" value="${PrivateData.ddDataId}">
            <c:choose>
                <c:when test="${!empty taskInfo}">
                    <input type="hidden" name="ddDataTaskId" id="ddDataTaskId" value="${taskInfo.ddTaskId}"/>
                </c:when>
                <c:otherwise>
                    <input type="hidden" name="ddDataTaskId" id="ddDataTaskId" value="${PrivateData.ddDataTaskId}"/>
                </c:otherwise>
            </c:choose>

        </form>
    </div>
</div>
</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</html>
