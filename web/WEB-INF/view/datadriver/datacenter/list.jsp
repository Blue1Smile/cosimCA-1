<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
    <title>项目树</title>
    <%@include file="/commons/include/get.jsp" %>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
    <style type="text/css">
        html, body {
            padding: 0px;
            margin: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
        }

    </style>
    <script type="text/javascript">
        $(function () {
            layout();
            loadTree();
        });
        //布局
        function layout() {
            $("#layout").ligerLayout({
                leftWidth: 210,
                height: "98%",
                onHeightChanged: heightChanged,
                allowLeftResize: false
            });
            //取得layout的高度
            var height = $(".l-layout-center").height();
            $("#tree").height(height - 60);
        }
        ;
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
            //var temp=new Array();
            <c:forEach items="${allTaskInfoName}" var="n">
            taskInfoName.push("${n}"); //js中可以使用此标签，将EL表达式中的值push到数组中
            </c:forEach>

            var taskInfoId = new Array();

            //var temp=new Array();
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
                                        name: projectName[i]
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
                        // layer.msg('当前节名称：'+ item.name + '<br>全部参数：'+ JSON.stringify(item));
                        // console.log(item);
//                        var isRoot = node.isRoot;
//                        if (isRoot == 1) {
//                            return;
//                        }
                        var taskId = item.id;
                        $("#listFrame").attr("src", "publishorderdata.ht?id=" + taskId);
//                        alert(taskId);
                    }
                    , nodes: createTree()
                });
            });
        }
    </script>
</head>
<body>
<%--<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">--%>
<%--<legend>生成一个较深的树</legend>--%>
<%--</fieldset>--%>
<div class="layui-tab layui-tab-card">

    <ul class="layui-tab-title">
        <li class="layui-this">数据中心</li>
    </ul>
    <div class="layui-tab-content">
        <div id="layout">
            <div position="left" title="项目树" class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <ul id="demo2" style="overflow:auto;"></ul>
            </div>
            <div position="center">
                <iframe id="listFrame" src="${ctx}/datadriver/datacenter/publishorderdata.ht" frameborder="no"
                        width="100%"
                        height="100%"></iframe>
            </div>
        </div>
    </div>

</div>

</body>

</html>