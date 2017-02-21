
<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@page import="com.hotent.core.util.ContextUtil" %>
<html>
<head>
    <title>数据发布列表</title>
    <%@include file="/commons/include/form.jsp" %>
    <%@include file="/newtable/tablecontext.jsp" %>
    <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
</head>
<body>
    <table id="tablelist">
    </table>

<script type="text/javascript">
    var $table = $('#tablelist'),
            $remove = $('#remove'),
            selections = [];
    var curRow = {};
    function initTable() {
        $table.bootstrapTable({
            url: "submitpublishjson.ht?id=${taskId}",
            //   pageList: [10, 25],
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber:1,                       //初始化加载第一页，默认第一页
            pageSize: 5,                       //每页的记录行数（*）
            queryParamsType:'',
            // queryParams:queryParams,
            pageList: [5, 10, 20, 50],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: false,                  //是否显示所有的列
            showRefresh: false,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: false,                //是否启用点击选中行
            height: 380,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            showToggle:false,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: true,                   //是否显示父子表
            columns: [
                {//第一列，数据ID
                    field: 'ddDataId',
                    title: '数据ID',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: false
                }, {//第二列，名称
                    field: 'ddDataName',
                    title: '数据名称',
                    sortable: true,
                    editable: false,
                    // footerFormatter: ddDataNameFormatter,
                    align: 'center',
                    visible: true
                }, {//所属任务ID
                    field: 'ddDataTaskId',
                    title: '所属任务ID',
                    sortable: true,
                    editable: false,
                    // footerFormatter: ddDataNameFormatter,
                    align: 'center',
                    visible: false
                }
                , {//第三列，数值
                    field: 'ddDataLastestValue',
                    title: '值',
                    sortable: true,
                    align: 'center',
                    editable: {
                        type: 'text',
                        title: '值',
                        validate: function (v) {
                            if (isNaN(v)) return '值必须是数字';
                        }
                    }
                    //,
                    // footerFormatter: ddDataLastestValueFormatter
                }
                , {//数据类型
                    field: 'ddDataType',
                    title: '数据类型',
                    sortable: true,
                    editable: false,
                    // footerFormatter: ddDataNameFormatter,
                    align: 'center',
                    visible: true
                }, {//所属任务
                    field: 'ddDataTaskName',
                    title: '所属任务',
                    sortable: true,
                    editable: false,
                    // footerFormatter: ddDataNameFormatter,
                    align: 'center',
                    visible: true
                }
            ],
            onClickRow: function (row, $element) {
                curRow = row;
            },
            //注册加载子表的事件。注意下这里的三个参数！
//            onExpandRow: function (index, row, $detail) {
//                $table.InitSubTable(index, row, $detail);
//            },
            //查询参数,每次调用是会带上这个参数，可自定义
//            queryParams: function(params) {
//                var name = $('#ddDataName').val();
//                return {
//                    pageNumber: params.offset+1,
//                    pageSize: params.limit,
//                    name:name
//                };
//            },
            onEditableSave: function (field, row, oldValue, $el) {
                $.ajax({
                    type: "post",
                    url: "refreshlastvalue.ht",
                    data: { strJson: JSON.stringify(row) },
                    success: function (data, status) {
                        if (status == "success") {
                            alert("修改成功！");
                        }
                    },
                    error: function () {
                        alert("Error");
                    },
                    complete: function () {

                    }

                });
            }
        });

        // sometimes footer render error.
        setTimeout(function () {
            $table.bootstrapTable('resetView');
        }, 200);
        $table.on('check.bs.table uncheck.bs.table ' +
                'check-all.bs.table uncheck-all.bs.table', function () {
            $remove.prop('disabled', !$table.bootstrapTable('getSelections').length);

            // save your data, here just save the current page
            selections = getIdSelections();
            // push or splice the selections if you want to save all data selections
        });
        $table.on('expand-row.bs.table', function (e, index, row, $detail) {
            $table.InitSubTable(index, row, $detail);
        });
        $table.on('all.bs.table', function (e, name, args) {
            console.log(name, args);
        });
        $remove.click(function () {
            var ids = getIdSelections();
            $table.bootstrapTable('remove', {
                field: 'id',
                values: ids
            });
            $remove.prop('disabled', true);
        });
        $table.InitSubTable = function (index, row, $detail){
        var ddDataId = row.ddDataId;
            var cur_table = $detail.html('<table></table>').find('table');
            $(cur_table).bootstrapTable({
                url: 'showfiveversion.ht',
                method: 'post',
                data:{ddDataId: ddDataId},
                queryParams: {ddDataId: ddDataId},
                ajaxOptions: {ddDataId: ddDataId},
                clickToSelect: true,
                detailView: true,//父子表
                detailFormatter:"detailFormatter",
                uniqueId: "MENU_ID",
                pageSize: 2,
                pageList: "[5, 10, 20, 50, ALL]",
                columns: [
                    //    {
                    //    checkbox: true
                    //},
                    {//第一列，数据ID
                        field: 'ddDataVersionId',
                        title: '数据版本ID',
                        sortable: true,
                        editable: false,
                        align: 'center',
                        visible: false
                    }, {//第二列，名称
                        field: 'ddDataId',
                        title: '数据ID',
                        sortable: true,
                        editable: false,
                        // footerFormatter: ddDataNameFormatter,
                        align: 'center',
                        visible: true
                    }, {//所属任务ID
                        field: 'ddDataRecordTime',
                        title: '数据记录时间',
                        sortable: true,
                        editable: false,
                        // footerFormatter: ddDataNameFormatter,
                        align: 'center',
                        visible: false
                    }
                    , {//第三列，数值
                        field: 'ddDataRecordPersonId',
                        title: '数据记录人ID',
                        sortable: true,
                        align: 'center',
                        editable: {
                            type: 'text',
                            title: '值',
                            validate: function (v) {
                                if (isNaN(v)) return '值必须是数字';
                            }
                        }
                        //,
                        // footerFormatter: ddDataLastestValueFormatter
                    }
                    , {//数据类型
                        field: 'ddDataValue',
                        title: '数据值',
                        sortable: true,
                        editable: false,
                        // footerFormatter: ddDataNameFormatter,
                        align: 'center',
                        visible: true
                    }
                ],
                ////无线循环取子表，直到子表里面没有记录
                //onExpandRow: function (index, row, $Subdetail) {
                //    oInit.InitSubTable(index, row, $Subdetail);
                //}
            });
        }
    }

    function getIdSelections() {
        return $.map($table.bootstrapTable('getSelections'), function (row) {
            return row.id
        });
    }

    function responseHandler(res) {
        $.each(res.rows, function (i, row) {
            row.state = $.inArray(row.id, selections) !== -1;
        });
        return res;
    }

    function detailFormatter(index, row) {
        var html = [];
        $.each(row, function (key, value) {
            html.push('<p><b>' + key + ':</b> ' + value + '</p>');
        });
        return html.join('');
    }

    //原始操作按钮
    function operateFormatter(value, row, index) {
        return [
            '<a class="like" href="javascript:void(0)" title="Like">',
            '<i class="glyphicon glyphicon-heart"></i>',
            '</a>  ',
            '<a class="remove" href="javascript:void(0)" title="Remove">',
            '<i class="glyphicon glyphicon-remove"></i>',
            '</a>'
        ].join('');
    }

    //发布数据更新
    function operateFormatterRefresh(value, row, index) {
        return [
            '<a class="refresh" href="javascript:void(0)" title="refresh">',
            '<i class="glyphicon glyphicon-refresh"></i>',
            '</a>'
        ].join('');
    }

    //操作按钮功能实现
    window.operateEvents = {
        'click .like': function (e, value, row, index) {
            alert('You click like action, row: ' + JSON.stringify(row));
        },
        'click .refresh': function (e, value, row, index) {
            //添加更新功能
        },
        'click .remove': function (e, value, row, index) {
            $table.bootstrapTable('remove', {
                field: 'id',
                values: [row.id]
            });
        }
    };

    function totalTextFormatter(data) {
        return 'Total';
    }

    function ddDataNameFormatter(value, row, index) {
        return "<a id=\"table_a\" href=\"#\" name=\"ddDataName\" data-type=\"text\" data-pk=\""+row.id+"\" data-title=\"用户名\">" + value + "</a>";
    }

    function ddDataLastestValueFormatter(data) {
        return "<a href=\"#\" name=\"ddDataLastestValue\" data-type=\"text\" data-pk=\""+row.id+"\" data-title=\"值\">" + value + "</a>";
    }

    function getHeight() {
        var length = $(window).height() - $('.layui-tab-title').outerHeight(true);
        return $(window).height() - $('.layui-tab-title').outerHeight(true);
    }

    $(function () {
        initTable();
    });
</script>
</body>
</html>
