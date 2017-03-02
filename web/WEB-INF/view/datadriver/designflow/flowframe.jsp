<%--
  Created by IntelliJ IDEA.
  User: dodo
  Date: 2016/12/26
  Time: 下午10:23
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="hotent" uri="http://www.jee-soft.cn/paging" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%--<%@ include file="/commons/include/get.jsp" %>--%>
<html lang="zh-CN">
<head>
    <title>项目流程绘制</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <%--<link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>--%>
</head>
<body>
<%--<div class="layui-tab layui-tab-card">--%>
    <%--<ul class="layui-tab-title">--%>
        <%--<li class="layui-this">项目流程绘制</li>--%>
    <%--</ul>--%>
    <%--<div class="layui-tab-content" >--%>
        <iframe src="${ctx}/datadriver/designflow/projectflow.ht?flag=0&id=${projectId}&processFlowXml=${processFlowXml}"></iframe>
    <%--</div>--%>
<%--</div>--%>
</body>
<%--<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>--%>
</html>
