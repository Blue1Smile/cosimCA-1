<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ include file="/commons/cloud/global.jsp" %>
<body>


<c:forEach items="${leftResourcesList}" var="leftResourcesItem">

    <ul class="layui-nav layui-nav-tree layui-nav-side">
        <li class="layui-nav-item layui-nav-itemed">
            <c:choose>
                <c:when test="${fn:contains(leftResourcesItem.defaultUrl,'http')||fn:contains(leftResourcesItem.defaultUrl,'cosim')}">
                    <a class="realactive"
                       href="javascript:openFrame('${leftResourcesItem.defaultUrl}');">${leftResourcesItem.resName}</a>
                </c:when>
                <c:otherwise>
                    <a class="realactive"
                       href="javascript:openFrame('${ctx}${leftResourcesItem.defaultUrl}');">${leftResourcesItem.resName}</a>
                </c:otherwise>
            </c:choose>

        <dl class="layui-nav-child">
            <c:forEach items="${leftResourcesItem.children}" var="child">
                <dd class="layui-nav-item">
                    <c:choose>
                        <c:when test="${fn:contains(child.defaultUrl,'http')||fn:contains(child.defaultUrl,'cosim')}">
                            <a href="javascript:openFrame('${child.defaultUrl}');">${child.resName}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:openFrame('${ctx}${child.defaultUrl}');">${child.resName}</a>
                        </c:otherwise>
                    </c:choose>
                </dd>
            </c:forEach>
        </dl>
        </li>
    </ul>

</c:forEach>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>

</body>