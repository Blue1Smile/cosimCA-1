<%--
  Created by IntelliJ IDEA.
  User: d
  Date: 2017/2/7
  Time: 上午10:33
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>统计</title>
</head>
<body>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
            class="sr-only">Close</span></button>
    <h4 class="modal-title" id="myModalLabel">项目统计</h4>
</div>
<div class="modal-body">
    <iframe src="${ctx}/datadriver/designflow/projectflow.ht?projectId=${projectId}&processFlowXml=${processFlowXml}" style="width: 100%;height: 500px" frameborder="no"></iframe>
</div>
</body>
</html>
