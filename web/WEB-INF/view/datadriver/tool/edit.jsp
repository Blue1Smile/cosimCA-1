<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <script type="text/javascript" src="../js/jquery-1.7.2.js" charset="UTF-8"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>上传工具</title>
    <%@include file="/commons/include/form.jsp" %>
    <%@include file="/newtable/tablecontext.jsp" %>
</head>
<body>
<%--<%--%>
    <%--request.setCharacterEncoding("UTF-8");--%>
    <%--String major=new String(request.getParameter("major").getBytes("ISO-8859-1"),"utf-8");--%>
    <%--out.print("name:"+major);--%>
<%--%>--%>

<div class="container-fluid" >
    <form name="userForm2" action="save.ht?major=<%=new String(request.getParameter("major").getBytes("ISO-8859-1"),"UtF-8")%>" enctype="multipart/form-data" method="post">
        <div>
            <th width="20%">工具名称:</th>
            <td><input type="text"  id="ddToolName" name="ddToolName"
                       value="" class="form-control"/></td>
        </div>
        <div>
            <th width="20%">工具版本:</th>
            <td><input type="text"  id="ddToolVersion" name="ddToolVersion"
                       value="" class="form-control"/></td>
        </div>
        <div>
            <th width="20%">工具说明:</th>
        <textarea class="form-control" rows="4" id="ddToolBf" name="ddToolBf"></textarea>
        </div>
        <div id="newUpload2">
            <th width="20%">上传工具:</th>
            <input type="file" name="file" value="上传" >
        </div>
        <input type="submit" value="上传" class="btn btn-success" >
    </form>
</div>
</body>
</html>