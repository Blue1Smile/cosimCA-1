<%--
  Created by IntelliJ IDEA.
  User: dodo
  Date: 2016/12/14
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

  <title>提交信息</title>
</head>
<body>
<div class="modal-header">
  <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">Close</span></button>
  <c:choose><c:when test="${valueLength==0}">
    <h4 class="modal-title" id="myModalLabel">提交成功</h4>
  </c:when>
    <c:otherwise>
      <h4 class="modal-title" id="myModalLabel">提交失败</h4>
    </c:otherwise></c:choose>
</div>
<div class="modal-body">
  <div class="container-fluid">
    <c:choose><c:when test="${valueLength==0}">
    </c:when>
      <c:otherwise>
        <c:set var="checkAll">
          <input type="checkbox" id="chkall"/>
        </c:set>
        <display:table name="publshListWithoutValue" id="publshListWithoutValueItem" requestURI="movetask.ht" sort="external"
                       cellpadding="1"
                       cellspacing="1" export="false" class="layui-table" pagesize="10">
          <display:column title="${checkAll}" media="html" style="width:3%;">
            <input type="checkbox" class="pk" name="id" value="${publshListWithoutValueItem.ddDataId}">
          </display:column>
          <display:column property="ddDataId" title="数据ID" sortable="true" sortName="DD_DATA_ID" maxLength="80"></display:column>
          <display:column property="ddDataName" title="数据名称" maxLength="80"></display:column>
          <display:column property="ddDataDescription" title="数据描述" maxLength="80"></display:column>
        </display:table>
      </c:otherwise></c:choose>

    <div class="row">

      <div class="col-xs-6">
        <%--<a id="confirm" class="btn btn-default btn-block" href="todotask.ht?id=${TaskInfo.ddTaskId}"><span class="glyphicon glyphicon-ok"></span> 确认--%>

        <a class="btn btn-default btn-block" href="todotask.ht?id=${ddTaskId}"  id="confirm">确认</a>
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
//    $("#confirm").click(function () {
//      frm.setData();
//      frm.ajaxForm(options);
//      if (frm.valid()) {
//        form.submit();
//      }
//    });
//  });

  function showResponse(responseText) {
    var obj = new com.hotent.form.ResultMessage(responseText);
    if (obj.isSuccess()) {
      var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
      parent.layer.close(index); //再执行关闭
      window.location.href = "todotask.ht?id=${TaskInfo.ddTaskId}";
    } else {
//            $.ligerMessageBox.error("提示信息", obj.getMessage());
    }
  }

</script>
<script type="text/javascript" src="${ctx}/timeselect/bootstrap-datetimepicker.zh-CN.js"></script>
</html>
