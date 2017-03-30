<!DOCTYPE html>
<%@page language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html lang="zh-CN">
<head>
    <title>数据发布列表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>
    <style>
        .big-font {
            font-size: larger;
            color: #A6A6A6;
        }

        table {
            background-color: #ffffff;
            width: 100%;
            margin: 0px;
        }

        .panel {
            padding-top: 0px !important;
        }
        .panel-body{
            padding: 0px !important;
        }

    </style>
</head>
<body>
<div class="row paneldocker" style="height: 100%">
    <div class="col-xs-6" style="height: 100%">
        <div class="panel panel-default task-panel">
            <div class="panel-heading">
                项目数据集合
                <div class="btn-group pull-right">
                    <a href="javascript:void(0)" title="点击获得更多列表操作" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
                       aria-expanded="false">
                        更多<span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-right">
                        <li><a href="javascript:void(0)" onclick="" title="订阅项目中的数据"><span class="glyphicon glyphicon-ok"></span>
                            订阅</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="javascript:void(0)" title="隐藏已选择数据"><span class="glyphicon glyphicon-trash"></span> 隐藏</a></li>
                        <li><a href="javascript:void(0)" title="选择没有被选中的数据"><span class="glyphicon glyphicon-retweet"></span> 反选</a></li>
                        <li><a href="javascript:void(0)" onclick="refresh(1)" title="刷新项目数据列表"><span
                                class="glyphicon glyphicon-refresh"></span> 刷新</a></li>
                    </ul>
                </div>

            </div>
            <div class="panel-body panelheight" id="canbeorderpanel">
                <table id="table_canbeorder"></table>
            </div>
        </div>
    </div>
    <div class="col-xs-6" style="height: 100%">
        <div class="panel panel-info task-panel">
            <div class="panel-heading">
                已订阅数据
                <div class="btn-group pull-right">
                    <a href="#" title="点击获得更多列表操作" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
                       aria-expanded="false">
                        更多<span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-right">
                        <li><a href="javascript:void(0)" title="撤销订阅数据"><span class="glyphicon glyphicon-hand-left"></span> 撤销订阅</a></li>
                        <li><a href="javascript:void(0)" title="导出数据表"><span class="glyphicon glyphicon-export"></span> 导出数据</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="javascript:void(0)" title="选择没有被选中的数据"><span class="glyphicon glyphicon-retweet"></span> 反选</a></li>
                        <li><a href="javascript:void(0)" onclick="refresh(0)" title="刷新私有数据看板"><span
                                class="glyphicon glyphicon-refresh"></span> 刷新</a></li>
                    </ul>
                </div>
            </div>
            <div class="panel-body panelheight" id="orderpanel">
                <table id="table_order"></table>
            </div>
        </div>
    </div>
</div>
</body>

<script type="text/javascript">
    //@ sourceURL=showdata.ht
    var $table_canbeorder = $('#table_canbeorder'),
            $table_order = $('#table_order'),
            $remove = $('#remove');
    var curRow = {};
    function initTable() {
        $table_canbeorder.bootstrapTable({
            checkboxHeader: true,
            idField: "ddDataId",
            classes: "table table-condensed table-hover",
            url: "canbeorderprivatedata.ht?id=${taskId}",
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: false,                      //是否显示行间隔色
            cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 15,                       //每页的记录行数（*）
            queryParamsType: '',
//            pageList: [5, 10, 20, 50],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
//            strictSearch: true,
            showColumns: false,                  //是否显示所有的列
            showRefresh: false,                  //是否显示刷新按钮
            minimumCountColumns: 1,             //最少允许的列数
            clickToSelect: false,                //是否启用点击选中行
            height: getHeight(),                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "ddDataId",                     //每一行的唯一标识，一般为主键列
            showToggle: false,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            columns: [
                {
                    checkbox: true
                },
                {//第一列，数据ID
                    field: 'ddDataId',
                    title: '指标Id',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: false
                }, {//第二列，名称
                    field: 'ddDataName',
                    title: '指标名称',
                    sortable: true,
                    editable: {
                        validate: function (va) {
                            if (va.length == 0) return '指标名称不能为空';
                        }
                    },
                    align: 'center',
                    visible: true
                }, {//所属任务ID
                    field: 'ddDataTaskName',
                    title: '所属项目ID',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: false
                }
                , {//第三列，数值
                    field: 'ddDataLastestValue',
                    title: '最新值',
                    sortable: true,
                    align: 'center',
                    editable: {
                        type: 'text',
                        title: '值',
                        validate: function (v) {
                            if (isNaN(v)) return '值必须是数字';
                        }
                    }
                }
                , {//数据类型
                    field: 'ddDataType',
                    title: '数据类型',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: true
                }
                , {//数据类型
                    field: 'ddDataPublishType',
                    title: '发布订阅状态',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: false
                }, {
                    field: 'operate',
                    title: '操作',
                    align: 'center',
                    events: operateEvents,
                    formatter: operateFormatterCanOrder
                }
            ],
            onClickRow: function (row, $element) {
                curRow = row;
            },
            onEditableSave: function (field, row, oldValue, $el) {
            }
        });

        $table_order.bootstrapTable({
            checkboxHeader: true,
            idField: "ddDataId",
            classes: "table table-condensed table-hover",
            url: "orderprivatedata.ht?id=${taskId}",
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: false,                      //是否显示行间隔色
            cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 15,                       //每页的记录行数（*）
            queryParamsType: '',
//            pageList: [5, 10, 20, 50],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
//            strictSearch: true,
            showColumns: false,                  //是否显示所有的列
            showRefresh: false,                  //是否显示刷新按钮
            minimumCountColumns: 1,             //最少允许的列数
            clickToSelect: false,                //是否启用点击选中行
            height: getHeight(),                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "ddDataId",                     //每一行的唯一标识，一般为主键列
            showToggle: false,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            columns: [
                {
                    checkbox: true
                },
                {//第一列，数据ID
                    field: 'ddDataId',
                    title: '数据Id',
                    sortable: false,
                    editable: false,
                    align: 'center',
                    visible: false
                }, {//第二列，名称
                    field: 'ddDataName',
                    title: '指标名称',
                    sortable: false,
                    editable: {
                        validate: function (va) {
                            if (va.length == 0) return '指标名称不能为空';
                        }
                    },
                    align: 'center',
                    visible: true
                }, {//所属任务ID
                    field: 'ddDataTaskName',
                    title: '所属项目ID',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: false
                }
                , {//第三列，数值
                    field: 'ddDataLastestValue',
                    title: '最新值',
                    sortable: true,
                    align: 'center',
                    editable: {
                        type: 'text',
                        title: '值',
                        validate: function (v) {
                            if (isNaN(v)) return '值必须是数字';
                        }
                    }
                }
                , {//数据类型
                    field: 'ddDataType',
                    title: '数据类型',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: true
                }, {//数据类型
                    field: 'ddDataPublishType',
                    title: '发布订阅状态',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: false
                }, {
                    field: 'operate',
                    title: '操作',
                    align: 'center',
                    events: operateEvents,
                    formatter: operateFormatterOrder
                }
            ],
            onClickRow: function (row, $element) {
                curRow = row;
            },
            onEditableSave: function (field, row, oldValue, $el) {
            }
        });
    }
    //刷新列表
    function refresh(e) {
        if (e == 0) $('#table_publish').bootstrapTable('refresh', parameter)
        if (e == 1) $('#table_private').bootstrapTable('refresh', parameter)
    }
    //私有数据列表按钮
    function operateFormatterCanOrder(value, row, index) {
        if (row.ddOrderType == 0)
            return [
                '<a id="canordertr" class="publish" href="javascript:void(0)" title="点击订阅该数据项">订阅',
                '</a>'
            ].join('');
        if (row.ddOrderType == 1)
            return [
                '<span class="glyphicon glyphicon-ok" style="color: green;"></span>'
            ].join('');
    }

    //发布数据列表按钮
    function operateFormatterOrder(value, row, index) {
        if (row.ddOrderType == '1')
            return [
                '<a id="ordertr" class="" href="javascript:void(0)" title="点击撤销发布该数据">撤销',
                '</a>'
            ].join('');
    }
    //设置table高度
    function getHeight() {
        return $(window).height() - $('.panel-heading').outerHeight(true) - 65;
    }

    window.operateEvents = {
        'click #ordertr': function (e, value, row, index) {
            $.get("canordertoorder.ht?id=" + row.ddDataId + "&parent=canorderpanel", function (data, status) {
                if (status=='success'){
                    $table_canbeorder.bootstrapTable('refresh');
                    $table_order.bootstrapTable('refresh');
                }
            });
        },
        'click #canordertr': function (e, value, row, index) {
            $.get("canordertoorder.ht?id=" + row.ddDataId + "&parent=orderpanel" + "&taskId=" +${taskId}, function (data, status) {
                if (status=='success'){
                    $table_canbeorder.bootstrapTable('refresh');
                    $table_order.bootstrapTable('refresh');
                }
            });
            $table_canbeorder.bootstrapTable('refresh');
            $table_order.bootstrapTable('refresh');
        }
    };

    $(function () {
        initTable();
    });
</script>
</html>
