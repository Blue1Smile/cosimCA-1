<%--
  Created by IntelliJ IDEA.
  User: d
  Date: 2017/3/5
  Time: 下午7:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>数据看板</title>
    <script type="text/javascript" src="${ctx}/styles/layui/jquery.dragsort-0.5.2.min.js"></script>
</head>
<body>
<div class="row paneldocker" style="height: 100%">
    <div class="col-xs-3" style="height: 100%">
        <div class="panel panel-default task-panel">
            <div class="panel-heading">
                私有数据
            </div>
            <div class="panel-body panelheight" style="overflow-y:auto; overflow-x: hidden">
                <ul id="createpanel" class="scrum-stage-tasks">
                    <c:forEach var="privateDataListbyTaskItem" items="${privateDataListbyTask}">
                        <li class="task task-card ui-sortable-handle " id="showRightPush"
                            onclick="showDataContent(${privateDataListbyTaskItem.ddDataId})">
                                <%--<div class="checkbox checkbox-primary">--%>
                                <%--<input id="checkbox1" type="checkbox">--%>
                                <%--<label for="checkbox1">--%>
                                <%--${privateDataListbyTaskItem.ddDataName}--%>
                                <%--</label>--%>
                                <%--</div>--%>
                                <%--<label class="pull-right taskname">${privateDataListbyTaskItem.ddDataTaskName}</label>--%>
                            <strong class="col-xs-6 overflow-card">${privateDataListbyTaskItem.ddDataName}</strong>
                            <em class="col-xs-6 overflow-card">${privateDataListbyTaskItem.ddDataTaskName}</em>
                            <input type="hidden" value="${privateDataListbyTaskItem.ddDataId}"
                                   name="release"/>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
    <div class="col-xs-3" style="height: 100%">
        <div class="panel panel-info task-panel">
            <div class="panel-heading">
                发布数据
            </div>
            <div class="panel-body panelheight" style="overflow-y:auto; overflow-x: hidden">
                <ul id="publishpanel" class="scrum-stage-tasks">
                    <c:forEach var="publishDataListItem" items="${publishDataList}">
                        <li class="task task-card ui-sortable-handle" id="showRightPush"
                            onclick="showDataContent(${publishDataListItem.ddDataId})">
                                <%--<div class="checkbox checkbox-primary">--%>
                                <%--<input id="checkbox2" type="checkbox">--%>
                                <%--<label for="checkbox2">--%>
                                <%--${publishDataListItem.ddDataName}--%>
                                <%--</label>--%>
                                <%--</div>--%>
                                <%--<label class="pull-right taskname">${publishDataListItem.ddDataTaskName}</label>--%>
                            <strong class="col-xs-6 overflow-card">${publishDataListItem.ddDataName}</strong>
                            <em class="col-xs-6 overflow-card">${publishDataListItem.ddDataTaskName}</em>
                            <input type="hidden" value="${publishDataListItem.ddDataId}"
                                   name="release"/>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
    <div class="col-xs-3" style="height: 100%">
        <div class="panel panel-success task-panel">
            <div class="panel-heading">
                可订阅
            </div>
            <div class="panel-body panelheight" style="overflow-y:auto; overflow-x: hidden">
                <ul id="canorderpanel" class="scrum-stage-tasks">
                    <c:forEach var="canBeOrderPrivatedataListItem" items="${canBeOrderPrivatedataList}">
                        <li class="task task-card ui-sortable-handle " id="showRightPush"
                            onclick="showDataContent(${canBeOrderPrivatedataListItem.ddDataId})">
                                <%--<div class="checkbox">--%>
                                <%--<input id="checkbox3" type="checkbox">--%>
                                <%--<label for="checkbox3">--%>
                                <%--${canBeOrderPrivatedataListItem.ddDataName}--%>
                                <%--</label>--%>
                                <%--</div>--%>
                                <%--<label class="pull-right taskname">${canBeOrderPrivatedataListItem.ddDataTaskName}</label>--%>
                            <strong class="col-xs-6 overflow-card">${canBeOrderPrivatedataListItem.ddDataName}</strong>
                            <em class="col-xs-6 overflow-card">${canBeOrderPrivatedataListItem.ddDataTaskName}</em>
                            <input type="hidden" value="${canBeOrderPrivatedataListItem.ddDataId}"
                                   name="release"/>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
    <div class="col-xs-3" style="height: 100%">
        <div class="panel panel-warning task-panel">
            <div class="panel-heading">
                已订阅
            </div>
            <div class="panel-body panelheight" style="overflow-y:auto; overflow-x: hidden">
                <ul id="orderpanel" class="scrum-stage-tasks">
                    <c:forEach var="OrderPrivatedataListItem" items="${OrderPrivatedataList}">
                        <li class="task task-card ui-sortable-handle" id="showRightPush"
                            onclick="showDataContent(${OrderPrivatedataListItem.ddDataId})">
                                <%--<div class="checkbox">--%>
                                <%--<input id="checkbox4" type="checkbox">--%>
                                <%--<label for="checkbox4">--%>
                                <%--${OrderPrivatedataListItem.ddDataName}--%>
                                <%--</label>--%>
                                <%--</div>--%>
                                <%--<label class="pull-right taskname">${OrderPrivatedataListItem.ddDataTaskName}</label>--%>
                            <strong class="col-xs-6 overflow-card">${OrderPrivatedataListItem.ddDataName}</strong>
                            <em class="col-xs-6 overflow-card">${OrderPrivatedataListItem.ddDataTaskName}</em>
                            <input type="hidden" value="${OrderPrivatedataListItem.ddDataId}"
                                   name="release"/>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
//@ sourceURL=showdata.ht
<script type="text/javascript">
    $(document).ready(function () {
//        $.MyCommon.PageLoading({sleep: 500});
        $("#createpanel,#publishpanel").dragsort({
            itemSelector: "li",
            dragSelector: "li",
            dragBetween: true,
            dragEnd: saveOrder,
            placeHolderTemplate: '<li class="task task-card ui-sortable-handle dropdown-color"></li>'
        });
        $("#canorderpanel,#orderpanel").dragsort({
            itemSelector: "li",
            dragSelector: "li",
            dragBetween: true,
            dragEnd: saveOrder2,
            placeHolderTemplate: '<li class="task task-card ui-sortable-handle dropdown-color"></li>'
        });
        function saveOrder() {
            var data = $(this).children('input').val();
            var parentid = $(this).parent().attr("id");
            $.get("createtopublish.ht?id=" + data + "&parent=" + parentid);
        }

        function saveOrder2() {
            var data = $(this).children('input').val();
            var parentid = $(this).parent().attr("id");
            $.get("canordertoorder.ht?id=" + data + "&parent=" + parentid + "&taskId=" +${TaskInfo.ddTaskId});
        }
    });
</script>
</html>
