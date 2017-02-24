<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/11/20 0020
  Time: 下午 3:41
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="hotent" uri="http://www.jee-soft.cn/paging" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <a id="" class="btn btn-primary" href="${ctx}/datadriver/datacenter/datasnapshot.ht?projectId=${projectId}"><span class="glyphicon glyphicon-ok"></span>数据快照</a>
    <a id="" class="btn btn-primary" href="${ctx}/datadriver/datacenter/snapshotlist.ht"><span class="glyphicon glyphicon-ok"></span>快照列表</a>

    <title>项目指标信息列表</title>
    <%--<link rel="stylesheet" href="${ctx}/newtable/bootstrap.css">--%>
    <%--<link rel="stylesheet" href="${ctx}/newtable/bootstrap-table.css">--%>
    <%--<script type="text/javascript" src="${ctx}/resources/script/configBase.js"></script>--%>


    <%--<script type="text/javascript" src="${ctx}/resources/script/jquery-ui.min.js"></script>--%>
    <%--<script type="text/javascript" src="${ctx}/resources/script/dcselect.js"></script>--%>
    <%--<script type="text/javascript" src="${ctx}/resources/script/layer/layer.js"></script>--%>
    <%--<script type="text/javascript" src="${ctx}/resources/script/artTemplate/template.js"></script>--%>

    <%--<script type="text/javascript" src="${ctx}/resources/script/exam/exam.js"></script>--%>

    <%--<script src="${ctx}/newtable/bootstrap-table.js"></script>--%>
    <%--<script src="${ctx}/newtable/bootstrap-table-zh-CN.js"></script>--%>

    <%--<style>--%>
    <%--.mutedandresize {--%>
    <%--color: #A6A6A6;--%>
    <%--font-size: 13px;--%>
    <%--margin-right: 6px;--%>
    <%--}--%>

    <%--table {--%>
    <%--background-color: #fefefe;--%>
    <%--}--%>
    <%--</style>--%>
    <%@include file="/newtable/tablecontext.jsp" %>
</head>
<body>

    <%--<div class="panel-heading">--%>
        <%--项目指标信息列表--%>
    <%--</div>--%>
    <%--<div class="panel-body">--%>
        <%--<br>--%>
        <%--<div class="row">--%>
            <%--<form id="searchForm" method="post" action="list.ht" class="form-inline">--%>
                <%--<div class="col-xs-3">--%>
                    <%--<label class="mutedandresize">指标名称: </label><input type="text" name="ddIndexName"--%>
                                                                       <%--class="form-control"/>--%>
                <%--</div>--%>
                <%--<div class="col-xs-3">--%>
                    <%--<label class="mutedandresize">创建日期 从: </label><input name="Q_begincreateTime_DL"--%>
                                                                         <%--class="form-control"/>--%>
                <%--</div>--%>
                <%--<div class="col-xs-3">--%>
                    <%--<label class="mutedandresize">至: </label><input name="Q_endcreateTime_DG" class="form-control"/>--%>
                <%--</div>--%>
            <%--</form>--%>
            <%--<div class="col-xs-3">--%>
                <%--<div class="pull-right">--%>
                    <%--<a class="btn btn-default" id="Search"><span class="glyphicon glyphicon-search"></span> 查询</a>--%>
                    <%--&lt;%&ndash;<a class="btn btn-success" href="edit.ht"><span class="glyphicon glyphicon-plus"></span> 添加</a>&ndash;%&gt;--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<br>--%>
        <table id="indextable"></table>
        <%--<c:set var="checkAll">--%>
            <%--<input type="checkbox" id="chkall"/>--%>
        <%--</c:set>--%>
        <%--<display:table name="indexInfoList" id="indexInfoItem" requestURI="list.ht" sort="external" cellpadding="0"--%>
                       <%--cellspacing="0" class="table table-striped" pagesize="10">--%>
            <%--&lt;%&ndash;<display:column title="${checkAll}" media="html" style="width:5%;">&ndash;%&gt;--%>
            <%--&lt;%&ndash;<input type="checkbox" class="pk" name="" value="">&ndash;%&gt;--%>
            <%--&lt;%&ndash;</display:column>&ndash;%&gt;--%>
            <%--&lt;%&ndash;<display:column property="ddIndexId" title="指标编号" sortable="true" sortName="DD_PROJECT_ID"&ndash;%&gt;--%>
            <%--&lt;%&ndash;maxLength="80"></display:column>&ndash;%&gt;--%>
            <%--<display:column property="ddIndexName" title="指标名称" sortable="false" sortName="DD_PROJECT_NAME"--%>
                            <%--maxLength="80"></display:column>--%>
            <%--&lt;%&ndash;<display:column property="ddIndexProjectId" title="指标关联id" maxLength="80"></display:column>&ndash;%&gt;--%>
            <%--&lt;%&ndash;<display:column property="ddIndexTypeId" title="指标类型id"></display:column>&ndash;%&gt;--%>
            <%--<display:column property="ddIndexProperty" title="指标类型" sortable="false"--%>
                            <%--sortName="DD_PROJECT_CREATE_DATATIME"></display:column>--%>
            <%--<display:column property="ddIndexOptimum" title="指标最优值" maxLength="80"></display:column>--%>
            <%--&lt;%&ndash;<display:column property="ddIndexResponsiblePersonId" title="指标责任人id" maxLength="80"></display:column>&ndash;%&gt;--%>
            <%--&lt;%&ndash;<display:column property="ddIndexSensitiveness" title="指标敏感度" maxLength="80"></display:column>&ndash;%&gt;--%>
            <%--<display:column property="ddIndexLastestValue" title="指标最新值"></display:column>--%>

            <%--<display:column title="操作" media="html" style="width:15%">--%>
                <%--<a href="" class="btn btn-primary btn-xs">编辑</a>--%>
                <%--<a href="" class="btn btn-danger btn-xs">删除</a>--%>
            <%--</display:column>--%>
        <%--</display:table>--%>
    <%--</div>--%>
<%--</div>--%>
<%--<!--主体框架开始-->--%>
<%--<div class="pagebox" id="pageContentId">--%>
    <%--<div class="home-desktop" id="desktop_scroll">--%>
        <%--<div class="row-fluid">--%>


            <%--<!--出题-->--%>
            <%--<div class="create-questions">--%>
                <%--<div class="questions-head-title">--%>
                    <%--<h4 class="h4-bg T_edit T-center" data-Tid="10001"><span--%>
                            <%--style="font-size:14px;">指标名称</span></h4>--%>

                <%--</div>--%>
                <%--<ul class="list-group pull-right" id="ui_sortable_exam">--%>
                    <%--<li data-uid="5" data-tempId="drag_completion" class="list-group-item">--%>
                        <%--<a href="javascript:;" data-checkType="1" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span></a>--%>
                    <%--</li>--%>
                <%--</ul>--%>
                <%--<table class="questions-items-title">--%>
                    <%--<tbody>--%>
                    <%--<tr>--%>
                        <%--<td class="module-menu">说明</td>--%>
                        <%--<td>--%>
                            <%--<div class="cq-title T_edit" data-Tid="10002"><span--%>
                                    <%--style="font-size:12px;">填写备注</span></div>--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                    <%--</tbody>--%>
                <%--</table>--%>
                <%--<ul class="ui-questions-content-list"></ul>--%>
                <%--<ul class="ui-foot-all-list"></ul>--%>
            <%--</div>--%>

        <%--</div>--%>
    <%--</div>--%>

    <%--<!--填空题-->--%>
    <%--<script type="text/html" id="drag_completion">--%>
        <%--<li class="ui-module items-questions">--%>
            <%--<div class="theme-type">--%>
                <%--<div class="module-menu">--%>
                    <%--<h4></h4>--%>
                    <%--<div class="module-ctrl">--%>
                        <%--<a href="javascript:void(0);" class="ui-up-btn" data-tisp="上移"><i class="icon-up"></i></a>--%>
                        <%--<a href="javascript:void(0);" class="ui-down-btn" data-tisp="下移"><i class="icon-down"></i></a>--%>
                        <%--<a href="javascript:void(0);" class="ui-clone-btn" data-tisp="复制"><i class="icon-clone"></i></a>--%>
                        <%--<a href="javascript:void(0);" class="ui-del-btn" data-tisp="删除"><i class="icon-del"></i></a>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="ui-drag-area">--%>
                    <%--<div class="cq-title T_edit" data-Tid="{{itmetid}}"><span style="font-size:16px;">{{if type==1}}填空题目标题{{else if type==2}}完形填空题目标题{{/if}}</span></div>--%>
                <%--</div>--%>
                <%--<div class="cq-items-content">--%>
                    <%--<div class="describe-edit-content T_edit" data-tid="{{items[0].tid}}"><span style="line-height: 1.6;12px;">这里是{{if type==1}}填空题目标题{{else if type==2}}完形填空题目标题{{/if}}</span></div>--%>
                <%--</div>--%>
                <%--<div class="cq-items-content">--%>
                    <%--<div class="describe-edit-content T_edit" data-tid="{{items[0].tid}}"><span style="line-height: 1.6;12px;">这里是{{if type==1}}填空题目标题{{else if type==2}}完形填空题目标题{{/if}}</span></div>--%>
                <%--</div>--%>
                <%--<div class="cq-items-content">--%>
                    <%--<div class="describe-edit-content T_edit" data-tid="{{items[0].tid}}"><span style="line-height: 1.6;12px;">这里是{{if type==1}}填空题目标题{{else if type==2}}完形填空题目标题{{/if}}</span></div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</li>--%>
    <%--</script>--%>

    <%--<script type="text/html" id="drag_T_edit">--%>
        <%--<div class="cq-into-edit">--%>
            <%--<div class="add-edit cq-edit-title" contenteditable="true">{{title}}</div>--%>
        <%--</div>--%>
    <%--</script>--%>
    <%--<script type="text/html" id="T_edit_plugins">--%>
        <%--<div class="edit-plug-box">--%>
            <%--<a href="javascript:void(0);"><i class="icon-picChoice"></i></a>--%>
            <%--<a href="javascript:void(0);"><i class="icon-title"></i></a>--%>
        <%--</div>--%>
    <%--</script>--%>
    <%--<script type="text/html" id="ui_additem_content">--%>
        <%--{{each items as itemData i}}--%>
        <%--<li><label class="input-check"><input type="{{if type==1}}radio{{else if type==2}}checkbox{{/if}}" name="{{name}}" value="{{itemData.value}}"></label>--%>
            <%--<div class="cq-answer-content T_edit T_plugins" data-Tid="{{itemData.tid}}">选项{{i+1+index}}</div>--%>
        <%--</li>--%>
        <%--{{/each}}--%>
    <%--</script>--%>
    <%--<script type="text/html" id="analysis_tmp">--%>
        <%--<textarea class="exam-textarea analysis_contx" placeholder="请在此填写答案解析"></textarea>--%>
    <%--</script>--%>
    <%--<script type="text/javascript">--%>
        <%--$(function() {--%>
            <%--exam.init();--%>
            <%--$("select").dcselect();--%>
        <%--});--%>
    <%--</script>--%>
<%--</div>--%>
<%--<!--主体框架结束-->--%>
        <script type="text/javascript">
            var $table = $('#indextable'),
                    $remove = $('#remove'),
                    selections = [];
            var curRow = {};
            function initTable() {
                $table.bootstrapTable({
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
                            editable: false,
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
                        }
                    ],
                    onClickRow: function (row, $element) {
                        curRow = row;
                    },
                    onEditableSave: function (field, row, oldValue, $el) {
                        $.ajax({
                            type: "post",
                            url: "${ctx}/datadriver/index/lastvalue.ht",
                            data: { strJson: JSON.stringify(row) },
                            success: function (data, status) {
                                if (status == "success") {
                                    alert("编辑成功");
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
                        ]
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




