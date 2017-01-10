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
          <p class="w19 bottom_1"><strong>平台概述</strong></p>
          <br />
          <p class="f129 bottom_2"> <br/>&nbsp;&nbsp;&nbsp;&nbsp;平台是一种面向企业用户，服务于全产业链研发、采购、生产、营销和服务各
环节业务协作和以云服务形式提供各类制造能力与制造资源的公共服务平台。<br />
<br />
&nbsp;&nbsp;&nbsp;&nbsp; 平台
支持企业在云端提供各类服务，在线加入社区，寻找商机，创建商圈，开展业务协作
和电子商务等，实现社会化协同大制造。<br />
主要提供三大功能：
   <br />
   &nbsp;&nbsp;&nbsp;&nbsp;（1）提供在线商机、制造能力、制造资源的搜索服务，实现商机撮合和企业对接； <br />
   &nbsp;&nbsp;&nbsp;&nbsp;（2）提供产业链各环节上企业间的业务协作服务,实现社会化协同制造，并提供物
        流和金融等配套服务； <br />
   &nbsp;&nbsp;&nbsp;&nbsp;（3）提供软制造资源、硬制造资源统一管理功能,实现资源在线应用。<br />

                        <img src="helpimg/helpimg014.jpg"/><br />
        </p>
        </div>
<div class="clear"></div>
	</div>
	
	<br /><br /><br /><br /><br /><br />
</div>
	
    
    <%@include file="/commons/cloud/foot.jsp"%>
</body>
</html>
