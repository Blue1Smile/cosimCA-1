<%--
  Created by IntelliJ IDEA.
  User: d
  Date: 2017/4/13
  Time: 上午9:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>上传私有模型文件</title>
</head>
<body>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title" id="myModalLabel">文件和模型上传</h4>
</div>
<form class="form-horizontal" name="excelImportForm" action="" id="uploadForm"
      method="post" enctype="multipart/form-data">
    <div class="modal-body">
        <div class="form-group">
            <div class="col-lg-12 col-lg-offset-2">
                <input class="btn btn-default" id="excel_file" type="file" name="filename"
                       accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel"/>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <input class="btn btn-primary" id="upload_button" type="submit" value="开始上传"/>
    </div>
</form>
</body>
</html>
