<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commons/cloud/global.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><decorator:title default="工作台"/>-协同设计</title>
	<%@include file="/commons/cloud/meta.jsp" %>
	<f:link href="Aqua/css/bootstrap.css"></f:link>
	<link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript">

		$(document).ready(function () {
			$(".sontable").show();
			$(".parenttable").toggle(function () {
				var index = $(".parenttable").index($(this)[0]);
				$(".sontable:eq(" + index + ")").slideUp();
			}, function () {
				var index = $(".parenttable").index($(this)[0]);
				$(".sontable:eq(" + index + ")").slideDown();
			});

		});

	</script>
</head>
<body>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="/commons/cloud/top_console.jsp" %>
	<div class="layui-layout layui-layout-admin">

		<decorator:body/>
		<div class="layui-body">

			<iframe src="main.ht" frameborder="0" scrolling="no" id="mainframe"
					style="width:100%;min-height:800px;"></iframe>
		</div>
	</div>
	<%@include file="/commons/cloud/foot.jsp" %>
</div>


</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</html>
