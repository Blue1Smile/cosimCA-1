<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
    <title>项目树</title>
    <%@include file="/commons/include/get.jsp" %>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <%--<LINK href="${ctx}/styles/jq22/page_style.css" type=text/css rel=stylesheet>--%>
    <script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>

    <style type="text/css">
        html, body {
            padding: 0px;
            margin: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
        }
        .panel-body{
            background-color: #FFFFFF !important;
        }
    </style>
    <script type="text/javascript">
        $(function () {
//            layout();
            loadTree();
        });
//        //布局
//        function layout() {
//            $("#layout").ligerLayout({
//                leftWidth: 210,
//                height: "98%",
//                onHeightChanged: heightChanged,
//                allowLeftResize: false
//            });
//            //取得layout的高度
//            var height = $(".l-layout-center").height();
//            $("#tree").height(height - 60);
//        }
//        ;
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
                                        Proid:projectId[i]
                                    });
                                }
                                return arr;
                            }();
                    start = start || 1;
                    layui.each(node, function (index, item) {
                        if (start < length[index] && index < "${ProjectLength}") {
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
                        layer.msg('当前节名称：' + item.name + '<br>全部参数：' + JSON.stringify(item));
                        var taskId = item.id;
                        if (taskId == undefined) {
                            $.get("${ctx}/datadriver/index/indexlist.ht?id="+item.Proid, function (data) {
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

        var     switch_attr_tree = document.getElementById('switch_attr_tree'),
                switch_attr_snapshot = document.getElementById('switch_attr_snapshot');

        switch_attr_tree.onclick = function () {
            $.get("list.ht", function (data) {
                $('#tree').html(data);
            });
        }
        switch_attr_snapshot.onclick = function () {
            $.get("${ctx}/datadriver/datacenter/snapshotlist.ht", function (data) {
                $('#snapshot').html(data);
            });
        }
    </script>
</head>
<body>
<div class="container-fluid" style="height: 100%">
  <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active" id="switch_attr_tree"><a href="#tree" data-toggle="tab" role="tab">项目树</a></li>
        <li role="presentation" id="switch_attr_snapshot"><a href="#snapshot" data-toggle="tab" role="tab">数据快照</a></li>
    </ul>
    <div class="col-xs-3" style="height: 100%">

        <%--<div></div>--%>
        <div class="panel panel-primary"  style="height: 100%">
            <div class="panel-heading">项目树</div>
            <div class="panel-body"  style="height: 93%">
                <div id="demo2"></div>
            </div>
        </div>
    </div>

    <%--src="${ctx}/datadriver/tool/edit.ht"--%>
    <div class="col-xs-9" style="height: 100%">
        <div class="panel panel-primary" style="height: 100%">
            <div class="panel-heading">数据中心列表</div>
            <div class="panel-body" style="height: 93%">
                <div id="listFrame" style="height: 100%">

                </div>
            </div>

        </div>
        <div class="modal fade" id="snapshot" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">

                </div>
            </div>
        </div>
    </div>
</div>
    <%--index--%>

</body>
</html>