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
          <p class="w19 bottom_1"><strong>如何建立企业组织，添加企业用户 ?</strong></p>
          <p class="f129 bottom_2"><br/>1） 企业管理员登陆后，在<strong>工作平台—设置与维护—组织结构维护</strong>中建立企业组织结构;<br />
          <img src="helpimg/helpimg004.jpg"/><br />
 2）	在<strong>工作平台—设置与维护—人员信息维护</strong>中添加用户，分配角色。<br />
 <img src="helpimg/helpimg005.jpg"/><br />
        </div>
<div class="clear"></div>
	</div>
	
	<br /><br /><br /><br /><br /><br />
</div>
	
    
    <%@include file="/commons/cloud/foot.jsp"%>
</body>
</html>
