//@ sourceURL=outputable.ht
/**
 * Created by d on 2017/5/9.
 * 任务输出表单js
 */
//@ sourceURL=outputable.js
var newRowID = null;
var count = 0;
function getWidth() {
    return $('#data').outerWidth();
}
function getHeight() {
    return $(window).height() - $('.nav-tabs').outerHeight(true) - 100;
}
// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function (from, to) {
    var rest = this.slice((to || from) + 1 || this.length);
    this.length = from < 0 ? this.length + from : from;
    return this.push.apply(this, rest);
};
//生成随机整数
function rd(n, m) {
    var c = m - n + 1;
    return Math.floor(Math.random() * c + n);
}
function arrayToJson(o) {
    var total = o.length;
    var tempJson = '{"total":' + total + ',' +
        '"rows":[' + o + ']}';
    // if (typeof o == "string") return "\"" + o.replace(/([\'\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\"";
    // if (typeof o == "object") {
    //     if (!o.sort) {
    //         for (var i in o)
    //             r.push(i + ":" + arrayToJson(o[i]));
    //         if (!!document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)) {
    //             r.push("toString:" + o.toString.toString());
    //         }
    //         r = "{" + r.join() + "}";
    //     } else {
    //         for (var i = 0; i < o.length; i++) {
    //             r.push(arrayToJson(o[i]));
    //         }
    //         r = "[" + r.join() + "]";
    //     }
    //     return r;
    // }
    return tempJson;
}
function outputTableInit(path) {
    var updateJson = new Array();

    // prepare the data
    var source =
        {
            dataType: "json",
            dataFields: [
                {name: "dataId", type: "number"},
                {name: "dataName", type: "string"},
                {name: "filePath", type: "string"},
                {name: "parentId", type: "number"},
                {name: "taskId", type: "number"},
                {name: "dataType", type: "string"},
                {name: "dataDescription", type: "string"},
                {name: "publishState", type: "string"},
                {name: "orderState", type: "string"},
                {name: "submitState", type: "string"},
                {name: "taskName", type: "string"},
                {name: "creator", type: "string"},
                {name: "createTime", type: "string"},
                {name: "projectId", type: "number"},
                {name: "creatorId", type: "number"},
                {name: "dataUnit", type: "string"},
                {name: "dataValue", type: "string"},
                {name: "data", type: "string"},
                {name: "dataValue", type: "string"},
                {name: "dataSenMax", type: "number"},
                {name: "dataSenMin", type: "number"}
            ],
            hierarchy: {
                keyDataField: {name: 'dataId'},
                parentDataField: {name: 'parentId'}
            },
            id: 'dataId',
            url: path,
            // url: 'showstructdata.ht',
            addRow: function (rowID, rowData, position, parentID, commit) {
                commit(true);
                newRowID = rowID;
            },
            updateRow: function (rowID, rowData, commit) {
                commit(true);
            },
            deleteRow: function (rowID, commit) {
                commit(true);
            }
        };
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadComplete: function () {
            // data is loaded.
        }
    });
    $("#treeGridOut").jqxTreeGrid({
        width: getWidth(),
        height: getHeight(),
        source: dataAdapter,
        pageable: true,
        showHeader: true,
        editable: true,
        editSettings: {
            saveOnPageChange: true,
            saveOnBlur: true,
            saveOnSelectionChange: true,
            cancelOnEsc: true,
            saveOnEnter: true,
            editSingleCell: true,
            editOnDoubleClick: true,
            editOnF2: true
        },
        showToolbar: true,
        altRows: true,
        hierarchicalCheckboxes: true,
        checkboxes: true,
        filterable: true,
        filterMode: 'advanced',
        theme: "office",
        ready: function () {
            // called when the DatatreeGrid is loaded.
            $("#treeGridOut").jqxTreeGrid('expandRow', '0');
            $("#treeGridOut").jqxTreeGrid('selectRow', '0');
            // focus jqxTreeGrid.
            $("#treeGridOut").jqxTreeGrid('focus');
        },
        pagerButtonsCount: 8,
        toolbarHeight: 35,
        renderToolbar: function (toolBar) {
            var toTheme = function (className) {
                // if (theme == "")
                return className;
                // return className + " " + className + "-" + theme;
            }
            // appends buttons to the status bar.
            var container = $("<div style='overflow: hidden; position: relative; height: 100%; width: 100%;'></div>");
            var buttonTemplate = "<div style='float: left; padding: 4px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
            var addButton = $(buttonTemplate);
            var editButton = $(buttonTemplate);
            var deleteButton = $(buttonTemplate);
            var cancelButton = $(buttonTemplate);
            var updateButton = $(buttonTemplate);

            container.append(addButton);
            container.append(editButton);
            container.append(deleteButton);
            container.append(cancelButton);
            container.append(updateButton);

            toolBar.append(container);

            addButton.jqxButton({
                cursor: "pointer",
                enableDefault: false,
                disabled: true,
                height: 30,
                width: 30
            });
            addButton.find('div:first').addClass(toTheme('glyphicon glyphicon-plus'));
            addButton.jqxTooltip({position: 'bottom', content: "添加数据"});
            editButton.jqxButton({
                cursor: "pointer",
                disabled: true,
                enableDefault: false,
                height: 30,
                width: 30
            });
            editButton.find('div:first').addClass(toTheme('glyphicon glyphicon-pencil'));
            editButton.jqxTooltip({position: 'bottom', content: "编辑行"});
            deleteButton.jqxButton({
                cursor: "pointer",
                disabled: true,
                enableDefault: false,
                height: 30,
                width: 30
            });
            deleteButton.find('div:first').addClass(toTheme('glyphicon glyphicon-trash'));
            deleteButton.jqxTooltip({position: 'bottom', content: "删除行"});
            updateButton.jqxButton({
                cursor: "pointer",
                disabled: true,
                enableDefault: false,
                height: 30,
                width: 30
            });
            updateButton.find('div:first').addClass(toTheme('glyphicon glyphicon-floppy-saved'));
            updateButton.jqxTooltip({position: 'bottom', content: "保存变更"});
            cancelButton.jqxButton({
                cursor: "pointer",
                disabled: true,
                enableDefault: false,
                height: 30,
                width: 30
            });
            cancelButton.find('div:first').addClass(toTheme('glyphicon glyphicon-remove'));
            cancelButton.jqxTooltip({position: 'bottom', content: "取消编辑"});
            var updateButtons = function (action) {
                switch (action) {
                    case "Select":
                        addButton.jqxButton({disabled: false});
                        deleteButton.jqxButton({disabled: false});
                        editButton.jqxButton({disabled: false});
                        cancelButton.jqxButton({disabled: true});
                        updateButton.jqxButton({disabled: false});
                        break;
                    case "Unselect":
                        addButton.jqxButton({disabled: false});
                        deleteButton.jqxButton({disabled: true});
                        editButton.jqxButton({disabled: true});
                        cancelButton.jqxButton({disabled: true});
                        updateButton.jqxButton({disabled: false});
                        break;
                    case "Edit":
                        addButton.jqxButton({disabled: false});
                        deleteButton.jqxButton({disabled: true});
                        editButton.jqxButton({disabled: true});
                        cancelButton.jqxButton({disabled: false});
                        updateButton.jqxButton({disabled: false});
                        break;
                    case "End Edit":
                        addButton.jqxButton({disabled: false});
                        deleteButton.jqxButton({disabled: false});
                        editButton.jqxButton({disabled: false});
                        cancelButton.jqxButton({disabled: true});
                        updateButton.jqxButton({disabled: false});
                        break;
                }
            }
            var rowKey = null;
            var rowParentId = 0;
            var dataIdtemp = 0;
            // var rowDataForParentId = 0;
            $("#treeGridOut").on('rowSelect', function (event) {
                var args = event.args;
                rowKey = args.key;
                if (rowKey != "0") {
                    // var rowDataForParentId = args.row;
                    rowParentId = rowKey;
                }
                updateButtons('Select');
            });
            $("#treeGridOut").on('rowUnselect', function (event) {
                updateButtons('Unselect');
            });
            $("#treeGridOut").on('rowEndEdit', function (event) {
                updateButtons('End Edit');
            });
            $("#treeGridOut").on('rowBeginEdit', function (event) {
                updateButtons('Edit');
            });
            addButton.click(function (event) {
                if (!addButton.jqxButton('disabled')) {
                    //TODO:判断不完全
                    if (rowKey != null & rowKey != "0") {
                        $("#treeGridOut").jqxTreeGrid('expandRow', rowKey);
                        // add new empty row.
                        $("#treeGridOut").jqxTreeGrid('addRow', null, {
                            dataId: rd(1, 999999),
                            dataName: "未定义子数据名称",
                            dataSenMax: 10000,
                            dataSenMin: 0,
                            publishState: "未发布",
                            parentId: rowParentId
                        }, 'first', rowKey);
                    } else {
                        $("#treeGridOut").jqxTreeGrid('addRow', null, {
                            dataId: rd(1, 999999),
                            dataName: "未定义数据名称",
                            dataSenMax: 10000,
                            dataSenMin: 0,
                            publishState: "未发布",
                            parentId: rowParentId
                        }, 'first');
                    }

                    // select the first row and clear the selection.
                    $("#treeGridOut").jqxTreeGrid('clearSelection');
                    $("#treeGridOut").jqxTreeGrid('selectRow', newRowID);
                    // edit the new row.
                    $("#treeGridOut").jqxTreeGrid('beginRowEdit', newRowID);
                    updateButtons('add');
                }
            });
            cancelButton.click(function (event) {
                if (!cancelButton.jqxButton('disabled')) {
                    // cancel changes.
                    $("#treeGridOut").jqxTreeGrid('endRowEdit', rowKey, true);
                }
            });
            updateButton.click(function (event) {
                if (!updateButton.jqxButton('disabled')) {
                    // save changes.
                    $("#treeGridOut").jqxTreeGrid('endRowEdit', rowKey, false);
                    var orderJson = arrayToJson(updateJson)
                    //TODO:添加是否确认提交的判断
                    $.ajax({
                        //json数组
                        type: 'POST',
                        url: "updatePrivateData.ht",
                        data: "orderJson=" + orderJson,
                        ContentType: "application/json; charset=utf-8",
                        success: function (data) {
                        }
                    });
                }
            });
            editButton.click(function () {
                if (!editButton.jqxButton('disabled')) {
                    $("#treeGridOut").jqxTreeGrid('beginRowEdit', rowKey);
                    updateButtons('edit');
                }
            });
            deleteButton.click(function () {
                if (!deleteButton.jqxButton('disabled')) {
                    var selection = $("#treeGridOut").jqxTreeGrid('getSelection');
                    if (selection.length > 1) {
                        var keys = new Array();
                        for (var i = 0; i < selection.length; i++) {
                            keys.push($("#treeGridOut").jqxTreeGrid('getKey', selection[i]));
                        }
                        $("#treeGridOut").jqxTreeGrid('deleteRow', keys);
                    }
                    else {
                        $("#treeGridOut").jqxTreeGrid('deleteRow', rowKey);
                        for (var i = 0; i < updateJson.length; i++) {
                            var tempJson = $.parseJSON(updateJson[i]);

                            if (selection[0].dataId == tempJson.dataId) {
                                var num = updateJson.splice(i, 1);   //从i位置开始删除
                                i = i - 1;    //改变循环变量
                            }
                        }
                        if (selection.dataId>=999999) updateJson.push('{"dataId":' + selection.dataId + ',"isDelete":1}');
                    }
                    updateButtons('delete');
                }
            });
        },
        // 数据表加载完事执行
        rendered: function () {
            if ($(".editButtons").length > 0) {
                $(".cancelButtons").jqxButton();
                $(".editButtons").jqxButton();

                var editClick = function (event) {
                    var target = $(event.target);
                    // get button's value.
                    var value = target.val();
                    // get clicked row.
                    var rowKey = event.target.getAttribute('data-row');
                    if (value == "Edit") {
                        // begin edit.
                        $("#treeGridOut").jqxTreeGrid('beginRowEdit', rowKey);
                        target.parent().find('.cancelButtons').show();
                        target.val("Save");
                    }
                    else {
                        // end edit and save changes.
                        target.parent().find('.cancelButtons').hide();
                        target.val("Edit");
                        $("#treeGridOut").jqxTreeGrid('endRowEdit', rowKey);
                    }
                }
                $(".editButtons").on('click', function (event) {
                    editClick(event);
                });

                $(".cancelButtons").click(function (event) {
                    // end edit and cancel changes.
                    var rowKey = event.target.getAttribute('data-row');
                    $("#treeGridOut").jqxTreeGrid('endRowEdit', rowKey, true);
                });
            }
        },
        columns: [
            {text: '名称', dataField: "dataName", align: 'left', width: '20%', pinned: true},
            {
                text: '类型', dataField: "dataType", align: 'left', width: '5%', columnType: "template",
                createEditor: function (row, cellvalue, editor, cellText, width, height) {
                    // construct the editor.
                    var source = ["结构型数据", "数值", "文件", "模型"];
                    editor.jqxDropDownList({
                        autoDropDownHeight: true,
                        source: source,
                        width: '100%',
                        height: '100%'
                    });
                },
                initEditor: function (row, cellvalue, editor, celltext, width, height) {
                    // set the editor's current value. The callback is called each time the editor is displayed.
                    editor.jqxDropDownList('selectItem', cellvalue);
                },
                getEditorValue: function (row, cellvalue, editor) {
                    // return the editor's value.
                    return editor.val();
                }
            },
            {text: '最新值', dataField: "dataValue", align: 'left', width: '25%'},
            {
                text: '单位', dataField: "dataUnit", align: 'left', width: '10%', columnType: "template",
                createEditor: function (row, cellvalue, editor, cellText, width, height) {
                    // construct the editor.
                    var source = ["Km/s", "m/s", "s", "km", "m", "kg", "mm", "N", "mm*mm", "μm", "°", "mm*mm", "°/s", "°/h", "Hz", "g", "ppm", "ms", "mm*mm*mm"];
                    editor.jqxDropDownList({
                        autoDropDownHeight: true,
                        source: source,
                        width: '100%',
                        height: '100%'
                    });
                },
                initEditor: function (row, cellvalue, editor, celltext, width, height) {
                    // set the editor's current value. The callback is called each time the editor is displayed.
                    editor.jqxDropDownList('selectItem', cellvalue);
                },
                getEditorValue: function (row, cellvalue, editor) {
                    // return the editor's value.
                    return editor.val();
                }
            },
            {text: '最小值', dataField: "dataSenMin", align: 'left', width: '10%'},
            {text: '最大值', dataField: "dataSenMax", align: 'left', width: '10%'},
            {text: '发布状态', dataField: "publishState", align: ' center', width: '10%'},
            {
                width: '10%',
                text: '发布',
                cellsAlign: 'center',
                align: "center",
                columnType: 'none',
                editable: false,
                sortable: false,
                dataField: null,
                cellsRenderer: function (row, column, value) {
                    // render custom column.
                    return "<button data-row='" + row + "' class='editButtons'>发布</button><button style='display: none; margin-left: 5px;' data-row='" + row + "' class='cancelButtons'>Cancel</button>";
                }
            }
        ]
    });
    $("#excelExport").jqxButton();
    $("#xmlExport").jqxButton();
    $("#csvExport").jqxButton();
    // $("#tsvExport").jqxButton();
    // $("#htmlExport").jqxButton();
    $("#jsonExport").jqxButton();
    $("#pdfExport").jqxButton();
    $("#excelExport").click(function () {
        $("#treeGridOut").jqxTreeGrid('exportData', 'xls');
    });
    $("#xmlExport").click(function () {
        $("#treeGridOut").jqxTreeGrid('exportData', 'xml');
    });
    $("#csvExport").click(function () {
        $("#treeGridOut").jqxTreeGrid('exportData', 'csv');
    });
    // $("#tsvExport").click(function () {
    //     $("#treeGridOut").jqxTreeGrid('exportData', 'tsv');
    // });
    // $("#htmlExport").click(function () {
    //     $("#treeGridOut").jqxTreeGrid('exportData', 'html');
    // });
    $("#jsonExport").click(function () {
        $("#treeGridOut").jqxTreeGrid('exportData', 'json');
    });
    $("#pdfExport").click(function () {
        $("#treeGridOut").jqxTreeGrid('exportData', 'pdf');
    });

    // 结束编辑触发事件
    $("#treeGridOut").on('cellEndEdit', function (event) {
        var args = event.args;
        // 行键值
        var rowKey = args.key;
        // 行数据
        var rowData = args.row;
        // 列数据域
        var columnDataField = args.dataField;
        // 列显示域
        var columnDisplayField = args.displayField;
        // 当前值
        var value = args.value;
        // if (columnDataField == "ShippedDate")
        //     value = dataAdapter.formatDate(value, 'dd/MM/yyyy');

        for (var i = 0; i < updateJson.length; i++) {
            var tempJson = $.parseJSON(updateJson[i]);
            if (rowData.dataId == tempJson.dataId) {
                var num = updateJson.splice(i, 1);   //从i位置开始删除
                i = i - 1;    //改变循环变量
            }
        }
        // if (rowData.dataId == 0 || rowData.dataId == "0") {
        //     rowData.dataId = rd(1, 999999)
        // }
        updateJson.push('{"dataId":' + rowData.dataId + ',' +
            '"dataName":"' + rowData.dataName + '",' +
            '"filePath":"' + rowData.filePath + '",' +
            '"dataType":"' + rowData.dataType + '",' +
            '"dataDescription":"' + rowData.dataDescription + '",' +
            '"dataUnit":"' + rowData.dataUnit + '",' +
            '"dataValue":"' + rowData.dataValue + '",' +
            '"parentId":"' + rowData.parentId + '",' +
            '"dataSenMin":"' + rowData.dataSenMin + '",' +
            '"dataSenMin":"' + rowData.dataSenMax + '"}');


    });
}