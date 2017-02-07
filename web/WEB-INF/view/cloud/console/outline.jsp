<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ include file="/commons/cloud/global.jsp" %>
<style>
    #cbp-spmenu-s1 {
        left: 15px !important;
    }
    .cbp-spmenu {
        background: #47a3da;
        position: fixed;
    }
    .cbp-spmenu-vertical {
        width: 240px !important;
        height: 100% !important;
        z-index: 1000 !important;
    }
    nav {
        display: block;
    }
    .cbp-spmenu-vertical a {
        border-bottom: 1px solid #258ecd;
        padding: 1em;
    }
    .cbp-spmenu a {
        display: block;
        color: #fff;
        font-size: 1.1em;
        font-weight: 300;
    }
    a {
        background-color: transparent;
    }
    li {
        list-style: none;
    }
</style>
<nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left" id="cbp-spmenu-s1">
    <c:forEach items="${leftResourcesList}" var="leftResourcesItem">
        <ul role="tablist">
            <li>
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
</nav>