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
    <title>项目基础信息列表</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>
    <%--<script src="${ctx}/newtable/jquery.js"></script>--%>
    <%@include file="/commons/datadriver/formbase.jsp" %>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
    <script src="${ctx}/newtable/bootstrap.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>

    <style>
        .fl {
            float: left;
        }

        .fr {
            float: right;
        }

        .pages {
            float: right;
        }

        .page_line {
            display: inline;
        }
    </style>
</head>
<body>
<div class="col-xs-10 col-xs-offset-1">
    <div class="layui-tab layui-tab-card">
        <ul class="layui-tab-title">
            <li class="layui-this">项目管理列表</li>
        </ul>
        <div class="layui-tab-content">
            <blockquote class="layui-elem-quote">
                <div style="height: 34px;">
                    <form id="searchForm" method="post" action="list.ht">
                        <div class="fl">
                            <input type="text" name="Q_name_SL" id="Q_name_SL"class="form-control"
                                   value="${param['Q_name_SL']}" placeholder="项目名称"/>
                        </div>
                        <div class="fr">
                            <a class="layui-btn layui-btn-small layui-btn-normal" href="list.ht?name=" id="Search"><i class="layui-icon">
                                &#xe615;</i> 查询</a>
                            <a class="layui-btn layui-btn-small" href="#" id="create" data-toggle="modal"
                               data-remote="create.ht"
                               data-target="#myCreate"><i class="layui-icon">&#xe61f;</i> 创建</a>
                            <a class="layui-btn layui-btn-small layui-btn-primary" onclick="location.reload()"><i
                                    class="layui-icon">
                                &#xe63d;</i> 刷新</a>
                        </div>
                    </form>
                </div>
            </blockquote>
            <display:table name="projectList" id="projectList" requestURI="list.ht" sort="external" cellpadding="0"
                           cellspacing="0" export="false" class="layui-table" pagesize="10">
                <display:column property="ddProjectName" title="项目名称" sortable="false" sortName="DD_PROJECT_NAME"
                                maxLength="80"></display:column>
                <display:column title="项目阶段" media="html" style="width:20%">
                    <c:choose><c:when test="${projectList.ddProjectPhaseId==-1}">
                        <i style="font-size: 14px; color: #1E9FFF;">未启动</i>
                    </c:when>
                        <c:when test="${projectList.ddProjectPhaseId==0}">
                            <i style="font-size: 14px; color: #5FB878;">已启动</i>
                        </c:when>
                        <c:otherwise>
                            <i style="font-size: 14px; color: #F7B824;">已完成</i>
                        </c:otherwise></c:choose>
                </display:column>
                <display:column title="操作" media="html" style="width:25%">
                    <c:choose>
                        <c:when test="${projectList.ddProjectPhaseId==-1}">
                            <a class="layui-btn layui-btn-mini" id="setup" href="#" data-toggle="modal"
                               data-remote="setup.ht?id=${projectList.ddProjectId}"
                               data-target="#myModal"><i
                                    class="layui-icon">
                                &#xe614;</i> 项目设置
                            </a>
                        </c:when>
                        <c:when test="${projectList.ddProjectPhaseId==1}">
                            <a class="layui-btn layui-btn-mini" id="setup" href="#" data-toggle="modal"
                               data-remote="setup.ht?id=${projectList.ddProjectId}"
                               data-target="#myModal"><i
                                    class="layui-icon">
                                &#xe614;</i> 项目设置
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a class="layui-btn layui-btn-mini layui-btn-disabled" id="setup" href="#"
                               data-toggle="modal"
                               data-remote="setup.ht?id=${projectList.ddProjectId}"
                               data-target="#myModal"><i
                                    class="layui-icon">
                                &#xe614;</i> 项目设置
                            </a>
                        </c:otherwise></c:choose>
                    <a href="stepinto.ht?id=${projectList.ddProjectId}"
                       class="layui-btn layui-btn-mini"><i class="layui-icon">&#xe642;</i> 进入</a>
                    <a class="layui-btn layui-btn-mini layui-btn-warm" target="_blank"
                       href="${ctx}/datadriver/designflow/flowframe.ht?id=${projectList.ddProjectId}"><i
                            class="layui-icon">
                        &#xe641;</i> 流程</a>
                </display:column>
            </display:table>
        </div>
    </div>
    <%--项目创建--%>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
            </div>
        </div>
    </div>
    <%--项目设置--%>
    <div class="modal fade" id="myCreate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
            </div>
        </div>
    </div>
</div>
</body>

<script>
    $(document).ready(function () {
        $("#myCreate").on("hidden.bs.modal", function () {
            $(this).removeData("bs.modal");
        });
        $("#myModal").on("hidden.bs.modal", function () {
            $(this).removeData("bs.modal");
        });
    })
</script>
</html>


