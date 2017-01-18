<%@ taglib prefix="ap" uri="/appleTag" %>
<%--
  Created by IntelliJ IDEA.
  User: d
  Date: 2017/1/16
  Time: 上午11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>创建项目</title>
    <%@include file="/commons/include/form.jsp" %>
    <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>

</head>
<body>
<div class="container-fluid">
    <br>
    <form class="form-horizontal" method="post" action="save.ht" id="createprojectform" name="createprojectform"
          enctype="multipart/form-data">
        <table id="AddHandlingFee" cellpadding="0" cellspacing="0"
               border="0"
               type="main" class="table table-striped">
            <tr>
                <th>指标名称:</th>
                <td>
                    <input type="text" class="form-control" placeholder="项目名称" value="" id="ddProjectName"
                           name="ddProjectName">
                </td>
            </tr>
            <tr>
                <%--项目阶段--%>
                <th>项目阶段:</th>
                <td>
                    <ap:selectDB name="ddProjectPhaseId" id="ddProjectPhaseId"
                                 where="parentId=10000027440009" optionValue="itemValue"
                                 optionText="itemName" table="SYS_DIC"
                                 selectedValue="${projectPhaseItem.id}" styleClass="form-control">
                    </ap:selectDB>
                </td>
            </tr>
            <tr>
                <%--所属型号--%>
                <th>所属型号:</th>
                <td>
                    <ap:selectDB name="ddProjectBelongModel" id="ddProjectBelongModel"
                                 where="parentId=10000027440014" optionValue="itemValue"
                                 optionText="itemName" table="SYS_DIC"
                                 selectedValue="${projectBelongModelItem.id}" styleClass="form-control">
                    </ap:selectDB>
                </td>

            </tr>
            <tr>
                <%--密级--%>
                <th>密级:</th>
                <td>
                    <ap:selectDB name="ddProjectSecretLevel" id="ddProjectSecretLevel"
                                 where="parentId=10000027440019" optionValue="itemValue"
                                 optionText="itemName" table="SYS_DIC"
                                 selectedValue="${projectSecretLevelItem.id}" styleClass="form-control">
                    </ap:selectDB>
                </td>
            </tr>
            <tr>
                <%--项目类型--%>
                <th>项目类型:</th>
                <td>
                    <ap:selectDB name="ddProjectType" id="ddProjectType"
                                 where="parentId=10000027440025" optionValue="itemValue"
                                 optionText="itemName" table="SYS_DIC"
                                 selectedValue="${projectTypeListItem.id}" styleClass="form-control">
                    </ap:selectDB>
                </td>
            </tr>
            <tr>
                <%--<label class="col-xs-2 control-label">项目简述</label>--%>
                <th>项目简介:</th>
                <td>
                <textarea class="form-control" rows="5" placeholder="项目简介" id="ddProjectDescription"
                          name="ddProjectDescription"></textarea>
                </td>
            </tr>
        </table>
    </form>
        <div class="form-group">
            <div class="col-xs-12">
                <button type="button" class="btn btn-primary btn-block" id="dataFormSave">完成并创建</button>
                <button type="button" class="btn btn-default btn-block">从模版创建</button>
            </div>
        </div>
</div>
</body>
<script type="text/javascript">
    $(function () {
        var options = {};
        if (showResponse) {
            options.success = showResponse;
        }
        var frm = $('#createprojectform').form();
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
                    window.location.href = "${ctx}/datadriver/project/list.ht";
                }
            });
        } else {
            $.ligerMessageBox.error("提示信息", obj.getMessage());
        }
    }
</script>
</html>