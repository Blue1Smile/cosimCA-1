<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ include file="/commons/cloud/global.jsp" %>

    <c:forEach items="${leftResourcesList}" var="leftResourcesItem">
        <ul class="list-group">
            <li class="list-group-item">
                <c:choose>
                <c:when test="${fn:contains(leftResourcesItem.defaultUrl,'http')||fn:contains(leftResourcesItem.defaultUrl,'cosim')}">
                <a href="javascript:openFrame('${leftResourcesItem.defaultUrl}');">${leftResourcesItem.resName}</a>
                </c:when>
                <c:otherwise>
                <a href="javascript:openFrame('${ctx}${leftResourcesItem.defaultUrl}');">${leftResourcesItem.resName}</a>
                </c:otherwise>
                </c:choose>
                <c:forEach items="${leftResourcesItem.children}" var="child">
            <li class="list-group-item">
                <c:choose>
                    <c:when test="${fn:contains(child.defaultUrl,'http')||fn:contains(child.defaultUrl,'cosim')}">
                        <a href="javascript:openFrame('${child.defaultUrl}');">${child.resName}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:openFrame('${ctx}${child.defaultUrl}');">${child.resName}</a>
                    </c:otherwise>
                </c:choose>
            </li>
            </c:forEach>
            </li>
        </ul>
    </c:forEach>
<%--<ul class="layui-nav layui-nav-tree layui-nav-side" lay-filter="test">--%>
    <%--<!-- 侧边导航: <ul class="layui-nav layui-nav-tree layui-nav-side"> -->--%>
    <%--<li class="layui-nav-item layui-nav-itemed">--%>
        <%--<a href="javascript:;">默认展开</a>--%>
        <%--<dl class="layui-nav-child">--%>
            <%--<dd><a href="javascript:;">选项1</a></dd>--%>
            <%--<dd><a href="javascript:;">选项2</a></dd>--%>
            <%--<dd><a href="">跳转</a></dd>--%>
        <%--</dl>--%>
    <%--</li>--%>
    <%--<li class="layui-nav-item">--%>
        <%--<a href="javascript:;">解决方案</a>--%>
        <%--<dl class="layui-nav-child">--%>
            <%--<dd><a href="">移动模块</a></dd>--%>
            <%--<dd><a href="">后台模版</a></dd>--%>
            <%--<dd><a href="">电商平台</a></dd>--%>
        <%--</dl>--%>
    <%--</li>--%>
    <%--<li class="layui-nav-item"><a href="">产品</a></li>--%>
    <%--<li class="layui-nav-item"><a href="">大数据</a></li>--%>
<%--</ul>--%>