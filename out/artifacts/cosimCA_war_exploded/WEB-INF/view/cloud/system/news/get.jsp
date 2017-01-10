<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commons/cloud/global.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/commons/cloud/meta.jsp"%>
<title>新闻列表</title>
</head>
<body>
<div id="all">
<%@ include file="/commons/cloud/top.jsp"%>

<!-- 新闻详细 开始 -->
<div id="newsList">
	<div id="newsTitle2" >${news.title }</div>
    <div class="newsTitle3" >发布时间：<fmt:formatDate value="${news.publishtime }" pattern="yyyy-MM-dd"/> 发布人:${news.publisher }</div>
  	<div class="data-ctrl3">${news.content}</div>
</div>
<!-- 新闻详细 结束 -->
</div>

<!-- 底部版权区  开始 -->
<%@ include file="/commons/cloud/foot.jsp"%>
<!-- 底部版权区  结束 -->
</body>
</html>

