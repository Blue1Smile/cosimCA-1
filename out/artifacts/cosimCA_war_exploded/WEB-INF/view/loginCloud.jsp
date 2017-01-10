<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commons/cloud/global.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>登录页面</title>
<%@include file="/commons/cloud/meta.jsp"%>
<link href="${ctx}/skins/validform.css"  rel="stylesheet"/>
<link type="text/css" rel="stylesheet" href="${ctx}/styles/default/css/login.css"/>
<script type="text/javascript">
		if(top!=this){//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面
			  top.location='<%=request.getContextPath()%>/loginCloud.ht';
		}
		
		function submitForm() {
			var loginform=document.forms["loginform"];
			loginform.submit();
		} 
</script>
</head>
<body>
<div class="second_body">

		<form action="${ctx}/loginCloudPost.ht" id="loginform" method="post">
			<table width="300" border="0">
				<tr>
					<td colspan="1"><input style="width:90%" placeholder="用户名" type="text" name="shortAccount" class="login"/></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td colspan="1"><input style="width:90%" placeholder="密码" type="password" name="password" class="login"/></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td colspan="1"><input style="width:80%" type="submit" value="登录" class="login_button" onclick="submitForm()"/></td>
				</tr>
				<input type="hidden" name="orgSn" id="orgSn" value="620001"/>
			</table>
		</form>

</div>
</body>
</html>
