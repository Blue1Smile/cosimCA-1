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
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="//res.layui.com/layui/build/css/layui.css"  media="all">
    <link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>

    <style>
        #iframe_tab {
            margin-top: 0px;
        }
         .fl {
             float: left;
         }

        .fr {
            float: right;
        }
        .pages{
            float: right;
        }
        .page_line{
            display:inline;
        }
    </style>



</head>
<body>

<div class="layui-tab layui-tab-card" id="iframe_tab">
    <ul class="layui-tab-title">
        <li class="layui-this" id="init">发布数据</li>
        <li>订购数据</li>
    </ul>
    <div class="layui-tab-content" style="height: 100%;">
        <!--任务发布数据-->
        <blockquote class="layui-elem-quote">
            <div style="height: 40px;">
                <span class="fl">
                    <form id="searchForm" method="post" action="list.ht">
                            <input type="text" name="ddDataName" class="layui-input"
                                   value="${param['ddDataName']}" placeholder="数据名称"/>
                    </form>
                </span>
                <span class="fr">
                    <a class="layui-btn layui-btn-normal" id="Search"><i class="layui-icon">&#xe615;</i> 查询</a>
                    <a class="layui-btn layui-btn-primary" onclick="location.reload()"><i class="layui-icon">&#x1002;</i> 刷新</a>
                </span>
            </div>
        </blockquote>
        <div class="layui-tab-item">
            <c:set var="checkAll">
                <input type="checkbox" id="chkall"/>
            </c:set>
            <display:table name="privateDataList_publish" id="privateDataList_publish" requestURI="publishorderdata.ht"
                           sort="external" cellpadding="1"
                           cellspacing="1" export="false" class="layui-table" pagesize="10">
                <display:column title="${checkAll}" media="html" style="width:5%;">
                    <input type="checkbox" class="pk" name="id" value="${taskList.ddTaskId}">
                </display:column>
                <display:column property="ddDataName" title="数据名称" sortable="true" maxLength="60"></display:column>
                <display:column property="ddDataLastestValue" title="最新值" sortable="true"
                                maxLength="80"></display:column>
                <display:column property="ddDataCreateTime" title="时间" sortable="true" maxLength="80"></display:column>
                <display:column property="ddDataDescription" title="数据描述" sortable="true"
                                maxLength="80"></display:column>
                <display:column title="操作" media="html" style="width:100px">
                    <a href="dataversion.ht?id=${privateDataList_publish.ddDataId}"
                       class="layui-btn layui-btn-normal  layui-btn-small"><i
                            class="layui-icon">&#xe615;</i> 数据版本</a>
                    <%--<a class="layui-btn layui-btn-primary" href="javascript:;">prompt层</a>--%>
                    <%--<div class="site-demo-button" id="LAY_demo" style="margin-bottom: 0;">--%>
                        <%--<button data-method="offset" data-type="auto" class="layui-btn layui-btn-normal">居中弹出</button>--%>
                    <%--</div>--%>
                </display:column>
            </display:table>
        </div>
        <!--任务订阅数据-->
        <div class="layui-tab-item">
            <c:set var="checkAll">
                <input type="checkbox" id="chkall"/>
            </c:set>
            <display:table name="privateDataList_order" id="privateDataList_order" requestURI="publishorderdata.ht"
                           sort="external" cellpadding="1"
                           cellspacing="1" export="false" class="layui-table" pagesize="10">
                <display:column title="${checkAll}" media="html" style="width:5%;">
                    <input type="checkbox" class="pk" name="id" value="${taskList.ddTaskId}">
                </display:column>
                <display:column property="ddDataName" title="数据名称" sortable="true" maxLength="60"></display:column>
                <display:column property="ddDataLastestValue" title="最新值" sortable="true"
                                maxLength="80"></display:column>
                <display:column property="ddDataCreateTime" title="时间" sortable="true" maxLength="80"></display:column>
                <display:column property="ddDataDescription" title="数据描述" sortable="true"
                                maxLength="80"></display:column>
                <display:column title="操作" media="html" style="width:100px">
                    <a href="dataversion.ht?id=${privateDataList_order.ddDataId}"
                       class="layui-btn layui-btn-normal  layui-btn-small"><i
                            class="layui-icon">&#xe615;</i> 数据版本</a>
                    <a href="showdatashot.ht?id=${privateDataList_order.ddDataId}"
                       class="layui-btn layui-btn-normal  layui-btn-small"><i
                            class="layui-icon">&#xe615;</i> 数据快照查看</a>
                    <%--<a class="layui-btn layui-btn-primary" href="javascript:;">prompt层</a>--%>
                    <button data-method="offset" data-type="t" class="layui-btn layui-btn-normal">上弹出</button>
                </display:column>
            </display:table>

        </div>
    </div>
</div>


<%--<div class="layui-layer layui-layer-page layui-layer-prompt layer-anim" id="layui-layer7" type="page" times="7" showtime="0" contype="string" style="z-index: 19891021; top: 388.5px; left: 324px;">--%>
    <%--<div class="layui-layer-title" style="cursor: move;">输入任何口令，并确认--%>
    <%--</div>--%>
    <%--<div id="" class="layui-layer-content">--%>
        <%--<input type="password" class="layui-layer-input" value="">--%>
<%--</div>--%>
    <%--<span class="layui-layer-setwin">--%>
        <%--<a class="layui-layer-ico layui-layer-close layui-layer-close1" href="javascript:;"></a>--%>
    <%--</span>--%>
    <%--<div class="layui-layer-btn layui-layer-btn-">--%>
        <%--<a class="layui-layer-btn0">确定</a>--%>
        <%--<a class="layui-layer-btn1">取消</a>--%>
    <%--</div>--%>
<%--</div>--%>




<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>
<script>
    layui.use('layer', function()
    { //独立版的layer无需执行这一句
        var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句
        //触发事件
        var active =
        {

            offset: function(othis){
                var type = othis.data('type')
                        ,text = othis.text();

                layer.prompt({title: '输入任何口令，并确认', formType: 1}, function(pass, index){
                    layer.close(index);
                    layer.prompt({title: '随便写点啥，并确认', formType: 2}, function(text, index){
                        layer.close(index);
                        layer.msg('演示完毕！您的口令：'+ pass +'您最后写下了：'+text);
                    });
                });
            }
        };
        $('#LAY_demo .layui-btn').on('click', function()
        {
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });
    });



</script>

<%--<script type="text/javascript">--%>
    <%--$('#init').trigger('click');--%>
    <%--var nowDataId;--%>


    <%--function Prompt(index) {--%>

        <%--layer.prompt({title: '输入任何口令，并确认', formType: 1}, function(pass, index){--%>
            <%--layer.close(index);--%>
            <%--layer.prompt({title: '随便写点啥，并确认', formType: 2}, function(text, index){--%>
                <%--layer.close(index);--%>
                <%--layer.msg('演示完毕！您的口令：'+ pass +您最后写下了:'+text);--%>
            <%--});--%>
        <%--});--%>

    <%--}--%>







<%--</script>--%>

</body>
</html>

