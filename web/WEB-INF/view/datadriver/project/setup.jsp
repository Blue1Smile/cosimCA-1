<%--
  Created by IntelliJ IDEA.
  User: d
  Date: 2017/1/16
  Time: 下午8:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>项目设置</title>
    <link href="${ctx}/newtable/bootstrap.css" rel="stylesheet" type="text/css"/>
    <script src="${ctx}/newtable/jquery.js"></script>
    <script src="${ctx}/newtable/bootstrap.js"></script>
</head>
<body>
<div class="container-fluid">
    <br>
    <div class="col-xs-3">
        <ul class="nav nav-pills nav-stacked" role="tablist">
            <li class="active"><a data-toggle="tab" href="#home">项目信息</a></li>
            <li><a data-toggle="tab" href="#menu1">项目偏好</a></li>
            <li><a data-toggle="tab" href="#menu2">更多...</a></li>
        </ul>
    </div>
    <div class="col-xs-9">
        <div class="well">
            <div class="tab-content">
                <div id="home" class="tab-pane fade in active">
                    <form class="form-horizontal" role="form" action="">
                        <div class="form-group">
                            <label class="col-xs-12 control-label">项目名称</label>
                            <div class="col-xs-12">
                                <input type="text" class="form-control" placeholder="项目名称" id="ddProjectName"
                                       name="ddProjectName">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-6">
                                <select class="form-control">
                                    <option>选择项目阶段</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                </select>
                            </div>
                            <div class="col-xs-6">
                                <select class="form-control">
                                    <option selected>选择所属型号</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-6">
                                <select class="form-control">
                                    <option selected>所属项目类型</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                </select>
                            </div>
                            <div class="col-xs-6">
                                <select class="form-control">
                                    <option selected>密级</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-12 control-label">项目简述</label>
                            <div class="col-xs-12">
                                    <textarea class="form-control" rows="5" placeholder="项目简介" id="ddProjectDescription"
                                              name="ddProjectDescription"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-12 control-label">项目负责人</label>
                            <div class="col-xs-9">
                                <input type="text" class="form-control" placeholder="项目负责人"
                                       id="ddProjectResponsiblePersonName" name="ddProjectResponsiblePersonName">
                                <input type="hidden" id="ddProjectResponsiblePersonId"
                                       name="ddProjectResponsiblePersonId"
                                       value="${projectItem.ddProjectResponsiblePersonId}"/>
                            </div>
                            <div class="col-xs-3">
                                <button class="btn btn-info">变更</button>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="button" class="btn btn-primary btn-block btn-">保存</button>
                            </div>
                        </div>
                    </form>
                </div>
                <div id="menu1" class="tab-pane fade">
                    <p><h3>动态提醒</h3><small>（仅对个人）</small></p>
                    <div class="col-sm-12">
                        <div class="radio">
                            <label>
                                <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
                                推送动态提醒（显示标记并以桌面通知的方式进行推送）
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                                不推送动态提醒（只显示标记）
                            </label>
                        </div>
                    </div>
                </div>
                <div id="menu2" class="tab-pane fade">
                    <p><h3>可执行操作</h3></p>
                    <div class="col-sm-12">
                        <br>
                        <button type="button" class="btn btn-primary btn-block">固化项目</button>
                        <button type="button" class="btn btn-danger btn-block">删除</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
