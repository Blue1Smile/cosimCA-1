<%--
  Created by IntelliJ IDEA.
  User: dodo
  Date: 2017/1/3
  Time: 下午5:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>指标编辑</title>
    <%@include file="/commons/include/form.jsp" %>
    <script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
    <script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>
</head>
<body>

<form id="indexform" class="layui-form layui-form-pane" action="save.ht">
    <div class="layui-form-item">
        <label class="layui-form-label">指标名称</label>
        <div class="layui-input-block">
            <input type="text" id="ddIndexName" name="ddIndexName" autocomplete="off" placeholder="请输入指标名称"
                   class="layui-input" value="${indexInfo.ddIndexName}">
        </div>
    </div>
    <%--<div class="layui-form-item">--%>
    <%--<label class="layui-form-label">指标敏感度</label>--%>
    <%--<div class="layui-input-inline">--%>
    <%--<input type="text" name="username" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">--%>
    <%--</div>--%>
    <%--</div>--%>

    <div class="layui-form-item">
        <%--<div class="layui-inline">--%>
        <%--<label class="layui-form-label">日期选择</label>--%>
        <%--<div class="layui-input-block">--%>
        <%--<input type="text" name="date" id="date" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">--%>
        <%--</div>--%>
        <%--</div>--%>
        <div class="layui-inline">
            <label class="layui-form-label">指标敏感度</label>
            <div class="layui-input-inline">
                <input type="number" id="ddIndexSensitiveness" name="ddIndexSensitiveness" autocomplete="off"
                       class="layui-input" value="${indexInfo.ddIndexSensitiveness}">
            </div>
        </div>
    </div>
    <%--<div class="layui-form-item">--%>
    <%--<label class="layui-form-label">密码</label>--%>
    <%--<div class="layui-input-inline">--%>
    <%--<input type="password" name="password" placeholder="请输入密码" autocomplete="off" class="layui-input">--%>
    <%--</div>--%>
    <%--<div class="layui-form-mid layui-word-aux">请务必填写用户名</div>--%>
    <%--</div>--%>

    <%--<div class="layui-form-item">--%>
    <%--<div class="layui-inline">--%>
    <%--<label class="layui-form-label">范围</label>--%>
    <%--<div class="layui-input-inline" style="width: 100px;">--%>
    <%--<input type="text" name="price_min" placeholder="￥" autocomplete="off" class="layui-input">--%>
    <%--</div>--%>
    <%--<div class="layui-form-mid">-</div>--%>
    <%--<div class="layui-input-inline" style="width: 100px;">--%>
    <%--<input type="text" name="price_max" placeholder="￥" autocomplete="off" class="layui-input">--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--</div>--%>

    <%--<div class="layui-form-item">--%>
    <%--<label class="layui-form-label">指标类型</label>--%>
    <%--<div class="layui-input-block">--%>
    <%--<select name="interest">--%>
    <%--<option value="0">1</option>--%>
    <%--<option value="2">3</option>--%>
    <%--<option value="3">4</option>--%>
    <%--<option value="4">5</option>--%>
    <%--</select>--%>
    <%--</div>--%>
    <%--</div>--%>

    <%--<div class="layui-form-item">--%>
    <%--<label class="layui-form-label">指标属性</label>--%>
    <%--<div class="layui-input-block">--%>
    <%--<select name="quiz1">--%>
    <%--<option value="">请选择</option>--%>
    <%--<option value="你的工号">2</option>--%>
    <%--<option value="你最喜欢的老师">3</option>--%>
    <%--</select>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="layui-form-item">--%>
    <%--<button class="layui-btn" lay-submit="" lay-filter="demo2">指标导入</button>--%>
    <%--</div>--%>
    <%--<div class="layui-form-item layui-form-text">--%>
    <%--<label class="layui-form-label">指标内容</label>--%>
    <%--<div class="layui-input-block">--%>
    <%--<textarea class="layui-textarea layui-hide" name="content" lay-verify="content"--%>
    <%--id="LAY_demo_editor"></textarea>--%>
    <%--</div>--%>
    <%--</div>--%>
    <div class="layui-form-item">
        <input type="submit" class="layui-btn" id="dataFormSave" value="提交"/>
    </div>
</form>
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
