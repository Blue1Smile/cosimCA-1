<%--
  Created by IntelliJ IDEA.
  User: dodo
  Date: 2016/12/14
  Time: 下午3:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="/commons/include/form.jsp" %>
    <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <title>添加任务</title>
</head>
<body>
<form id="taskInfoForm" name="taskInfoForm" method="post" action="save.ht"
      enctype="multipart/form-data">
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
                       value="${projectItem.ddProjectName}" class="layui-input"/></td>
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

                <div class="layui-input-inline">
                    <select name="ddTaskResponsiblePerson" class="layui-select" id="personSelect">
                        <c:forEach var="personItem" items="${sysUserList}">
                            <option value="${personItem.userId}"
                                    <c:if test="${TaskInfo.ddTaskPerson == '${personItem.fullname}'}">selected="selected"</c:if>>${personItem.fullname}</option>
                        </c:forEach>
                    </select>
                </div>

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

        <tr>
            <%--<th width="20%">任务完成状态:</th>--%>
            <%--<td><input type="text" id="ddTaskCompleteState" name="ddTaskCompleteState" value="${TaskInfo.ddTaskCompleteState}" class="layui-input"/></td>--%>
            <%--<th width="20%">任务资源id:</th>--%>
            <%--<td><input type="text" id="ddTaskResourceId" name="ddTaskResourceId" value="${TaskInfo.ddTaskResourceId}" class="layui-input"/></td>--%>
        </tr>
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
        <input type="hidden" id="ddTaskCompleteState" name="ddTaskCompleteState"
               value="${TaskInfo.ddTaskCompleteState}" class="layui-input"/>
        <input type="hidden" id="ddTaskResourceId" name="ddTaskResourceId"
               value="${TaskInfo.ddTaskResourceId}" class="layui-input"/>
        <input type="hidden" id="ddTaskProjectId" name="ddTaskProjectId"
               value="${projectItem.ddProjectId}" class="layui-input"/>
        <input type="hidden" id="ddTaskPerson" name="ddTaskPerson"
               value="${TaskInfo.ddTaskPerson}" class="layui-input"/>
    </table>
</form>
<center>
    <button class="layui-btn layui-btn-normal" id="dataFormSave">保存</button>
    <button class="layui-btn layui-btn-primary" id="">取消</button>
</center>
</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
<script type="text/javascript">
    $("#personSelect").change(function () {
        var taskPerson = $("#personSelect").find("option:selected").text();
        $("#ddTaskPerson").val(taskPerson);
    });

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
                    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                    parent.layer.close(index); //再执行关闭
                    window.location.href = "${ctx}/datadriver/task/list.ht";
                }
            });
        } else {
            $.ligerMessageBox.error("提示信息", obj.getMessage());
        }
    }

</script>
</html>
