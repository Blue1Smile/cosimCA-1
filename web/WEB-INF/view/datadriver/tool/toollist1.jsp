<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html lang="zh-CN">
<head>
    <title>任务数据中心</title>
    <%--<%@include file="/commons/include/form.jsp" %>--%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <link rel="stylesheet" href="${ctx}/newtable/bootstrap.css">
    <link rel="stylesheet" href="${ctx}/newtable/bootstrap-table.css">
    <link rel="stylesheet" href="${ctx}/newtable/bootstrap-editable.css">

    <script src="${ctx}/newtable/jquery.js"></script>
    <script src="${ctx}/newtable/bootstrap.js"></script>
    <script src="${ctx}/newtable/bootstrap-table.js"></script>
    <script src="${ctx}/newtable/bootstrap-table-zh-CN.js"></script>
    <script src="${ctx}/newtable/tableExport.js"></script>
    <script src="${ctx}/newtable/bootstrap-editable.js"></script>
    <script src="${ctx}/newtable/bootstrap-table-editable.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div id="toolbar" class="btn-group">
    <button id="btn_add" type="button" class="btn btn-success">
        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
    </button>
</div>
<%--<%--%>
    <%--request.setCharacterEncoding("UTF-8");--%>
<%--String major=new String(request.getParameter("major").getBytes("ISO-8859-1"),"utf-8");--%>
<%--out.print("name:"+major);--%>
<%--%>--%>
<table id="tb_departments"
       data-url="showtools.ht?major=<%=new String(request.getParameter("major").getBytes("ISO-8859-1"),"UTF-8")%>&son=1">
</table>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
<script src="${ctx}/newtable/showtool.js"></script>
</body>
<script charset=UTF-8>
    $('#btn_add').on('click', function () {
        var index = layer.open({
            type: 2,
            title: "工具上传", //不显示标题栏
            shadeClose: true,
            shade: 0.2,
            area: ['80%', '80%'],
            id: 'layer_taskinfo', //设定一个id，防止重复弹出
            moveType: 1,//拖拽模式，0或者1
            content: 'edit.ht?major=<%=new String(request.getParameter("major").getBytes("ISO-8859-1"),"UTF-8")%>'
        });
    });

</script>
</html>