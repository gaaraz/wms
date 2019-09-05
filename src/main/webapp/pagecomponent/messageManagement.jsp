<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<style>
    .unread{
        font-weight: 600;
        color: steelblue;
    }
</style>
<script>
    var selectID = null;

    $(function() {
        shelvesListInit();
        deleteGoodsAction();
    })

    // 表格初始化
    function shelvesListInit() {
        $('#msgList')
            .bootstrapTable(
                {
                    columns : [
                        {
                            field : 'id',
                            title : '编号'
                        },
                        {
                            field : 'title',
                            title : '标题'
                        },
                        {
                            field : 'content',
                            title : '内容'
                        },
                        {
                            field : 'status',
                            title : '状态',
                            formatter : function(value, row, index) {
                                if(row.status == 1){
                                    return '已读';
                                }else{
                                    return '未读';
                                }
                            }
                        },
                        {
                            field : 'timeStr',
                            title : '时间'
                        },
                        {
                            field : 'operation',
                            title : '操作',
                            formatter : function(value, row, index) {
                                console.log(row);
                                console.log(value);
                                var s = '<button class="btn btn-info btn-sm edit"><span>标记已读</span></button>';
                                var d = '<button class="btn btn-danger btn-sm delete"><span>删除</span></button>';
                                var fun;
                                if(row.status == 0){
                                    fun = s + ' ' + d;
                                }else{
                                    fun = d;
                                }
                                return fun;
                            },
                            events : {
                                // 操作列中编辑按钮的动作
                                'click .edit' : function(e, value,row, index) {
                                    selectID = row.id;
                                    rowEditOperation(row);
                                },
                                'click .delete' : function(e,value, row, index) {
                                    selectID = row.id;
                                    $('#deleteWarning_modal')
                                        .modal('show');
                                }
                            }
                        } ],
                    url : 'messageManage/list',
                    method : 'GET',
                    queryParams : queryParams,
                    sidePagination : "server",
                    dataType : 'json',
                    pagination : true,
                    pageNumber : 1,
                    pageSize : 5,
                    pageList : [ 5, 10, 25, 50, 100 ],
                    clickToSelect : true,
                    rowStyle:function (row, index) {
                        if (row.status == 0){
                            return {
                                classes:'unread'
                            }
                        }else{
                            return '';
                        }
                    }
                });
    }

    // 分页查询参数
    function queryParams(params) {
        var temp = {
            limit : params.limit,
            offset : params.offset
        }
        return temp;
    }

    // 表格刷新
    function tableRefresh() {
        $('#msgList').bootstrapTable('refresh', {
            query : {}
        });
    }

    function rowEditOperation(row) {
        data = {
            id : row.id,
        }

        $.ajax({
            type : 'POST',
            url : 'messageManage/update',
            dataType : 'json',
            content : 'application/json',
            data : data,
            success : function(response){
                tableRefresh();
            },
            error : function(response){
            }
        })
    }

    function deleteGoodsAction(){
        $('#delete_confirm').click(function(){
            data = {
                id : selectID,
            }

            $.ajax({
                type : 'POST',
                url : 'messageManage/delete',
                dataType : 'json',
                content : 'application/json',
                data : data,
                success : function(response){
                    $('#deleteWarning_modal').modal("hide");
                    var type;
                    var msg;
                    if(response.result == "success"){
                        type = "success";
                        msg = "消息删除成功";
                    }else{
                        type = "error";
                        msg = "消息删除失败";
                    }
                    infoModal(type, msg);
                    tableRefresh();
                },
                error : function(response){
                }
            })
        })
    }

    // 操作结果提示模态框
    function infoModal(type, msg) {
        $('#info_success').removeClass("hide");
        $('#info_error').removeClass("hide");
        if (type == "success") {
            $('#info_error').addClass("hide");
        } else if (type == "error") {
            $('#info_success').addClass("hide");
        }
        $('#info_content').text(msg);
        $('#info_modal').modal("show");
    }
</script>
<div class="panel panel-default">
    <ol class="breadcrumb">
        <li>消息提醒</li>
    </ol>
    <div class="panel-body">
        <div class="row" style="margin-top: 15px">
            <div class="col-md-12">
                <table id="msgList" class="table table-striped"></table>
            </div>
        </div>
    </div>
</div>

<!-- 删除提示模态框 -->
<div class="modal fade" id="deleteWarning_modal" table-index="-1"
     role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">警告</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-3 col-sm-3" style="text-align: center;">
                        <img src="media/icons/warning-icon.png" alt=""
                             style="width: 70px; height: 70px; margin-top: 20px;">
                    </div>
                    <div class="col-md-8 col-sm-8">
                        <h3>是否确认删除消息</h3>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">
                    <span>取消</span>
                </button>
                <button class="btn btn-danger" type="button" id="delete_confirm">
                    <span>确认删除</span>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 提示消息模态框 -->
<div class="modal fade" id="info_modal" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">信息</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-4 col-sm-4"></div>
                    <div class="col-md-4 col-sm-4">
                        <div id="info_success" class=" hide" style="text-align: center;">
                            <img src="media/icons/success-icon.png" alt=""
                                 style="width: 100px; height: 100px;">
                        </div>
                        <div id="info_error" style="text-align: center;">
                            <img src="media/icons/error-icon.png" alt=""
                                 style="width: 100px; height: 100px;">
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-4"></div>
                </div>
                <div class="row" style="margin-top: 10px">
                    <div class="col-md-4 col-sm-4"></div>
                    <div class="col-md-4 col-sm-4" style="text-align: center;">
                        <h4 id="info_content"></h4>
                    </div>
                    <div class="col-md-4 col-sm-4"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">
                    <span>&nbsp;&nbsp;&nbsp;关闭&nbsp;&nbsp;&nbsp;</span>
                </button>
            </div>
        </div>
    </div>
</div>