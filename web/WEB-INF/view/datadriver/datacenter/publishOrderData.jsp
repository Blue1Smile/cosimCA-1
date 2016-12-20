<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/12/16
  Time: 20:43
  To change this template use File | Settings | File Templates.
--%>
<%--
	time:2013-04-11 11:48:44
	desc:edit the 业务定义，如邀标采购这样的大业务。
--%>
<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@page import="com.hotent.core.util.ContextUtil" %>
<html>
<head>
  <title>发布/订购数据</title>
  <%@include file="/commons/include/form.jsp" %>
  <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
  <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
  <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
  <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
  <script type="text/javascript">
//    (function($) {
//      $.getUrlParam = function(name) {
//        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
//        var r = window.location.search.substr(1).match(reg);
//        if (r != null)
//          return unescape(r[2]);
//        return null;
//      }
//    })(jQuery);
//    $(function()
//    {
//      var temp= $.getUrlParam("id");
//     alert(temp);
//    });

  </script>

</head>
<body>

<div class="panel">

  <fieldset class="layui-elem-field">
      <div class="panel-body">
          <div class="layui-tab layui-tab-card">
            <ul class="layui-tab-title">
              <li class="layui-this">发布数据</li>
              <li>订购数据</li>
            </ul>
            <div class="layui-tab-content" style="height: 100%;">
              <!--任务发布数据-->
              <div class="layui-tab-item">
                <%--<iframe src="${ctx}/datadriver/datacenter/publishData.ht?id="+temp--%>
                        <%--style="width: 100%;height: 500px" scrolling="no"></iframe>--%>
                  <table class="layui-table" cellpadding="1" cellspacing="1" id="taskInfo"
                         formType="window" type="sub">
                    <tr>
                      <td colspan="11">
                        <div align="center">
                          发布数据
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th>数据编号</th>
                      <th>数据名称</th>
                      <th>数据类型</th>
                      <th>数据描述</th>
                      <th>数据所属任务id</th>
                      <th>操作</th>
                    </tr>
                    <c:forEach items="${privateDataList_publish}" var="privateDataList"
                               varStatus="status">
                      <tr type="subdata">
                        <td style="text-align: center"
                            name="ddDataId">${privateDataList.ddDataId}</td>
                        <td style="text-align: center"
                            name="ddDataName">${privateDataList.ddDataName}</td>
                        <td style="text-align: center"
                            name="ddDataType">${privateDataList.ddDataType}</td>
                        <td style="text-align: center"
                            name="ddDataSensitiveness">${privateDataList.ddDataDescription}</td>
                        <td style="text-align: center"
                            name="ddDataSensitiveness">${privateDataList.ddDataTaskId}</td>
                        <td style="text-align: center">
                          <a href="#" class="layui-btn layui-btn-normal layui-btn-small" >数据版本</a>
                        </td>
                      </tr>
                    </c:forEach>
                  </table>

              </div>
              <!--任务订阅数据-->
              <div class="layui-tab-item">
                <table class="layui-table" cellpadding="1" cellspacing="1" id="taskInfo"
                       formType="window" type="sub">
                  <tr>
                    <td colspan="11">
                      <div align="center">
                        订购数据
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <th>数据编号</th>
                    <th>数据名称</th>
                    <th>数据类型</th>
                    <th>数据描述</th>
                    <th>数据所属任务id</th>
                    <th>操作</th>
                  </tr>
                  <c:forEach items="${privateDataList_order}" var="privateDataList"
                             varStatus="status">
                    <tr type="subdata">
                      <td style="text-align: center"
                          name="ddDataId">${privateDataList.ddDataId}</td>
                      <td style="text-align: center"
                          name="ddDataName">${privateDataList.ddDataName}</td>
                      <td style="text-align: center"
                          name="ddDataType">${privateDataList.ddDataType}</td>
                      <td style="text-align: center"
                          name="ddDataSensitiveness">${privateDataList.ddDataDescription}</td>
                      <td style="text-align: center"
                          name="ddDataSensitiveness">${privateDataList.ddDataTaskId}</td>
                      <td style="text-align: center">
                        <a href="#" class="layui-btn layui-btn-normal layui-btn-small" >数据版本</a>
                      </td>
                    </tr>
                  </c:forEach>
                </table>
              </div>
            </div>
          </div>
      </div>
    <%--</div>--%>
  </fieldset>
</div>
<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
</body>
</html>

