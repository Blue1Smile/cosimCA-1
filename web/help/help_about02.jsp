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
          <p class="w19 bottom_1"><strong>天智网价值</strong></p>
          <br />
          <p class="f129 bottom_2"> <br/>   (1) 对政府的价值
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;            政府通过引导企业登云，有针对性地选择重点发展产业，按需引进先进的技术和
商业模式，创新招商方式、扩大税收来源，有力推动产业转型升级。同时，整合产业
资源，提升对周边地区的产业辐射能力。 <br />
<br />
(2) 对行业的影响
    <br />
&nbsp;&nbsp;&nbsp;&nbsp;    行业协会通过天智网可以提高行业的聚集度，扩大行业影响力，整体提升行业竞
争力。逐步建立行业评估体系，辅助开展行业分析，为企业决策提供资讯。<br />
<br />
(3) 对企业的价值
    <br />
&nbsp;&nbsp;&nbsp;&nbsp;    解决企业内外部信息化问题，企业可以通过天智网开展企业间业务对接和协同，
同时可以通过天智网高效利用在线资源，降低制造成本，并获得整体的创新手段，提
升创新能力，提高生产效率，从而获得增值收益。<br />

                        <img src="helpimg/helpimg015.jpg"/><br />
        </p>
        </div>
<div class="clear"></div>
	</div>
	
	<br /><br /><br /><br /><br /><br />
</div>
	
    
    <%@include file="/commons/cloud/foot.jsp"%>
</body>
</html>
