<%--
  Created by IntelliJ IDEA.
  User: d
  Date: 2017/3/5
  Time: 下午7:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="ap" uri="/appleTag" %>
<html>
<head>
    <title>数据看板</title>
    <script type="text/javascript" src="${ctx}/jqwidgets/jqx-all.js"></script>
    <script type="text/javascript" src="${ctx}/jqwidgets/table/inputable.js"></script>
    <style>
        table {
            background-color: #ffffff;
            width: 100% !important;
        }

        .panel {
            padding-top: 0px !important;
        }

        .panel-body {
            padding: 5px !important;
            border-radius: 0px !important;
        }
    </style>
</head>
<body>
<div class="row paneldocker" style="height: 100%">
    <div class="col-xs-6" style="height: 100%">
        <div class="panel panel-default task-panel">
            <div class="panel-body panelheight" id="createpanel">
                <div id="treeGridOut"></div>
            </div>
        </div>
    </div>
</div>
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
    //设置table高度
    function getHeight() {
        return $(window).height() - $('.panel-heading').outerHeight(true) - 80;
    }

    window.operateEvents = {
        'click #privatetr': function (e, value, row, index) {
            $.get("${ctx}/datadriver/personaltask/createtopublish.ht?id=" + row.ddStructId + "&parent=publishpanel", function (data, status) {
                if (status == 'success') {
                    $table_private.bootstrapTable('refresh')
                    $table_publish.bootstrapTable('refresh')
                }
            });
        },
        'click #publishtr': function (e, value, row, index) {
            $.get("${ctx}/datadriver/personaltask/createtopublish.ht?id=" + row.ddStructId + "&parent=createpanel" + "&taskId=" +${taskId}, function (data, status) {
                if (status == 'success') {
                    $table_publish.bootstrapTable('refresh')
                    $table_private.bootstrapTable('refresh')
                }
            });
        },
        'click #privatetr_del': function (e, value, row, index) {
            $.get("${ctx}/datadriver/data/del.ht?id=" + row.ddStructId, function (data, status) {
                if (status == 'success') {
                    $table_publish.bootstrapTable('refresh')
                    $table_private.bootstrapTable('refresh')
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
        initTable();
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
