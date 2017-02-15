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
    <title>项目指标信息列表</title>
    <%--<link rel="stylesheet" href="${ctx}/newtable/bootstrap.css">--%>
    <%--<link rel="stylesheet" href="${ctx}/newtable/bootstrap-table.css">--%>
    <%--<script type="text/javascript" src="${ctx}/resources/script/configBase.js"></script>--%>


    <script type="text/javascript" src="${ctx}/resources/script/jquery-ui.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/script/dcselect.js"></script>
    <script type="text/javascript" src="${ctx}/resources/script/layer/layer.js"></script>
    <script type="text/javascript" src="${ctx}/resources/script/artTemplate/template.js"></script>

    <script type="text/javascript" src="${ctx}/resources/script/exam/exam.js"></script>

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
</head>
<body>
<%--<div class="panel panel-primary" style="height: 100%">--%>
<%--<div class="panel-heading">--%>
<%--项目指标信息列表--%>
<%--</div>--%>
<%--<div class="panel-body">--%>
<%--<br>--%>
<%--<div class="row">--%>
<%--<form id="searchForm" method="post" action="list.ht" class="form-inline">--%>
<%--<div class="col-xs-3">--%>
<%--<label class="mutedandresize">指标名称: </label><input type="text" name="ddIndexName" class="form-control"/>--%>
<%--</div>--%>
<%--<div class="col-xs-3">--%>
<%--<label class="mutedandresize">创建日期 从: </label><input name="Q_begincreateTime_DL" class="form-control"/>--%>
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
<!--主体框架开始-->
<div class="pagebox" id="pageContentId">
    <div class="home-desktop" id="desktop_scroll">
        <div class="row-fluid">


            <!--出题-->
            <div class="create-questions col-xs-10">
                <div class="questions-head-title">
                    <h4 class="h4-bg T_edit T-center" data-Tid="10001"><span
                            style="font-size:14px;">指标名称</span></h4></div>
                <table class="questions-items-title">
                    <tbody>
                    <tr>
                        <td class="module-menu">说明</td>
                        <td>
                            <div class="cq-title T_edit" data-Tid="10002"><span
                                    style="font-size:12px;">填写备注</span></div>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <ul class="ui-questions-content-list"></ul>
                <ul class="ui-foot-all-list"></ul>
            </div>
            <div class="col-xs-2">
                <ul class="exam-nav-list" id="ui_sortable_exam">
                    <li data-uid="5" data-tempId="drag_completion">
                        <a href="javascript:;" data-checkType="1"><span class="glyphicon glyphicon-plus"></span></a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <!--填空题-->
    <script type="text/html" id="drag_completion">
        <li class="ui-module items-questions">
            <div class="theme-type">
                <div class="module-menu">
                    <h4></h4>
                    <div class="module-ctrl">
                        <a href="javascript:void(0);" class="ui-up-btn" data-tisp="上移"><i class="icon-up"></i></a>
                        <a href="javascript:void(0);" class="ui-down-btn" data-tisp="下移"><i class="icon-down"></i></a>
                        <a href="javascript:void(0);" class="ui-clone-btn" data-tisp="复制"><i class="icon-clone"></i></a>
                        <a href="javascript:void(0);" class="ui-del-btn" data-tisp="删除"><i class="icon-del"></i></a>
                    </div>
                </div>
                <div class="ui-drag-area">
                    <div class="cq-title T_edit" data-Tid="{{itmetid}}"><span style="font-size:16px;">{{if type==1}}填空题目标题{{else if type==2}}完形填空题目标题{{/if}}</span></div>
                </div>
                <div class="cq-items-content">
                    <div class="describe-edit-content T_edit" data-tid="{{items[0].tid}}"><span style="line-height: 1.6;12px;">这里是{{if type==1}}填空题目标题{{else if type==2}}完形填空题目标题{{/if}}</span></div>
                </div>
            </div>
        </li>
    </script>

    <script type="text/html" id="drag_T_edit">
        <div class="cq-into-edit">
            <div class="add-edit cq-edit-title" contenteditable="true">{{title}}</div>
        </div>
    </script>
    <script type="text/html" id="T_edit_plugins">
        <div class="edit-plug-box">
            <a href="javascript:void(0);"><i class="icon-picChoice"></i></a>
            <a href="javascript:void(0);"><i class="icon-title"></i></a>
        </div>
    </script>
    <script type="text/html" id="ui_additem_content">
        {{each items as itemData i}}
        <li><label class="input-check"><input type="{{if type==1}}radio{{else if type==2}}checkbox{{/if}}" name="{{name}}" value="{{itemData.value}}"></label>
            <div class="cq-answer-content T_edit T_plugins" data-Tid="{{itemData.tid}}">选项{{i+1+index}}</div>
        </li>
        {{/each}}
    </script>
    <script type="text/html" id="analysis_tmp">
        <textarea class="exam-textarea analysis_contx" placeholder="请在此填写答案解析"></textarea>
    </script>
    <script type="text/javascript">
        $(function() {
            exam.init();
            $("select").dcselect();
        });
    </script>
</div>
<!--主体框架结束-->

</body>
</html>




