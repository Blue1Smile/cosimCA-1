<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>


<!--主导航菜单 开始-->
<div class="layui-header header">
    <div class="layui-main" style="margin: 0;padding: 0;">
        <ul class="layui-nav">
            <li class="layui-nav-item">
                <a style="width: 200px;" href="#"></a>
            </li>
            <c:forEach items="${resourcesList}" var="resourcesItem">
                <c:if test="${resourcesItem.parentId==0}">
                    <li class="layui-nav-item">
                        <c:choose>
                        <c:when test="${empty resourcesItem.defaultUrl}">
                        <a href="${ctx}/cloud/console/outline.ht?resId=${resourcesItem.resId}">
                            </c:when>
                            <c:otherwise>
                            <c:choose>
                            <c:when test="${fn:indexOf(resourcesItem.defaultUrl,'?')!=-1}">
                            <a href="${ctx}${resourcesItem.defaultUrl}&resId=${resourcesItem.resId}">
                                </c:when>
                                <c:otherwise>
                                <a href="${ctx}${resourcesItem.defaultUrl}?resId=${resourcesItem.resId}">
                                    </c:otherwise>
                                    </c:choose>
                                    </c:otherwise>
                                    </c:choose>
                                        ${resourcesItem.resName}</a></li>
                </c:if>
            </c:forEach>
        </ul>
    </div>
</div>
<script src="${ctx}/skins/slides.min.jquery.js" type="text/javascript"></script>

<!-- 主导航菜单 结束 -->