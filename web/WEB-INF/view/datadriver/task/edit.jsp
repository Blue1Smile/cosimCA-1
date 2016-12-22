<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@page import="com.hotent.core.util.ContextUtil" %>
<html>
<head>
    <title>任务基础信息添加</title>
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
            var frm = $('#taskInfoForm').form();
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
                        window.location.href = "${ctx}/datadriver/task/list.ht";
                    }
                });
            } else {
                $.ligerMessageBox.error("提示信息", obj.getMessage());
            }
        }

    </script>
    <style>
        #iframe_tab {
            margin-top: 0px;
        }
    </style>
</head>
<body>
<div class="panel">
    <fieldset class="layui-elem-field">
        <legend>任务详细配置</legend>
        <div class="layui-field-box">
            <a class="layui-btn layui-btn-normal" id="dataFormSave" href="#">保存</a>
            <%--<a class="layui-btn layui-btn-normal" id="privatedatalist" href="${ctx}/datadriver/privatedata/list.ht?id=${TaskInfo.ddTaskId}">任务私有数据</a>--%>
            <%--<a class="layui-btn layui-btn-normal" id="dataFormSave" href="publishconfig.ht?id=${TaskInfo.ddTaskId}">任务发布数据</a>--%>
            <%--<a class="layui-btn layui-btn-normal" id="dataFormSave" href="orderconfig.ht?id=${TaskInfo.ddTaskId}">任务订阅数据</a>--%>
            <div class="panel-body">
                <form id="taskInfoForm" name="taskInfoForm" method="post" action="save.ht"
                      enctype="multipart/form-data">
                    <div class="layui-tab layui-tab-card" id="iframe_tab">
                        <ul class="layui-tab-title">
                            <li class="layui-this">任务配置</li>
                            <%--<li>任务私有数据</li>--%>
                            <%--<li>任务发布数据</li>--%>
                            <%--<li>任务订阅数据</li>--%>
                    </ul>
                        <div class="layui-tab-content" style="height: 100%;">
                            <div class="layui-tab-item layui-show">
                                <table id="AddHandlingFee" class="layui-table" cellpadding="0" cellspacing="0"
                                       border="0"
                                       type="main">
                                    <tr>
                                        <th width="20%">任务名称:</th>
                                        <td><input type="text" id="ddTaskName" name="ddTaskName"
                                                   value="${TaskInfo.ddTaskName}" class="layui-input"/></td>
                                        <%--<th width="20%">任务编号:</th>--%>
                                        <%--<td><input type="text" id="ddTaskId" name="ddTaskId" value="${TaskInfo.ddTaskId}" class="layui-input"/></td>--%>
                                        <th width="20%">任务所属项目:</th>
                                        <td><input type="text" id="ddTaskProjectName" name="ddTaskProjectName"
                                                   value="${TaskInfo.ddTaskProjectName}" class="layui-input"/></td>
                                    </tr>
                                    <tr>
                                        <th width="20%">任务基本描述:</th>
                                        <td><input type="text" id="ddTaskDescription" name="ddTaskDescription"
                                                   value="${TaskInfo.ddTaskDescription}" class="layui-input"/></td>
                                        <th width="20%">计划工期:</th>
                                        <td><input type="text" id="ddTaskPlanDuration" name="ddTaskPlanDuration"
                                                   value="${TaskInfo.ddTaskPlanDuration}" class="layui-input"/></td>
                                        <%--<th width="20%">任务创建者id:</th>--%>
                                        <%--<td><input type="text" id="ddTaskCreatorId" name="ddTaskCreatorId" value="${TaskInfo.ddTaskCreatorId}" class="layui-input"/></td>--%>
                                    </tr>
                                    <tr>
                                        <th width="20%">任务负责人:</th>
                                        <td>
                                            <select name="ddTaskResponsiblePerson" class="layui-input"
                                                    id="personSelect">
                                                <c:forEach var="personItem" items="${sysUserList}">
                                                    <option value="${personItem.userId}"
                                                            <c:if test="${personItem.fullname == TaskInfo.ddTaskPerson}">selected</c:if>>${personItem.fullname}</option>
                                                </c:forEach>
                                            </select>
                                        </td>

                                    <th width="20%">任务是否固化:</th>
                                    <td><input type="text" id="ddTaskFixedPattern" name="ddTaskFixedPattern"
                                               value="${TaskInfo.ddTaskFixedPattern}" class="layui-input"/></td>
                                    </tr>
                                    <tr>
                                        <th width="20%">任务类型:</th>
                                        <td><input type="text" id="ddTaskType" name="ddTaskType"
                                                   value="${TaskInfo.ddTaskType}" class="layui-input"/></td>
                                        <th width="20%">任务子类型:</th>
                                        <td><input type="text" id="ddTaskChildType" name="ddTaskChildType"
                                                   value="${TaskInfo.ddTaskChildType}" class="layui-input"/></td>
                                    </tr>
                                    <tr>
                                        <th width="20%">优先级:</th>
                                        <td><input type="text" id="ddTaskPriority" name="ddTaskPriority"
                                                   value="${TaskInfo.ddTaskPriority}" class="layui-input"/></td>
                                        <th width="20%">是否里程碑任务:</th>
                                        <td><input type="text" id="ddTaskMilestone" name="ddTaskMilestone"
                                                   value="${TaskInfo.ddTaskMilestone}" class="layui-input"/></td>
                                    </tr>

                                    <tr>
                                        <th width="20%">任务计划工时:</th>
                                        <td><input type="text" id="ddTaskEstimateTime" name="ddTaskEstimateTime"
                                                   value="${TaskInfo.ddTaskEstimateTime}" class="layui-input"/></td>
                                        <th width="20%">任务计划开始时间:</th>
                                        <td><input type="text" id="ddTaskPlanStartTime" name="ddTaskPlanStartTime"
                                                   value="${TaskInfo.ddTaskPlanStartTime}" class="layui-input"/></td>
                                    </tr>
                                    <tr>
                                        <th width="20%">任务计划结束时间:</th>
                                        <td><input type="text" id="ddTaskPlanEndTime" name="ddTaskPlanEndTime"
                                                   value="${TaskInfo.ddTaskPlanEndTime}" class="layui-input"/></td>
                                        <th width="20%">任务完成率:</th>
                                        <td><input type="text" id="ddTaskCompleteRate" name="ddTaskCompleteRate"
                                                   value="${TaskInfo.ddTaskCompleteRate}" class="layui-input"/></td>
                                    </tr>

                                    <%--<tr>--%>
                                    <%--&lt;%&ndash;<th width="20%">任务完成状态:</th>&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;<td><input type="text" id="ddTaskCompleteState" name="ddTaskCompleteState" value="${TaskInfo.ddTaskCompleteState}" class="layui-input"/></td>&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;<th width="20%">任务资源id:</th>&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;<td><input type="text" id="ddTaskResourceId" name="ddTaskResourceId" value="${TaskInfo.ddTaskResourceId}" class="layui-input"/></td>&ndash;%&gt;--%>
                                    <%--</tr>--%>
                                    <tr>
                                        <th width="20%">实际工时:</th>
                                        <td><input type="text" id="ddTaskActualTime" name="ddTaskActualTime"
                                                   value="${TaskInfo.ddTaskActualTime}" class="layui-input"/></td>
                                        <th width="20%">计划工时:</th>
                                        <td><input type="text" id="ddTaskPlanTime" name="ddTaskPlanTime"
                                                   value="${TaskInfo.ddTaskPlanTime}" class="layui-input"/></td>
                                    </tr>
                                    <tr>
                                        <th width="20%">实际开始日期:</th>
                                        <td><input type="text" id="ddTaskActualStartTime" name="ddTaskActualStartTime"
                                                   value="${TaskInfo.ddTaskActualStartTime}" class="layui-input"/></td>
                                        <th width="20%">实际结束日期:</th>
                                        <td><input type="text" id="ddTaskActualEndTime" name="ddTaskActualEndTime"
                                                   value="${TaskInfo.ddTaskActualEndTime}" class="layui-input"/></td>
                                    </tr>
                                    <input type="hidden" id="ddTaskId" name="ddTaskId" value="${TaskInfo.ddTaskId}"
                                           class="layui-input"/>
                                    <input type="hidden" id="ddTaskCreatorId" name="ddTaskCreatorId"
                                           value="${TaskInfo.ddTaskCreatorId}" class="layui-input"/>
                                    <input type="hidden" id="ddTaskProjectId" name="ddTaskProjectId"
                                           value="${TaskInfo.ddTaskProjectId}" class="layui-input"/>
                                    <input type="hidden" id="ddTaskCompleteState" name="ddTaskCompleteState"
                                           value="${TaskInfo.ddTaskCompleteState}" class="layui-input"/>
                                    <input type="hidden" id="ddTaskResourceId" name="ddTaskResourceId"
                                           value="${TaskInfo.ddTaskResourceId}" class="layui-input"/>
                                    <%--<input type="hidden" id="ddTaskResponsiblePerson" name="ddTaskResponsiblePerson"--%>
                                    <%--value="${TaskInfo.ddTaskResponsiblePerson}" class="layui-input"/>--%>
                                    <input type="hidden" id="ddTaskPerson" name="ddTaskPerson"
                                           value="${TaskInfo.ddTaskPerson}" class="layui-input"/>
                                </table>
                            </div>
                            <%--<!--任务私有数据-->--%>
                            <%--<div class="layui-tab-item">--%>
                                <%--<table class="layui-table" cellpadding="1" cellspacing="1" id="privateData"--%>
                                       <%--formType="window" type="sub">--%>
                                    <%--<tr>--%>
                                        <%--<td colspan="11">--%>
                                            <%--<div class="group" align="left">--%>
                                                <%--<a id="btnAdd" class="link add">添加</a>--%>
                                            <%--</div>--%>
                                            <%--<div align="center">--%>
                                                <%--任务编辑：添加私有数据--%>
                                            <%--</div>--%>
                                        <%--</td>--%>
                                    <%--</tr>--%>
                                    <%--<tr>--%>
                                        <%--<th>数据名称</th>--%>
                                        <%--<th>数据类型</th>--%>
                                        <%--<th>灵敏阈</th>--%>
                                        <%--<th>操作</th>--%>
                                    <%--</tr>--%>
                                    <%--<c:forEach items="${privateDataList}" var="privateDataList"--%>
                                               <%--varStatus="status">--%>
                                        <%--<tr type="subdata">--%>
                                            <%--<td style="text-align: center"--%>
                                                <%--name="ddDataName">${privateDataList.ddDataName}</td>--%>
                                            <%--<td style="text-align: center"--%>
                                                <%--name="ddDataType">${privateDataList.ddDataType}</td>--%>
                                            <%--<td style="text-align: center"--%>
                                                <%--name="ddDataSensitiveness">${privateDataList.ddDataSensitiveness}</td>--%>
                                                <%--&lt;%&ndash;<td style="text-align: center"&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;name="url2">${task.url2}</td>&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;<td style="text-align: center"&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;name="url2Name">${cloudResourceInstanceListItem.url2Name}</td>&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;<td style="text-align: center"&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;name="blank1">${cloudResourceInstanceListItem.blank1}</td>&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;<td style="text-align: center"&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;name="blank2">${cloudResourceInstanceListItem.blank2}</td>&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;<td style="text-align: center"&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;name="mode">${cloudResourceInstanceListItem.mode}</td>&ndash;%&gt;--%>
                                            <%--<td style="text-align: center">--%>
                                                <%--<a href="#" class="link del">删除</a>--%>
                                                <%--<a href="#" class="link edit">编辑</a>--%>
                                            <%--</td>--%>
                                            <%--<input type="hidden" name="ddDataId" value="${privateDataList.ddDataId}"/>--%>
                                            <%--<input type="hidden" name="ddDataName"--%>
                                                   <%--value="${privateDataList.ddDataName}"/>--%>
                                            <%--<input type="hidden" name="ddDataType"--%>
                                                   <%--value="${privateDataList.ddDataType}"/>--%>
                                            <%--<input type="hidden" name="ddDataDescription"--%>
                                                   <%--value="${privateDataList.ddDataDescription}"/>--%>
                                            <%--<input type="hidden" name="ddDataTaskId"--%>
                                                   <%--value="${privateDataList.ddDataTaskId}"/>--%>
                                            <%--<input type="hidden" name="ddDataPublishType"--%>
                                                   <%--value="${privateDataList.ddDataPublishType}"/>--%>
                                            <%--<input type="hidden" name="ddDataLastestValue"--%>
                                                   <%--value="${privateDataList.ddDataLastestValue}"/>--%>
                                            <%--<input type="hidden" name="ddDataSubmiteState"--%>
                                                   <%--value="${privateDataList.ddDataSubmiteState}"/>--%>
                                            <%--<input type="hidden" name="ddDataCreatePerson"--%>
                                                   <%--value="${privateDataList.ddDataCreatePerson}"/>--%>
                                            <%--<input type="hidden" name="ddDataCreateTime"--%>
                                                   <%--value="${privateDataList.ddDataCreateTime}"/>--%>
                                            <%--<input type="hidden" name="ddDataIsDelivery"--%>
                                                   <%--value="${privateDataList.ddDataIsDelivery}"/>--%>
                                            <%--<input type="hidden" name="ddDataSensitiveness"--%>
                                                   <%--value="${privateDataList.ddDataSensitiveness}"/>--%>
                                        <%--</tr>--%>
                                    <%--</c:forEach>--%>
                                    <%--<tr type="append">--%>
                                        <%--<td style="text-align: center" name="ddDataName"></td>--%>
                                        <%--<td style="text-align: center" name="ddDataType"></td>--%>
                                        <%--<td style="text-align: center" name="ddDataSensitiveness"></td>--%>
                                        <%--<td style="text-align: center">--%>
                                            <%--<a href="#" class="link del">删除</a>--%>
                                            <%--<a href="#" class="link edit">编辑</a>--%>
                                        <%--</td>--%>
                                        <%--<input type="hidden" name="ddDataId" value=""/>--%>
                                        <%--<input type="hidden" name="ddDataName" value=""/>--%>
                                        <%--<input type="hidden" name="ddDataType" value=""/>--%>
                                        <%--<input type="hidden" name="ddDataDescription" value=""/>--%>
                                        <%--<input type="hidden" name="ddDataTaskId" value=""/>--%>
                                        <%--<input type="hidden" name="ddDataPublishType" value=""/>--%>
                                        <%--<input type="hidden" name="ddDataLastestValue" value=""/>--%>
                                        <%--<input type="hidden" name="ddDataSubmiteState" value=""/>--%>
                                        <%--<input type="hidden" name="ddDataCreatePerson" value=""/>--%>
                                        <%--<input type="hidden" name="ddDataCreateTime" value=""/>--%>
                                        <%--<input type="hidden" name="ddDataIsDelivery" value=""/>--%>
                                        <%--<input type="hidden" name="ddDataSensitiveness" value=""/>--%>
                                    <%--</tr>--%>
                                <%--</table>--%>
                            <%--</div>--%>
                            <%--<!--任务发布数据-->--%>
                            <%--<div class="layui-tab-item">--%>
                                <%--<iframe src="${ctx}/datadriver/task/publishconfig.ht?id=${TaskInfo.ddTaskId}"--%>
                                        <%--style="width: 100%;height: 500px" scrolling="auto" frameborder="no"></iframe>--%>
                            <%--</div>--%>
                            <%--<!--任务订阅数据-->--%>
                            <%--<div class="layui-tab-item">--%>
                                <%--<iframe src="${ctx}/datadriver/task/orderconfig.ht?id=${TaskInfo.ddTaskId}"--%>
                                        <%--style="width: 100%;height: 500px" scrolling="auto" frameborder="no"></iframe>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                </form>
                <%--<form id="privateDataForm" style="display:none">--%>
                    <%--<table class="layui-table" cellpadding="1" cellspacing="1" border="1">--%>
                        <%--<colgroup>--%>
                            <%--<col width="150">--%>
                            <%--<col width="200">--%>
                        <%--</colgroup>--%>
                        <%--<tr>--%>
                            <%--<th width="20%">数据名称:</th>--%>
                            <%--<td><input type="text" name="ddDataName" value="" class="layui-input"--%>
                                       <%--validate="{required:false,maxlength:96}"/></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<th width="20%">数据类型:</th>--%>
                            <%--<td><input type="text" name="ddDataType" value="" class="layui-input"--%>
                                       <%--validate="{required:false}"/>--%>
                            <%--</td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<th width="20%">灵敏阈:</th>--%>
                            <%--<td><input type="text" name="ddDataSensitiveness" value="" class="layui-input"--%>
                                       <%--validate="{required:false,maxlength:768}"/></td>--%>
                        <%--</tr>--%>
                    <%--</table>--%>
                <%--</form>--%>
            </div>
        </div>
    </fieldset>
</div>
</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
<script>
    $("#personSelect").change(function () {
        var taskPerson = $("#personSelect").find("option:selected").text();
        $("#ddTaskPerson").val(taskPerson);
    });
</script>
</html>
