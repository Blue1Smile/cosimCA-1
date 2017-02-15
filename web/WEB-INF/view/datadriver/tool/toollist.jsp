<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/12/16
  Time: 20:43
  To change this template use File | Settings | File Templates.
--%>
<%--
	time:2013-04-11 11:48:44
	desc:edit the 业务定义，如邀标采购这样的大业务。
--%>
<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@page import="com.hotent.core.util.ContextUtil" %>
<html>
<head>
    <title>工具信息</title>
    <%@include file="/commons/include/form.jsp" %>
    <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>

    <style>
        #iframe_tab {
            margin-top: 0px;
        }
         .fl {
             float: left;
         }

        .fr {
            float: right;
        }
        .pages{
            float: right;
        }
        .page_line{
            display:inline;
        }
    </style>
</head>
<body>

<div class="layui-tab layui-tab-card" id="iframe_tab">
    <ul class="layui-tab-title">
        <li class="layui-this" id="init">工具列表</li>
    </ul>
    <div class="layui-tab-content" style="height: 100%;">
        <!--任务发布数据-->
        <blockquote class="layui-elem-quote">
            <div style="height: 40px;">
                <%--<span class="fl">--%>
                    <%--<form id="searchForm" method="post" action="list.ht">--%>
                            <%--<input type="text" name="ddDataName" class="layui-input"--%>
                                   <%--value="${param['ddDataName']}" placeholder="数据名称"/>--%>
                    <%--</form>--%>
                <%--</span>--%>
                    <%--<%--%>
                        <%--request.setCharacterEncoding("UTF-8");--%>
                        <%--String major=new String(request.getParameter("major").getBytes("ISO-8859-1"),"utf-8");--%>
                        <%--out.print("name:"+major);--%>
                    <%--%>--%>
                <span class="fr">
                    <a class="layui-btn layui-btn-normal "  id="Add"><i class="layui-icon">&#xe615;</i> 增加</a>
                    <a class="layui-btn layui-btn-normal" id="Search"><input name="file1" lay-type="file" class="layui-upload-file" type="file"> 查询</a>
                    <a class="layui-btn layui-btn-primary" onclick="location.reload()"><i class="layui-icon">&#x1002;</i> 刷新</a>
                </span>
            </div>
        </blockquote>
        <div class="layui-tab-item">
            <c:set var="checkAll">
                <input type="checkbox" id="chkall"/>
            </c:set>
            <display:table name="ToolList" id="ToolItem" requestURI="toollist.ht"
                           sort="external" cellpadding="1"
                           cellspacing="1" export="false" class="layui-table" pagesize="10">
                <display:column title="${checkAll}" media="html" style="width:5%;">
                    <input type="checkbox" class="pk" name="id" value="${toolitem.ddToolId}">
                </display:column>
                <display:column property="ddToolName" title="工具名称" sortable="true" maxLength="80"></display:column>
                <display:column property="ddToolUrl" title="工具地址" sortable="true" maxLength="80"></display:column>
                <display:column property="ddToolMajor" title="工具专业" sortable="true" maxLength="80"></display:column>
                <display:column property="ddToolStutus" title="工具状态" sortable="true" maxLength="80"></display:column>
                <display:column property="ddToolVersion" title="工具版本" sortable="true" maxLength="80"></display:column>
                <display:column property="ddToolUser" title="上传者" sortable="true" maxLength="80"></display:column>
                <display:column property="ddToolData" title="上传日期" sortable="true" maxLength="80"></display:column>
                <display:column title="操作" media="html" style="width:100px">
                </display:column>
            </display:table>
        </div>
    </div>
</div>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
<script>
    $('#init').trigger('click');
</script>
</body>
</html>

