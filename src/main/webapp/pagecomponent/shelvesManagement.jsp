<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    var search_type_shelves = "none";
    var search_keyWord = "";
    var selectID;

    $(function() {
        optionAction();
        searchAction();
        shelvesListInit();
        bootstrapValidatorInit();

        repositorySelectorInit();
        goodsSelectorInit();
        addShelvesAction();
        editShelvesAction();
        deleteShelvesAction();

        exportShelvesAction();
    })

    // 下拉框選擇動作
    function optionAction() {
        $(".dropOption").click(function() {
            var type = $(this).text();
            $("#search_input").val("");
            if (type == "所有") {
                $("#search_input").attr("readOnly", "true");
                search_type_shelves = "searchAll";
            } else if (type == "货架名称") {
                $("#search_input").removeAttr("readOnly");
                search_type_shelves = "searchByName";
            } else if (type == "仓库ID") {
                $("#search_input").removeAttr("readOnly");
                search_type_shelves = "searchByRepos";
            } else {
                $("#search_input").removeAttr("readOnly");
            }

            $("#search_type").text(type);
            $("#search_input").attr("placeholder", type);
        })
    }

    // 搜索动作
    function searchAction() {
        $('#search_button').click(function() {
            search_keyWord = $('#search_input').val();
            tableRefresh();
        })
    }

    // 分页查询参数
    function queryParams(params) {
        var temp = {
            limit : params.limit,
            offset : params.offset,
            searchType : search_type_shelves,
            keyWord : search_keyWord
        }
        return temp;
    }

    // 表格初始化
    function shelvesListInit() {
        $('#shelvesList')
            .bootstrapTable(
                {
                    columns : [
                        {
                            field : 'id',
                            title : '货架ID'
                        },
                        {
                            field : 'name',
                            title : '货架名称'
                        },
                        {
                            field : 'repoName',
                            title : '所在仓库'
                        },
                        {
                            field : 'goodNames',
                            title : '支持存放的货物'
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
                                    $('#deleteWarning_modal')
                                        .modal('show');
                                }
                            }
                        } ],
                    url : 'shelvesManage/list',
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
        $('#shelvesList').bootstrapTable('refresh', {
            query : {}
        });
    }

    // 行编辑操作
    function rowEditOperation(row) {
        $('#edit_modal').modal("show");
        // load info
        $('#shelves_form_edit').bootstrapValidator("resetForm", true);
        $('#shelves_name_edit').val(row.name);
        $('#repo_id_edit').val(row.repoId);
        $('#good_ids_edit').val(row.goodIds.split(','))
    }

    // 添加仓库模态框数据校验
    function bootstrapValidatorInit() {
        $("#shelves_form,#shelves_form_edit").bootstrapValidator({
            message : 'This is not valid',
            feedbackIcons : {
                valid : 'glyphicon glyphicon-ok',
                invalid : 'glyphicon glyphicon-remove',
                validating : 'glyphicon glyphicon-refresh'
            },
            excluded : [ ':disabled' ],
            fields : {
                shelves_name : {
                    validators : {
                        notEmpty : {
                            message : '货架名称不能为空'
                        }
                    }
                },
                repo_id : {
                    validators : {
                        notEmpty : {
                            message : '所在仓库不能为空'
                        }
                    }
                },
                good_ids : {
                    validators : {
                        notEmpty : {
                            message : '可存放的货物不能为空'
                        }
                    }
                }
            }
        })
    }

    // 仓库下拉列表初始化
    function repositorySelectorInit(){
        $.ajax({
            type : 'GET',
            url : 'repositoryManage/getRepositoryList',
            dataType : 'json',
            contentType : 'application/json',
            data : {
                searchType : 'searchAll',
                keyWord : '',
                offset : -1,
                limit : -1
            },
            success : function(response){
                $.each(response.rows,function(index,elem){
                    $('#repo_id').append("<option value='" + elem.id + "'>" + elem.name +"</option>");
                    $('#repo_id_edit').append("<option value='" + elem.id + "'>" + elem.name +"</option>");
                });
            },
            error : function(response){
                $('#repo_id').append("<option value='-1'>加载失败</option>");
                $('#repo_id_edit').append("<option value='-1'>加载失败</option>");
            }

        })
    }

    // 货物多选列表初始化
    function goodsSelectorInit(){
        $.ajax({
            type : 'GET',
            url : 'goodsManage/getGoodsList',
            dataType : 'json',
            contentType : 'application/json',
            data : {
                searchType : 'searchAll',
                keyWord : '',
                offset : -1,
                limit : -1
            },
            success : function(response){
                $.each(response.rows,function(index,elem){
                    $('#good_ids').append("<option value='" + elem.id + "'>" + elem.name +"</option>");
                    $('#good_ids_edit').append("<option value='" + elem.id + "'>" + elem.name +"</option>");
                });
            },
            error : function(response){
                $('#good_ids').append("<option value='-1'>加载失败</option>");
                $('#good_ids_edit').append("<option value='-1'>加载失败</option>");
            }

        })
    }

    // 编辑货架信息
    function editShelvesAction() {
        $('#edit_modal_submit').click(
            function() {
                $('#shelves_form_edit').data('bootstrapValidator')
                    .validate();
                if (!$('#shelves_form_edit').data('bootstrapValidator')
                        .isValid()) {
                    return;
                }

                var data = {
                    id : selectID,
                    name : $('#shelves_name_edit').val(),
                    repoId : $('#repo_id_edit').val(),
                    goodIds : $('#good_ids_edit').val().toString()
                }

                // ajax
                $.ajax({
                    type : "POST",
                    url : 'shelvesManage/update',
                    dataType : "json",
                    contentType : "application/json",
                    data : JSON.stringify(data),
                    success : function(response) {
                        $('#edit_modal').modal("hide");
                        var type;
                        var msg;
                        if (response.result == "success") {
                            type = "success";
                            msg = "货架信息更新成功";
                        } else if (resposne == "error") {
                            type = "error";
                            msg = "货架信息更新失败"
                        }
                        infoModal(type, msg);
                        tableRefresh();
                    },
                    error : function(response) {
                    }
                });
            });
    }

    // 刪除货架信息
    function deleteShelvesAction() {
        $('#delete_confirm').click(function() {
            var data = {
                "id" : selectID
            }

            // ajax
            $.ajax({
                type : "GET",
                url : "shelvesManage/delete",
                dataType : "json",
                contentType : "application/json",
                data : data,
                success : function(response) {
                    $('#deleteWarning_modal').modal("hide");
                    var type;
                    var msg;
                    if (response.result == "success") {
                        type = "success";
                        msg = "货架信息删除成功";
                    } else {
                        type = "error";
                        msg = "货架信息删除失败";
                    }
                    infoModal(type, msg);
                    tableRefresh();
                },
                error : function(response) {
                }
            })

            $('#deleteWarning_modal').modal('hide');
        })
    }

    // 添加货架信息
    function addShelvesAction() {
        $('#add_shelves').click(function() {
            $('#add_modal').modal("show");
        });

        $('#add_modal_submit').click(function() {
            var data = {
                name : $('#shelves_name').val(),
                repoId : $('#repo_id').val(),
                goodIds : $('#good_ids').val().toString()
            }
            // ajax
            $.ajax({
                type : "POST",
                url : "shelvesManage/add",
                dataType : "json",
                contentType : "application/json",
                data : JSON.stringify(data),
                success : function(response) {
                    $('#add_modal').modal("hide");
                    var msg;
                    var type;
                    if (response.result == "success") {
                        type = "success";
                        msg = "货架添加成功";
                    } else if (response.result == "error") {
                        type = "error";
                        msg = "货架添加失败";
                    }
                    infoModal(type, msg);
                    tableRefresh();

                    // reset
                    $('#shelves_name').val("");
                    $('#repo_id').val("");
                    $('#good_ids').val("");
                    $('#shelves_form').bootstrapValidator("resetForm", true);
                },
                error : function(response) {
                }
            })
        })
    }

    // 导出供应商信息
    function exportShelvesAction() {
        $('#export_shelves').click(function() {
            $('#export_modal').modal("show");
        })

        $('#export_shelves_download').click(function(){
            var data = {
                searchType : search_type_shelves,
                keyWord : search_keyWord
            }
            var url = "shelvesManage/exportShelves?" + $.param(data)
            window.open(url, '_blank');
            $('#export_modal').modal("hide");
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
        <li>仓库信息管理</li>
    </ol>
    <div class="panel-body">
        <div class="row">
            <div class="col-md-1 col-sm-2">
                <div class="btn-group">
                    <button class="btn btn-default dropdown-toggle"
                            data-toggle="dropdown">
                        <span id="search_type">查询方式</span> <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="javascript:void(0)" class="dropOption">货架名称</a></li>
                        <li><a href="javascript:void(0)" class="dropOption">仓库ID</a></li>
                        <li><a href="javascript:void(0)" class="dropOption">所有</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-md-9 col-sm-9">
                <div>
                    <div class="col-md-3 col-sm-4">
                        <input id="search_input" type="text" class="form-control"
                               placeholder="货架信息查询">
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
                <button class="btn btn-sm btn-default" id="add_shelves">
                    <span class="glyphicon glyphicon-plus"></span> <span>添加货架信息</span>
                </button>
                <button class="btn btn-sm btn-default" id="export_shelves">
                    <span class="glyphicon glyphicon-export"></span> <span>导出</span>
                </button>
            </div>
            <div class="col-md-5"></div>
        </div>

        <div class="row" style="margin-top: 15px">
            <div class="col-md-12">
                <table id="shelvesList" class="table table-striped"></table>
            </div>
        </div>
    </div>
</div>

<!-- 添加仓库信息模态框 -->
<div id="add_modal" class="modal fade" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加货架信息</h4>
            </div>
            <div class="modal-body">
                <!-- 模态框的内容 -->
                <div class="row">
                    <div class="col-md-1 col-sm-1"></div>
                    <div class="col-md-8 col-sm-8">
                        <form class="form-horizontal" role="form" id="shelves_form"
                              style="margin-top: 25px">
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>货架名称：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <input type="text" class="form-control" id="shelves_name"
                                           name="shelves_name" placeholder="货架名称">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>所属仓库：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <select name="repo_id" id="repo_id" class="form-control">
                                        <option value="">请选择仓库</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>可存放的货物：按住Ctrl可多选</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <select name="good_ids" id="good_ids" class="form-control" multiple="multiple" size="8">
                                    </select>
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
                        <h3>是否确认删除该条货架信息</h3>
                        <p>(注意：若该货架已经有出入库记录或仓存信息，则该货架信息将不能删除成功。如需删除该货架的信息，请保证该货架没有出入库和货架信息关联)</p>
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

<!-- 编辑仓库信息模态框 -->
<div id="edit_modal" class="modal fade" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">编辑仓库信息</h4>
            </div>
            <div class="modal-body">
                <!-- 模态框的内容 -->
                <div class="row">
                    <div class="col-md-1 col-sm-1"></div>
                    <div class="col-md-8 col-sm-8">
                        <form class="form-horizontal" role="form" id="shelves_form_edit"
                              style="margin-top: 25px">
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>货架名称：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <input type="text" class="form-control" id="shelves_name_edit"
                                           name="shelves_name" placeholder="货架名称">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>所在仓库：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <select name="repo_id" id="repo_id_edit" class="form-control">
                                        <option value="">请选择仓库</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>可存放的货物：按住Ctrl可多选</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <select name="good_ids" id="good_ids_edit" class="form-control" multiple="multiple" size="8">
                                    </select>
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

<!-- 导出供应商信息模态框 -->
<div class="modal fade" id="export_modal" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">导出货架信息</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-3 col-sm-3" style="text-align: center;">
                        <img src="media/icons/warning-icon.png" alt=""
                             style="width: 70px; height: 70px; margin-top: 20px;">
                    </div>
                    <div class="col-md-8 col-sm-8">
                        <h3>是否确认导出货架信息</h3>
                        <p>(注意：请确定要导出的货架信息，导出的内容为当前列表的搜索结果)</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">
                    <span>取消</span>
                </button>
                <button class="btn btn-success" type="button" id="export_shelves_download">
                    <span>确认下载</span>
                </button>
            </div>
        </div>
    </div>
</div>