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
          <p class="w19 bottom_1"><strong>天智网功能</strong></p>
          <br />
          <p class="f129 bottom_2">    <img src="helpimg/helpimg016.jpg"/><br />
(1) 企业对接
            <br />
A.寻找商机<br />
&nbsp;&nbsp;&nbsp;&nbsp;实现对商机的发布和管理，同时企业可以便捷的通过天智网寻找合适商机。<br />
&nbsp;&nbsp;&nbsp;&nbsp; ◎ 研发商机<br />
&nbsp;&nbsp;&nbsp;&nbsp; ◎ 采购商机<br />
&nbsp;&nbsp;&nbsp;&nbsp; ◎ 生产商机<br />
&nbsp;&nbsp;&nbsp;&nbsp; ◎ 营销商机<br />
&nbsp;&nbsp;&nbsp;&nbsp; ◎ 服务商机<br />
<img src="helpimg/helpimg017.jpg"/><br />
B.寻找能力<br />
&nbsp;&nbsp;&nbsp;&nbsp;实现对企业能力的发布和管理，同时企业可以便捷的通过天智网寻找合适的能力。<br />
&nbsp;&nbsp;&nbsp;&nbsp; ◎ 研发能力<br />
&nbsp;&nbsp;&nbsp;&nbsp; ◎ 贸易能力<br />
&nbsp;&nbsp;&nbsp;&nbsp; ◎ 生产能力<br />
&nbsp;&nbsp;&nbsp;&nbsp; ◎ 服务能力<br />
<img src="helpimg/helpimg018.jpg"/><br />
C.寻找企业<br />
&nbsp;&nbsp;&nbsp;&nbsp; 提供在线企业的管理和搜索，为企业提供主页定制服务。<br />
<img src="helpimg/helpimg019.jpg"/><br />
D.企业对接<br />
&nbsp;&nbsp;&nbsp;&nbsp;根据业务需求构造企业商圈，实现企业对接，为企业提供业务协作平台。<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 商圈管理<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 商圈动态<br />
<img src="helpimg/helpimg020.jpg"/><br />
(2) 资源应用<br />
A.寻找资源<br />
&nbsp;&nbsp;&nbsp;&nbsp;实现对在线软制造资源、硬制造资源的监控和管理，同时提供对在线资源搜索。<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 硬制造资源<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 软制造资源<br />
<img src="helpimg/helpimg021.jpg"/><br />
B.硬制造资源应用<br />
&nbsp;&nbsp;&nbsp;&nbsp;实现大计算量任务的解算，高性能集群资源的应用。<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 计算中心<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 数据中心<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 制造设备<br />
<img src="helpimg/helpimg022.jpg"/><br />
C.软制造资源应用<br />
&nbsp;&nbsp;&nbsp;&nbsp;实现利用昂贵的大型软件开展设计研发。<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 工具软件<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 应用系统<br />
<img src="helpimg/helpimg023.jpg"/><br />
(3) 协同业务<br />
A.寻找资源<br />
&nbsp;&nbsp;&nbsp;&nbsp;天智网支持协同研发、协同采购、协同生产、协同营销、协同服务五大协同业务的开展。主要包括以下应用模式：<br />
&nbsp;&nbsp;&nbsp;&nbsp;A.  协同研发<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 基于3D在线协同设计模式<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 基于3D在线协同仿真模式<br />
&nbsp;&nbsp;&nbsp;&nbsp;B.  协同采购<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 招投标模式<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 询报价模式<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 直接下单模式<br />
&nbsp;&nbsp;&nbsp;&nbsp;C.  协同营销<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 委外加工模式<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 协同排产模式<br />
&nbsp;&nbsp;&nbsp;&nbsp;D.  协同生产<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 代理模式<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 经营模式<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 联营模式<br />
&nbsp;&nbsp;&nbsp;&nbsp;E.  协同服务<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 指定服务站维修模式<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 服务站返厂维修模式<br />
<img src="helpimg/helpimg024.jpg"/><br />
<img src="helpimg/helpimg025.jpg"/><br />
(4) 配套服务<br />
A.寻找资源<br />
&nbsp;&nbsp;&nbsp;&nbsp;通过天智网实现协同业务向流通领域、金融领域的扩展。<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 物流服务<br />
&nbsp;&nbsp;&nbsp;&nbsp;◎ 金融服务<br />
<img src="helpimg/helpimg026.jpg"/><br />
        </p>
        </div>
<div class="clear"></div>
	</div>
	
	<br /><br /><br /><br /><br /><br />
</div>
	
    
    <%@include file="/commons/cloud/foot.jsp"%>
</body>
</html>
