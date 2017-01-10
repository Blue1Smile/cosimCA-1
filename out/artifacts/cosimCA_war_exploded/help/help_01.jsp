<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/commons/cloud/global.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx}/skins/main.css" rel="stylesheet"/>
<%@include file="/commons/cloud/meta.jsp"%>
<script src="${ctx}/skins/jquery.js" type="text/javascript"></script>
<script src="${ctx}/skins/main.js" type="text/javascript"></script>
<title>帮助中心</title>
</head>
	
<body>
<div id="all">
	<%@include file="/commons/cloud/top.jsp"%>
	
	<!--左侧菜单-->
	<div id="manager">
	  <%@include file="/commons/cloud/help_left.jsp"%>
	  
	  <div id="help" class="bggraybox">
        <div class="title"><a href="#">帮助中心</a></div>
          <p style="clear:both"></p>
          <p class="w19 bottom_1"><strong>如何登云 ?</strong></p>
                    				<img src="helpimg/helpimg002.jpg"/><br />
          <p class="f129 bottom_2"><br/>1） 访问注册页面，填写注册信息，点击“提交”，等待审核完成后，即完成注册。<br />

                        <img src="helpimg/helpimg001.jpg"/><br />

2）	获取企业代码和企业管理员用户名密码。请牢记。
  <br />
  <br />
  3）	访问登录页面，进入登陆界面填写正确的企业代码、用户名和密码，点击“提交”即可完成登陆， <br />
  <br />
        </p>
        </div>
<div class="clear"></div>
	</div>
	
	<br /><br /><br /><br /><br /><br />
</div>
	
    
    <%@include file="/commons/cloud/foot.jsp"%>
</body>
</html>
