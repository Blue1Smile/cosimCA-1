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
          <p class="w19 bottom_1"><strong>如何使用资源 ?</strong></p>
          <img src="helpimg/helpimg013.jpg"/><br />
          <p class="f129 bottom_2"><br/>1） 搜索资源：在搜索栏中选择资源，输入关键字，点击“<img src="helpimg/helpimg010.jpg"/ style="padding:0;">”，查看搜索结果；<br />
  2）	  加商友：在企业搜索结果中，点击“加商友”，在商机/能力搜索结果中，点击商机/能力，查看详细信息，点击企业名称，进入企业首页，点击“加商友”，发出加商友请求;<br />
  <br />
  3）	作业取回/保存结果。<br />
  <br />
      </div>
<div class="clear"></div>
	</div>
	
	<br /><br /><br /><br /><br /><br />
</div>
	
    
    <%@include file="/commons/cloud/foot.jsp"%>
</body>
</html>
