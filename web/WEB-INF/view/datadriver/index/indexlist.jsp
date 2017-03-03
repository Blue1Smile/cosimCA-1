<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/11/20 0020
  Time: 下午 3:41
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="hotent" uri="http://www.jee-soft.cn/paging" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html lang="zh-CN">
<head>
    <title>项目指标信息列表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>
</head>
<body>
<p class="pull-right">
    <a id="" class="btn btn-success" href="${ctx}/datadriver/datacenter/datasnapshot.ht?projectId=${projectId}"><span
            class="glyphicon glyphicon-camera"></span> 数据快照</a>
</p>

<table id="indextable"></table>
<script type="text/javascript">
    var $table = $('#indextable'),
            $remove = $('#remove');
    var curRow = {};
    function initTable() {
        $table.bootstrapTable({
            idField: "ddIndexId",
            url: "${ctx}/datadriver/index/indexjson.ht?id=${projectId}",
            //   pageList: [10, 25],
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 5,                       //每页的记录行数（*）
            queryParamsType: '',
            // queryParams:queryParams,
            pageList: [5, 10, 20, 50],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: false,                  //是否显示所有的列
            showRefresh: false,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: false,                //是否启用点击选中行
            height: 380,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "ddIndexId",                     //每一行的唯一标识，一般为主键列
            showToggle: false,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            columns: [
                {//第一列，数据ID
                    field: 'ddIndexId',
                    title: '指标Id',
                    sortable: true,
                    editable: false,
                    align: 'center',
                    visible: false
                }, {//第二列，名称
                    field: 'ddIndexName',
                    title: '指标名称',
                    sortable: true,
                    editable: {
                        validate: function (va) {
                            if (va.length == 0) return '指标名称不能为空';
                        }
                    },
                    // footerFormatter: ddDataNameFormatter,
                    align: 'center',
                    visible: true
                }, {//所属任务ID
                    field: 'ddIndexProjectId',
                    title: '所属项目ID',
                    sortable: true,
                    editable: false,
                    // footerFormatter: ddDataNameFormatter,
                    align: 'center',
                    visible: false
                }
                , {//第三列，数值
                    field: 'ddIndexLastestValue',
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
                    //,
                    // footerFormatter: ddDataLastestValueFormatter
                }
                , {//数据类型
                    field: 'ddIndexTypeId',
                    title: '数据类型',
                    sortable: true,
                    editable: false,
                    // footerFormatter: ddDataNameFormatter,
                    align: 'center',
                    visible: true
                }, {//所属任务
                    field: 'ddIndexOptimum',
                    title: '最优值',
                    sortable: true,
                    editable: false,
                    // footerFormatter: ddDataNameFormatter,
                    align: 'center',
                    visible: true
                }, {
                    field: 'operate',
                    title: '操作',
                    align: 'center',
                    events: operateEvents,
                    formatter: operateFormatter()
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
//                        if (status == "success") {
//                            alert("编辑成功");
//                        }
                    },
                    error: function () {
//                        alert("Error");
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
    }
    //原始操作按钮
    function operateFormatter(value, row, index) {
        return [
            '<a id="removetr" class="remove" href="javascript:void(0)" title="删除">',
            '<i class="glyphicon glyphicon-remove"></i>',
            '</a>'
        ].join('');
    }
    window.operateEvents = {
//        'click .like': function (e, value, row, index) {
//            alert('You click like action, row: ' + JSON.stringify(row));
//        },
        'click .remove': function (e, value, row, index) {
            $table.bootstrapTable('remove', {
                field: 'ddIndexId',
                values: [row.ddIndexId],
            });
            $.get('${ctx}/datadriver/index/delindex.ht?id=' + row.ddIndexId);
        }

    };
    $(function () {
        initTable();
    });
</script>
</body>
</html>




