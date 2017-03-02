<!DOCTYPE html>
<%@ taglib prefix="ap" uri="/appleTag" %>
<%--
  Created by IntelliJ IDEA.
  User: d
  Date: 2017/1/16
  Time: 上午11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <title>创建项目</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <%@include file="/commons/include/form.jsp" %>
    <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
            class="sr-only">Close</span></button>
    <h4 class="modal-title" id="myModalLabel">项目创建</h4>
</div>
<div class="modal-body">
    <div class="container-fluid">
        <form class="form-horizontal" method="post" action="save.ht" id="createprojectform" name="createprojectform"
              enctype="multipart/form-data">
            <table id="AddHandlingFee" cellpadding="0" cellspacing="0"
                   border="0"
                   type="main" class="table table-striped">
                <tr>
                    <th>项目名称:</th>
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
                <a href="#" type="button" class="btn btn-default btn-block" disabled="disabled" title="暂不可用">从模版创建</a>
            </div>
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
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
            window.location.href = "${ctx}/datadriver/project/list.ht";
        } else {

        }
    }

</script>
</html>
