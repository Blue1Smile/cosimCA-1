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
          <p class="w19 bottom_1"><strong>如何定制企业主页 ?</strong></p>
          <p class="f129 bottom_2"><br/>1） 企业管理员登陆；<br />
            <br />
 2）	在工作平台—设置与维护—企业信息维护中填写企业信息，点击“保存”后，相关信息自动更新到企业主页。<br />
 <img src="helpimg/helpimg003.jpg"/><br />
        </div>
<div class="clear"></div>
	</div>
	
	<br /><br /><br /><br /><br /><br />
</div>
	
    
    <%@include file="/commons/cloud/foot.jsp"%>
</body>
</html>
