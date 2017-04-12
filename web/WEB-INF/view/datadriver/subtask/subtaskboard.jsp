<%--
  Created by IntelliJ IDEA.
  User: d
  Date: 2017/3/5
  Time: 下午3:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>任务看板</title>
    <link rel="stylesheet" href="${ctx}/jqwidgets/styles/jqx.base.css" type="text/css"/>
    <script type="text/javascript" src="${ctx}/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="${ctx}/jqwidgets/jqxdata.js"></script>
    <script type="text/javascript" src="${ctx}/jqwidgets/jqxsortable.js"></script>
    <script type="text/javascript" src="${ctx}/jqwidgets/jqxkanban.js"></script>
    <script type="text/javascript" src="${ctx}/jqwidgets/jqxexpander.js"></script>
    <script type="text/javascript" src="${ctx}/jqwidgets/jqxinput.js"></script>
    <script type="text/javascript" src="${ctx}/jqwidgets/jqxcolorpicker.js"></script>
    <script type="text/javascript" src="${ctx}/jqwidgets/jqxradiobutton.js"></script>
    <script type="text/javascript" src="${ctx}/jqwidgets/jqxdropdownbutton.js"></script>
    <script type="text/javascript" src="${ctx}/jqwidgets/jqxbuttons.js"></script>
    <style>
        html, body {
            padding: 0;
            margin: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            var fields = [
                {name: "id", type: "string"},
                {name: "status", map: "state", type: "string"},
                {name: "text", map: "label", type: "string"},
                {name: "tags", type: "string"},
                {name: "color", map: "hex", type: "string"},
                {name: "resourceId", type: "number"}
            ];

            var source =
            {
                localData: [
                    {
                        id: "1161",
                        state: "new",
                        label: "Combine Orders",
                        tags: "orders, combine",
                        hex: "#5dc3f0",
                        resourceId: 3
                    },
                    {
                        id: "1645",
                        state: "work",
                        label: "Change Billing Address",
                        tags: "billing",
                        hex: "#f19b60",
                        resourceId: 1
                    },
                    {
                        id: "9213",
                        state: "new",
                        label: "One item added to the cart",
                        tags: "cart",
                        hex: "#5dc3f0",
                        resourceId: 3
                    },
                    {
                        id: "6546",
                        state: "done",
                        label: "Edit Item Price",
                        tags: "price, edit",
                        hex: "#5dc3f0",
                        resourceId: 4
                    },
                    {id: "9034", state: "new", label: "Login 404 issue", tags: "issue, login", hex: "#6bbd49"}
                ],
                dataType: "array",
                dataFields: fields
            };

            var dataAdapter = new $.jqx.dataAdapter(source);

            var resourcesAdapterFunc = function () {
                var resourcesSource =
                {
                    localData: [
                        {id: 0, name: "No name", image: "../../jqwidgets/styles/images/common.png", common: true},
                        {id: 1, name: "Andrew Fuller", image: "../../images/andrew.png"},
                        {id: 2, name: "Janet Leverling", image: "../../images/janet.png"},
                        {id: 3, name: "Steven Buchanan", image: "../../images/steven.png"},
                        {id: 4, name: "Nancy Davolio", image: "../../images/nancy.png"},
                        {id: 5, name: "Michael Buchanan", image: "../../images/Michael.png"},
                        {id: 6, name: "Margaret Buchanan", image: "../../images/margaret.png"},
                        {id: 7, name: "Robert Buchanan", image: "../../images/robert.png"},
                        {id: 8, name: "Laura Buchanan", image: "../../images/Laura.png"},
                        {id: 9, name: "Laura Buchanan", image: "../../images/Anne.png"}
                    ],
                    dataType: "array",
                    dataFields: [
                        {name: "id", type: "number"},
                        {name: "name", type: "string"},
                        {name: "image", type: "string"},
                        {name: "common", type: "boolean"}
                    ]
                };

                var resourcesDataAdapter = new $.jqx.dataAdapter(resourcesSource);
                return resourcesDataAdapter;
            }

            $('#kanban').jqxKanban({
                resources: resourcesAdapterFunc(),
                source: dataAdapter,
                // render items.
                itemRenderer: function (item, data, resource) {
                    $(item).find(".jqx-kanban-item-color-status").html("<span style='line-height: 23px; margin-left: 5px;'></span>");
                    $(item).find(".jqx-kanban-item-text").css('background', item.color);
                    item.on('dblclick', function (event) {
                        var input = $("<textarea placeholder='(No Title)' style='border: none; width: 100%;' class='jqx-input'></textarea>");
                        var addToHeader = false;
                        var header = null;
                        if (event.target.nodeName == "SPAN" && $(event.target).parent().hasClass('jqx-kanban-item-color-status')) {
                            var input = $("<input placeholder='(No Title)' style='border: none; background: transparent; width: 80%;' class='jqx-input'/>");
                            // add to header
                            header = event.target;
                            header.innerHTML = "";
                            input.val($(event.target).text());
                            $(header).append(input);
                            addToHeader = true;
                        }
                        if (!addToHeader) {
                            var textElement = item.find(".jqx-kanban-item-text");
                            input.val(textElement.text());
                            textElement[0].innerHTML = "";
                            textElement.append(input);
                        }

                        input.mousedown(function (event) {
                            event.stopPropagation();
                        });
                        input.mouseup(function (event) {
                            event.stopPropagation();
                        });

                        input.blur(function () {
                            var value = input.val();
                            if (!addToHeader) {
                                $("<span>" + value + "</span>").appendTo(textElement);
                            }
                            else {
                                header.innerHTML = value;
                            }
                            input.remove();
                        });
                        input.keydown(function (event) {
                            if (event.keyCode == 13) {
                                if (!header) {
                                    $("<span>" + $(event.target).val() + "</span>").insertBefore($(event.target));
                                    $(event.target).remove();
                                }
                                else {
                                    header.innerHTML = $(event.target).val();
                                }
                            }
                        });
                        input.focus();
                    });
                },
                width: '100%',
                height: '100%',
                columns: [
                    {text: "新建子任务", dataField: "new"},
                    {text: "正在执行", dataField: "doing"},
                    {text: "需要审核", dataField: "todo"},
                    {text: "通过审核", dataField: "done"}
                ]
            });
            //点击item事件
            $('#kanban').on('itemAttrClicked', function (event) {
                var args = event.args;
                var itemId = args.itemId;
                var attribute = args.attribute; // template, colorStatus, content, keyword, text, avatar
            });

        });
    </script>
</head>
<body>
<div id="kanban"></div>
</body>
</html>
