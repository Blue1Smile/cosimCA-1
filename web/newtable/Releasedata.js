/**
 * Created by 忠 on 2017/2/17.
 */

$(function () {

    //1.初始化Table
    new TableInit();
    // oTable.Init();

    // //2.初始化Button的点击事件
    new ButtonInit();
    // oButtonInit.Init();

});


function TableInit () {
    // var oTableInit = new Object();
    //初始化Table

    $('#tb_department').bootstrapTable({
        // url: 'showtools.ht?major=<%=new String(request.getParameter("major").getBytes("ISO-8859-1"),"UTF-8")%>',         //请求后台的URL（*）
        // url: 'showtools.ht',
        //   method: 'get',
        //   detailView: true,//父子表
        //   //sidePagination: "server",
        //   pageSize: 10,
        //   pageList: [10, 25],
        method: 'get',                      //请求方式（*）
        toolbar: '#toolbar',                //工具按钮用哪个容器
        striped: true,                      //是否显示行间隔色
        cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
        pagination: true,                   //是否显示分页（*）
        sortable: true,                     //是否启用排序
        sortOrder: "asc",                   //排序方式
        sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
        pageNumber:1,                       //初始化加载第一页，默认第一页
        pageSize: 5,                       //每页的记录行数（*）
        pageList: [5,10,20,50],        //可供选择的每页的行数（*）
        queryParamsType:'',
        // queryParams:queryParams,
        // pageList: [5,10,20,50],        //可供选择的每页的行数（*）
        // search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
        // strictSearch: false,
        showColumns: false,                  //是否显示所有的列
        showRefresh: false,                  //是否显示刷新按钮
        minimumCountColumns: 2,             //最少允许的列数
        clickToSelect: false,                //是否启用点击选中行
        height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
        uniqueId: "DdDataId",                     //每一行的唯一标识，一般为主键列
        showToggle:false,                    //是否显示详细视图和列表视图的切换按钮
        cardView: false,                    //是否显示详细视图
        detailView: true,                   //是否显示父子表
        columns: [
            {//第一列，数据名称
                field: 'DdDataName',
                title: '数据名称',
                sortable: true,
                editable: false,
                align: 'center',
                visible: true
            }, {//第二列，最新值
                field: 'DdDataLastestValue',
                title: '最新值',
                sortable: true,
                editable: false,
                // footerFormatter: ddDataNameFormatter,
                align: 'center',
                visible: true
            }, {//第三列
                field: 'DdDataType',
                title: '数据类型',
                sortable: true,
                editable: false,
                // footerFormatter: ddDataNameFormatter,
                align: 'center',
                visible: true
            }, {//第四列
                field: 'DdDataCreateTime',
                title: '更新时间',
                sortable: true,
                editable: false,
                // footerFormatter: ddDataNameFormatter,
                align: 'center',
                visible: true
            }, {//第五列，
                field: 'DdDataDescription',
                title: '描述',
                sortable: true,
                editable: false,
                // footerFormatter: ddDataNameFormatter,
                align: 'center',
                visible: true
            },
            {//第六列，
                field: 'DdDataId',
                title: '数据ID',
                sortable: true,
                editable: false,
                // footerFormatter: ddDataNameFormatter,
                align: 'center',
                visible: false
            },
        ], onExpandRow: function (index, row, $detail) {
            InitSubTable(index, row, $detail);
        },
        // queryParams: function(params) {
        //     var name = $('#ddToolName').val();
        //     return {
        //         pageNumber: params.offset+1,
        //         pageSize: params.limit,
        //         // name:name
        //     };
        // },

    });


    // <display:column property="ddToolName" title="工具名称" sortable="true" maxLength="80"></display:column>
    // <display:column property="ddToolUrl" title="工具地址" sortable="true" maxLength="80"></display:column>
    // <display:column property="ddToolMajor" title="工具专业" sortable="true" maxLength="80"></display:column>
    // <display:column property="ddToolStutus" title="工具状态" sortable="true" maxLength="80"></display:column>
    // <display:column property="ddToolVersion" title="工具版本" sortable="true" maxLength="80"></display:column>
    // <display:column property="ddToolUser" title="上传者" sortable="true" maxLength="80"></display:column>
    // <display:column property="ddToolData" title="上传日期" sortable="true" maxLength="80"></display:column>
    //初始化子表格(无线循环)
    function InitSubTable(index, row, $detail) {
        var parentid = row.DdDataId;
        var cur_table = $detail.html('<table></table>').find('table');
        $(cur_table).bootstrapTable({
            url: 'dataversion.ht?id='+row.DdDataId,
            method: 'get',
            queryParams: { strParentID: parentid },
            ajaxOptions: { strParentID: parentid },
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            // pagination: true,                   //是否显示分页（*）
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            clickToSelect: true,
            detailView: false,//父子表
            uniqueId: "MENU_ID",
            pageSize: 10,
            pageList: [5,10,20,50],
            columns:[ {//第一列，数据名称
                field: 'DdDataVersion',
                title: '版本',
                sortable: true,
                editable: false,
                align: 'center',
                visible: true
            }, {//第二列，数据值
                field: 'ddDataValue',
                title: '数据值',
                sortable: true,
                editable: false,
                // footerFormatter: ddDataNameFormatter,
                align: 'center',
                visible: true
            }, {//第三列
                field: 'ddDataRecordTime',
                title: '更新时间',
                sortable: true,
                editable: false,
                // footerFormatter: ddDataNameFormatter,
                align: 'center',
                visible: true
            },
                {   field: 'operate',
                    title: '操作',
                    align: 'center',
                    events: operateEvents,
                    formatter: operateFormatter(),
                    visible: true
                },
            ],
            //无线循环取子表，直到子表里面没有记录
            onExpandRow: function (index, row, $Subdetail) {
                InitSubTable(index, row, $Subdetail);
            },


        });
    };

    // 得到查询的参数
    function queryParams(params) {
        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
            limit: params.limit,   //页面大小
            offset: params.offset,  //页码
            departmentname: $("#txt_search_departmentname").val(),
            statu: $("#txt_search_statu").val(),
            search:params.search
        };
    };

};
//注册加载子表的事件。注意下这里的三个参数！
//原始操作按钮
function operateFormatter(value, row, index) {
    return [
        '<a id="removetr" class="remove" href="javascript:void(0)" title="删除">',
        '<i class="glyphicon glyphicon-remove"></i>',
        '</a>',
        '<a id="download0" class="download" href="javascript:void(0)" title="下载">',
        '<i class="glyphicon glyphicon-download-alt"></i>',
        '</a>'
    ].join('');
}
window.operateEvents = {
    'click .remove': function (e, value, row, index) {
        // $table.bootstrapTable('remove', {
        //     field: 'ddIndexId',
        //     values: [row.ddIndexId],
        // });
        // alert(row.ToolID);
        $.get('remove.ht?id=' + row.ToolID);
        $("#tb_departments").bootstrapTable("refresh");
        // window.location.href="remove.ht?id=" + 1;
    }
    ,

    'click .download': function (e, value, row, index) {
        alert(row.DdDataType);
        if (row.DdDataType == "模型"||row.DdDataType == "文件" ){
            window.location.href="gettool.ht?major="+row.ToolUrl+"&name="+row.ToolName;
        }

    }

};

var ButtonInit = function ButtonInit () {
    var oInit = new Object();
    var postdata = {};

    oInit.Init = function () {
        //初始化页面上面的按钮事件

    };

    return oInit;
};