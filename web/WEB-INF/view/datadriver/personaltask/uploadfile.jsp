<%--
  Created by IntelliJ IDEA.
  User: d
  Date: 2017/3/2
  Time: 下午2:07
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="hotent" uri="http://www.jee-soft.cn/paging" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html lang="zh-CN">
<head>
    <title>文件和模型上传</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1"/>
    <%--<link rel="stylesheet" type="text/css" href="${ctx}/uploadfile/webuploader.css">--%>
    <%--<script type="text/javascript" src="${ctx}/uploadfile/webuploader.js"></script>--%>
</head>
<body>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
            class="sr-only">Close</span></button>
    <h4 class="modal-title" id="myModalLabel">模型和文件上传窗口</h4>
</div>
<div class="modal-body">
    <div class="container-fluid">
        <input type="file" name="file" value="上传">
    </div>
</div>
<div class="modal-footer">
    <input id="dataFormSave" value="上传" type="submit" class="btn btn-primary btn-block">
</div>
</body>
</html>
