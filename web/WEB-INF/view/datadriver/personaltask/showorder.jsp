<!DOCTYPE html>
<%@page language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="ap" uri="/appleTag" %>
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
            width: 100% !important;
            /*margin: 0px !important;*/
        }

        .panel {
            padding-top: 0px !important;

        }

        .panel-body {
            padding: 5px !important;
            border-radius: 0px !important;
        }

        /*thead{*/
        /*display:none !important;*/
        /*}*/

        /*.bootstrap-table{*/
        /*margin-top: -20px;*/
        /*}*/
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
                <div id="toolbar_canbeorder" class="form-inline">
                    <div class="form-group">
                        <label for="dataNameCanBeOrder">名称：</label>
                        <input id="dataNameCanBeOrder" class="form-control" type="text" value="" placeholder="任务名称"/>
                    </div>
                    <div class="form-group">
                        <label for="ddType">类型：</label>
                        <ap:selectDB name="ddType" id="ddType"
                                     where="parentId=10000025100454" optionValue="itemValue"
                                     optionText="itemName" table="SYS_DIC"
                                     selectedValue="" styleClass="form-control">
                        </ap:selectDB>
                    </div>
                    <div class="form-group">
                        <label for="ddDataTaskNameCanBeOrder">任务：</label>
                        <select id="ddDataTaskNameCanBeOrder" class="form-control">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                        </select>
                    </div>
                    <input class="btn btn-default" type="submit" value="筛选"/>
                </div>
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
                <div id="toolbar_order" class="form-inline">
                    <div class="form-group">
                        <label for="dataNameOrder">名称：</label>
                        <input id="dataNameOrder" class="form-control" type="text" value="" placeholder="任务名称"/>
                    </div>
                    <div class="form-group">
                        <label for="ddType">类型：</label>
                        <ap:selectDB name="ddType" id="ddType"
                                     where="parentId=10000025100454" optionValue="itemValue"
                                     optionText="itemName" table="SYS_DIC"
                                     selectedValue="" styleClass="form-control">
                        </ap:selectDB>
                    </div>
                    <div class="form-group">
                        <label for="ddDataTaskNameOrder">任务：</label>
                        <select id="ddDataTaskNameOrder" class="form-control">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                        </select>
                    </div>
                    <input class="btn btn-default" type="submit" value="筛选"/>
                </div>
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
            url: "${ctx}/datadriver/data/showpublishdataByProid.ht?projectId=${projectId}"+ "&taskId=" +${taskId},
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar_canbeorder',                //工具按钮用哪个容器
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
            detailView: true,                   //是否显示父子表
            columns: [
                {
                    checkbox: true
                },
                {//第一列，数据ID
                    field: 'ddStructId',
                    title: '数据Id',
                    sortable: false,
                    editable: false,
                    align: 'center',
                    visible: false
                }, {//第二列，名称
                    field: 'ddStructName',
                    title: '数据名称',
                    sortable: false,
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
                , {//数据类型
                    field: 'ddType',
                    title: '数据类型',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: true
                },{//数据类型
                    field: 'ddPublishState',
                    title: '发布状态',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: false
                }, {//数据类型
                    field: 'ddOrderState',
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
            onExpandRow: function (index, row, $detail) {
                InitSubTablePro(index, row, $detail);
            },
            onEditableSave: function (field, row, oldValue, $el) {
            }
        });

        function InitSubTablePro(index, row, $detail) {
            var parentid = row.ddStructId;
            var cur_table = $detail.html('<table></table>').find('table');
            // alert(row.ToolName);
            $(cur_table).bootstrapTable({
                url: '${ctx}/datadriver/data/showprivatedata.ht?id='+row.ddStructId,
                method: 'get',
                queryParams: { strParentID: parentid },
                ajaxOptions: { strParentID: parentid },
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                // pagination: true,                   //是否显示分页（*）
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                clickToSelect: true,
                detailView: false,//父子表
                uniqueId: "MENU_ID",
//                pageSize: 10,
//                pageList: [10, 25],
                columns: [{
                    checkbox: true
                },                {//第一列，数据ID
                    field: 'ddDataId',
                    title: '数据Id',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: false
                }, {//第二列，名称
                    field: 'ddDataName',
                    title: '数据名称',
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
                        editable: false,
                    } , {//单位
                        field: 'ddDataUnit',
                        title: '单位',
                        sortable: true,
                        editable: false,
                        align: 'center',
                        visible: true
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
                    }
                ],
                //
                //无线循环取子表，直到子表里面没有记录
                onExpandRow: function (index, row, $Subdetail) {
                    InitSubTable(index, row, $Subdetail);
                },
                onClickRow:function (row, tr)
                {
                    // alert(row.ToolUrl);
                    // window.location.href="gettool.ht?major="+row.ToolUrl+"&name="+row.ToolName;
                }


            });
        };

        $table_order.bootstrapTable({
            checkboxHeader: true,
            idField: "ddDataId",
            classes: "table table-condensed table-hover",
            url: "${ctx}/datadriver/data/showsubscriptiondata.ht?id=${taskId}",
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar_order',                //工具按钮用哪个容器
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
            detailView: true,                   //是否显示父子表
            columns: [
                {
                    checkbox: true
                },
                {//第一列，数据ID
                    field: 'ddOrderDataId',
                    title: 'Id',
                    sortable: false,
                    editable: false,
                    align: 'center',
                    visible: false
                }, {//第二列，名称
                    field: 'ddDataId',
                    title: '数据id',
                    sortable: false,
                    align: 'center',
                    visible: false
                }, {//所属任务ID
                    field: 'ddOrderType',
                    title: '数据类型',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: false
                }
                , {//数据类型
                    field: 'ddTaskId',
                    title: '任务ID',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: false
                }, {//数据名称
                    field: 'ddDataName',
                    title: '数据名称',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: true
                }, {//是否订阅
                    field: 'exist',
                    title: '是否订阅',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: false
                },
                {
                    field: 'operate',
                    title: '操作',
                    align: 'center',
                    events: operateEventsordertr,
                    formatter: operateFormatterOrder
                }
            ],
            onClickRow: function (row, $element) {
                curRow = row;
            },
            onExpandRow: function (index, row, $detail) {
                InitSubTable(index, row, $detail);
            },
            onEditableSave: function (field, row, oldValue, $el) {
            }
        });

        function InitSubTable(index, row, $detail) {
            var parentid = row.ddDataId;
            var cur_table = $detail.html('<table></table>').find('table');
            // alert(row.ToolName);
            $(cur_table).bootstrapTable({
                url: '${ctx}/datadriver/data/showprivatedata.ht?id='+row.ddDataId,
                method: 'get',
                queryParams: { strParentID: parentid },
                ajaxOptions: { strParentID: parentid },
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                // pagination: true,                   //是否显示分页（*）
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                clickToSelect: true,
                detailView: false,//父子表
                uniqueId: "MENU_ID",
//                pageSize: 10,
//                pageList: [10, 25],
                columns: [{
                    checkbox: true
                },                {//第一列，数据ID
                    field: 'ddDataId',
                    title: '指标Id',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: false
                }, {//第二列，名称
                    field: 'ddDataName',
                    title: '数据名称',
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
                        editable:false,
                    } , {//单位
                        field: 'ddDataUnit',
                        title: '单位',
                        sortable: true,
                        editable: false,
                        align: 'center',
                        visible: true
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
                    }
                ],
                //
                //无线循环取子表，直到子表里面没有记录
                onExpandRow: function (index, row, $Subdetail) {
                    InitSubTable(index, row, $Subdetail);
                },
                onClickRow:function (row, tr)
                {
                    // alert(row.ToolUrl);
                    // window.location.href="gettool.ht?major="+row.ToolUrl+"&name="+row.ToolName;
                }


            });
        };
    }
    //刷新列表
    function refresh(e) {
        if (e == 0) $('#table_publish').bootstrapTable('refresh', parameter)
        if (e == 1) $('#table_private').bootstrapTable('refresh', parameter)
    }
    //私有数据列表按钮
    function operateFormatterCanOrder(value, row, index) {
        if (row.exist == 0)
            return [
                '<a id="canordertr" class="publish" href="javascript:void(0)" title="点击订阅该数据项">订阅',
                '</a>'
            ].join('');
        if (row.exist == 1)
            return [
                '<span class="glyphicon glyphicon-ok" style="color: green;"></span>'
            ].join('');
    }

    //发布数据列表按钮
    function operateFormatterOrder(value, row, index) {
//        if (row.ddOrderState == '1')
            return [
                '<a id="ordertr" class="" href="javascript:void(0)" title="点击撤销订阅该数据">撤销',
                '</a>'
            ].join('');
    }
    //设置table高度
    function getHeight() {
        return $(window).height() - $('.panel-heading').outerHeight(true) - 160;
    }

    window.operateEvents = {
        'click #canordertr': function (e, value, row, index) {
//            alert(222);
            $.get("canordertoorder.ht?id=" + row.ddStructId + "&parent=orderpanel" + "&taskId=" +${taskId}, function (data, status) {
                if (status=='success'){
                    $table_canbeorder.bootstrapTable('refresh');
                    $table_order.bootstrapTable('refresh');
                }
            });
            $table_canbeorder.bootstrapTable('refresh');
            $table_order.bootstrapTable('refresh');
        }
    };
    window.operateEventsordertr = {
        'click #ordertr': function (e, value, row, index) {
//            alert(222);
            $.get("canordertoorder.ht?id=" + row.ddDataId + "&parent=canorderpanel" + "&taskId=" +${taskId}, function (data, status) {
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
