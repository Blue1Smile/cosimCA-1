<%--
  Created by IntelliJ IDEA.
  User: dodo
  Date: 2017/2/16
  Time: 下午3:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ap" uri="/appleTag" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <%--<%@include file="/commons/include/form.jsp" %>--%>
    <script type="text/javascript" src="${ctx}/js/jquery/jquery.form.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery/additional-methods.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
    <script type="text/javascript" src="${ctx}/js/util/util.js"></script>
    <script type="text/javascript" src="${ctx}/js/util/form.js"></script>
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
                    <th width="20%">数据所属任务:</th>
                    <td><input type="text" id="ddDataTaskName" name="ddDataTaskName"
                               value="${taskInfo.ddTaskName}" class="form-control" readonly/></td>
                </tr>
                <tr>
                    <th width="20%">数据类型:</th>
                    <td>
                        <ap:selectDB name="ddDataType" id="ddDataType"
                                     where="parentId=10000025100454" optionValue="itemValue"
                                     optionText="itemName" table="SYS_DIC"
                                     selectedValue="${indexInfo.ddIndexTypeId}" styleClass="form-control">
                        </ap:selectDB>
                    </td>
                    <th width="20%">数据敏感度:</th>
                    <td><input type="text" id="ddDataSensitiveness" name="ddDataSensitiveness"
                               value=""
                               class="form-control"/></td>
                </tr>
                <tr>
                    <th width="20%">数据创建时间:</th>
                    <td><input type="text" id="ddDataCreateTime" name="ddDataCreateTime"
                               value="${currentTime}" readonly class="form_datetime form-control"/></td>
                    <th width="20%">数据创建人:</th>
                    <td><input type="text" id="ddDataCreatePerson" name="ddDataCreatePerson"
                               value="${sysName}" readonly class="form-control"/></td>
                <tr>
                    <th width="20%">任务基本描述:</th>
                    <td colspan="3"><textarea id="ddDataDescription" name="ddDataDescription"
                                              value="" class="form-control"
                                              rows="5"/></textarea>
                    </td>
                </tr>
                <input type="hidden" id="ddDataTaskId" name="ddDataTaskId"
                       value="${taskInfo.ddTaskId}"/>
            </table>
        </form>
        <div class="row">
            <button class="btn btn-primary btn-block" id="dataFormSave">创建新私有数据</button>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    $(function () {
        var options = {};
        var frm = $('#privateDataForm').form();
        $("#dataFormSave").click(function () {
            frm.setData();
            frm.ajaxForm(options);
            if (frm.valid()) {
                form.submit();
                window.location.reload(true);
                <%--window.location.href = "${ctx}/datadriver/personaltask/todotask.ht?id=${taskInfo.ddTaskId}";--%>
            }
        });
    });
</script>
<script type="text/javascript" src="${ctx}/timeselect/bootstrap-datetimepicker.zh-CN.js"></script>
</html>

