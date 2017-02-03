<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@page import="com.hotent.core.util.ContextUtil" %>
<html>
<head>
    <title>任务数据中心</title>
    <%@include file="/commons/include/form.jsp" %>
    <%@include file="/newtable/tablecontext.jsp" %>
    <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
</head>
<%
    request.setCharacterEncoding("UTF-8");
    String major=new String(request.getParameter("major").getBytes("ISO-8859-1"),"utf-8");
    out.print("name:"+major);
%>
<body>
<div id="toolbar" class="btn-group">
    <button id="btn_add" type="button" class="btn btn-success" >
        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
    </button>
    <button id="btn_edit" type="button" class="btn btn-default">
        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
    </button>
    <button id="btn_delete" type="button" class="btn btn-danger">
        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
    </button>
</div>
<table id="tb_departments" data-url="showtools.ht?major=<%=new String(request.getParameter("major").getBytes("ISO-8859-1"),"UtF-8")%>&son=1&">
</table>

<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
<script src="${ctx}/newtable/showtool.js"></script>
</body>
<script charset=UTF-8>
    $('#btn_add').on('click', function () {
        layer.open({
            type: 2,
            title: "上传工具", //不显示标题栏
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