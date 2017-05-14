/**
 * Created by d on 2017/5/9.
 * 任务输出表单js
 */
var newRowID = null;
function getWidth() {
    return $('.container').outerWidth();
}
function getHeight() {
    return $(window).height() - $('.nav-tabs').outerHeight(true) - 80;
}
function inputTableInit(path) {
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
                {name: "dataValue", type: "string"}
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
    $("#treeGridIn").jqxTreeGrid(
        {
            width: getWidth(),
            height: getHeight(),
            source: dataAdapter,
            pageable: true,
            editable: true,
            showToolbar: true,
            altRows: true,
            hierarchicalCheckboxes: true,
            checkboxes: true,
            filterable: true,
            filterMode: 'advanced',
            theme: "darkblue",
            ready: function () {
                // called when the DatatreeGrid is loaded.
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
                var buttonTemplate = "<div style='float: left; padding: 3px; margin: 2px;'><div style='margin: 4px; width: 16px; height: 16px;'></div></div>";
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
                    height: 25,
                    width: 25
                });
                addButton.find('div:first').addClass(toTheme('jqx-icon-plus'));
                addButton.jqxTooltip({position: 'bottom', content: "Add"});
                editButton.jqxButton({
                    cursor: "pointer",
                    disabled: true,
                    enableDefault: false,
                    height: 25,
                    width: 25
                });
                editButton.find('div:first').addClass(toTheme('jqx-icon-edit'));
                editButton.jqxTooltip({position: 'bottom', content: "Edit"});
                deleteButton.jqxButton({
                    cursor: "pointer",
                    disabled: true,
                    enableDefault: false,
                    height: 25,
                    width: 25
                });
                deleteButton.find('div:first').addClass(toTheme('jqx-icon-delete'));
                deleteButton.jqxTooltip({position: 'bottom', content: "Delete"});
                updateButton.jqxButton({
                    cursor: "pointer",
                    disabled: true,
                    enableDefault: false,
                    height: 25,
                    width: 25
                });
                updateButton.find('div:first').addClass(toTheme('jqx-icon-save'));
                updateButton.jqxTooltip({position: 'bottom', content: "Save Changes"});
                cancelButton.jqxButton({
                    cursor: "pointer",
                    disabled: true,
                    enableDefault: false,
                    height: 25,
                    width: 25
                });
                cancelButton.find('div:first').addClass(toTheme('jqx-icon-cancel'));
                cancelButton.jqxTooltip({position: 'bottom', content: "Cancel"});
                var updateButtons = function (action) {
                    switch (action) {
                        case "Select":
                            addButton.jqxButton({disabled: false});
                            deleteButton.jqxButton({disabled: false});
                            editButton.jqxButton({disabled: false});
                            cancelButton.jqxButton({disabled: true});
                            updateButton.jqxButton({disabled: true});
                            break;
                        case "Unselect":
                            addButton.jqxButton({disabled: true});
                            deleteButton.jqxButton({disabled: true});
                            editButton.jqxButton({disabled: true});
                            cancelButton.jqxButton({disabled: true});
                            updateButton.jqxButton({disabled: true});
                            break;
                        case "Edit":
                            addButton.jqxButton({disabled: true});
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
                            updateButton.jqxButton({disabled: true});
                            break;
                    }
                }
                var rowKey = null;
                $("#treeGridOut").on('rowSelect', function (event) {
                    var args = event.args;
                    rowKey = args.key;
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
                        $("#treeGridOut").jqxTreeGrid('expandRow', rowKey);
                        // add new empty row.
                        $("#treeGridOut").jqxTreeGrid('addRow', null, {}, 'first', rowKey);
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
                        }
                        updateButtons('delete');
                    }
                });
            },
            columns: [
                {text: '名称', dataField: "dataName", align: 'left', width: '25%'},
                {text: '类型', dataField: "dataType", align: 'left', width: '10%'},
                {text: '最新值', dataField: "dataValue", align: 'left', width: '30%'},
                {text: '单位', dataField: "dataUnit", align: 'left', width: '10%'},
                {text: '订阅状态', dataField: "orderState", align: 'left', width: '20%'}
            ]
        });
}