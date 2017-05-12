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
    <title>项目树</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>

    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/newtable/bootstrap-table.css">
    <link rel="stylesheet" href="${ctx}/newtable/bootstrap-editable.css">

    <script type="text/javascript" src="${ctx}/newtable/jquery.js"></script>
    <script type="text/javascript" src="${ctx}/newtable/bootstrap.js"></script>
    <script type="text/javascript" src="${ctx}/newtable/bootstrap-table.js"></script>
    <script type="text/javascript" src="${ctx}/newtable/bootstrap-table-zh-CN.js"></script>
    <script type="text/javascript" src="${ctx}/js/util/util.js"></script>
    <script type="text/javascript" src="${ctx}/js/util/form.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/displaytag.js"></script>
    <script type="text/javascript" src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
    <style type="text/css">
        html, body {
            padding: 0px;
            margin: 0;
            width: 100%;
            height: 100%;
            /*overflow: auto;*/
        }

        .panel-body {
            background-color: #FFFFFF !important;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            loadTree();
        });
        //布局大小改变的时候通知tab，面板改变大小
        function heightChanged(options) {
            $("#tree").height(options.middleHeight - 60);
        }
        ;
        function loadTree() {
            var projectName = new Array();
            var projectId = new Array();
            var length = new Array();
            <c:forEach items="${TaskLength}" var="t">
            length.push("${t}"); //js中可以使用此标签，将EL表达式中的值push到数组中
            </c:forEach>

            <c:forEach items="${ProjectName}" var="t">
            projectName.push("${t}"); //js中可以使用此标签，将EL表达式中的值push到数组中
            </c:forEach>

            <c:forEach items="${ProjectId}" var="m">
            projectId.push("${m}"); //js中可以使用此标签，将EL表达式中的值push到数组中
            </c:forEach>
            var k = 0;
            var t = 0;
            var taskInfoName = new Array();
            <c:forEach items="${allTaskInfoName}" var="n">
            taskInfoName.push("${n}"); //js中可以使用此标签，将EL表达式中的值push到数组中
            </c:forEach>

            var taskInfoId = new Array();
            <c:forEach items="${allTaskInfoId}" var="n">
            taskInfoId.push("${n}"); //js中可以使用此标签，将EL表达式中的值push到数组中
            </c:forEach>

            layui.use(['tree', 'layer'], function () {
                var layer = layui.layer
                        , $ = layui.jquery;
                var createTree = function (node, start) {
                    node = node || function () {
                                var arr = [];
                                for (var i = 0; i < "${ProjectLength}"; i++) {
                                    arr.push({
                                        name: projectName[i],
                                        Proid: projectId[i]
                                    });
                                }
                                return arr;
                            }();
                    start = start || 1;
                    layui.each(node, function (index, item) {
                        if (start <= length[index] && index < "${ProjectLength}") {
                            var child = function (node, start) {
                                var arr = [];
                                for (var i = 0; i < length[index]; i++) {
                                    arr.push({
                                        name: taskInfoName[k++],
                                        id: taskInfoId[t++]
                                    });
                                }
                                return arr;
                            }();
                            node[index].children = child;
                        }
                    });
                    return node;
                };
                layui.tree({
                    elem: '#demo2' //指定元素
                    , target: '_blank' //是否新选项卡打开（比如节点返回href才有效）
                    , click: function (item) { //点击节点回调
                        var taskId = item.id;
                        if (taskId == undefined) {
                            $.get("${ctx}/datadriver/index/indexlist.ht?id=" + item.Proid, function (data) {
                                $('#listFrame').html(data);
                            });
                        }
                        else {
                            $.get("${ctx}/datadriver/datacenter/publishorderdata.ht?id=" + taskId, function (data) {
                                $('#listFrame').html(data);
                            });
                        }
                    }
                    , nodes: createTree()
                });
            });
        }
    </script>
</head>
<body>
<div class="container-fluid" style="height: 100%">
    <div class="col-xs-3" style="height: 100%">
        <div class="panel panel-primary" style="height: 100%">
            <div class="panel-heading">项目树</div>
            <div class="panel-body" style="height: 93%; overflow-x: auto;overflow-y: auto">
                <div id="demo2"></div>
            </div>
        </div>
    </div>
    <div class="col-xs-9" style="height: 100%">
        <div class="panel panel-primary" style="height: 100%">
            <div class="panel-heading">数据中心列表</div>
            <div class="panel-body" style="height: 93%">

                <div id="listFrame" style="height: 100%">
                </div>

            </div>
        </div>
    </div>
</div>
</body>
</html>