<%--
  Created by IntelliJ IDEA.
  User: d
  Date: 2017/3/5
  Time: 下午7:57
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="ap" uri="/appleTag" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html lang="zh-CN">
<head>
    <title>数据看板</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>
    <script type="text/javascript" src="${ctx}/jqwidgets/table/outputable.js"></script>
    <%--<script type="text/javascript" src="${ctx}/jqwidgets/scripts/demos.js"></script>--%>
</head>
<body>
<div class="col-xs-12">
    <div class="pull-right">
        <input type="button" value="导出Excel" id='excelExport'/>
        <input type="button" value="导出XML" id='xmlExport'/>
        <input type="button" value="导出CSV" id='csvExport'/>
        <input type="button" value="导出JSON" id='jsonExport'/>
        <input type="button" value="导出PDF" id='pdfExport'/>
    </div>
</div>
<%--<br>--%>
<div id="treeGridOut" style="width: 100%"></div>
<%--<div class="row">--%>
    <%--<div class="pull-right">--%>
        <%--<input type="button" value="导出Excel" id='excelExport'/>--%>
        <%--<input type="button" value="导出XML" id='xmlExport'/>--%>
        <%--<input type="button" value="导出CSV" id='csvExport'/>--%>
        <%--<input type="button" value="导出JSON" id='jsonExport'/>--%>
        <%--<input type="button" value="导出PDF" id='pdfExport'/>--%>
    <%--</div>--%>
<%--</div>--%>
<br>
<%--导入数据--%>
<div class="modal fade" id="importData" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

        </div>
    </div>
</div>
<%--上传私有数据文件或模型--%>
<div class="modal fade" id="uploadPrivateFile" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

        </div>
    </div>
</div>
</body>

<script type="text/javascript">
    //@ sourceURL=showdata.ht

    <%--window.operateEvents = {--%>
        <%--'click #privatetr': function (e, value, row, index) {--%>
            <%--$.get("${ctx}/datadriver/personaltask/createtopublish.ht?id=" + row.ddStructId + "&parent=publishpanel", function (data, status) {--%>
                <%--if (status == 'success') {--%>
                <%--}--%>
            <%--});--%>
        <%--},--%>
        <%--'click #publishtr': function (e, value, row, index) {--%>
            <%--$.get("${ctx}/datadriver/personaltask/createtopublish.ht?id=" + row.ddStructId + "&parent=createpanel" + "&taskId=" +${taskId}, function (data, status) {--%>
                <%--if (status == 'success') {--%>
                <%--}--%>
            <%--});--%>
        <%--},--%>
        <%--'click #privatetr_del': function (e, value, row, index) {--%>
            <%--$.get("${ctx}/datadriver/data/del.ht?id=" + row.ddStructId, function (data, status) {--%>
                <%--if (status == 'success') {--%>
                <%--}--%>
            <%--});--%>
        <%--},--%>
        <%--'click #privatetr_file': function (e, value, row, index) {--%>
            <%--$('#uploadPrivateFile').modal({--%>
                <%--keyboard: true,--%>
                <%--remote: "${ctx}/datadriver/privatedata/uploadPrivateFile.ht?id=" + row.ddDataId--%>
            <%--})--%>
        <%--}--%>
    <%--};--%>
    $(function () {
        outputTableInit("${ctx}/datadriver/privatedata/outputData.ht?taskId=${taskId}");
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
