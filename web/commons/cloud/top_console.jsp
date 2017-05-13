<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!--主导航菜单 开始-->
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">协同设计平台</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="${ctx}/cloud/console/home.ht">主页</a></li>
                <c:forEach items="${resourcesList}" var="resourcesItem">
                    <c:if test="${resourcesItem.parentId==0}">
                        <li>
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
            </ul>
            <%--<form class="navbar-form navbar-right">--%>
                <%--<div class="form-group">--%>
                    <%--<input type="text" class="form-control" placeholder="Search">--%>
                <%--</div>--%>
                <%--<button type="submit" class="btn btn-default">搜索</button>--%>
            <%--</form>--%>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <c:if test="${not empty SPRING_SECURITY_LAST_USERNAME}"><a id="username"
                                                                               href="javascript:void(0)"
                                                                               class="dropdown-toggle"
                                                                               data-toggle="dropdown" role="button"
                                                                               aria-haspopup="true"
                                                                               aria-expanded="false">
                        <sec:authentication property="principal.fullname"/> <span class="caret"></span></a></c:if>
                    <ul class="dropdown-menu">
                        <li><a href="${ctx}/loginCloud.ht"><span class="glyphicon glyphicon-log-out"></span> 注销</a></li>
                        <li><a href="javascript:void(0)"><span class="glyphicon glyphicon-info-sign"></span> 帮助</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<!-- 主导航菜单 结束 -->