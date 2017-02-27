<%--
  Created by IntelliJ IDEA.
  User: dodo
  Date: 2016/12/29
  Time: 下午8:35
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
    <title>任务概览</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/slide/css/default.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/styles/slide/css/component.css"/>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/styles/check/font-awesome.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/styles/check/build.css" rel="stylesheet" type="text/css"/>

    <script src="${ctx}/styles/slide/js/modernizr.custom.js"></script>
    <script src="${ctx}/newtable/jquery.js"></script>
    <script src="${ctx}/newtable/bootstrap.js"></script>
    <script src="${ctx}/styles/layui/jquery.dragsort-0.5.2.min.js"></script>
    <style>
        html, body {
            margin: 0px 0px !important;
            width: 100% !important;
            height: 100% !important;
        }

        iframe {
            margin: 0px 0px !important;
            width: 100% !important;
            height: 100% !important;
        }

        .scrum-stage .task.task-card {
            margin: 0 8px 8px !important;
        }

        .task.task-card {
            padding: 0 !important;
            background-color: #fff !important;
            border-radius: 3px !important;
            box-shadow: 0 1px 2px rgba(0, 0, 0, .1) !important;
            cursor: pointer !important;
            margin-left: -42px !important;
        }

        .checkbox label {
            margin: 12px !important;
        }

        li {
            list-style-type: none !important;
        }

        .paneldocker {
            position: relative;
            height: 100%;
            padding: 10px;
        }

        .panelheight {
            position: relative;
            height: 93%;
        }

        /*.cbp-spmenu-push{*/
        /*overflow:scroll !important;*/
        /*overflow-x:hidden !important;*/
        /*}*/
        .bs-callout-danger {
            border-left-color: #ce4844;
            border-left-width: 5px;
        }
        .board-view {
            position: fixed;
            top: 50px;
            right: 0;
            bottom: 0;
            left: 0;
            padding: 0;
            overflow: hidden;
            transition: all 218ms ease;
        }
        .task-panel {
            position: relative;
            height: 100%;
        }
        .board-scrum-view {
            position: relative;
            height: 100%;
            background-color: #FFF;
            border-style: solid;
            border-width: 0;
            border-color: #E5E5E5;
            overflow-y: auto;
            overflow-x: hidden;
        }

    </style>
</head>
<body>

<div class="container-fluid">

    <div class="row">
        <p class="pull-right">
            <a class="layui-btn layui-btn-normal" id="commit" href="submittask.ht?id=${taskInfo.ddTaskId}"><i
                    class="layui-icon">&#xe62f;</i> 提交工作</a>
            <a class="layui-btn layui-btn-normal" id="invite" href="jobinvite.ht"><i class="layui-icon">&#xe613;</i>
                邀请协作</a>
            <a class="layui-btn" id="jobdone" href="jobdone.ht"><i class="layui-icon">&#x1005;</i> 完成任务</a>
            <a class="layui-btn layui-btn-primary" action="#" onclick="location.reload()"><i
                    class="layui-icon">&#x1002;</i> 刷新看板</a>
        </p>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">订阅数据</h3>
                </div>
                <div class="panel-body">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">私有数据</h3>
                </div>
                <div class="panel-body">
                    <div id="orderupdate"></div>
                </div>
            </div>
        </div>
    </div>
    <%--<div class="row">--%>
        <%--<div class="col-md-5">--%>
            <%--<div class="panel panel-default">--%>
                <%--<div class="panel-heading">--%>
                    <%--<h3 class="panel-title">订阅关系图</h3>--%>
                <%--</div>--%>
                <%--<div class="panel-body">--%>
                    <%--<div id="main" style="height:360px;"></div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
</div>
</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
<script src="${ctx}/echart/echarts-all.js"></script>

<script>
    var myChart = echarts.init(document.getElementById('main'));
    var option = {
        title: {
            text: '数据输出订阅关系',
            x: 'right',
            y: 'bottom'
        },
        tooltip: {
            trigger: 'item',
            formatter: '{a} : {b}'
        },
        toolbox: {
            show: true,
            feature: {
                restore: {show: true},
                magicType: {show: true, type: ['force', 'chord']},
                saveAsImage: {show: true}
            }
        },
        series: [
            {
                type: 'force',
                name: "订阅关系",
                ribbonType: false,
                itemStyle: {
                    normal: {
                        label: {
                            show: true,
                            textStyle: {
                                color: '#333'
                            }
                        },
                        nodeStyle: {
                            brushType: 'both',
                            borderColor: 'rgba(255,215,0,0.4)',
                            borderWidth: 1
                        },
                        linkStyle: {
                            type: 'curve'
                        }
                    },
                    emphasis: {
                        label: {
                            show: false
                            // textStyle: null      // 默认使用全局文本样式，详见TEXTSTYLE
                        },
                        nodeStyle: {
                            //r: 30
                        },
                        linkStyle: {}
                    }
                },
                useWorker: false,
                minRadius: 15,
                maxRadius: 25,
                gravity: 1.1,
                scaling: 1.1,
                roam: 'move',
                nodes: [
                    {category: 0, name: '项目一', value: 10, label: '项目一\n（主要）'},
                    {category: 1, name: '任务一', value: 2},
                    {category: 1, name: '任务二', value: 3},
                    {category: 1, name: '任务三', value: 3},
                    {category: 1, name: '任务四', value: 7},
                    {category: 2, name: '任务五', value: 5},
                    {category: 2, name: '任务六', value: 8},
                    {category: 2, name: '任务七', value: 9},
                    {category: 2, name: '任务八', value: 4},
                    {category: 2, name: '任务九', value: 4},
                    {category: 2, name: '任务十', value: 1},
                ],
                links: [
                    {source: '任务一', target: '项目一', weight: 1},
                    {source: '任务二', target: '项目一', weight: 2},
                    {source: '任务三', target: '项目一', weight: 1},
                    {source: '任务四', target: '项目一', weight: 2},
                    {source: '任务五', target: '项目一', weight: 3},
                    {source: '任务六', target: '项目一', weight: 1},
                    {source: '任务七', target: '项目一', weight: 6},
                    {source: '任务八', target: '项目一', weight: 1},
                    {source: '任务九', target: '项目一', weight: 1},
                    {source: '任务十', target: '项目一', weight: 1},
                    {source: '任务三', target: '任务二', weight: 1},
                    {source: '任务六', target: '任务二', weight: 1},
                    {source: '任务六', target: '任务三', weight: 1},
                    {source: '任务六', target: '任务四', weight: 1},
                    {source: '任务六', target: '任务五', weight: 1},
                    {source: '任务七', target: '任务六', weight: 6},
                    {source: '任务七', target: '任务三', weight: 1},
                    {source: '任务九', target: '任务六', weight: 1}
                ]
            }
        ]
    };
    //    var ecConfig = require('echarts/config');
    //    function focus(param) {
    //        var data = param.data;
    //        var links = option.series[0].links;
    //        var nodes = option.series[0].nodes;
    //        if (
    //                data.source !== undefined
    //                && data.target !== undefined
    //        ) { //点击的是边
    //            var sourceNode = nodes.filter(function (n) {return n.name == data.source})[0];
    //            var targetNode = nodes.filter(function (n) {return n.name == data.target})[0];
    //            console.log("选中了边 " + sourceNode.name + ' -> ' + targetNode.name + ' (' + data.weight + ')');
    //        } else { // 点击的是点
    //            console.log("选中了" + data.name + '(' + data.value + ')');
    //        }
    //    }
    //    myChart.on(ecConfig.EVENT.CLICK, focus)
    //
    //    myChart.on(ecConfig.EVENT.FORCE_LAYOUT_END, function () {
    //        console.log(myChart.chart.force.getPosition());
    //    });
    myChart.setOption(option);
</script>

</html>
