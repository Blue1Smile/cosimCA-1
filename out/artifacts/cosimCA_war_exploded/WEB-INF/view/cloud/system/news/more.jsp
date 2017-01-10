<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commons/cloud/global.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新闻列表</title>
<head>
<%@ include file="/commons/cloud/meta.jsp"%>
<%@include file="/commons/include/get.jsp" %>
 
<style type="text/css">
	#header .serch .serch_01{
	float:left; width:550px; height:38px; vertical-align:bottom; padding-left:49px;
	*height:20px; /* ie6 Hack */
	}
	#header .tab{
	float:left;
	margin-top: 16px;
	padding-left:0px;
	*padding-left:13px; *margin:0; /* ie6 Hack */
	}
	.serch_03{
	float:left; width:487px;height:34px;
	}
	.header_input{
	width:475px;height:22px; font-size:14px; color:#999; padding:4px; line-height:22px; border:#1f73b9 2px solid;
	}
	#newsItem .link{
	font-size:14px; color:#005085; text-decoration:none;  width:600px; height:30px;line-height:30px;float:left;
	}
	
	.panel-page {
	border: 1px #8dc2e3 solid;
	border-top: none;
	height: 28px;
	width: 998px;
	margin-top:-5px;
	margin-left: 10px;
	background: #dff5fd;
	/*background: url(../images/tool_bg.jpg) repeat-x;*/
	}
	.zxc{
	width:80px;
	height:25px;
	line-height:25px;
	float:left;
	text-align:center;
	color: #1F73BB;
    cursor: pointer;
    float: left;
    font-size: 12px;
    font-weight: bold;
	}
</style>
</head>
<body>
<script>
	function getNews(id){
		location.href="${ctx}/cloud/system/news/get.ht?id=" + id;
	}
	
</script>

<body>
<div id="all">
<%@include file="/commons/cloud/top.jsp"%>
<!-- 页面主体  开始 -->
<div id="newsList">
	<div id="newsTitle" ><span id="title01">新闻列表</span></div>
<div id="model01">
<table id="newsItem">
	    <c:forEach items="${newsList}" var="c1" >
	      <tr><td><a href="javascript:getNews('${c1.id}');" class="link">${c1.title }</a></td><td><span><fmt:formatDate value="${c1.publishtime}" pattern="yyyy-MM-dd "/></span></td></tr>
	    </c:forEach>
</table>	
</div>
<div class="pub_tab" style="margin-top:20px;">
		<div class="fenye">
			 <hotent:paging tableId="newsItem"/>
		 </div>
</div>
</div>

</div>
<%@ include file="/commons/cloud/foot.jsp"%>
</body>
</html>
