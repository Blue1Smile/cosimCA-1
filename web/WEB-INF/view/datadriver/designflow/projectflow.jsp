<%--
  Created by IntelliJ IDEA.
  User: dodo
  Date: 2016/12/26
  Time: 下午5:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/commons/include/get.jsp" %>
<html>
<head>
    <title>项目流程</title>
    <%--<link href="${ctx}/styles/layui/css/layui.css" rel="stylesheet" type="text/css"/>--%>
    <style type="text/css" media="screen">
        div.base {
            position: absolute;
            overflow: hidden;
            white-space: nowrap;
            font-family: Arial;
            font-size: 8pt;
        }

        div.base#graph {
            border-style: solid;
            border-color: #F2F2F2;
            border-width: 1px;
            background: url('${ctx}/datadriver/designflow/images/grid.gif');
        }
    </style>
    <script type="text/javascript">
        mxBasePath = '${ctx}/src';
    </script>
    <script type="text/javascript" src="${ctx}/src/js/mxClient.js"></script>
    <script type="text/javascript" src="${ctx}/designflow/editors/js/mxApplication.js"></script>
    <script type="text/javascript">
        mxConstants.DEFAULT_HOTSPOT = 1;

        var id='${projectId}';
        var xml='${processFlowXml}';
        var flag=${flag};
        // Enables guides
        mxGraphHandler.prototype.guidesEnabled = true;

        // Alt disables guides
        mxGuide.prototype.isEnabledForEvent = function (evt) {
            return !mxEvent.isAltDown(evt);
        };

        // Enables snapping waypoints to terminals
        mxEdgeHandler.prototype.snapToTerminals = true;


        window.onbeforeunload = function () {
            return "  ";

        };
    </script>
</head>
<body onload="if(flag) new mxApplication('${ctx}/datadriver/designflow/editors/config/workfloweditor_graph.xml',id,xml); else new mxApplication('${ctx}/datadriver/designflow/editors/config/workfloweditor.xml',id,xml); ">

<table id="splash" width="100%" height="100%"
       style="background:white;position:relative;top:0px;left:0px;z-index:4;">
    <tr>
        <td align="center" valign="middle">
            <img src="${ctx}/designflow/images/loading.gif">
        </td>
    </tr>
</table>
<div id="graph" class="base">
    <!-- Graph Here -->
</div>
<div id="status" class="base" align="right">
    <!-- Status Here -->
</div>

</body>
<%--<script src="${ctx}/styles/layui/lay/dest/layui.all.js"></script>--%>
</html>
