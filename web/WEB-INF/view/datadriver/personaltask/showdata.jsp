<%--
  Created by IntelliJ IDEA.
  User: d
  Date: 2017/3/5
  Time: 下午7:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>数据看板</title>
    <script type="text/javascript" src="${ctx}/styles/layui/jquery.dragsort-0.5.2.min.js"></script>
    <style>
        .big-font {
            font-size: larger;
            color: #A6A6A6;
        }

        table {
            background-color: #ffffff;
            width: 100% !important;
            margin: 0px !important;
        }

        .panel {
            padding-top: 0px !important;

        }

        .panel-body{
            padding: 0px !important;
            border-radius: 0px !important;
        }

        thead{
            display:none !important;
        }

        .bootstrap-table{
            margin-top: -20px;
        }
    </style>
</head>
<body>
<div class="row paneldocker" style="height: 100%">
    <div class="col-xs-6" style="height: 100%">
        <div class="panel panel-default task-panel">
            <div class="panel-heading">
                私有数据

                <div class="btn-group pull-right">
                    <a href="#" title="点击获得更多列表操作" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
                       aria-expanded="false">
                        更多<span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-right">
                        <li><a href="javascript:void(0)" title="创建单条数据"><span class="glyphicon glyphicon-plus"></span> 创建单条数据</a></li>
                        <li><a href="javascript:void(0)" title="批量导入数据" onclick="importPrivateData(${taskId})"><span class="glyphicon glyphicon-import"></span> 批量导入数据</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="javascript:void(0)" onclick="" title="发布私有数据"><span class="glyphicon glyphicon-ok"></span>
                            发布私有数据</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="javascript:void(0)" title="删除"><span class="glyphicon glyphicon-trash"></span> 删除</a></li>
                        <li><a href="javascript:void(0)" title="选择没有被选中的数据"><span class="glyphicon glyphicon-retweet"></span> 反选</a></li>
                        <li><a href="javascript:void(0)" onclick="refresh(1)" title="刷新私有数据看板"><span
                                class="glyphicon glyphicon-refresh"></span> 刷新</a></li>
                    </ul>
                </div>

            </div>
            <div class="panel-body panelheight" id="createpanel">
                <table id="table_private"></table>
                <%--<ul id="createpanel" class="scrum-stage-tasks">--%>
                <%--<c:forEach var="privateDataListbyTaskItem" items="${privateDataListbyTask}">--%>
                <%--<li class="task task-card ui-sortable-handle " id="showRightPush">--%>
                <%--<div class="row">--%>
                <%--<strong class="col-xs-5 overflow-card" onclick="showDataContent(${privateDataListbyTaskItem.ddDataId})">${privateDataListbyTaskItem.ddDataName}</strong>--%>
                <%--<em class="col-xs-5 overflow-card">${privateDataListbyTaskItem.ddDataTaskName}</em>--%>
                <%--<a class="big-font glyphicon glyphicon-transfer col-xs-2"></a>--%>
                <%--</div>--%>
                <%--<input type="hidden" value="${privateDataListbyTaskItem.ddDataId}"--%>
                <%--name="release"/>--%>
                <%--</li>--%>
                <%--</c:forEach>--%>
                <%--</ul>--%>
            </div>
        </div>
    </div>
    <div class="col-xs-6" style="height: 100%">
        <div class="panel panel-info task-panel">
            <div class="panel-heading">
                发布数据
                <div class="btn-group pull-right">
                    <a href="#" title="添加" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
                       aria-expanded="false">
                        更多<span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-right">
                        <li><a href="#" title="取消发布数据"><span class="glyphicon glyphicon-hand-left"></span> 撤销发布</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="#" title="反选"><span class="glyphicon glyphicon-retweet"></span> 反选</a></li>
                        <li><a href="#" onclick="refresh(0)" title="刷新私有数据看板"><span
                                class="glyphicon glyphicon-refresh"></span> 刷新</a></li>
                    </ul>
                </div>
            </div>
            <div class="panel-body panelheight" id="publishpanel">
                <table id="table_publish"></table>
            </div>
        </div>
    </div>
</div>
<%--导入数据--%>
<div class="modal fade" id="exportData" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

        </div>
    </div>
</div>
</body>

<script type="text/javascript">
    //@ sourceURL=showdata.ht
    var $table_private = $('#table_private'),
            $table_publish = $('#table_publish');
    var $export_xml = $('#export_xml');
    var curRow = {};
    function initTable() {
        $table_publish.bootstrapTable({
            checkboxHeader: true,
            idField: "ddDataId",
            classes: "table table-condensed table-hover",
            url: "showpublishdata.ht?id=${taskId}",
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: false,                      //是否显示行间隔色
            cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 20,                       //每页的记录行数（*）
            queryParamsType: '',
            pageList: [5, 10, 20, 50],        //可供选择的每页的行数（*）
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
                    editable: false,
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
                    editable: false
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
                    formatter: operateFormatterPublish
                }
            ],
            onClickRow: function (row, $element) {
                curRow = row;
            },
            onEditableSave: function (field, row, oldValue, $el) {
                <%--$.ajax({--%>
                <%--type: "post",--%>
                <%--url: "${ctx}/datadriver/index/lastvalue.ht",--%>
                <%--data: {strJson: JSON.stringify(row)},--%>
                <%--success: function (data, status) {--%>
                <%--},--%>
                <%--error: function () {--%>
                <%--},--%>
                <%--complete: function () {--%>
                <%--}--%>
                <%--});--%>
            }
        });

        $table_private.bootstrapTable({
            checkboxHeader: true,
            idField: "ddDataId",
            classes: "table table-condensed table-hover",
            url: "showprivatedata.ht?id=${taskId}",
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: false,                      //是否显示行间隔色
            cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 20,                       //每页的记录行数（*）
            queryParamsType: '',
            pageList: [5, 10, 20, 50],        //可供选择的每页的行数（*）
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
                        mode: 'inline',
                        onblur: 'submit',
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
                    formatter: operateFormatterPrivate
                }
            ],
            onClickRow: function (row, $element) {
                curRow = row;
            },
            onEditableSave: function (field, row, oldValue, $el) {
                $.ajax({
                    type: "post",
                    url: "${ctx}/datadriver/index/lastvalue.ht",
                    data: {strJson: JSON.stringify(row)},
                    success: function (data, status) {
                    },
                    error: function () {
                    },
                    complete: function () {
                    }
                });
            }
        });
    }
    //刷新列表
    function refresh(e) {
        if (e == 0) $('#table_publish').bootstrapTable('refresh')
        if (e == 1) $('#table_private').bootstrapTable('refresh')
    }
    //数据名称是否能够更改
//    function ifDataNameChange(value, row, index) {
//        if (row.ddDataPublishType == 1)
//            $('a').replaceWith($('a').text());
//    }
    //私有数据列表按钮
    function operateFormatterPrivate(value, row, index) {
        if (row.ddDataPublishType == 0)
        return [
            '<a id="privatetr" class="publish" href="javascript:void(0)" title="点击发布该列数据">发布',
            '</a>'
        ].join('');
        if (row.ddDataPublishType == 1)
        return [
            '<span class="glyphicon glyphicon-ok" style="color: green;"></span>'
        ].join('');
    }

    //发布数据列表按钮
    function operateFormatterPublish(value, row, index) {
        if (row.ddDataPublishType == '1')
        return [
            '<a id="publishtr" class="" href="javascript:void(0)" title="点击撤销发布该数据">收回',
            '</a>'
        ].join('');
        if (row.ddDataPublishType == '0')
        return [
            '未发布'
        ].join('');
    }
    //设置table高度
    function getHeight() {
        return $(window).height() - $('.panel-heading').outerHeight(true) - 65;
    }

    window.operateEvents = {
        'click #privatetr': function (e, value, row, index) {
            $.get("createtopublish.ht?id=" + row.ddDataId + "&parent=publishpanel");
            $table_private.bootstrapTable('refresh')
            $table_publish.bootstrapTable('refresh')
        },
        'click #publishtr': function (e, value, row, index) {
            $.get("createtopublish.ht?id=" + row.ddDataId + "&parent=createpanel" + "&taskId=" +${taskId});
            $table_publish.bootstrapTable('refresh')
            $table_private.bootstrapTable('refresh')
        }
    };

    $(function () {
        initTable();
    });

    //Excel批量导入
    function importPrivateData(taskId) {
        $('#exportData').modal({
            keyboard: true,
            remote: "${ctx}/datadriver/privatedata/importPrivateData.ht?id=" + taskId
        })
    }
    <%--function saveOrder() {--%>
    <%--var data = $(this).children('input').val();--%>
    <%--var parentid = $(this).parent().attr("id");--%>
    <%--$.get("createtopublish.ht?id=" + data + "&parent=" + parentid);--%>
    <%--}--%>
    <%--function saveOrder2() {--%>
    <%--var data = $(this).children('input').val();--%>
    <%--var parentid = $(this).parent().attr("id");--%>
    <%--$.get("canordertoorder.ht?id=" + data + "&parent=" + parentid + "&taskId=" +${taskId});--%>
    <%--}--%>
</script>
</html>
