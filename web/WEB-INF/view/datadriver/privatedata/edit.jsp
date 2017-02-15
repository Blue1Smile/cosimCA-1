<%--&lt;%&ndash;--%>
	<%--time:2013-04-11 11:48:44--%>
	<%--desc:edit the 业务定义，如邀标采购这样的大业务。--%>
<%--&ndash;%&gt;--%>
<%--<%@page language="java" pageEncoding="UTF-8" %>--%>
<%--<%@include file="/commons/include/html_doctype.html" %>--%>
<%--<html>--%>
<%--<head>--%>
    <%--<title>私有数据添加</title>--%>
    <%--<%@include file="/commons/include/form.jsp" %>--%>
    <%--<script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>--%>
    <%--<script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>--%>
    <%--<script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>--%>
    <%--<link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>--%>
    <%--<script type="text/javascript">--%>
        <%--$(function () {--%>
            <%--var options = {};--%>
            <%--if (showResponse) {--%>
                <%--options.success = showResponse;--%>
            <%--}--%>
            <%--var frm = $('#privateDataForm').form();--%>
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

                        <%--window.location.href = "${ctx}/datadriver/privatedata/list.ht?id=${taskId}";--%>

            <%--} else {--%>

            <%--}--%>
        <%--}--%>

    <%--</script>--%>
    <%--<style>--%>
        <%--.fr {--%>
            <%--float: right;--%>
        <%--}--%>
    <%--</style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="layui-tab layui-tab-card">--%>
    <%--<ul class="layui-tab-title">--%>
        <%--<c:choose>--%>
            <%--<c:when test="">--%>
                <%--<li class="layui-this">编辑私有数据信息</li>--%>
            <%--</c:when>--%>
            <%--<c:otherwise>--%>
                <%--<li class="layui-this">添加私有数据信息</li>--%>
            <%--</c:otherwise>--%>
        <%--</c:choose>--%>
    <%--</ul>--%>
    <%--<div class="layui-tab-content" style="height: 100%;">--%>
        <%--<blockquote class="layui-elem-quote">--%>
            <%--<div style="height: 40px;">--%>
                <%--<div class="fr">--%>
                    <%--<a class="layui-btn layui-btn-normal" id="dataFormSave" href="#"><i--%>
                            <%--class="layui-icon">&#xe61e;</i> 保存</a>--%>
                    <%--<a class="layui-btn layui-btn-normal" href="list.ht?id=${taskId}"><i--%>
                            <%--class="layui-icon">&#xe603;</i> 返回</a>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</blockquote>--%>
        <%--<form id="privateDataForm" name="privateDataForm" method="post" action="save.ht" enctype="multipart/form-data">--%>
            <%--<table id="AddHandlingFee" class="layui-table" cellpadding="0" cellspacing="0" border="0" type="main">--%>
                <%--<tr>--%>

                    <%--<th width="20%">数据名称:</th>--%>
                    <%--<td><input type="text" id="ddDataName" name="ddDataName" value="${PrivateData.ddDataName}"--%>
                               <%--class="layui-input"/></td>--%>
                    <%--<th width="20%">灵敏阈:</th>--%>
                    <%--<td><input type="text" id="ddDataSensitiveness" name="ddDataSensitiveness"--%>
                               <%--value="${PrivateData.ddDataSensitiveness}" class="layui-input"/></td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th width="20%">数据类型:</th>--%>
                    <%--<td><input type="text" id="ddDataType" name="ddDataType" value="${PrivateData.ddDataType}"--%>
                               <%--class="layui-input"/></td>--%>
                    <%--<th width="20%">数据描述:</th>--%>
                    <%--<td><input type="text" id="ddDataDescription" name="ddDataDescription"--%>
                               <%--validate="{required:false}" class="layui-input"--%>
                               <%--value="${PrivateData.ddDataDescription}"/>--%>
                    <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th width="20%">所属任务:</th>--%>
                    <%--<td>--%>
                        <%--<c:choose>--%>
                            <%--<c:when test="${!empty taskInfo}">--%>
                                <%--<input type="text" id="ddDataTaskName" name="ddDataTaskName"--%>
                                       <%--value="${taskInfo.ddTaskName}"--%>
                                       <%--class="layui-input"/>--%>
                            <%--</c:when>--%>
                            <%--<c:otherwise>--%>
                                <%--<input type="text" id="ddDataTaskName" name="ddDataTaskName"--%>
                                       <%--value="${PrivateData.ddDataTaskName}"--%>
                                       <%--class="layui-input"/>--%>
                            <%--</c:otherwise>--%>
                        <%--</c:choose>--%>

                    <%--</td>--%>
                    <%--<th width="20%">数据可见性:</th>--%>
                    <%--<td><input type="text" id="ddDataPublishType" name="ddDataPublishType"--%>
                               <%--value="${PrivateData.ddDataPublishType}" class="layui-input"/></td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th width="20%">数据最新值:</th>--%>
                    <%--<td><input type="text" id="ddDataLastestValue" name="ddDataLastestValue"--%>
                               <%--value="${PrivateData.ddDataLastestValue}" class="layui-input"/></td>--%>
                    <%--<th width="20%">数据订阅状态:</th>--%>
                    <%--<td><input type="text" id="ddDataSubmiteState" name="ddDataSubmiteState"--%>
                               <%--value="${PrivateData.ddDataSubmiteState}" class="layui-input"/></td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th width="20%">创建人:</th>--%>
                    <%--<td><input type="text" id="ddDataCreatePerson" name="ddDataCreatePerson"--%>
                               <%--value="${PrivateData.ddDataCreatePerson}" class="layui-input"/></td>--%>
                    <%--<th width="20%">创建时间:</th>--%>
                    <%--<td><input type="text" id="ddDataCreateTime" name="ddDataCreateTime"--%>
                               <%--value="${PrivateData.ddDataCreateTime}" class="layui-input"/></td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th width="20%">是否交付:</th>--%>
                    <%--<td><input type="text" id="ddDataIsDelivery" name="ddDataIsDelivery"--%>
                               <%--value="${PrivateData.ddDataIsDelivery}" class="layui-input"/></td>--%>

                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<th width="20%">模型文件1111:</th>--%>
                    <%--<td><input type="text" id="ddDataIsModel" name="ddDataIsModel"--%>
                               <%--value="${PrivateData.ddDataIsDelivery}" class="layui-input"/></td>--%>

                <%--</tr>--%>
            <%--</table>--%>
            <%--<input type="hidden" name="ddDataId" id="ddDataId" value="${PrivateData.ddDataId}">--%>
            <%--<c:choose>--%>
                <%--<c:when test="${!empty taskInfo}">--%>
                    <%--<input type="hidden" name="ddDataTaskId" id="ddDataTaskId" value="${taskInfo.ddTaskId}"/>--%>
                <%--</c:when>--%>
                <%--<c:otherwise>--%>
                    <%--<input type="hidden" name="ddDataTaskId" id="ddDataTaskId" value="${PrivateData.ddDataTaskId}"/>--%>
                <%--</c:otherwise>--%>
            <%--</c:choose>--%>

        <%--</form>--%>
    <%--</div>--%>
<%--</div>--%>
<%--</body>--%>
<%--<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>--%>
<%--</html>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html style="height: 100%;">
<head>
    <title>私有数据</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/newtable/bootstrap-editable.css">
    <link href="${ctx}/styles/check/build.css" rel="stylesheet" type="text/css"/>

    <script src="${ctx}/newtable/bootstrap-editable.js"></script>
    <script src="${ctx}/timeselect/moment.js"></script>
    <style>
        .panel {
            margin: 0px;
            height: 100%;
        }

        .panel-heading {
            padding: 10px 15px;
            border-bottom: 1px solid #ddd;
            border-top-left-radius: 1px;
            border-top-right-radius: 1px;
            background-color: #f5f5f5;
        }

        #card1, #card2, #card3 {
            padding-right: 2px;
            padding-left: 2px;
        }

        #row {
            margin-right: 0px !important;
            margin-left: 0px !important;
        }

        button.panel-button {
            -webkit-appearance: none;
            padding: 0;
            cursor: pointer;
            background: transparent;
            border: 0;
        }

        .detail-info {
            margin-bottom: 4px;
        }

        .panel-button {
            float: right;
            font-size: 14px;
            font-weight: bold;
            line-height: 1;
            color: #000;
            text-shadow: 0 1px 0 #fff;
            filter: alpha(opacity=20);
            opacity: .2;
        }

        .task-info-title {
            margin: 5px 16px 10px;
            line-height: 12px;
            color: grey;
        }

        .card .task-detail-executor {
            margin: 10px 16px 14px;
            line-height: 24px;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .editable-pre-wrapped {
            white-space: normal !important;
        }

        .activities-list {
            padding: 0;
            position: relative;
        }

        .activity {
            position: relative;
            overflow: hidden;
            margin: 15px;
        }

        .activity .activity-type-icon {
            width: 36px;
            text-align: center;
            font-size: 16px;
        }

        .activity .activity-body-coyness {
            font-size: 12px;
            margin: 0 0 0 46px;
        }

        .muted {
            color: #A6A6A6;
        }
    </style>
</head>
<body style="height: 100%; margin: 0px;">
<div class="panel">
    <div class="panel-heading">
        ${privateData.ddDataName}
        <div class="btn-group" style="float: right">
            <button type="button" class="panel-button dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
                    aria-expanded="false">
                更多 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu dropdown-menu-right">
                <center>数据菜单</center>
                <li role="separator" class="divider"></li>
            </ul>
        </div>
    </div>
    <div class="panel-body" style="height: 100%; overflow: scroll">
        <div class="col-xs-12 detail-info">
            <div class="row" id="row">
                <div class="col-xs-4" id="card1">
                    <div class="panel panel-default">
                        <div class="panel-body card">
                            <h5 class="task-info-title">
                                数据类型
                            </h5>
                            <a class="data-type" id="dataType" data-type="combodate" data-pk="1" href="#">
                                ${privateData.ddDataType}
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-xs-4" id="card2">
                    <div class="panel panel-default">
                        <div class="panel-body card">
                            <h5 class="task-info-title">
                                数据最新值
                            </h5>
                            <a class="data-lastest-value" href="#" id="lastestValue" data-type="combodate" data-pk="1">
                                ${privateData.ddDataLastestValue}</a>
                        </div>
                    </div>
                </div>
                <div class="col-xs-4" id="card3">
                    <div class="panel panel-default">
                        <div class="panel-body card">
                            <h5 class="task-info-title">
                                数据创建者
                            </h5>
                            <a class="data-create-person" href="#" id="createPerson" data-type="combodate" data-pk="1">
                                ${privateData.ddDataCreatePerson}</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xs-12 detail-info">
            <div class="panel panel-default">
                <div class="list-group">
                    <a class="list-group-item" href="#" id="description" data-type="textarea" data-pk="1" href="#">
                        <c:choose>
                            <c:when test="${empty privateData.ddDataDescription}">
                                <h5 class="task-info-title">添加描述</h5>
                            </c:when>
                            <c:otherwise>
                                <p>${privateData.ddDataDescription}</p>
                            </c:otherwise>
                        </c:choose>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-xs-12" id="card4">
            <div class="panel panel-default">
                <div class="panel-body card">
                    <h5 class="task-info-title">
                        数据创建时间
                    </h5>
                    <a class="data-creat-time" href="#" id="creatTime" data-type="combodate" data-pk="1"
                       >
                        ${privateData.ddDataCreateTime}</a>
                </div>
            </div>
        </div>

        <div class="col-xs-12">
            <div class="panel panel-default">
                <div class="panel-body"><h5 class="task-info-title">记录</h5>
                    <div class="panel-group" id="record" role="tablist" aria-multiselectable="true">
                        <%--<div class="panel panel-default">--%>
                            <%--<div class="panel-heading" role="tab" id="headingOne">--%>
                                <%--<h5 class="panel-title">--%>
                                    <%--<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne"--%>
                                       <%--aria-expanded="true" aria-controls="collapseOne">--%>
                                        <%--数据历史--%>
                                    <%--</a>--%>
                                <%--</h5>--%>
                            <%--</div>--%>
                            <%--<div id="collapseOne" class="panel-collapse collapse in" role="tabpanel"--%>
                                 <%--aria-labelledby="headingOne">--%>
                                <%--<div class="panel-body">--%>
                                    <%--<ul class="activities-list">--%>
                                        <%--<li class="activity">--%>
                                            <%--<span class="glyphicon glyphicon-pencil pull-left activity-type-icon muted"></span>--%>
                                            <%--<div class="activity-body-coyness muted pull-right"><span>2017年1月16日</span>--%>
                                            <%--</div>--%>
                                            <%--<div class="activity-body-coyness muted">--%>
                                                <%--<span>设计师一 更新了 截止时间</span>--%>
                                            <%--</div>--%>
                                        <%--</li>--%>
                                        <%--<li class="activity">--%>
                                            <%--<span class="glyphicon glyphicon-pencil pull-left activity-type-icon muted"></span>--%>
                                            <%--<div class="activity-body-coyness muted pull-right"><span>2017年1月22日</span>--%>
                                            <%--</div>--%>
                                            <%--<div class="activity-body-coyness muted">--%>
                                                <%--<span>设计师一 更新了 优先级</span>--%>
                                            <%--</div>--%>
                                        <%--</li>--%>
                                    <%--</ul>--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingThree">
                                <h5 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion"
                                       href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                        数据历史
                                    </a>
                                </h5>
                            </div>
                            <div id="collapseThree" class="panel-collapse collapse" role="tabpanel"
                                 aria-labelledby="headingThree">
                                <div class="panel-body">
                                    <ul class="activities-list">
                                        <c:forEach items="${dataVersionList}" var="dataVersionItem">
                                            <li class="activity">
                                                <span class="glyphicon glyphicon-pencil pull-left activity-type-icon muted"></span>
                                                <div class="activity-body-coyness muted pull-right"><span>${dataVersionItem.ddDataRecordTime}</span>
                                                </div>
                                                <div class="activity-body-coyness muted">
                                                    <%--<span> 因为${dataVersionItem.ddDataChangeReason}</span>--%>
                                                    <span> ${dataVersionItem.ddDataRecordPersonId}修改了数据，修改值为：${dataVersionItem.ddDataValue}</span>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="panel-footer" style="margin-bottom: 0px">
        <div class="input-group">
            <input type="text" class="form-control" placeholder="输入@选择提醒人员">
            <span class="input-group-btn">
                <button class="btn btn-success" type="button">发送</button>
            </span>
        </div><!-- /input-group -->
    </div>
</div>

</body>

<script>
    var curRow = {};
    var taskItem = 0;

    function onChangeprivateData(params, dataItem) {
        curRow[dataItem] = params.value;
        $.ajax({
            type: 'post',
            url: "${ctx}/datadriver/privatedata/onchangeprivatedata.ht?dataId=${privateData.ddDataId}",
            data: {strJson: JSON.stringify(curRow)}
//                    success: function (data, textStatus, jqXHR) {
//                        alert('保存成功！');
//                    },
//                    error: function () { alert("error");}
        });
    }
    $(function () {
        $('#executorSelect').editable({
            showbuttons: false,
            value: ${executorName.userId},
            placement: 'bottom',
            source: [
                <c:forEach var="personItem" items="${sysUserList}">
                {value: ${personItem.userId}, text: '${personItem.fullname}'},
                </c:forEach>
            ],

            url: function (params) {
                taskItem = 0;
                onChangeprivateData(params, taskItem);
            }
        });
//        $('#taskPrioritySelect').editable({
//            showbuttons: false,
//            value: 1,
//            placement: 'left',
//            source: [
//                {value: 3, text: '紧急'},
//                {value: 2, text: '重要'},
//                {value: 1, text: '一般'}
//            ],
//            url: function (params) {
//                taskItem = 1;
//                onChangeprivateData(params, taskItem);
//            }
//        });

        $('#dob').editable({
            showbuttons: true,
            placement: 'bottom',
            format: 'YYYY-MM-DD',
            viewformat: 'YYYY年 MM月 DD日',
            template: 'YYYY年 MMMM月 DD日',
            combodate: {
                minYear: 2000,
                maxYear: 2030,
                minuteStep: 1
            },
            url: function (params) {
                taskItem = 2;
                onChangeprivateData(params, taskItem);
            }
        });
        $('#comments').editable({
            showbuttons: true,
            placement: 'bottom',
            rows: 5,
            url: function (params) {
                taskItem = 3;
                onChangeprivateData(params, taskItem);
            }
        });

    })
    ;
</script>
</html>
