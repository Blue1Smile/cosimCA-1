<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!--主导航菜单 开始-->
<ul class="layui-nav" id="wizardnav">
    <li class="layui-nav-item"><a href="${ctx}/cloud/console/home.ht">主页</a></li>
    <c:forEach items="${resourcesList}" var="resourcesItem">
        <c:if test="${resourcesItem.parentId==0}">
            <li class="layui-nav-item">
                <c:choose>
                    <c:when test="${empty resourcesItem.defaultUrl}">
                        <a href="${ctx}/cloud/console/outline.ht?resId=${resourcesItem.resId}">${resourcesItem.resName}</a>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${fn:indexOf(resourcesItem.defaultUrl,'?')!=-1}">
                                <a href="${ctx}${resourcesItem.defaultUrl}&resId=${resourcesItem.resId}">${resourcesItem.resName}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${ctx}${resourcesItem.defaultUrl}?resId=${resourcesItem.resId}">${resourcesItem.resName}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </li>
        </c:if>
    </c:forEach>
    <li class="layui-nav-item" style="float: right">
        <c:if test="${not empty SPRING_SECURITY_LAST_USERNAME}"><a id="username" href="javascript:void(0)"><span class="glyphicon glyphicon-user"></span> <sec:authentication
                property="principal.fullname"/></a></c:if>
        <dl class="layui-nav-child">
            <dd><a href="${ctx}/loginCloud.ht"><span class="glyphicon glyphicon-log-out"></span> 注销</a></dd>
            <dd><a href="javascript:void(0)"><span class="glyphicon glyphicon-info-sign"></span> 帮助</a></dd>
        </dl>
    </li>
    <li class="layui-nav-item" style="float: right">
        <a href="javascript:void(0)" title="暂不可用"><span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span> 消息 <span class="badge">42</span></a>
    </li>
</ul>

<!-- 主导航菜单 结束 -->