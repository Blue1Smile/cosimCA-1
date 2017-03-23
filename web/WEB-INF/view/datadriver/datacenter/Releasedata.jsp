<!DOCTYPE html>
<%--
  Created by IntelliJ IDEA.
  User: 忠
  Date: 2017/2/20
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@page import="com.hotent.core.util.ContextUtil" %>
<html lang="zh-CN">
<head>
    <%--<title>任务数据中心</title>--%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>
     <script src="${ctx}/newtable/bootstrap-table-filter-control.js"></script>
</head>
<body>

<%--<div class="btn-group  col-xs-4 ">--%>
    <%--<button type="button" class="btn btn-default dropdown-toggle"--%>
            <%--data-toggle="dropdown" style="margin:10px" >--%>
        <%--数据类型分类选择 <span class="caret"></span>--%>
    <%--</button>--%>
    <%--<ul class="dropdown-menu" role="menu" >--%>
        <%--<li><a href="#" id="buttonmodel">模型</a></li>--%>
        <%--<li><a href="#" id="buttonfile">文件</a></li>--%>
        <%--<li><a href="#" id="buttondata">结构型数据</a></li>--%>
        <%--<li><a href="#" id="buttonother">全部</a></li>--%>
    <%--</ul>--%>
<%--</div>--%>
<div class="form-group col-xs-4">
    <%--<label for="name">选择列表</label>--%>
    <select class="form-control" id="testSelect" style="margin:10px">
        <option value="4">全部类型</option>
        <option value="1">模型</option>
        <option value="2">文件</option>
        <option value="3">结构型数据</option>
        <%--<option>5</option>--%>
    </select>
</div>
<table id="tb_department" class=" col-xs-2 ">
</table>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
<%--<script src="${ctx}/newtable/Releasedata.js"></script>--%>
</body>
<script type="text/javascript">
    $(function () {
//1.初始化Table
       new TableInit();
    });
    function TableInit() {
//初始化Table
        var $table = $('#tb_department');
//        InitSubTable();
        $('#tb_department').bootstrapTable({
            url:"getReleasedatanew.ht?id=<%=request.getParameter("id")%>&DataTypenum="+$('#testSelect option:selected') .val(),
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
//            sortable: true,                     //是否启用排序
//            sortName : 'DdDataName',//初始化的时候排序的字段
            showExport: true,                     //是否显示导出
            exportDataType: "basic",              //basic', 'all', 'selected'.
            sortOrder: "desc",                   //排序方式
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 5,                       //每页的记录行数（*）
            pageList: [5, 10, 20, 50],        //可供选择的每页的行数（*）
            queryParamsType: '',
//            search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            showColumns: false,                  //是否显示所有的列
            showRefresh: false,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: false,                //是否启用点击选中行
//            height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "DdDataId",                     //每一行的唯一标识，一般为主键列
            showToggle: false,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: true,                   //是否显示父子表
            columns: [
                {//第一列，数据名称
                    field: 'DdDataName',
                    title: '数据名称',
//                    events: operateEvents,
//                   formatter: operateFormatter(),
                    sortable: false,
                    editable: false,
                    align: 'center',
                    visible: true
                }, {//第二列，最新值
                    field: 'DdDataLastestValue',
                    title: '最新值',
//                    sortable: true,
                    editable: false,
// footerFormatter: ddDataNameFormatter,
                    align: 'center',
                    visible: true
                }, {//第三列
                    field: 'DdDataType',
                    title: '数据类型',
//                    sortable: true,
                    editable: false,
// footerFormatter: ddDataNameFormatter,
                    align: 'center',
                    visible: true
                }, {//第四列
                    field: 'DdDataCreateTime',
                    title: '更新时间',
//                    sortable: true,
                    editable: false,
// footerFormatter: ddDataNameFormatter,
                    align: 'center',
                    visible: true
                }, {//第五列，
                    field: 'DdDataDescription',
                    title: '描述',
//                    sortable: true,
                    editable: false,
// footerFormatter: ddDataNameFormatter,
                    align: 'center',
                    visible: true
                },
                {//第六列，
                    field: 'DdDataId',
                    title: '数据ID',
//                    sortable: true,
                    editable: false,
// footerFormatter: ddDataNameFormatter,
                    align: 'center',
                    visible: false
                },
            ],
            onExpandRow: function (index, row, $detail) {
                InitSubTable(index, row, $detail);
            },
        });
//初始化子表格(无线循环)
            function InitSubTable(index, row, $detail) {
            var parentid = row.DdDataId;
            var cur_table = $detail.html('<table></table>').find('table');
            $(cur_table).bootstrapTable({
                url: 'dataversion.ht?id=' + row.DdDataId,
                method: 'get',
                queryParams: {strParentID: parentid},
                ajaxOptions: {strParentID: parentid},
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
// pagination: true,                   //是否显示分页（*）
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                clickToSelect: true,
                detailView: false,//父子表
                uniqueId: "MENU_ID",
                pageSize: 10,
                pageList: [5, 10, 20, 50],
                columns: [{//第一列，数据名称
                    field: 'DdDataVersion',
                    title: '版本',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: true
                }, {//第二列，数据值
                    field: 'ddDataValue',
                    title: '数据值',
                    sortable: true,
                    editable: false,
// footerFormatter: ddDataNameFormatter,
                    align: 'center',
                    visible: true
                }, {//第三列
                    field: 'ddDataRecordTime',
                    title: '更新时间',
                    sortable: true,
                    editable: false,
// footerFormatter: ddDataNameFormatter,
                    align: 'center',
                    visible: true
                },
                    {
                        field: 'operate',
                        title: '操作',
                        align: 'center',
                        events: operateEvents,
                        formatter: operateFormatter(),
                        visible: true
                    },
                ],
//无线循环取子表，直到子表里面没有记录
                onExpandRow: function (index, row, $Subdetail) {
                    InitSubTable(index, row, $Subdetail);
                },
            });
        };
// 得到查询的参数
        function queryParams(params) {
            var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                limit: params.limit,   //页面大小
                offset: params.offset,  //页码
                departmentname: $("#txt_search_departmentname").val(),
                statu: $("#txt_search_statu").val(),
                search: params.search
            };
        };
    }
    ;
//    alert($('#testSelect option:selected') .val());
    $('#testSelect').click(function () {
        $('#tb_department').bootstrapTable('refresh', {url: 'getReleasedatanew.ht?id=<%=request.getParameter("id")%>&DataTypenum='+$('#testSelect option:selected') .val()});
    });


    $('#button').click(function () {
        $('#tb_department').bootstrapTable('refresh',{url: 'getReleasedatanew.ht?id=<%=request.getParameter("id")%>'});
    });

    //注册加载子表的事件。注意下这里的三个参数！
    //原始操作按钮
    function operateFormatter(value, row, index) {
        return [
//            '<a id="removetr" class="remove" href="javascript:void(0)" title="删除">',
//            '<i class="glyphicon glyphicon-remove"></i>',
//            '</a>',
            '<a id="download0" class="download" href="javascript:void(0)" title="下载">',
            '<i class="glyphicon glyphicon-download-alt"></i>',
            '</a>'
        ].join('');
    }
    window.operateEvents = {
        <%--'click .remove': function (e, value, row, index) {--%>
            <%--$.get('${ctx}/datadriver/modelcenter/remove.ht?id=' + row.ModelID);--%>
            <%--$("#tb_departments").bootstrapTable("refresh");--%>
        <%--},--%>
        'click .download': function (e, value, row, index) {
            alert(row.DataType);
            alert(row.ModelUrl);
            if (row.DataType == "模型" || row.DataType == "文件") {
                window.location.href = "${ctx}/datadriver/modelcenter/getmodel.ht?modelurl=" + row.ModelUrl + "&modelname=" + row.ModelName;
            }
        }
    };
</script>
</html>