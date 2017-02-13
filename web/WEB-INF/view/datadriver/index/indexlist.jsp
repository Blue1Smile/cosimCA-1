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
    <link rel="stylesheet" href="${ctx}/newtable/bootstrap.css">
    <link rel="stylesheet" href="${ctx}/newtable/bootstrap-table.css">

    <script src="${ctx}/newtable/bootstrap-table.js"></script>
    <script src="${ctx}/newtable/bootstrap-table-zh-CN.js"></script>

    <style>
        .mutedandresize {
            color: #A6A6A6;
            font-size: 13px;
            margin-right: 6px;
        }
        table {
            background-color: #FFFFFF;
        }
    </style>
</head>
<body>
<div class="panel panel-primary" style="height: 100%">
    <div class="panel-heading">
        项目指标信息列表
    </div>
    <div class="panel-body">
        <br>
        <div class="row">
            <form id="searchForm" method="post" action="list.ht" class="form-inline">
                <div class="col-xs-3">
                        <label class="mutedandresize">指标名称: </label><input type="text" name="ddIndexName" class="form-control"/>
                </div>
                <div class="col-xs-3">
                    <label class="mutedandresize">创建日期 从: </label><input name="Q_begincreateTime_DL" class="form-control"/>
                </div>
                <div class="col-xs-3">
                    <label class="mutedandresize">至: </label><input name="Q_endcreateTime_DG" class="form-control"/>
                </div>
            </form>
            <div class="col-xs-3">
                <div class="pull-right">
                    <a class="btn btn-default" id="Search"><span class="glyphicon glyphicon-search"></span> 查询</a>
                    <%--<a class="btn btn-success" href="edit.ht"><span class="glyphicon glyphicon-plus"></span> 添加</a>--%>
                </div>
            </div>
        </div>
<br>
        <c:set var="checkAll">
            <input type="checkbox" id="chkall"/>
        </c:set>
        <display:table name="indexInfoList" id="indexInfoItem" requestURI="list.ht" sort="external" cellpadding="0"
                       cellspacing="0" class="table table-bordered" pagesize="10">
            <%--<display:column title="${checkAll}" media="html" style="width:5%;">--%>
                <%--<input type="checkbox" class="pk" name="" value="">--%>
            <%--</display:column>--%>
            <%--<display:column property="ddIndexId" title="指标编号" sortable="true" sortName="DD_PROJECT_ID"--%>
                            <%--maxLength="80"></display:column>--%>
            <display:column property="ddIndexName" title="指标名称" sortable="true" sortName="DD_PROJECT_NAME"
                            maxLength="80"></display:column>
            <%--<display:column property="ddIndexProjectId" title="指标关联id" maxLength="80"></display:column>--%>
            <%--<display:column property="ddIndexTypeId" title="指标类型id"></display:column>--%>
            <%--<display:column property="ddIndexProperty" title="指标属性" sortable="true"--%>
                            <%--sortName="DD_PROJECT_CREATE_DATATIME"></display:column>--%>
            <%--<display:column property="ddIndexOptimum" title="指标最优值" maxLength="80"></display:column>--%>
            <display:column property="ddIndexResponsiblePersonId" title="指标责任人id" maxLength="80"></display:column>
            <%--<display:column property="ddIndexSensitiveness" title="指标敏感度" maxLength="80"></display:column>--%>
            <%--<display:column property="ddIndexLastestValue" title="指标最新值"></display:column>--%>

            <display:column title="操作" media="html" style="width:15%">
                <a href="" class="btn btn-info btn-xs">查看</a>
                <a href="" class="btn btn-primary btn-xs">编辑</a>
                <a href="" class="btn btn-danger btn-xs">删除</a>
            </display:column>
        </display:table>
    </div>
</div>
</body>
</html>




