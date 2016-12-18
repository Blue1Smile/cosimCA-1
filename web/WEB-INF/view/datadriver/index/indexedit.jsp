<%--
	time:2013-04-11 11:48:44
	desc:edit the 业务定义，如邀标采购这样的大业务。




指标跳转    要把项目id传过来
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<%@page import="com.hotent.core.util.ContextUtil"%>
<html>
<head>
  <title>项目基础信息添加</title>
  <%@include file="/commons/include/form.jsp" %>
  <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js" ></script>
  <script type="text/javascript" src="${ctx}/js/hotent/formdata.js" ></script>>
  <script type="text/javascript" src="${ctx}/js/hotent/subform.js" ></script>

  <script type="text/javascript">
    $(function() {
      var options={};
      if(showResponse){
        options.success=showResponse;
      }
      var frm=$('#projinfoForm').form();
      $("a.save").click(function() {
        frm.setData();
        frm.ajaxForm(options);
        if(frm.valid()){
          form.submit();
        }
      });
    });

    function showResponse(responseText) {
      var obj = new com.hotent.form.ResultMessage(responseText);
      if (obj.isSuccess()) {
        $.ligerMessageBox.confirm("提示信息", obj.getMessage()+",是否继续操作", function(rtn) {
          if(rtn){
            this.close();
          }else{
            window.location.href = "${ctx}/datadriver/project/indexlist.ht";
          }
        });
      } else {
        $.ligerMessageBox.error("提示信息",obj.getMessage());
      }
    }

  </script>

</head>
<body>
<div class="panel">
  <div class="panel-top">
    <div class="tbar-title">
      <c:choose>
        <c:when test="">
          <span class="tbar-label">编辑项目信息</span>
        </c:when>
        <c:otherwise>
          <span class="tbar-label">添加项目信息</span>
        </c:otherwise>
      </c:choose>
    </div>
    <div class="panel-toolbar">
      <div class="toolBar">
        <div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
        <div class="l-bar-separator"></div>
        <div class="group"><a class="link back " href="indexlist.ht">返回</a></div>
      </div>
    </div>
  </div>
  <div class="panel-body">


    <form id="indexinfoForm" name="indexfoForm" method="post" action="indexsave.ht" enctype="multipart/form-data" >
      <table id="AddHandlingFee"   class="table-detail" cellpadding="0" cellspacing="0" border="0" type="main">
        <tr>
          <th width="20%">指标编号: </th>
          <td><input type="text" id="ddIndexId" name="ddIndexId" value="${Index.ddIndexId}" validate="{required:false,maxlength:768}" class="inputText"/></td>
          <th width="20%">指标名称: </th>
          <td><input type="text" id="ddProjectName" name="ddProjectName" value="${Index.ddProjectName}" validate="{required:false,maxlength:768}" class="inputText"/></td>
        </tr>
        <tr>
          <th width="20%">指标类型: </th>
          <td><input type="text" id="ddIndexTypeId" name="ddIndexTypeId" value="${Index.ddIndexTypeId}" validate="{required:false,maxlength:768}" class="inputText"/></td>
          <th width="20%">指标属性: </th>
          <td><input type="text" id="ddIndexProperty" name="ddIndexProperty" value="${Index.ddIndexProperty}" validate="{required:false}" class="inputText"/></td>
        </tr>
        <tr>
          <th width="20%">指标最优值: </th>
          <td><input type="text" id="ddIndexOptimum" name="ddIndexOptimum" value="${Index.ddIndexOptimum}" validate="{required:false,maxlength:768}" class="inputText"/></td>

          <th width="20%">指标责任人: </th>
          <td><input type="text" id="ddIndexResponsiblePersonId" name="ddIndexResponsiblePersonId" value="${Index.ddIndexResponsiblePersonId}" validate="{required:false,maxlength:768}" class="inputText"/></td>
        </tr>
        <tr>
          <th width="20%">指标敏感度: </th>
          <td><input type="text" id="ddIndexSensitiveness" name="ddIndexSensitiveness" value="${Index.ddIndexSensitiveness}" validate="{required:false,maxlength:768}" class="inputText"/></td>
          <th width="20%">指标最新值: </th>
          <td><input type="text" id="ddIndexLastestValue" name="ddIndexLastestValue" value="${Index.ddIndexLastestValue}" validate="{required:false,maxlength:768}" class="inputText"/></td>
        </tr>

      </table>

      <input type="hidden" name="" value="" />
    </form>
  </div>
</div>





</body>
</html>
