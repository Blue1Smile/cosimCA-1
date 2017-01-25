<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
  <title>数据快照列表</title>
  <%@include file="/commons/include/get.jsp" %>
  <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
  <style>
    .pages{
      float: right;
    }
    .page_line{
      display:inline;
    }
  </style>

</head>
<body>
<div class="layui-tab layui-tab-card">
  <ul class="layui-tab-title">
    <li class="layui-this">数据快照列表</li>
  </ul>
  <div class="layui-tab-content">
    <form id="searchForm" method="post" action="list.ht">
      <div class="layui-form-item">
        <div class="layui-inline">
          <label class="layui-form-label">数据名称</label>
          <div class="layui-input-block">
            <input type="text" name="Q_name_SL " class="layui-input"
                   value="${param['Q_name_SL']}"/>
          </div>
        </div>
        <div class="layui-inline">
          <label class="layui-form-label">任务名称</label>
          <div class="layui-input-inline">
            <input type="text" name="Q_taskid_SL " class="layui-input"
                   value="${param['Q_taskid_SL']}"/>
          </div>
        </div>


        <a class="layui-btn layui-btn-normal" id="Search">查询</a>
      </div>
      <c:set var="checkAll">
      <input type="checkbox" id="chkall"/>
      </c:set>
      <display:table name="datasnapshotlist" id="DataSnapshotItem" requestURI="datasnapshotlist.ht" sort="external"
                     cellpadding="1"
                     cellspacing="1" export="false" class="layui-table" pagesize="10">
      <display:column title="${checkAll}" media="html" style="width:3%;">
      <input type="checkbox" class="pk" name="id" value="${DataSnapshotItem.ddDataId}">
      </display:column>
        <%--<display:column property="ddDataId" title="数据编号" sortable="true" sortName="DD_DATA_ID"--%>
        <%--maxLength="80"></display:column>--%>


        <display:column property="ddDataId" title="数据ID" sortable="true" sortName="DD_DATA_NAME" maxLength="80"></display:column>
        <display:column property="ddDataValue" title="数据快照值" maxLength="80"></display:column>
        <%--<display:column property="ddDataRecordTime" title="数据记录时间"></display:column>--%>
        <%--<display:column property="ddSnapshotPersonId" title="数据快照人ID" sortable="true"></display:column>--%>
        <%--<display:column property="ddSnapshotTime" title="数据快照时间" maxLength="80"></display:column>--%>
        <display:column property="ddDataTag" title="数据标签" maxLength="80"></display:column>


      <display:column title="操作" media="html" style="width:260px">
      <a href="showdatashot.ht?ddDataSnapshotId=${DataSnapshotItem.ddDataSnapshotId}" class="layui-btn layui-btn-normal layui-btn-small">查看</a>

      </display:column>
      </display:table>
  </div>
</div>
</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</html>


