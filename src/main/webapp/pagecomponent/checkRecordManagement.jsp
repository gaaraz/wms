<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
//    var search_type_storage = "none";
    var search_keyWord = "";
    var search_repository = "";
    var search_shelves = "";
//    var select_goodsID;
//    var select_repositoryID;
//    var select_shelvesID;
    var search_start_date = null
    var search_end_date = null
    $(function() {
        searchAction();
        recordListInit();
        repositoryOptionInit();
        shelvesOptionInit();

        datePickerInit();
        bootstrapValidatorInit();
        addRecordAction();

        exportRecordAction();
    })

    // 日期选择器初始化
    function datePickerInit(){
        $('.form_date').datetimepicker({
            format:'yyyy-mm-dd',
            language : 'zh-CN',
            endDate : new Date(),
            weekStart : 1,
            todayBtn : 1,
            autoClose : 1,
            todayHighlight : 1,
            startView : 2,
            forceParse : 0,
            minView:2
        });
    }

    // 仓库下拉框数据初始化，页面加载时完成
    function repositoryOptionInit(){
        $.ajax({
            type : 'GET',
            url : 'repositoryManage/getRepositoryList',
            dataType : 'json',
            contentType : 'application/json',
            data:{
                searchType : "searchAll",
                keyWord : "",
                offset : -1,
                limit : -1
            },
            success : function(response){
                //组装option
                $.each(response.rows,function(index,elem){
                    $('#search_input_repository').append("<option value='" + elem.id + "'>" + elem.name +"</option>");
                    $('#record_repositoryID').append("<option value='" + elem.id + "'>" + elem.name +"</option>");
                })
            },
            error : function(response){
            }
        });
        $('#search_input_repository').append("<option value=''>请选择仓库</option>");
        $('#record_repositoryID').append("<option value=''>请选择仓库</option>");
    }

    // 货架下拉框数据初始化，页面加载时完成
    function shelvesOptionInit(){
        $('#search_input_repository').change(function(){
            var reposId = $(this).val();
            $('#search_input_shelves').empty();
            $.ajax({
                type : 'GET',
                url : 'shelvesManage/list',
                dataType : 'json',
                contentType : 'application/json',
                data:{
                    searchType : "searchByRepos",
                    keyWord : reposId,
                    offset : -1,
                    limit : -1
                },
                success : function(response){
                    //组装option
                    $.each(response.rows,function(index,elem){
                        $('#search_input_shelves').append("<option value='" + elem.id + "'>" + elem.name +"</option>");
                    })
                },
                error : function(response){
                }
            });
            $('#search_input_shelves').append("<option value=''>请选择货架</option>");
        });

        $('#record_repositoryID').change(function(){
            var reposId = $(this).val();
            $('#record_shelvesID').empty();
            $('#record_goodsID').empty();
            $.ajax({
                type : 'GET',
                url : 'shelvesManage/list',
                dataType : 'json',
                contentType : 'application/json',
                data:{
                    searchType : "searchByRepos",
                    keyWord : reposId,
                    offset : -1,
                    limit : -1
                },
                success : function(response){
                    //组装option
                    $.each(response.rows,function(index,elem){
                        $('#record_shelvesID').append("<option value='" + elem.id + "'>" + elem.name +"</option>");
                    })
                },
                error : function(response){
                }
            });
            $('#record_shelvesID').append("<option value=''>请选择货架</option>");
        });

        $('#record_shelvesID').change(function(){
            var shelvesId = $(this).val();
            $('#record_goodsID').empty();
            $.ajax({
                type : 'GET',
                url : 'goodsManage/getGoodsListByShelvesId',
                dataType : 'json',
                contentType : 'application/json',
                data:{
                    shelvesId : shelvesId
                },
                success : function(response){
                    //组装option
                    $.each(response.rows,function(index,elem){
                        $('#record_goodsID').append("<option value='" + elem.id + "'>" + elem.name +"</option>");
                    })
                },
                error : function(response){
                }
            });
            $('#record_goodsID').append("<option value=''>请选择货物</option>");
        });

        $('#record_goodsID').change(function(){
            var goodId = $(this).val();
            var shelvesId = $("#record_shelvesID").val();
            var reposId = $("#record_repositoryID").val();
            $.ajax({
                type : 'GET',
                url : 'storageManage/getStorageListWithRepository',
                dataType : 'json',
                contentType : 'application/json',
                data:{
                    searchType : "searchByGoodsID",
                    repositoryBelong : reposId,
                    shelvesBelong : shelvesId,
                    keyword : goodId,
                    offset : -1,
                    limit : -1
                },
                success : function(response){
                    if(response.rows.length > 0){
                        $("#record_number").text(response.rows[0].number);
                    }else{
                        $("#record_number").text(0);
                    }
                },
                error : function(response){
                }
            });
        });
    }

    // 搜索动作
    function searchAction() {
        $('#search_button').click(function() {
            search_keyWord = $('#search_input_type').val();
            search_repository = $('#search_input_repository').val();
            search_shelves = $('#search_input_shelves').val();
            search_start_date = $('#search_start_date').val();
            search_end_date = $('#search_end_date').val();
            tableRefresh();
        })
    }

    // 导出盘点记录
    function exportRecordAction() {
        $('#export_record').click(function() {
            $('#export_modal').modal("show");
        })

        $('#export_record_download').click(function(){
            var data = {
                repositoryId : search_repository,
                shelvesId : search_shelves,
                goodId : search_keyWord,
                startDate : search_start_date,
                endDate : search_end_date
            }
            var url = "checkRecordManage/exportCheckRecord?" + $.param(data)
            window.open(url, '_blank');
            $('#export_modal').modal("hide");
        })
    }

    // 分页查询参数
    function queryParams(params) {
        var temp = {
            limit : params.limit,
            offset : params.offset,
            repositoryId : search_repository,
            shelvesId : search_shelves,
            goodId : search_keyWord,
            startDate : search_start_date,
            endDate : search_end_date
        }
        return temp;
    }

    // 表格初始化
    function recordListInit() {
        $('#recordList')
            .bootstrapTable(
                {
                    columns : [
                        {
                            field : 'id',
                            title : '盘点记录ID'
                            //sortable: true
                        },
                        {
                            field : 'respository',
                            title : '仓库名称'
                        },
                        {
                            field : 'shelves',
                            title : '货架名称'
                        },
                        {
                            field : 'good',
                            title : '货物名称'
                        },
                        {
                            field : 'recordNum',
                            title : '记录数量'
                        },
                        {
                            field : 'realNum',
                            title : '实际数量'
                        },
                        {
                            field : 'person',
                            title : '操作人'
                        },
                        {
                            field : 'checkTimeStr',
                            title : '盘点时间'
                        }],
                    url : 'checkRecordManage/list',
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
        $('#recordList').bootstrapTable('refresh', {
            query : {}
        });
    }

    // 添加库存信息模态框数据校验
    function bootstrapValidatorInit() {
        $("#record_form").bootstrapValidator({
            message : 'This is not valid',
            feedbackIcons : {
                valid : 'glyphicon glyphicon-ok',
                invalid : 'glyphicon glyphicon-remove',
                validating : 'glyphicon glyphicon-refresh'
            },
            excluded : [ ':disabled' ],
            fields : {
                storage_goodsID : {
                    validators : {
                        notEmpty : {
                            message : '实际数量不能为空'
                        }
                    }
                }
            }
        })
    }

    // 添加盘点信息
    function addRecordAction() {
        $('#add_record').click(function() {
            $('#add_modal').modal("show");
        });

        $('#add_modal_submit').click(function() {
            var data = {
                goodID : $('#record_goodsID').val(),
                respositoryID : $('#record_repositoryID').val(),
                shelvesID : $('#record_shelvesID').val(),
                realNum : $('#real_number').val()
            }
            // ajax
            $.ajax({
                type : "POST",
                url : "checkRecordManage/add",
                dataType : "json",
                contentType : "application/json",
                data : JSON.stringify(data),
                success : function(response) {
                    $('#add_modal').modal("hide");
                    var msg;
                    var type;
                    if (response.result == "success") {
                        type = "success";
                        msg = "盘点信息添加成功";
                    } else if (response.result == "error") {
                        type = "error";
                        msg = "盘点信息添加失败";
                    }
                    infoModal(type, msg);
                    tableRefresh();

                    // reset
                    $('#record_goodsID').val("");
                    $('#record_repositoryID').val("");
                    $('#record_shelvesID').val("");
                    $('#real_number').val("");
                    $('#record_number').text(0);
                    $('#storage_form').bootstrapValidator("resetForm", true);
                },
                error : function(response) {
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
        <li>盘点记录</li>
    </ol>
    <div class="panel-body">
        <div class="row">

            <div class="col-md-9 col-sm-9">
                <div>
                    <div class="col-md-3 col-sm-3">
                        <input id="search_input_type" type="text" class="form-control"
                               placeholder="货物ID">
                    </div>
                    <!--通过后台查询仓库信息-->
                    <div class="col-md-3 col-sm-4">
                        <select class="form-control" id="search_input_repository">
                        </select>
                    </div>
                    <!--通过后台查询货架信息-->
                    <div class="col-md-3 col-sm-4">
                        <select class="form-control" id="search_input_shelves">
                        </select>
                    </div>
                    <div class="col-md-2 col-sm-2">
                        <button id="search_button" class="btn btn-success">
                            <span class="glyphicon glyphicon-search"></span> <span>查询</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" style="margin-top:20px">
            <div class="col-md-12">
                <form action="" class="form-inline">
                    <label class="form-label">日期范围：</label>
                    <input class="form_date form-control" value="" id="search_start_date" name="" placeholder="开始日期">
                    <label class="form-label">&nbsp;&nbsp;-&nbsp;&nbsp;</label>
                    <input class="form_date form-control" value="" id="search_end_date" name="" placeholder="结束日期">
                </form>
            </div>
        </div>

        <div class="row" style="margin-top: 25px">
            <div class="col-md-5">
                <button class="btn btn-sm btn-default" id="add_record">
                    <span class="glyphicon glyphicon-plus"></span> <span>盘点</span>
                </button>
                <button class="btn btn-sm btn-default" id="export_record">
                    <span class="glyphicon glyphicon-export"></span> <span>导出</span>
                </button>
            </div>
            <div class="col-md-5"></div>
        </div>

        <div class="row" style="margin-top: 15px">
            <div class="col-md-12">
                <table id="recordList" class="table table-striped"></table>
            </div>
        </div>
    </div>
</div>


<!-- 添加库存信息模态框 -->
<div id="add_modal" class="modal fade" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加库存记录</h4>
            </div>
            <div class="modal-body">
                <!-- 添加库存信息模态框的内容 -->
                <div class="row">
                    <div class="col-md-1 col-sm-1"></div>
                    <div class="col-md-8 col-sm-8">
                        <form class="form-horizontal" role="form" id="record_form"
                              style="margin-top: 25px">
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>仓库：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <select class="form-control" id="record_repositoryID"
                                            name="record_repositoryID"></select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>货架：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <select class="form-control" id="record_shelvesID"
                                            name="record_shelvesID"></select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>货物：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <select class="form-control" id="record_goodsID"
                                            name="record_goodsID"></select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>记录数量：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <p id="record_number"
                                       name="record_number">0</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>实际数量：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <input type="text" class="form-control" id="real_number"
                                           name="real_number" placeholder="数量">
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

<!-- 导出盘点记录模态框 -->
<div class="modal fade" id="export_modal" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">导出盘点记录</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-3 col-sm-3" style="text-align: center;">
                        <img src="media/icons/warning-icon.png" alt=""
                             style="width: 70px; height: 70px; margin-top: 20px;">
                    </div>
                    <div class="col-md-8 col-sm-8">
                        <h3>是否确认导出盘点记录</h3>
                        <p>(注意：请确定要导出的盘点记录，导出的内容为当前列表的搜索结果)</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">
                    <span>取消</span>
                </button>
                <button class="btn btn-success" type="button" id="export_record_download">
                    <span>确认下载</span>
                </button>
            </div>
        </div>
    </div>
</div>
