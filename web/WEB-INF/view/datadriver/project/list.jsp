<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="hotent" uri="http://www.jee-soft.cn/paging" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
    <title>项目基础信息列表</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
    <%--<%@include file="/commons/include/get.jsp" %>--%>
    <script src="${ctx}/newtable/jquery.js"></script>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <style>
        .fl {
            float: left;
        }

        .fr {
            float: right;
        }
    </style>

</head>

<body>

<div class="layui-tab layui-tab-card">
    <ul class="layui-tab-title">
        <li class="layui-this">项目管理列表</li>
    </ul>
    <div class="layui-tab-content">
        <%--<div class="list-group">--%>
        <%--<c:forEach var="projectItem" items="${projectList}">--%>
        <%--<a href="#" class="list-group-item">${projectItem.ddProjectName}</a>--%>
        <%--</c:forEach>--%>
        <%--</div>--%>
        <blockquote class="layui-elem-quote">
            <div style="height: 40px;">
                <form id="searchForm" method="post" action="list.ht">
                    <div class="fl">
                        <%--<span class="label">项目编号:</span><input type="text" name="Q_id_SL" class="inputText"--%>
                        <%--value="${param['Q_id_SL']}"/>--%>
                        <input type="text" name="Q_name_SL " class="layui-input"
                               value="${param['Q_name_SL']}" placeholder="项目名称"/>
                        <%--<span class="label">创建日期 从:</span> <input name="Q_createStartDate_SL" class="inputText date"--%>
                        <%--value="${param['Q_createStartDate_DL']}"/>--%>
                        <%--<span class="label">至: </span><input name="Q_createEndData_SL" class="inputText date"--%>
                        <%--value="${param['Q_createEndData_DL']}"/>--%>
                    </div>
                    <div class="fr">
                        <a class="layui-btn layui-btn-normal" id="Search"><i class="layui-icon">&#xe615;</i> 查询</a>
                        <a class="layui-btn" href="#" id="create" data-toggle="modal" data-remote="create.ht"
                           data-target="#myCreate"><i class="layui-icon">&#xe61f;</i> 创建</a>

                        <%--<a class="layui-btn layui-btn-danger" action="del.ht"><i--%>
                        <%--class="layui-icon">&#xe640;</i> 删除</a>--%>
                        <a class="layui-btn layui-btn-primary" onclick="location.reload()"><i class="layui-icon">
                            &#x1002;</i> 刷新</a>
                    </div>


                </form>
            </div>
        </blockquote>
        <%--<c:set var="checkAll">--%>
        <%--<input type="checkbox" id="chkall"/>--%>
        <%--</c:set>--%>
        <display:table name="projectList" id="projectList" requestURI="list.ht" sort="external" cellpadding="0"
                       cellspacing="0" export="false" class="table table-hover table-bordered" pagesize="10">
            <%--<display:column title="${checkAll}" media="html" style="width:3%;">--%>
            <%--<input type="checkbox" class="pk" name="id" value="${ProjectItem.ddProjectId}">--%>
            <%--</display:column>--%>
            <%--<display:column property="ddProjectId" title="项目编号" sortable="true" sortName="DD_PROJECT_ID"--%>
            <%--maxLength="80"></display:column>--%>
            <display:column property="ddProjectName" title="项目名称" sortable="true" sortName="DD_PROJECT_NAME"
                            maxLength="80"></display:column>
            <%--<display:column property="ddProjectResponsibleUnits" title="项目责任单位" maxLength="80"></display:column>--%>
            <%--<display:column property="ddProjectPhaseId" title="项目阶段"></display:column>--%>
            <%--<display:column property="ddProjectCreateDatatime" title="项目创建时间" sortable="true"--%>
            <%--sortName="DD_PROJECT_CREATE_DATATIME"></display:column>--%>
            <%--<display:column property="ddProjectDescription" title="项目基本描述" maxLength="80"></display:column>--%>
            <%--<display:column property="ddProjectOwnerSystemId" title="项目所属系统" maxLength="80"></display:column>--%>
            <%--<display:column property="ddProjectCreatorId" title="项目创建者id" maxLength="80"></display:column>--%>
            <%--<display:column property="ddProjectFixedPattern" title="项目是否固化"></display:column>--%>
            <%--<display:column property="ddProjectResponsiblePersonId" title="项目负责人id" sortable="true"--%>
            <%--sortName="DD_PROJECT_RSPONSIBLE_PERSON_ID"></display:column>--%>
            <%--<display:column property="ddProjectType" title="项目类型" maxLength="80"></display:column>--%>
            <%--<display:column property="ddProjectBelongModel" title="所属型号" maxLength="80"></display:column>--%>
            <%--<display:column property="ddProjectSecretLevel" title="项目密级" maxLength="80"></display:column>--%>
            <%--<display:column property="ddProjectChangePersonId" title="修改人id"></display:column>--%>
            <%--<display:column property="ddProjectPriority" title="优先级" sortable="true"></display:column>--%>
            <%--<display:column property="ddProjectRemark" title="备注" maxLength="80"></display:column>--%>
            <%--<display:column property="ddProjectState" title="状态" maxLength="80"></display:column>--%>
            <%--<display:column property="ddProjectPlanStartDate" title="计划开始日期" maxLength="80"></display:column>--%>
            <%--<display:column property="ddProjectCompleteDate" title="计划完成日期"></display:column>--%>
            <%--<display:column property="ddProjectActualStartDate" title="实际开始日期"></display:column>--%>
            <%--<display:column property="ddProjectActualCompleteData" title="实际结束日期" maxLength="80"></display:column>--%>
            <%--<display:column property="ddProjectCurrentStage" title="当前项目进度"></display:column>--%>
            <%--<display:column property="ddProjectScheduleState" title="项目研制阶段"></display:column>--%>
            <display:column title="项目阶段" media="html" style="width:40%">
                <c:choose><c:when test="${projectList.ddProjectPhaseId==-1}">
                    <a href=""
                       class="layui-btn layui-btn-mini"><i class="layui-icon">&#x1005;</i> 未启动</a>
                </c:when>
                    <c:when test="${projectList.ddProjectPhaseId==0}">
                        <a href=""
                           class="layui-btn layui-btn-mini"><i class="layui-icon">&#x1005;</i> 启动</a>
                    </c:when>
                    <c:otherwise>
                        <a href=""
                           class="layui-btn layui-btn-mini"><i class="layui-icon">&#x1005;</i> 完成</a>
                    </c:otherwise></c:choose>
            </display:column>
            <display:column title="操作" media="html" style="width:40%">
                <%--<c:choose><c:when test="${projectList.ddProjectState==1}">--%>
                    <%--&lt;%&ndash;<a href="edit.ht?id=${projectList.ddProjectId}" class="layui-btn layui-btn-disabled layui-btn-mini"><i&ndash;%&gt;--%>
                    <%--&lt;%&ndash;class="layui-icon" id="setup">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;&#xe614;</i> 项目设置</a>&ndash;%&gt;--%>
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
                            <a class="layui-btn layui-btn-mini layui-btn-disabled" id="setup" href="#" data-toggle="modal"
                               data-remote="setup.ht?id=${projectList.ddProjectId}"
                               data-target="#myModal"><i
                                    class="layui-icon">
                                &#xe614;</i> 项目设置
                            </a>
                        </c:otherwise></c:choose>

                    <%--<a href="start.ht?id=${projectList.ddProjectId}"--%>
                       <%--class="layui-btn layui-btn-disabled layui-btn-mini"><i class="layui-icon">&#x1005;</i> 项目启动</a>--%>
                    <a href="stepinto.ht?id=${projectList.ddProjectId}"
                       class="layui-btn layui-btn-mini"><i class="layui-icon">&#x1005;</i> 进入</a>
                    <%--<a href="get.ht?id=${ProjectItem.ddProjectId}"--%>
                    <%--class="layui-btn layui-btn-normal layui-btn-small">明细</a>--%>
                    <%--<a class="layui-btn layui-btn-mini layui-btn-normal"--%>
                    <%--href="${ctx}/datadriver/task/list.ht?id=${projectList.ddProjectId}"><i class="layui-icon">--%>
                    <%--&#xe62a;</i> 任务</a>--%>
                    <a class="layui-btn layui-btn-mini layui-btn-warm" target="_blank"
                       href="${ctx}/datadriver/designflow/flowframe.ht?id=${projectList.ddProjectId}"><i
                            class="layui-icon">
                        &#xe641;</i> 流程</a>
                    <%--<a class="layui-btn layui-btn-mini layui-btn-normal"--%>
                    <%--href="${ctx}/datadriver/index/indexedit.ht?id=${ProjectItem.ddProjectId}"><i class="layui-icon">--%>
                    <%--&#xe60a;</i> 指标</a>--%>
                    <%--<a href="del.ht?id=${projectList.ddProjectId}"--%>
                    <%--class="layui-btn layui-btn-disabled layui-btn-mini"><i class="layui-icon">&#xe640;</i> 删除</a>--%>
                <%--</c:when>--%>
                    <%--<c:otherwise>--%>
                        <%--<a href="edit.ht?id=${projectList.ddProjectId}" class="layui-btn layui-btn-mini"><i--%>
                        <%--class="layui-icon" id="setup">--%>
                        <%--&#xe614;</i> 项目设置</a>--%>
                        <%--<a class="layui-btn layui-btn-mini" id="setup" href="#" data-toggle="modal"--%>
                           <%--data-remote="setup.ht?id=${projectList.ddProjectId}"--%>
                           <%--data-target="#myModal"><i--%>
                                <%--class="layui-icon">--%>
                            <%--&#xe614;</i> 项目设置--%>
                        <%--</a>--%>
                        <%--<a href="start.ht?id=${projectList.ddProjectId}"--%>
                           <%--class="layui-btn layui-btn-primary layui-btn-mini"><i class="layui-icon">&#x1005;</i>--%>
                            <%--项目启动</a>--%>
                        <%--<a href="stepinto.ht?id=${projectList.ddProjectId}"--%>
                           <%--class="layui-btn layui-btn-mini"><i class="layui-icon">&#x1005;</i> 进入</a>--%>
                        <%--<a href="get.ht?id=${ProjectItem.ddProjectId}"--%>
                        <%--class="layui-btn layui-btn-normal layui-btn-small">明细</a>--%>
                        <%--<a class="layui-btn layui-btn-mini layui-btn-normal"--%>
                        <%--href="${ctx}/datadriver/task/list.ht?id=${projectList.ddProjectId}"><i class="layui-icon">--%>
                        <%--&#xe62a;</i> 任务</a>--%>
                        <%--<a class="layui-btn layui-btn-mini layui-btn-warm" target="_blank"--%>
                           <%--href="${ctx}/datadriver/designflow/flowframe.ht?id=${projectList.ddProjectId}"><i--%>
                                <%--class="layui-icon">--%>
                            <%--&#xe641;</i> 流程</a>--%>
                        <%--<a class="layui-btn layui-btn-mini layui-btn-normal"--%>
                        <%--href="${ctx}/datadriver/index/indexedit.ht?id=${projectList.ddProjectId}"><i--%>
                        <%--class="layui-icon">--%>
                        <%--&#xe60a;</i> 指标</a>--%>
                        <%--<a href="del.ht?id=${projectList.ddProjectId}"--%>
                        <%--class="layui-btn layui-btn-mini layui-btn-danger"><i class="layui-icon">&#xe640;</i> 删除</a>--%>
                    <%--</c:otherwise></c:choose>--%>
            </display:column>
        </display:table>
        <%--<hotent:paging tableId="ProjectItem"/>--%>
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
</body>
<%--<script src="${ctx}/js/jquery-3.1.1.min.js"></script>--%>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
<script src="${ctx}/newtable/bootstrap.js"></script>
</html>


