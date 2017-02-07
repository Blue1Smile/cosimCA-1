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
    <script type="text/javascript" src="${ctx}/timeselect/bootstrap-datetimepicker.min.js"></script>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/timeselect/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>

    <title>添加任务</title>
</head>
<body>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
            class="sr-only">Close</span></button>
    <h4 class="modal-title" id="myModalLabel">任务创建</h4>
</div>
<div class="modal-body">
    <div class="container-fluid">
        <form id="taskInfoForm" name="taskInfoForm" method="post" action="${ctx}/datadriver/task/save.ht"
              enctype="multipart/form-data">
            <table id="AddHandlingFee" class="table table-striped" cellpadding="0" cellspacing="0"
                   border="0"
                   type="main">
                <tr>
                    <th width="20%">任务名称:</th>
                    <td><input type="text" id="ddTaskName" name="ddTaskName"
                               value="" class="form-control"/></td>
                    <%--<th width="20%">任务编号:</th>--%>
                    <%--<td><input type="text" id="ddTaskId" name="ddTaskId" value="${TaskInfo.ddTaskId}" class="layui-input"/></td>--%>
                    <th width="20%">任务所属项目:</th>
                    <td><input type="text" id="ddTaskProjectName" name="ddTaskProjectName"
                               value="${projectItem.ddProjectName}" class="form-control" readonly/></td>
                </tr>
                <tr>
                    <th width="20%">任务类型:</th>
                    <td><input type="text" id="ddTaskType" name="ddTaskType"
                               value="" class="form-control"/></td>
                    <th width="20%">任务截至时间:</th>
                    <td><input type="text" name="ddTaskPlanEndTime"
                               value="" readonly
                               class="form_datetime form-control"/></td>
                    <%--<th width="20%">任务子类型:</th>--%>
                    <%--<td><input type="text" id="ddTaskChildType" name="ddTaskChildType"--%>
                    <%--value="${TaskInfo.ddTaskChildType}" class="form-control"/></td>--%>
                </tr>
                <tr>
                    <th width="20%">优先级:</th>
                    <td><input type="text" id="ddTaskPriority" name="ddTaskPriority"
                               value="" class="form-control"/></td>
                    <th width="20%">是否里程碑任务:</th>
                    <td>

                        <div class="radio radio-info radio-inline">
                            <input type="radio" name="ddTaskMilestone" id="ddTaskMilestone1" value="1" checked>
                            <label for="ddTaskMilestone1">
                                是
                            </label>
                        </div>
                        <div class="radio radio-info radio-inline">
                            <input type="radio" name="ddTaskMilestone" id="ddTaskMilestone0" value="0">
                            <label for="ddTaskMilestone0">
                                否
                            </label>
                        </div>


                    </td>
                    <%--<input type="text" id="ddTaskMilestone" name="ddTaskMilestone"--%>
                    <%--value="${TaskInfo.ddTaskMilestone}" class="form-control"/></td>--%>
                </tr>
                <tr>
                    <th width="20%">任务负责人:</th>
                    <td>
                        <div class="layui-input-inline">
                            <select name="ddTaskResponsiblePerson" class="form-control" id="personSelect">
                                <c:forEach var="personItem" items="${sysUserList}">
                                    <option value="${personItem.userId}"
                                            <c:if test="${TaskInfo.ddTaskPerson == '${personItem.fullname}'}">selected="selected"</c:if>>${personItem.fullname}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </td>
                    <%--<th width="20%">任务是否固化:</th>--%>
                    <%--<td><input type="text" id="ddTaskFixedPattern" name="ddTaskFixedPattern"--%>
                    <%--value="${TaskInfo.ddTaskFixedPattern}" class="form-control"/></td>--%>
                </tr>
                <tr>
                    <th width="20%">任务基本描述:</th>
                    <td colspan="3"><textarea id="ddTaskDescription" name="ddTaskDescription"
                                              value="" class="form-control"
                                              rows="5"/></textarea>
                    </td>
                    <%--<th width="20%">计划工期:</th>--%>
                    <%--<td><input type="text" id="ddTaskPlanDuration" name="ddTaskPlanDuration"--%>
                    <%--value="${TaskInfo.ddTaskPlanDuration}" class="form-control"/></td>--%>
                    <%--<th width="20%">任务创建者id:</th>--%>
                    <%--<td><input type="text" id="ddTaskCreatorId" name="ddTaskCreatorId" value="${TaskInfo.ddTaskCreatorId}" class="layui-input"/></td>--%>
                </tr>
                <%--<tr>--%>
                <%--<th width="20%">任务计划工时:</th>--%>
                <%--<td><input type="text" id="ddTaskEstimateTime" name="ddTaskEstimateTime"--%>
                <%--value="${TaskInfo.ddTaskEstimateTime}" class="form-control"/></td>--%>
                <%--<th width="20%">任务计划开始时间:</th>--%>
                <%--<td><input type="text" id="ddTaskPlanStartTime" name="ddTaskPlanStartTime"--%>
                <%--value="${TaskInfo.ddTaskPlanStartTime}" class="form-control"/></td>--%>
                <%--</tr>--%>


                <%--<th width="20%">任务完成率:</th>--%>
                <%--<td><input type="text" id="ddTaskCompleteRate" name="ddTaskCompleteRate"--%>
                <%--value="${TaskInfo.ddTaskCompleteRate}" class="form-control"/></td>--%>


                <%--<th width="20%">任务完成状态:</th>--%>
                <%--<td><input type="text" id="ddTaskCompleteState" name="ddTaskCompleteState" value="${TaskInfo.ddTaskCompleteState}" class="layui-input"/></td>--%>
                <%--<th width="20%">任务资源id:</th>--%>
                <%--<td><input type="text" id="ddTaskResourceId" name="ddTaskResourceId" value="${TaskInfo.ddTaskResourceId}" class="layui-input"/></td>--%>

                <%--<tr>--%>
                <%--<th width="20%">实际工时:</th>--%>
                <%--<td><input type="text" id="ddTaskActualTime" name="ddTaskActualTime"--%>
                <%--value="${TaskInfo.ddTaskActualTime}" class="form-control"/></td>--%>
                <%--<th width="20%">计划工时:</th>--%>
                <%--<td><input type="text" id="ddTaskPlanTime" name="ddTaskPlanTime"--%>
                <%--value="${TaskInfo.ddTaskPlanTime}" class="form-control"/></td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<th width="20%">实际开始日期:</th>--%>
                <%--<td><input type="text" id="ddTaskActualStartTime" name="ddTaskActualStartTime"--%>
                <%--value="${TaskInfo.ddTaskActualStartTime}" class="form-control"/></td>--%>
                <%--<th width="20%">实际结束日期:</th>--%>
                <%--<td><input type="text" id="ddTaskActualEndTime" name="ddTaskActualEndTime"--%>
                <%--value="${TaskInfo.ddTaskActualEndTime}" class="form-control"/></td>--%>
                <%--</tr>--%>
                <input type="hidden" id="ddTaskProjectId" name="ddTaskProjectId"
                       value="${projectItem.ddProjectId}" class="layui-input"/>
            </table>
        </form>
        <div class="row">
            <div class="col-xs-6">
                <input class="btn btn-primary btn-block" id="dataFormSave" value="创建新任务"/>
            </div>
            <div class="col-xs-6">
                <input class="btn btn-default btn-block" id="" value="从模版创建任务"/>
            </div>
        </div>

    </div>
</div>
</body>
<script type="text/javascript">
    $("#personSelect").change(function () {
        var taskPerson = $("#personSelect").find("option:selected").text();
        $("#ddTaskPerson").val(taskPerson);
    });
    $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});
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
<script type="text/javascript" src="${ctx}/timeselect/bootstrap-datetimepicker.zh-CN.js"></script>
</html>
