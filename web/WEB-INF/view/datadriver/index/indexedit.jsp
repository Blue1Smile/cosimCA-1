<%--
  Created by IntelliJ IDEA.
  User: dodo
  Date: 2017/1/3
  Time: 下午5:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/commons/include/html_doctype.html" %>
<%@page import="com.hotent.core.util.ContextUtil" %>
<html>
<head>
    <title>指标编辑</title>
    <%@include file="/commons/include/form.jsp" %>
    <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <style>
        .fr {
            float: right;
        }
    </style>
</head>
<body>
<div class="layui-tab layui-tab-card" id="iframe_tab">
    <ul class="layui-tab-title">
        <li class="layui-this" id="init">项目指标</li>
    </ul>
    <div class="layui-tab-content" style="height: 100%;">
        <div class="layui-tab-item layui-show">
            <form id="indexform" name="indexform" class="layui-form layui-form-pane" method="post" action="save.ht"
                  enctype="multipart/form-data">
                <table id="AddHandlingFee" class="layui-table" cellpadding="0" cellspacing="0"
                       border="0"
                       type="main">
                    <tr>
                        <th width="20%">指标名称:</th>
                        <td><input type="text" id="ddIndexName" name="ddIndexName"
                                   value="" class="layui-input"/></td>
                    </tr>
                    <tr>
                        <th width="20%">指标类型:</th>
                        <td>
                            <select name="ddIndexTypeId">
                                <option value=""></option>
                                <option value="0">0</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th width="20%">指标属性:</th>
                        <td>
                            <select name="ddIndexProperty">
                                <option value=""></option>
                                <option value="0">0</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th width="20%">最优值:</th>
                        <td><input type="text" id="ddIndexOptimum" name="ddIndexOptimum"
                                   value="" class="layui-input"/></td>
                    </tr>
                    <tr>
                        <th width="20%">灵敏度:</th>
                        <td>
                            <input type="text" name="ddIndexSensitiveness" id="ddIndexSensitiveness"
                                   value="" class="layui-input"/>
                        </td>
                    </tr>
                    <tr>
                        <th width="20%">最新值:</th>
                        <td><input type="text" id="ddIndexLastestValue" name="ddIndexLastestValue"
                                   value="" class="layui-input"/></td>
                    </tr>
                </table>
                <input id="ddIndexProjectId" name="ddIndexProjectId" type="hidden" value="${projectId}"/>
            </form>

            <div class="layui-form-item">
                <a class="layui-btn" id="dataFormSave" href="#">提交</a>
            </div>
        </div>
    </div>
    <script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
    <script>
        $(function () {
            var options = {};
            if (showResponse) {
                options.success = showResponse;
            }
            var frm = $('#indexform').form();
            $("#dataFormSave").click(function () {
                frm.setData();
                frm.ajaxForm(options);
                if (frm.valid()) {
                    form.submit();
                }
            });
        });

        function showResponse(responseText) {
            var obj = new com.hotent.form.ResultMessage(responseText);
            if (obj.isSuccess()) {
                layer.alert("项目指标提交成功", {
                    title: '提交信息'
                })
            } else {
                layer.alert("项目指标提交失败", {
                    title: '提交信息'
                })
            }
        }
        //    layui.use(['form', 'layedit', 'laydate'], function () {
        //        var form = layui.form()
        //                , layer = layui.layer
        //                , layedit = layui.layedit;
        ////                ,laydate = layui.laydate;

        //创建一个编辑器
        //        var editIndex = layedit.build('LAY_demo_editor');

        //自定义验证规则
        //        form.verify({
        //            title: function(value){
        //                if(value.length < 5){
        //                    return '标题至少得5个字符啊';
        //                }
        //            }
        //            ,pass: [/(.+){6,12}$/, '密码必须6到12位']
        //            ,content: function(value){
        //                layedit.sync(editIndex);
        //            }
        //        });
        //        function showResponse() {
        //            var frm = $('#indexform').form();
        //            frm.setData();
        //            frm.ajaxForm(options)
        //            form.submit()
        //        }
        //监听提交
        //        form.on(form.submit(), function (data) {
        ////      layer.alert(JSON.stringify(data.field), {
        //            layer.alert("项目指标提交成功", {
        //                title: '提交信息'
        //            })
        //            return false;
        //        });
        //    });
    </script>
</body>
</html>
