<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/11/20 0020
  Time: 下午 3:41
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
  <title>项目指标信息列表</title>
  <%@include file="/commons/include/get.jsp" %>
  <script type="text/javascript">


  </script>
</head>
<body>
<div class="panel">
  <div class="panel-top">
    <div class="tbar-title">
      <span class="tbar-label">项目指标信息列表</span>
    </div>
    <div class="panel-toolbar">
      <div class="toolBar">
        <div class="group"><a class="link search" id="Search">查询</a></div>
        <div class="l-bar-separator"></div>
        <div class="group"><a class="link add" href="edit.ht">添加</a></div>
        <div class="l-bar-separator"></div>
        <div class="group"><a class="link update" id="btnUpd" action="edit.ht">修改</a></div>
        <div class="l-bar-separator"></div>
        <div class="group"><a class="link del"  action="">删除</a></div>
      </div>
    </div>
    <div class="panel-search">
      <form id="searchForm" method="post" action="list.ht">
        <div class="row">

          <span class="label">指标名称:</span><input type="text" name="ddIndexName"  class="inputText" />
          <span class="label">创建日期 从:</span> <input  name="Q_begincreateTime_DL"  class="inputText date" />
          <span class="label">至: </span><input  name="Q_endcreateTime_DG" class="inputText date" />
        </div>
      </form>
    </div>
  </div>
  <div class="panel-body">
    <c:set var="checkAll">
      <input type="checkbox" id="chkall"/>
    </c:set>
      <display:table name="DDIndexList" id="DDIndexItem" requestURI="list.ht" sort="external" cellpadding="1"
                     cellspacing="1" export="true" class="table-grid" pagesize="10">
      <display:column title="${checkAll}" media="html" style="width:30px;">
        <input type="checkbox" class="pk" name="" value="">
      </display:column>
      <display:column property="ddIndexId" title="指标编号" sortable="true" sortName="DD_PROJECT_ID" maxLength="80"></display:column>
      <display:column property="ddIndexName" title="指标名称" sortable="true" sortName="DD_PROJECT_NAME" maxLength="80"></display:column>
      <display:column property="ddIndexProjectId" title="指标关联id" maxLength="80"></display:column>
      <display:column property="ddIndexTypeId" title="指标类型id" ></display:column>
      <display:column property="ddIndexProperty" title="指标属性" sortable="true" sortName="DD_PROJECT_CREATE_DATATIME"></display:column>
      <display:column property="ddIndexOptimum" title="指标最优值" maxLength="80"></display:column>
      <display:column property="ddIndexResponsiblePersonId" title="指标责任人id"  maxLength="80"></display:column>
      <display:column property="ddIndexSensitiveness" title="指标敏感度" maxLength="80"></display:column>
      <display:column property="ddIndexLastestValue" title="指标最新值" ></display:column>

      <display:column title="操作" media="html" style="width:260px">
        <a href="" class="link del">删除</a>
        <a href="" class="link edit">编辑</a>
        <a href="" class="link detail">明细</a>

      </display:column>
    </display:table>
      <%--<hotent:paging tableId=""/>--%>
  </div><!-- end of panel-body -->
</div> <!-- end of panel -->
</body>
</html>




