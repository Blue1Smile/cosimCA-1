<%--<%@ page language="java" contentType="text/html; charset=UTF-8"--%>
         <%--pageEncoding="UTF-8"%>--%>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">--%>
<%--<html>--%>
<%--<head>--%>
    <%--&lt;%&ndash;<script type="text/javascript" src="../js/jquery-1.7.2.js" charset="UTF-8"></script>&ndash;%&gt;--%>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>

    <%--<title>上传工具</title>--%>
    <%--<%@include file="/commons/include/form.jsp" %>--%>
    <%--<%@include file="/newtable/tablecontext.jsp" %>--%>
    <%--<script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>--%>
    <%--<script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>--%>
    <%--<script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>--%>

<%--&lt;%&ndash;&lt;%&ndash;%>--%>
    <%--&lt;%&ndash;request.setCharacterEncoding("UTF-8");&ndash;%&gt;--%>
    <%--&lt;%&ndash;String major=new String(request.getParameter("major").getBytes("ISO-8859-1"),"utf-8");&ndash;%&gt;--%>
    <%--&lt;%&ndash;out.print("name:"+major);&ndash;%&gt;--%>
<%--&lt;%&ndash;%>&ndash;%&gt;--%>
<%--<script type="text/javascript">--%>
    <%--$(function () {--%>
        <%--var options = {};--%>
        <%--if (showResponse) {--%>
            <%--options.success = showResponse;--%>
        <%--}--%>
        <%--var frm = $('#userForm2').form();--%>
        <%--$("#dataFormSave").click(function () {--%>
            <%--frm.setData();--%>
            <%--frm.ajaxForm(options);--%>
            <%--if (frm.valid()) {--%>
                <%--form.submit();--%>
            <%--}--%>
        <%--});--%>
    <%--});--%>

    <%--function showResponse(responseText) {--%>
        <%--var obj = new com.hotent.form.ResultMessage(responseText);--%>
        <%--if (obj.isSuccess()) {--%>
            <%--$.ligerMessageBox.confirm("提示信息", obj.getMessage() + ",是否继续操作", function (rtn) {--%>
                <%--if (rtn) {--%>
                    <%--this.close();--%>
                <%--} else {--%>
                    <%--&lt;%&ndash;window.location.href = "${ctx}/datadriver/project/list.ht";&ndash;%&gt;--%>
                <%--}--%>
            <%--});--%>
        <%--} else {--%>
<%--//            $.ligerMessageBox.error("提示信息", obj.getMessage());--%>
        <%--}--%>
    <%--}--%>

<%--</script>--%>
<%--</head>--%>

<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@page import="com.hotent.core.util.ContextUtil" %>
<html>
<head>
    <title>项目基础信息添加</title>

    <%@include file="/newtable/tablecontext.jsp" %>
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
            var frm = $('#userForm2').form();
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

                        window.location.href = "${ctx}/datadriver/project/list.ht";

            } else {
//                $.ligerMessageBox.error("提示信息", obj.getMessage());
            }
        }

    </script>
</head>
<body>

<div class="container-fluid">
    <form name="userForm2" id="userForm2"
          action="${ctx}/datadriver/tool/save.ht?major=<%=new String(request.getParameter("major").getBytes("ISO-8859-1"),"UtF-8")%>"
          enctype="multipart/form-data" method="post">
        <table id="AddHandlingFee" class="table table-striped" cellpadding="0" cellspacing="0"
               border="0"
               type="main">
            <tr>
                <th width="20%">工具名称:</th>
                <td><input type="text" id="ddToolName" name="ddToolName"
                           value="" class="form-control"/></td>
            </tr>
            <tr>
                <th width="20%">工具版本:</th>
                <td><input type="text" id="ddToolVersion" name="ddToolVersion"
                           value="" class="form-control"/></td>
            </tr>
            <tr>
                <th width="20%">工具说明:</th>
                <td colspan="3"><textarea class="form-control" rows="4" id="ddToolBf" name="ddToolBf"></textarea></td>
            </tr>
            <tr id="newUpload2">
                <th width="20%">上传工具:</th>
                <td><input type="file" name="file" value="上传"></td>
            </tr>
        </table>
    </form>
    <%--<input class="btn btn-primary btn-block" id="dataFormSave" value="创建新任务"/>--%>
    <td><input id="dataFormSave" value="上传" class="btn btn-primary btn-block"></td>
</div>
</body>
</html>