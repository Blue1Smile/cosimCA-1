<%--
  Created by IntelliJ IDEA.
  User: dodo
  Date: 2016/12/25
  Time: 下午9:57
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="hotent" uri="http://www.jee-soft.cn/paging" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html lang="zh-CN">
<head>
    <title>办理任务</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/slide/css/default.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/slide/css/component.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/newtable/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/check/font-awesome.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/check/build.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/fourpanel/fourpanel.css"/>

    <script src="${ctx}/newtable/jquery.js"></script>
    <%@include file="/newtable/tablecontext.jsp" %>
    <script type="text/javascript" src="${ctx}/styles/slide/js/modernizr.custom.js"></script>

    <script type="text/javascript" src="${ctx}/js/jquery/jquery.form.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery/additional-methods.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
    <script type="text/javascript" src="${ctx}/js/util/util.js"></script>
    <script type="text/javascript" src="${ctx}/js/util/form.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
</head>
<body>
<div class="container-fluid">
    <ul class="nav nav-tabs" role="tablist" id="myTab">
        <li role="presentation" class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                ${TaskInfo.ddTaskName} <span class="caret"></span>
            </a>
            <ul class="dropdown-menu" style="overflow: auto">
                <c:forEach var="taskInfoListItem" items="${taskInfoList}">
                    <li title="${taskInfoListItem.ddTaskProjectName}">
                        <a href="todotask.ht?id=${taskInfoListItem.ddTaskId}&projectId=${taskInfoListItem.ddTaskProjectId}">${taskInfoListItem.ddTaskName}</a>
                    </li>
                </c:forEach>
            </ul>
        </li>
        <li role="presentation" class="active" id="switch_attr_publish"><a href="#data" data-toggle="tab"
                                                                           role="tab">私有&发布</a>
        </li>
        <li role="presentation" id="switch_attr_order"><a href="#publish" data-toggle="tab"
                                                          role="tab">集合&订阅</a>
        </li>
        <%--<li role="presentation" id="switch_attr_order"><a href="#order" data-toggle="tab" role="tab">订阅数据</a>--%>
        <%--</li>--%>
        <li role="presentation" id="switch_attr_index"><a href="#index" data-toggle="tab" role="tab">任务约束</a>
        </li>
        <li role="presentation" id="switch_attr_child"><a href="#child" data-toggle="tab" role="tab">子任务</a></li>
        <%--<li role="presentation" id="switch_attr_file"><a href="#file" data-toggle="tab" role="tab">模型文件</a></li>--%>
        <li role="presentation" id="switch_attr_source"><a href="#source" data-toggle="tab" role="tab">设计资源</a></li>
        <li role="presentation" id="switch_attr_talk"><a href="#talk" data-toggle="tab" role="tab">项目研讨</a></li>
        <div class="pull-right">

            <a class="btn btn-success" href="javascript:void(0)" id="create_data"
               onclick="createPrivateData(${TaskInfo.ddTaskId})"><span
                    class="glyphicon glyphicon-plus"></span> 创建私有</a>
            <a class="btn btn-primary" href="#" id="upload_file" onclick=""><span
                    class="glyphicon glyphicon-cloud-upload"></span> 上传</a>
            <a id="child_btn" href="#" class="btn btn-primary"><span class="glyphicon glyphicon-stats"></span>
                创建子任务
            </a>
            <a class="btn btn-info" href="#" data-toggle="modal" id="submit_btn"
               data-remote="submittask.ht?id=${TaskInfo.ddTaskId}"
               data-target="#submittask"><span class="glyphicon glyphicon-ok"></span> 提交审核</a>
            <a id="statis_btn" href="#" class="btn btn-warning"><span class="glyphicon glyphicon-stats"></span>
                进程统计
            </a>
            <button class="btn btn-default" onclick="location.reload()"><span
                    class="glyphicon glyphicon-refresh"></span> 刷新
            </button>
        </div>
    </ul>

    <br>
    <div class="tab-content board-view">
        <div role="tabpanel" class="tab-pane active board-scrum-view" id="data" style="height: 100%">
        </div>
        <div role="tabpanel" class="tab-pane" id="index">
        </div>
        <div role="tabpanel" class="tab-pane" id="publish">
        </div>
        <%--<div role="tabpanel" class="tab-pane" id="order">--%>
        <%--</div>--%>
        <%--<div role="tabpanel" class="tab-pane" id="file">--%>
        <%--</div>--%>
        <div role="tabpanel" class="tab-pane" id="talk">
        </div>
        <div role="tabpanel" class="tab-pane" id="source">
        </div>
        <div role="tabpanel" class="tab-pane" id="child">
        </div>
    </div>

    <%--添加数据--%>
    <div class="modal fade" id="adddata" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">

            </div>
        </div>
    </div>
    <%--任务完成--%>
    <div class="modal fade" id="submittask" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">

            </div>
        </div>
    </div>
    <%--统计--%>
    <div class="modal fade" id="statis" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">

            </div>
        </div>
    </div>

    <%--数据详情--%>
    <div class="modal fade" id="datadetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="overflow: auto" id="datadetailcontent" style="overflow: auto">

            </div>
        </div>
    </div>

    <%--文件上传--%>
    <div class="modal fade" id="fileupload" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="overflow: auto" id="fileuploadcontent" style="overflow: auto">

            </div>
        </div>
    </div>
</div>
</body>
<script src="${ctx}/styles/slide/js/classie.js"></script>
<%--<script src="${ctx}/styles/loading/PerfectLoad.js"></script>--%>
<script type="text/javascript">
    //@ sourceURL=todotask.ht
    $(document).ready(function () {
        $.get("showdata.ht?id=${TaskInfo.ddTaskId}&projectId=${TaskInfo.ddTaskProjectId}", function (data) {
            $('#data').html(data);
        });
        $("#create_data").show();
        $("#upload_file").hide();
        $("#child_btn").hide();

    });

    var switch_attr_index = document.getElementById('switch_attr_index'),
            switch_attr_data = document.getElementById('switch_attr_data'),
            switch_attr_publish = document.getElementById('switch_attr_publish'),
            switch_attr_order = document.getElementById('switch_attr_order'),
            statis_btn = document.getElementById('statis_btn'),
            create_task = document.getElementById('create_task'),
            upload_file = document.getElementById('upload_file'),
            switch_attr_child = document.getElementById('switch_attr_child');
    //显示数据详情
    function showDataContent(dataId) {
        $('#datadetail').modal({
            keyboard: true,
            remote: "${ctx}/datadriver/privatedata/edit.ht?id=" + dataId
        })
    }
    //创建私有数据
    function createPrivateData(taskId) {
        $('#adddata').modal({
            keyboard: true,
            remote: "${ctx}/datadriver/privatedata/addprivatedata.ht?id=" + taskId
        })
    }
    //对话框关闭清除缓存
    $("#datadetail").on("hidden.bs.modal", function () {
        $(this).removeData("bs.modal");
    });
    $("#fileupload").on("hidden.bs.modal", function () {
        $(this).removeData("bs.modal");
    });
    $("#statis").on("hidden.bs.modal", function () {
        $(this).removeData("bs.modal");
    });
    $("#adddata").on("hidden.bs.modal", function () {
        $(this).removeData("bs.modal");
    });

    //tab切换操作
    switch_attr_index.onclick = function () {
        $.get("${ctx}/datadriver/index/indexlist.ht?id=${TaskInfo.ddTaskProjectId}", function (data) {
            $('#index').html(data);
        });
        $("#create_data").hide();
        $("#upload_file").hide();
        $("#child_btn").hide();
    }
    switch_attr_publish.onclick = function () {
        <%--alert(${TaskInfo.ddTaskProjectId});--%>
        $.get("showdata.ht?id=${TaskInfo.ddTaskId}&projectId=${TaskInfo.ddTaskProjectId}", function (data) {
            $('#data').html(data);
        });
        $("#create_data").show();
        $("#upload_file").hide();
        $("#child_btn").hide();
    }
    switch_attr_order.onclick = function () {
        $.get("showorder.ht?id=${TaskInfo.ddTaskId}&projectId=${TaskInfo.ddTaskProjectId}", function (data) {
            $('#publish').html(data);
        });
        $("#create_data").hide();
        $("#upload_file").hide();
        $("#child_btn").hide();
    }
    switch_attr_child.onclick = function () {
        $("#child_btn").show();
        $("#create_data").hide();
        $("#upload_file").hide();
    }
    <%--switch_attr_order.onclick = function () {--%>
    <%--$.get("${ctx}/datadriver/personaltask/showorder.ht?id=${TaskInfo.ddTaskId}", function (data) {--%>
    <%--$('#order').html(data);--%>
    <%--});--%>
    <%--$("#create_data").hide();--%>
    <%--$("#upload_file").hide();--%>
    <%--}--%>
    <%--switch_attr_file.onclick = function () {--%>
    <%--$.get("${ctx}/datadriver/personaltask/OrderModel.ht?id=${TaskInfo.ddTaskId}", function (data) {--%>
    <%--$('#file').html(data);--%>
    <%--});--%>
    <%--$("#create_data").hide();--%>
    <%--$("#upload_file").show();--%>
    <%--}--%>
    switch_attr_source.onclick = function () {
        <%--$.get("showdata.ht?id=${TaskInfo.ddTaskId}", function (data) {--%>
        <%--$('#source').html(data);--%>
        <%--});--%>
        $("#create_data").hide();
        $("#upload_file").hide();
        $("#child_btn").hide();
    }
    //按钮点击操作
    statis_btn.onclick = function () {
        $('#statis').modal({
            keyboard: true,
            remote: "statis.ht?id=${TaskInfo.ddTaskId}"
        })
    }
    upload_file.onclick = function () {
        $('#fileupload').modal({
            keyboard: true,
            remote: "uploadfile.ht?id=${TaskInfo.ddTaskId}"
        })
    }
</script>
</html>
