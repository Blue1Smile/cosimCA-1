<%--
  Created by IntelliJ IDEA.
  User: dodo
  Date: 2017/2/16
  Time: 下午3:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
  <%@include file="/commons/include/form.jsp" %>
  <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
  <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
  <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
  <script type="text/javascript" src="${ctx}/timeselect/bootstrap-datetimepicker.min.js"></script>
  <%--<link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>--%>
  <link href="${ctx}/timeselect/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>

  <title>添加私有数据</title>
</head>
<body>
<div class="modal-header">
  <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">Close</span></button>
  <h4 class="modal-title" id="myModalLabel">私有数据创建</h4>
</div>
<div class="modal-body">
  <div class="container-fluid">
    <form id="privateDataForm" name="privateDataForm" method="post" action="${ctx}/datadriver/privatedata/save.ht"
          enctype="multipart/form-data">
      <table id="AddHandlingFee" class="table table-striped" cellpadding="0" cellspacing="0"
             border="0"
             type="main">
        <tr>
          <th width="20%">数据名称:</th>
          <td><input type="text" id="ddDataName" name="ddDataName"
                     value="" class="form-control"/></td>
          <%--<th width="20%">任务编号:</th>--%>
          <%--<td><input type="text" id="ddTaskId" name="ddTaskId" value="${TaskInfo.ddTaskId}" class="layui-input"/></td>--%>
          <th width="20%">数据所属任务:</th>
          <td><input type="text" id="ddDataTaskName" name="ddDataTaskName"
                     value="${taskInfo.ddTaskName}" class="form-control" readonly/></td>
        </tr>
        <tr>
          <th width="20%">数据类型:</th>
          <td><input type="text" id="ddDataType" name="ddDataType"
                     value="" class="form-control"/></td>
          <th width="20%">数据敏感度:</th>
          <td><input type="text" id="ddDataSensitiveness" name="ddDataSensitiveness"
                     value=""
                     class="form-control"/></td>
          <%--<th width="20%">任务子类型:</th>--%>
          <%--<td><input type="text" id="ddTaskChildType" name="ddTaskChildType"--%>
          <%--value="${TaskInfo.ddTaskChildType}" class="form-control"/></td>--%>
        </tr>
        <tr>
          <th width="20%">数据创建时间:</th>
          <td><input type="text" id="ddDataCreateTime" name="ddDataCreateTime"
                     value="${currentTime}" readonly class="form_datetime form-control"/></td>
          <th width="20%">数据创建人:</th>
          <td><input type="text" id="ddDataCreatePerson" name="ddDataCreatePerson"
                     value="${sysName}" readonly class="form-control"/></td>

            <%--<div class="radio radio-info radio-inline">--%>
              <%--<input type="radio" name="ddTaskMilestone" id="ddTaskMilestone1" value="1" checked>--%>
              <%--<label for="ddTaskMilestone1">--%>
                <%--是--%>
              <%--</label>--%>
            <%--</div>--%>
            <%--<div class="radio radio-info radio-inline">--%>
              <%--<input type="radio" name="ddTaskMilestone" id="ddTaskMilestone0" value="0">--%>
              <%--<label for="ddTaskMilestone0">--%>
                <%--否--%>
              <%--</label>--%>
            <%--</div>--%>


          <%--</td>--%>
          <%--<input type="text" id="ddTaskMilestone" name="ddTaskMilestone"--%>
          <%--value="${TaskInfo.ddTaskMilestone}" class="form-control"/></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
          <%--<th width="20%">任务负责人:</th>--%>
          <%--<td>--%>
            <%--<div class="layui-input-inline">--%>
              <%--<select name="ddTaskResponsiblePerson" class="form-control" id="personSelect">--%>
                <%--<c:forEach var="personItem" items="${sysUserList}">--%>
                  <%--<option value="${personItem.userId}"--%>
                          <%--<c:if test="${TaskInfo.ddTaskPerson == '${personItem.fullname}'}">selected="selected"</c:if>>${personItem.fullname}</option>--%>
                <%--</c:forEach>--%>
              <%--</select>--%>
            <%--</div>--%>
          <%--</td>--%>
          <%--<th width="20%">任务是否固化:</th>--%>
          <%--<td><input type="text" id="ddTaskFixedPattern" name="ddTaskFixedPattern"--%>
          <%--value="${TaskInfo.ddTaskFixedPattern}" class="form-control"/></td>--%>
        <%--</tr>--%>
        <tr>
          <th width="20%">任务基本描述:</th>
          <td colspan="3"><textarea id="ddDataDescription" name="ddDataDescription"
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
        <button class="btn btn-primary btn-block" id="dataFormSave">创建新私有数据</button>
      </div>
      <%--<div class="col-xs-6">--%>
        <%--<button class="btn btn-default btn-block" id="createfrommodel">从模版创建任务</button>--%>
      <%--</div>--%>
    </div>

  </div>
</div>
</body>
<script type="text/javascript">

  $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});
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
      var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
      parent.layer.close(index); //再执行关闭
      window.location.href = "${ctx}/datadriver/task/stepinto.ht?id=${taskItem.ddTaskId}";
    } else {
//            $.ligerMessageBox.error("提示信息", obj.getMessage());
    }
  }

</script>
<script type="text/javascript" src="${ctx}/timeselect/bootstrap-datetimepicker.zh-CN.js"></script>
</html>

