<!DOCTYPE html>
<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@page import="com.hotent.core.util.ContextUtil" %>
<html>
<head>
    <title>模型增加</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>
    <link rel="stylesheet" href="${ctx}/newtable/bootstrap.css">
    <link rel="stylesheet" href="${ctx}/newtable/bootstrap-table.css">
    <link rel="stylesheet" href="${ctx}/newtable/bootstrap-editable.css">
    <%--&lt;%&ndash;<script src="${ctx}/newtable/jquery.js"></script>&ndash;%&gt;--%>
    <%--<script src="${ctx}/newtable/bootstrap.js"></script>--%>
    <script src="${ctx}/newtable/bootstrap-table.js"></script>
    <script src="${ctx}/newtable/bootstrap-table-zh-CN.js"></script>
    <%--<script src="${ctx}/newtable/tableExport.js"></script>--%>
    <%--<script src="${ctx}/newtable/bootstrap-editable.js"></script>--%>
    <%--<script src="${ctx}/newtable/bootstrap-table-editable.js"></script>--%>

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
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        $(function () {
            var options = {};
            var frm = $('#userForm2').form();
            $("#dataFormSave").click(function () {
                frm.setData();
                frm.ajaxForm(options);
                if (frm.valid()) {
                    form.submit();
                    $("#addModel").modal('hide');
                    $("#tb_departments").bootstrapTable("refresh");
                }
            });
        });
    </script>
</head>
<body>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
            class="sr-only">Close</span></button>
    <h4 class="modal-title" id="myModalLabel">上传模型文件</h4>
</div>
<div class="container-fluid">
    <div class="modal-body">
        <form name="userForm2" id="userForm2"
              action="${ctx}/datadriver/modelcenter/save.ht?Modeltype=<%=new String(request.getParameter("Modeltype").getBytes("ISO-8859-1"),"UtF-8")%>"
              enctype="multipart/form-data" method="post">
            <table id="AddHandlingFee" class="table table-striped" cellpadding="0" cellspacing="0"
                   border="0"
                   type="main">
                <tr>
                    <th width="20%">模型名称:</th>
                    <td><input type="text" id="ddModelName" name="ddModelName"
                               value="" class="form-control"/></td>
                </tr>
                <tr>
                    <th width="20%">模型版本:</th>
                    <td><input type="text" id="ddModelVersion" name="ddModelVersion"
                               value="" class="form-control"/></td>
                </tr>
                <tr>
                    <th width="20%">模型状态:</th>
                    <td>
                        <div class="radio radio-info radio-inline">
                            <input type="radio" name="ddModelBf2" id="ddModelBf21" value="1" checked>
                            <label for="ddModelBf21">
                                模型上传
                            </label>
                            <br>
                            <input type="radio" name="ddModelBf2" id="ddModelBf20" value="0">
                            <label for="ddModelBf20">
                                模型更新
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th width="20%">模型说明:</th>
                    <td colspan="3"><textarea class="form-control" rows="4" id="DdModelExplain"
                                              name="DdModelExplain"></textarea></td>
                </tr>
                <tr id="newUpload2">
                    <th width="20%">上传模型:</th>
                    <td><input type="file" name="file" value="上传"></td>
                </tr>
            </table>
        </form>
    </div>
    <div class="modal-footer">
        <input id="dataFormSave" value="上传" type="submit" class="btn btn-primary btn-block"/>
    </div>
</div>
</body>
</html>