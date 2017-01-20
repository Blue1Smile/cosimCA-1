<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ include file="/commons/cloud/global.jsp" %>
<body>
<c:forEach items="${leftResourcesList}" var="leftResourcesItem">

    <ul class="nav nav-list bs-docs-sidenav affix" role="tablist">
        <li class="active">
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


            <c:forEach items="${leftResourcesItem.children}" var="child">
        <li>
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
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>

</body>