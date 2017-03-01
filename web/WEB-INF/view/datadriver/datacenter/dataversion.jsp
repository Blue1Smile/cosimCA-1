<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html lang="zh-CN">
<head>
  <title>数据版本</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
  <%@include file="/commons/include/get.jsp" %>
  <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="layui-tab layui-tab-card">
  <ul class="layui-tab-title">
    <li class="layui-this">数据版本</li>
  </ul>
  <div class="layui-tab-content">
    <div class="layui-form-item">

      </div>
    </div>


    <a class="link back" href="publishorderdata.ht">返回</a>
    <form id="datacentreForm" name="datacentreForm" method="post" action="dataversion.ht"
          enctype="multipart/form-data">
        <div class="layui-tab-item layui-show">
            <table id="dataVersionList" class="layui-table" cellpadding="1" cellspacing="1">
                <thead>
                <%--<th style="text-align:center !important;">数据</th>--%>
                <th style="text-align:center !important;">数据修改人</th>
                <%--<th style="text-align:center !important;">数据类型</th>--%>
                <th style="text-align:center !important;">数据值</th>
                <th style="text-align:center !important;">数据修改时间</th>
                <th style="text-align:center !important;">数据描述</th>
                <%--<th style="text-align:center !important;">数据所属任务</th>--%>
                </thead>
                <tbody id="gridtbody">
                <c:forEach items="${dataVersionList}" var="dataVersionList">
                    <%--<tr style="cursor:pointer">--%>
                    <tr style="cursor:pointer">
                        <td style="text-align: center;">
                            <input name="ddDataRecordPersonId" type="hidden" value="${dataVersionList.ddDataRecordPersonId}">
                                ${dataVersionList.ddDataRecordPersonId}
                        </td>
                        <td style="text-align: center;">
                            <input type="hidden" name="ddDataValue" value="${dataVersionList.ddDataValue}">
                                ${dataVersionList.ddDataValue}
                        </td>
                        <td style="text-align: center;">
                            <input type="hidden" name="ddDataRecordTime" value="${dataVersionList.ddDataRecordTime}">
                                ${dataVersionList.ddDataRecordTime}
                        </td>
                     <td style="text-align: center;">
                        <a href="datasnapshot.ht?ddDataVersionId=${dataVersionList.ddDataVersionId}"
                           class="layui-btn layui-btn-normal  layui-btn-small"><i
                                class="layui-icon">&#xe615;</i> 数据快照</a>
                            <%--<input type="hidden" name="ddDataRecordTime" value="${dataVersionList.ddDataRecordTime}">--%>
                                <%--${dataVersionList.ddDataRecordTime}--%>
                         <%--<input type="hidden" name="ddDataVersionId" value="${dataVersionList.ddDataVersionId}">--%>
                             <%--${dataVersionList.ddDataVersionId}--%>
                       </td>

                        <%--<td style="text-align: center;">--%>
                            <%--<input type="hidden" name="ddDataDescription"--%>
                                   <%--value="${privateDataItem.ddDataLastestValue}">--%>
                            <%--<font color="red">${privateDataItem.ddDataLastestValue}</font>--%>
                        <%--</td>--%>
                        <%--<td style="text-align: center;">--%>
                            <%--<input type="hidden" name="ddDataDescription"--%>
                                   <%--value="${privateDataItem.ddDataDescription}">--%>
                                <%--${privateDataItem.ddDataDescription}--%>
                        <%--</td>--%>
                        <%--<td style="text-align: center;">--%>
                            <%--<input type="hidden" name="ddDataTaskId" value="${privateDataItem.ddDataTaskId}">--%>
                                <%--${privateDataItem.ddDataTaskId}--%>
                        <%--</td>--%>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </form>
</div>
</body>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</html>


