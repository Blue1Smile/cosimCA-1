<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/commons/cloud/global.jsp" %>
<%@taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><decorator:title default="工作台"/>协同设计</title>
    <%@include file="/commons/cloud/meta.jsp" %>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">

        $(document).ready(function () {
            $(".sontable").show();
            $(".parenttable").toggle(function () {
                var index = $(".parenttable").index($(this)[0]);
                $(".sontable:eq(" + index + ")").slideUp();
            }, function () {
                var index = $(".parenttable").index($(this)[0]);
                $(".sontable:eq(" + index + ")").slideDown();
            });
            //增加导航栏选中效果
            $("li").each(function(index){
                $(this).click(function(){
                    $("li").removeClass("layui-this");
                    $("li").eq(index).addClass("layui-this");
                });
            });
        });

    </script>
</head>
<body>

<div id="head">
    <div id="top_info">
    <span>
    <a href="${ctx}/cloud/console/home.ht" class="link01">个人主页</a>
    </span>
        <c:if test="${not empty SPRING_SECURITY_LAST_USERNAME}">欢迎您，<a id="username" href="#"><sec:authentication
                property="principal.fullname"/></a>，<a href="${ctx}/loginCloud.ht" class="link01">注销</a></c:if>
        <c:if test="${empty SPRING_SECURITY_LAST_USERNAME}">请<a href="${ctx}/loginCloud.ht" class="link01">登录</a> │
            <a
                    href="${ctx}/reg.ht" class="link01">注册</a></c:if>
    </div>
    <div id="logo_zone">
        <%--<div id="logo_zone_left"><a href="#"><img src="${ctx}/testimg/logo6.jpg"/> </a></div>--%>
        <svg width="500" height="100">
            <text x="20" y="45" fill="orange" font-weight="500" font-size="50" font-family="Impact"> Cosim</text>
            <text x="155" y="40" fill="#369" font-weight="900" font-size="45" font-family="SimHei">协同设计平台 </text>
        </svg>
    </div>
</div>

<div class="layui-layout-admin">

    <%@include file="/commons/cloud/top_console.jsp" %>
    <decorator:body/>
    <div class="layui-body">

        <iframe src="main.ht" frameborder="0" scrolling="no" id="mainframe"
                style="width:100%;min-height:800px;"></iframe>
    </div>

    <%@include file="/commons/cloud/foot.jsp" %>
</div>
</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</html>
