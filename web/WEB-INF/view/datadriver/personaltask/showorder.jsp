<!DOCTYPE html>
<%@page language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="ap" uri="/appleTag" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html lang="zh-CN">
<head>
    <title>数据发布列表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>
    <script type="text/javascript" src="${ctx}/jqwidgets/table/inputable.js"></script>
</head>
<body>
<div id="treeGridIn"></div>
<%--模型预览--%>
<div class="modal fade" id="model_content" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

        </div>
    </div>
</div>

</body>
<script type="text/javascript">
    //@ sourceURL=showdata.ht

    window.operateEvents = {
        'click #privatetr': function (e, value, row, index) {
            $.get("${ctx}/datadriver/personaltask/createtopublish.ht?id=" + row.ddStructId + "&parent=publishpanel", function (data, status) {
                if (status == 'success') {
                }
            });
        },
        'click #publishtr': function (e, value, row, index) {
            $.get("${ctx}/datadriver/personaltask/createtopublish.ht?id=" + row.ddStructId + "&parent=createpanel" + "&taskId=" +${taskId}, function (data, status) {
                if (status == 'success') {
                }
            });
        },
        'click #privatetr_del': function (e, value, row, index) {
            $.get("${ctx}/datadriver/data/del.ht?id=" + row.ddStructId, function (data, status) {
                if (status == 'success') {
                }
            });
        },
        'click #privatetr_file': function (e, value, row, index) {
            $('#uploadPrivateFile').modal({
                keyboard: true,
                remote: "${ctx}/datadriver/privatedata/uploadPrivateFile.ht?id=" + row.ddDataId
            })
        }
    };
    $(function () {
        inputTableInit("${ctx}/datadriver/privatedata/inputData.ht?taskId=${taskId}&projectId=${projectId}");
    });
    //Excel批量导入
    function importPrivateData(taskId, projectId) {
        $('#importData').modal({
            keyboard: true,
            remote: "${ctx}/datadriver/privatedata/importPrivateData.ht?id=" + taskId + "&projectId=" + projectId
        });
    }
    //对话框关闭清除缓存
    $("#uploadPrivateFile").on("hidden.bs.modal", function () {
        $(this).removeData("bs.modal");
    });

</script>
</html>
