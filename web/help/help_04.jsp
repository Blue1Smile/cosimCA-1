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
          <p class="w19 bottom_1"><strong>如何发布商机 ?</strong></p>
          <img src="helpimg/helpimg006.jpg"/><br />
          <p class="f129 bottom_2"><br/>1）  用户登录后，在个人主页中点击商机发布快捷键，打开商机发布页面，输入商机详细信息，点击“发布”按钮；<br />
 <img src="helpimg/helpimg007.jpg"/><br />
  2）	企业管理员登陆后，在工作平台-设置与维护-商机维护中，选择要审核的分类商机（研发商机管理、采购商机管理、生产商机管理、营销商机管理、服务商机管理），点击“审核”按钮，选择“审核通过”，商机即可发布。<br />
   <img src="helpimg/helpimg008.jpg"/><br />
        </div>
<div class="clear"></div>
	</div>
	
	<br /><br /><br /><br /><br /><br />
</div>
	
    
    <%@include file="/commons/cloud/foot.jsp"%>
</body>
</html>
