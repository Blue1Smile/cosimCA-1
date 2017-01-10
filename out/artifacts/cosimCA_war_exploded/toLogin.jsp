<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/commons/global.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/commons/meta.jsp"%>
<title>跳转到登录页面</title>
<script>
	$(function(){
		$('#dd').loading('正在跳转页面');
		window.top.location.href='${ctx}/login.jsp';
	})
</script>
</head>
<body>	
	<div id="dd" style="margin:100px auto;width:800px;height:600px;></div>
</body>
</html>
