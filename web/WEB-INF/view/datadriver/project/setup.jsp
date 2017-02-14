<%--
  Created by IntelliJ IDEA.
  User: d
  Date: 2017/1/16
  Time: 下午8:16
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="ap" uri="/appleTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>项目设置</title>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <script src="${ctx}/newtable/jquery.js"></script>
    <script src="${ctx}/newtable/bootstrap.js"></script>
</head>
<body>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
            class="sr-only">Close</span></button>
    <h4 class="modal-title" id="myModalLabel">项目设置</h4>
</div>
<div class="modal-body">
    <div class="container-fluid">
        <div class="col-xs-2">
            <ul class="nav nav-pills nav-stacked" role="tablist">
                <li role="presentation" class="active"><a href="#info" role="tab" data-toggle="tab">项目信息</a></li>
                <li role="presentation"><a href="#profile" role="tab" data-toggle="tab">项目偏好</a></li>
                <li role="presentation"><a href="#more" role="tab" data-toggle="tab">更多...</a></li>
            </ul>
        </div>
        <div class="col-xs-10">
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="info">
                    <div class="well">
                        <form class="form-horizontal" role="form" action="save.ht" id="setupform">
                            <table id="AddHandlingFee" cellpadding="0" cellspacing="0"
                                   border="0"
                                   type="main" class="table table-striped">
                                <tr>
                                    <th>项目名称</th>
                                    <td colspan="3">
                                        <input type="text" class="form-control" placeholder="项目名称" id="ddProjectName"
                                               name="ddProjectName" value="${Project.ddProjectName}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th>项目阶段</th>
                                    <td>
                                        <ap:selectDB name="ddProjectPhaseId" id="ddProjectPhaseId"
                                                     where="parentId=10000027440009" optionValue="itemValue"
                                                     optionText="itemName" table="SYS_DIC"
                                                     selectedValue="${Project.ddProjectPhaseId}"
                                                     styleClass="form-control">
                                        </ap:selectDB>
                                    </td>
                                    <th>所属型号</th>
                                    <td>
                                        <ap:selectDB name="ddProjectBelongModel" id="ddProjectBelongModel"
                                                     where="parentId=10000027440014" optionValue="itemValue"
                                                     optionText="itemName" table="SYS_DIC"
                                                     selectedValue="${Project.ddProjectBelongModel}"
                                                     styleClass="form-control">
                                        </ap:selectDB>
                                    </td>
                                </tr>
                                <tr>
                                    <th>项目类型</th>
                                    <td>
                                        <ap:selectDB name="ddProjectType" id="ddProjectType"
                                                     where="parentId=10000027440025" optionValue="itemValue"
                                                     optionText="itemName" table="SYS_DIC"
                                                     selectedValue="${Project.ddProjectType}"
                                                     styleClass="form-control">
                                        </ap:selectDB>
                                    </td>
                                    <th>密级</th>
                                    <td>
                                        <ap:selectDB name="ddProjectSecretLevel" id="ddProjectSecretLevel"
                                                     where="parentId=10000027440019" optionValue="itemValue"
                                                     optionText="itemName" table="SYS_DIC"
                                                     selectedValue="${Project.ddProjectSecretLevel}"
                                                     styleClass="form-control">
                                        </ap:selectDB>
                                    </td>
                                </tr>
                                <tr>
                                    <th>项目简述</th>
                                    <td colspan="3">
                                    <textarea class="form-control" rows="5" placeholder="项目简介" id="ddProjectDescription"
                                              name="ddProjectDescription">${Project.ddProjectDescription}</textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th>项目负责人</th>
                                    <td colspan="3">
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="ddProjectResponsiblePersonName"
                                                   name="ddProjectResponsiblePersonName" placeholder="项目负责人">
                                            <span class="input-group-btn">
        <button class="btn btn-info" type="button">变更</button>
      </span>
                                        </div><!-- /input-group -->
                                        <input type="hidden" id="ddProjectResponsiblePersonId"
                                               name="ddProjectResponsiblePersonId"
                                               value="${Project.ddProjectResponsiblePersonId}"/>
                                    </td>
                                </tr>

                            </table>
                            <div class="form-group">
                                <div class="col-xs-12">
                                    <button id="dataFormSave" type="button" class="btn btn-primary btn-block">
                                        保存
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="profile">
                    <p>
                    <h3>动态提醒</h3>
                    <small>（仅对个人）</small>
                    </p>
                    <div class="col-sm-12">
                        <div class="radio">
                            <label>
                                <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1"
                                       checked>
                                推送动态提醒（显示标记并以桌面通知的方式进行推送）
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                                不推送动态提醒（只显示标记）
                            </label>
                        </div>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="more">
                    <p>
                    <h3>可执行操作</h3></p>
                    <div class="col-sm-12">
                        <br>
                        <button type="button" class="btn btn-primary btn-block">固化项目</button>
                        <a href="${ctx}/datadriver/project/del.ht?id=${Project.ddProjectId}" type="button"
                           class="btn btn-danger btn-block">删除</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<%@include file="/commons/include/form.jsp" %>
<script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
<script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
<script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
<script type="text/javascript">
    $(function () {
        var options = {};
        if (showResponse) {
            options.success = showResponse;
        }
        var frm = $('#setupform').form();
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
