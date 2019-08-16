<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    var search_type_category = "none";
    var search_keyWord = "";
    var selectID;

    $(function () {
        addCategoryAction();
        categoryListInit();
        deleteCategoryAction();
        editCategorysAction();
        bootstrapValidatorInit();
    })


    // 分页查询参数
    function queryParams(params) {
        var temp = {
            limit : params.limit,
            offset : params.offset,
            keyWord : search_keyWord
        }
        return temp;
    }

    // 表格初始化
    function categoryListInit() {
        $('#categoryList')
            .bootstrapTable(
                {
                    columns : [
                        {
                            field : 'id',
                            title : '分类ID'
                            //sortable: true
                        },
                        {
                            field : 'name',
                            title : '分类名称'
                        },
                        {
                            field : 'operation',
                            title : '操作',
                            formatter : function(value, row, index) {
                                var s = '<button class="btn btn-info btn-sm edit"><span>编辑</span></button>';
                                var d = '<button class="btn btn-danger btn-sm delete"><span>删除</span></button>';
                                var fun = '';
                                return s + ' ' + d;
                            },
                            events : {
                                // 操作列中编辑按钮的动作
                                'click .edit' : function(e, value,
                                                         row, index) {
                                    selectID = row.id;
                                    rowEditOperation(row);
                                },
                                'click .delete' : function(e,
                                                           value, row, index) {
                                    selectID = row.id;
                                    $('#deleteWarning_modal').modal(
                                        'show');
                                }
                            }
                        } ],
                    url : 'categoryManage/getCategoryList',
                    method : 'GET',
                    queryParams : queryParams,
                    sidePagination : "server",
                    dataType : 'json',
                    pagination : true,
                    pageNumber : 1,
                    pageSize : 5,
                    pageList : [ 5, 10, 25, 50, 100 ],
                    clickToSelect : true
                });
    }

    // 表格刷新
    function tableRefresh() {
        $('#categoryList').bootstrapTable('refresh', {
            query : {}
        });
    }

    // 行编辑操作
    function rowEditOperation(row) {
        $('#edit_modal').modal("show");

        // load info
        $('#category_form_edit').bootstrapValidator("resetForm", true);
        $('#category_name_edit').val(row.name);
    }

    // 添加供应商模态框数据校验
    function bootstrapValidatorInit() {
        $("#category_form,#category_form_edit").bootstrapValidator({
            message : 'This is not valid',
            feedbackIcons : {
                valid : 'glyphicon glyphicon-ok',
                invalid : 'glyphicon glyphicon-remove',
                validating : 'glyphicon glyphicon-refresh'
            },
            excluded : [ ':disabled' ],
            fields : {
                category_name : {
                    validators : {
                        notEmpty : {
                            message : '货物类型不能为空'
                        }
                    }
                }
            }
        })
    }

    // 添加货物类型
    function addCategoryAction() {
        $('#add_category').click(function() {
            $('#add_modal').modal("show");
        });

        $('#add_modal_submit').click(function() {
            var data = {
                name : $('#category_name').val(),
            }
            // ajax
            $.ajax({
                type : "POST",
                url : "categoryManage/addCategory",
                dataType : "json",
                contentType : "application/json",
                data : JSON.stringify(data),
                success : function(response) {
                    $('#add_modal').modal("hide");
                    var msg;
                    var type;
                    if (response.result == "success") {
                        type = "success";
                        msg = "货物类型添加成功";
                    } else if (response.result == "error") {
                        type = "error";
                        msg = "货物类型添加失败";
                    }
                    infoModal(type, msg);
                    tableRefresh();

                    // reset
                    $('#category_name').val("");
                    $('#category_form').bootstrapValidator("resetForm", true);
                },
                error : function(response) {
                }
            })
        })
    }

    // 刪除货物类型
    function deleteCategoryAction(){
        $('#delete_confirm').click(function(){
            var data = {
                "id" : selectID
            }

            // ajax
            $.ajax({
                type : "GET",
                url : "categoryManage/deleteCategory",
                dataType : "json",
                contentType : "application/json",
                data : data,
                success : function(response){
                    $('#deleteWarning_modal').modal("hide");
                    var type;
                    var msg;
                    if(response.result == "success"){
                        type = "success";
                        msg = "货物类型删除成功";
                    }else{
                        type = "error";
                        msg = "货物类型删除失败";
                    }
                    infoModal(type, msg);
                    tableRefresh();
                },error : function(response){
                }
            })

            $('#deleteWarning_modal').modal('hide');
        })
    }

    // 编辑货物类型
    function editCategorysAction() {
        $('#edit_modal_submit').click(
            function() {
                $('#category_form_edit').data('bootstrapValidator')
                    .validate();
                if (!$('#category_form_edit').data('bootstrapValidator')
                        .isValid()) {
                    return;
                }

                var data = {
                    id : selectID,
                    name : $('#category_name_edit').val()
                }

                // ajax
                $.ajax({
                    type : "POST",
                    url : 'categoryManage/updateCategory',
                    dataType : "json",
                    contentType : "application/json",
                    data : JSON.stringify(data),
                    success : function(response) {
                        $('#edit_modal').modal("hide");
                        var type;
                        var msg;
                        if (response.result == "success") {
                            type = "success";
                            msg = "货物信息更新成功";
                        } else if (resposne == "error") {
                            type = "error";
                            msg = "货物信息更新失败"
                        }
                        infoModal(type, msg);
                        tableRefresh();
                    },
                    error : function(response) {
                    }
                });
            });
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
        <li>货物类型管理</li>
    </ol>
    <div class="panel-body">
        <div class="row">
            <div class="col-md-9 col-sm-9">
                <div>
                    <div class="col-md-3 col-sm-4">
                        <input id="search_input" type="text" class="form-control"
                               placeholder="类型ID">
                    </div>
                    <div class="col-md-2 col-sm-2">
                        <button id="search_button" class="btn btn-success">
                            <span class="glyphicon glyphicon-search"></span> <span>查询</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" style="margin-top: 25px">
            <div class="col-md-5">
                <button class="btn btn-sm btn-default" id="add_category">
                    <span class="glyphicon glyphicon-plus"></span> <span>添加货物类型</span>
                </button>
            </div>
            <div class="col-md-5"></div>
        </div>

        <div class="row" style="margin-top: 15px">
            <div class="col-md-12">
                <table id="categoryList" class="table table-striped"></table>
            </div>
        </div>
    </div>
</div>

<!-- 添加货物类型模态框 -->
<div id="add_modal" class="modal fade" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加货物类型</h4>
            </div>
            <div class="modal-body">
                <!-- 模态框的内容 -->
                <div class="row">
                    <div class="col-md-1 col-sm-1"></div>
                    <div class="col-md-8 col-sm-8">
                        <form class="form-horizontal" role="form" id="category_form"
                              style="margin-top: 25px">
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>类型名称：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <input type="text" class="form-control" id="category_name"
                                           name="category_name" placeholder="类型名称">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-1 col-sm-1"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">
                    <span>取消</span>
                </button>
                <button class="btn btn-success" type="button" id="add_modal_submit">
                    <span>提交</span>
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
                        <h3>是否确认删除该条货物类型</h3>
                        <p>(注意：若该货物类型下有货物,则无法删除该条货物类型)</p>
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

<!-- 编辑货物信息模态框 -->
<div id="edit_modal" class="modal fade" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">编辑货物类型</h4>
            </div>
            <div class="modal-body">
                <!-- 模态框的内容 -->
                <div class="row">
                    <div class="col-md-1 col-sm-1"></div>
                    <div class="col-md-8 col-sm-8">
                        <form class="form-horizontal" role="form" id="category_form_edit"
                              style="margin-top: 25px">
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>类型名称：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <input type="text" class="form-control" id="category_name_edit"
                                           name="category_name" placeholder="类型名称">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-1 col-sm-1"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">
                    <span>取消</span>
                </button>
                <button class="btn btn-success" type="button" id="edit_modal_submit">
                    <span>确认更改</span>
                </button>
            </div>
        </div>
    </div>
</div>
