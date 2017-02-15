<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ include file="/commons/cloud/global.jsp" %>
<%--<style>--%>
    <%--.bs-docs-sidenav {--%>
        <%--max-width: 228px;--%>
        <%--margin: 30px 0 0;--%>
        <%--padding: 0;--%>
        <%--background-color: #fff;--%>
        <%---webkit-border-radius: 6px;--%>
        <%---moz-border-radius: 6px;--%>
        <%--border-radius: 6px;--%>
        <%---webkit-box-shadow: 0 1px 4px rgba(0,0,0,.065);--%>
        <%---moz-box-shadow: 0 1px 4px rgba(0,0,0,.065);--%>
        <%--box-shadow: 0 1px 4px rgba(0,0,0,.065);--%>
    <%--}--%>
<%--</style>--%>
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