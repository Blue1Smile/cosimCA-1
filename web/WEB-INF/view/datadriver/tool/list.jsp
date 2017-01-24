<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
    <title>专业工具树</title>
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
    <script type="text/javascript" >
        $(function () {
            layout();
            loadTree();
//            createTree();
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
        };


        //布局大小改变的时候通知tab，面板改变大小
        function heightChanged(options) {
            $("#tree").height(options.middleHeight - 60);
        }
        ;
//
//        list<String> p1;
//        p1.push("1");
//        p1.push("2");
//        p1.push("3");
//        p1.push("4");
//        p1.push("5");
//        p1.push("6");
//
//        list<String> p2;
//        p2.push("1.1");
//        p2.push("1.2");
//        p2.push("2.1");
//        p2.push("3.1");
//        p2.push("4.1");
//        p2.push("5.1");
//        list<String> p3;
//        p3.push("1.1.1");
//        p3.push("1.1.2");
//        p3.push("1.2.1");
//        p3.push("2.1.1");
//        p3.push("3.1.1");
//        p3.push("4.1.1");
//        list<String> p4;
//        list<String> p5;
//        var p1size = p1.size();
//        var p2size = p2.size();
//        var p3size = p3.size();
//
//        //生成一个模拟树/////////////////////////////
//        var createTree = function(node, start){j
//            node = node || function(){
//                        var arr = [];
//                        for(var i = 1; i < p1.size(); i++){
//                            arr.push({
//                                name: p1.at(i);
//                            });
//                        }
//                        return arr;
//                    }();
//            start = start || 1;
//            layui.each(
//                    ]
//            , function(index, item){
//                if(start < 10 && index < 9){
//                    var child = [
//                        {
//                            name: (1 + index + start).toString().replace(/(\d)/, '$1$1$1$1$1$1$1$1$1')
//                        }
//                    ];
//                    node[index].children = child;
//                    createTree(child, index + start + 1);
//                }
//            });
//            return node;
//        };
//
//        layui.tree({
//            elem: '#demo2' //指定元素
//            ,nodes: createTree()
//        });
//
//        ////////////////////////
        function loadTree() {
        layui.use(['tree', 'layer'], function() {

            var layer = layui.layer
                    , $ = layui.jquery;
            layui.tree({
                elem: '#demo2' //指定元素
                , target: '_blank' //是否新选项卡打开（比如节点返回href才有效）
                , click: function (item) { //点击节点回调
                    layer.msg('当前节名称：' + item.name + '<br>全部参数：' + JSON.stringify(item));
//                   window.location.href='edit.ht?id='+item.name;

                    if ( item.name == undefined) return;
                    $("#listFrame").attr("src", "toollist1.ht?major=" +  item.id);
                    console.log(item);
                }
                , nodes: [ //节点
                    { name: '工具1'
                        , id: 1
                        , alias: 'gongju1'
                        , children: [
                        {
                            name: '工具1.1'
                            , id: 11
//                            , href:'edit.ht?major='+"工具1.1"
                            , alias: 'weidu'
                            , children:[
                            {name:'dsad'}
                        ]
                        }, {
                            name: '工具1.2'
                            , id: 12
                        }, {
                            name: '工具1.3'
                            , id: 13
//                            ,href:'toollist.ht?major='+"工具1"
                            , alias: 'weidu'
                        }
                    ]
                    },
                    { name: '工具2'
                        , id: 2
                        , alias: 'gongju2'
                        , children: [
                        {
                            name: '工具2.1'
                            , id: 21
//                            , href:'edit.ht?major='+"工具1.1"
                            , alias: 'weidu2'
                            , children:[
                            {name:'dsad'}
                        ]
                        }, {
                            name: '工具2.2'
                            , id: 22
                        }, {
                            name: '工具2.3'
                            , id: 23
//                            ,href:'toollist.ht?major='+"工具1"
                            , alias: 'weidu1'
                        }
                    ]
                    },
                ]
            });
        });
        }
//       function createTree(node, start){
//            node = node || function(){
//                        var arr = [];
//                        for(var i = 1; i < 10; i++){
//                            arr.push({
//                                name: i.toString().replace(/(\d)/, '$1$1$1$1$1$1$1$1$1')
//                            });
//                        }
//                        return arr;
//                    }();
//            start = start || 1;
//            layui.each(node, function(index, item){
//                if(start < 10 && index < 9){
//                    var child = [
//                        {
//                            name: (1 + index + start).toString().replace(/(\d)/, '$1$1$1$1$1$1$1$1$1')
//                        }
//                    ];
//                    node[index].children = child;
//                    createTree(child, index + start + 1);
//                }
//            });
//            return node;
//        };
//        layui.tree({
//            elem: '#demo2' //指定元素
//            ,nodes: createTree()
//        });
    </script>
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>生成一个较深的树</legend>
</fieldset>

<ul id="demo23"></ul>
<div class="layui-tab layui-tab-card">

    <ul class="layui-tab-title">
        <li class="layui-this">工具中心</li>
    </ul>
    <div class="layui-tab-content">
        <div id="layout">
            <div position="left" title="专业工具树" class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <ul id="demo2" ></ul>
            </div>
            <%--src="${ctx}/datadriver/tool/edit.ht"--%>
            <div position="center">
                <iframe id="listFrame"  frameborder="no"
                        width="100%"
                        height="100%"></iframe>
            </div>
        </div>
    </div>

</div>

</body>

</html>