<!DOCTYPE html>
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
<html lang="zh-CN">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>
    <title>添加私有数据</title>
    <style>
        .tree {
            overflow: auto;
            min-height: 20px;
            padding: 0px;
            margin-bottom: 0px;
            background-color: #fbfbfb;
            border: 1px solid #999;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
            -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05)
        }

        .tree li {
            list-style-type: none;
            margin: 0;
            padding: 10px 5px 0 5px;
            position: relative
        }

        .tree li::before, .tree li::after {
            content: '';
            left: -20px;
            position: absolute;
            right: auto
        }

        .tree li::before {
            border-left: 1px solid #999;
            bottom: 50px;
            height: 100%;
            top: 0;
            width: 1px
        }

        .tree li::after {
            border-top: 1px solid #999;
            height: 20px;
            top: 25px;
            width: 25px
        }

        .tree li span {
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border: 1px solid #999;
            border-radius: 5px;
            display: inline-block;
            padding: 3px 8px;
            text-decoration: none
        }

        .tree li.parent_li > span {
            cursor: pointer
        }

        .tree > ul > li::before, .tree > ul > li::after {
            border: 0
        }

        .tree li:last-child::before {
            height: 30px
        }

        .tree li.parent_li > span:hover, .tree li.parent_li > span:hover + ul li span {
            background: #eee;
            border: 1px solid #94a0b4;
            color: #000
        }
    </style>
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
            <table id="AddHandlingFee" class="table table-bordered" cellpadding="0" cellspacing="0"
                   border="0"
                   type="main">
                <tr>
                    <th width="20%">数据名称:</th>
                    <td><input type="text" id="ddDataName" name="ddDataName"
                               value="" class="form-control" placeholder="请输入数据名称"/></td>
                    <th width="20%">数据所属任务:</th>
                    <td><input type="text" id="ddDataTaskName" name="ddDataTaskName"
                               value="${taskInfo.ddTaskName}" class="form-control" readonly/></td>
                </tr>
                <tr id="changemodelfile">
                    <th width="20%">数据类型:</th>
                    <td>
                        <ap:selectDB name="ddDataType" id="ddDataType"
                                     where="parentId=10000025100454" optionValue="itemValue"
                                     optionText="itemName" table="SYS_DIC"
                                     selectedValue="${indexInfo.ddIndexTypeId}" styleClass="form-control">
                        </ap:selectDB>
                    </td>
                    <th width="20%">数据创建时间:</th>
                    <td><input type="text" id="ddDataCreateTime" name="ddDataCreateTime"
                               value="${currentTime}" readonly class="form_datetime form-control"/></td>
                    <%--<th width="20%">数据敏感度:</th>--%>
                    <%--<td><input type="text" id="ddDataSensitiveness" name="ddDataSensitiveness"--%>
                               <%--value=""--%>
                               <%--class="form-control"/></td>--%>
                </tr>
                <tr>

                    <th width="20%">数据创建人:</th>
                    <td><input type="text" id="ddDataCreatePerson" name="ddDataCreatePerson"
                               value="${sysName}" readonly class="form-control"/></td>

                <tr id="selectModeltr">
                    <th width="20%">请选择文件:</th>
                    <td colspan="5">
                        <select id="selectModel" name="ddDataLastestValue" class="form-control">
                            <c:forEach items="${modelCenterModelList}" var="modelCenterModelItem">
                                <option value="${modelCenterModelItem.ddModelName}">${modelCenterModelItem.ddModelName}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr id="initValue">
                    <th width="20%">创建数据结构:</th>
                    <td colspan="5">
                        <div class="tree well">

                                <li>
                                    <span id="parent_input">数据名称</span> <a href="javascript:void(0)"
                                                           id="parent"><i class="glyphicon glyphicon-plus"></i></a>
                                    <ul>
                                    </ul>
                                </li>

                        </div>
                    </td>
                </tr>
                <tr>
                    <th width="20%">数据基本描述:</th>
                    <td colspan="3"><textarea id="ddDataDescription" name="ddDataDescription"
                                              value="" class="form-control"
                                              rows="3"/></textarea>
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
    //@ sourceURL=addprivatedata.ht
    $(function () {
        $('#selectModeltr').hide();
        $('#selectModel').attr("disabled", "disabled");
        var options = {};
        var frm = $('#privateDataForm').form();
        $("#dataFormSave").click(function () {
            frm.setData();
            frm.ajaxForm(options);
            if (frm.valid()) {
                form.submit();
                $('#adddata').modal('hide');
                $('#table_private').bootstrapTable('refresh');
//                window.location.reload(true);
            }
        });
        $("#ddDataType").change(function () {
            if ($(this).val() == '文件') {
                $('#selectModeltr').show();
                $('#selectModel').removeAttr("disabled");
                $('#initValue').remove();
            } else if ($(this).val() == '模型') {
                $('#selectModeltr').show();
                $('#selectModel').removeAttr("disabled");
                $('#initValue').remove();
            } else {
                $('#selectModeltr').hide();
                $('#selectModel').attr("disabled", "disabled");
                if ($("#initValue").length <= 0) {
                    $('table').append('<tr id="initValue">' +
                            '<th width = "20%" > 初始值:</th>' +
                            '<td colspan = "5" >' +
                            '<input type = "text" id="ddDataLastestValue" name="ddDataLastestValue" value="" class="form-control"/>' +
                            '</td>' +
                            '</tr>');
                }
            }
        });

        $('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', '展开');
        $('.tree li.parent_li > span').on('click', function (e) {
            var children = $(this).parent('li.parent_li').find(' > ul > li');
            if (children.is(":visible")) {
                children.hide('fast');
                $(this).attr('title', '展开').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');
            } else {
                children.show('fast');
                $(this).attr('title', '收敛').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
            }
            e.stopPropagation();
        });

        $("#parent").click(function() {
            $(this).parent("li").children("ul").append('<li><span><input type="text" class="form-control" placeholder="请输入数据名称"/></span> <a href="javascript:void(0)" id="child_node" onclick="confirm(this)"> <i class="glyphicon glyphicon-ok"></i></a><ul></ul></li>');
        });

        var $inputs = $("#ddDataName");
        $inputs.keyup(function() {
            $('#parent_input').html($inputs.val());
        });
    });

    function addTreeNode(obj) {
        $(obj).parent("li").children("ul").append('<li><span><input type="text" class="form-control" placeholder="请输入数据名称"/></span><a href="javascript:void(0)" id="child_node" onclick="confirm(this)"> <i class="glyphicon glyphicon-ok"></i></a></li>');
    }

    function confirm(obj) {
        var this_val = $(obj).prev().children("input").val();
        $(obj).parent("li").replaceWith('<li><span>'+this_val+'</span> <a href="javascript:void(0)" id="child_node" onclick="addTreeNode(this)"> <i class="glyphicon glyphicon-plus"></i></a><ul></ul></li>');

    }
</script>
<script type="text/javascript" src="${ctx}/timeselect/bootstrap-datetimepicker.zh-CN.js"></script>
</html>

