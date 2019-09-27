<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
<script>
    var search_keyWord = "";
    var search_start_date = null;
    var search_end_date = null;
    var myChart = echarts.init(document.getElementById('main'));

    $(function(){
        datePickerInit();
        echartsInit();
        searchAction();
        exportSqlAction();
        importSqlAction();
    })


    // 日期选择器初始化
    function datePickerInit(){
        $('.form_date').datetimepicker({
            format:'yyyy-mm',
            language : 'zh-CN',
            weekStart : 1,
            todayBtn : 1,
            autoClose : 1,
            todayHighlight : 0,
            startView : 3,
            forceParse : 0,
            minView:3
        });
    }

    function searchAction() {
        $('#search_button').click(function() {
            search_keyWord = $('#search_input').val();
            search_start_date = $('#search_start_date').val();
            search_end_date = $('#search_end_date').val();
            echartsInit();
        })
    }

    function echartsInit(){
        myChart.showLoading();
        $.ajax({
            type : 'GET',
            url : 'stockRecordManage/queryStatisticalData',
            dataType : 'json',
            contentType : 'application/json',
            data:{
                goodID : search_keyWord,
                startDate : search_start_date,
                endDate : search_end_date
            },
            success : function(response){
                var category = [];
                var total = [];
                var price = [];
                $.each(response.rows,function(index,elem){
                    category.push(elem.date);
                    total.push(elem.total);
                    price.push(elem.price);
                })

                myChart.hideLoading();
                var option = {
//                    color: ['#00BFFF'],
                    title : {
                        text: '货物出库分析'
//                subtext: '纯属虚构'
                    },
                    tooltip : {
                        trigger: 'axis'
                    },
                    legend: {
                        data:['出库数量','出库金额']
                    },
                    toolbox: {
                        show : true,
                        feature : {
                            magicType : {show: true, type: ['line', 'bar']}
                        }
                    },
                    xAxis : [
                        {
                            type : 'category',
                            data : category
                        }
                    ],
                    yAxis : [
                        {
                            type : 'value'
                        }
                    ],
                    series : [
                        {
                            name:'出库数量',
                            type:'bar',
                            data:total
                        },
                        {
                            name:'出库金额',
                            type:'bar',
                            data:price
                        }
                    ]
                };
                myChart.clear();
                myChart.setOption(option);
            },
            error : function(response){
            }
        });
    }

    // 数据库备份
    function exportSqlAction() {
        $('#export_sql').click(function() {
            $('#export_modal').modal("show");
        })

        $('#export_sql_download').click(function(){
            var url = "systemLog/exportSql";
            window.open(url, '_blank');
            $('#export_modal').modal("hide");
        })
    }


    // 数据库恢复
    function importSqlAction() {
        $('#import_sql').click(function() {
            $('#import_modal').modal("show");
        });

        $('#submit').click(function() {
            $('#uploading').removeClass("hide");
            $('#confirm').removeClass("hide");
            $('#submit').addClass("hide");

            // ajax
            $.ajaxFileUpload({
                url : "systemLog/importSql",
                secureuri: false,
                dataType: 'json',
                fileElementId:"file",
                success : function(data, status){
                    var msg1 = "数据库恢复成功";
                    var msg2 = "数据库恢复失败";
                    var info;

                    $('#import_progress_bar').addClass("hide");
                    if(data.result == "success"){
                        info = msg1;
                        $('#import_success').removeClass('hide');
                    }else{
                        info = msg2
                        $('#import_error').removeClass('hide');
                    }

                    $('#import_result').removeClass('hide');
                    $('#import_info').text(info);
                    $('#confirm').removeClass('disabled');
                },error : function(data, status){
                }
            })
        })
    }
</script>
<div class="panel panel-default">
    <ol class="breadcrumb">
        <li>数据统计</li>
    </ol>
    <div class="panel-body" >
        <div class="row">
            <div class="col-md-9 col-sm-9">
                <div>
                    <div class="col-md-2 col-sm-4">
                        <input id="search_input" type="text" class="form-control"
                               placeholder="货物ID">
                    </div>
                    <div class="col-md-7">
                        <form action="" class="form-inline">
                            <label class="form-label">日期范围：</label>
                            <input class="form_date form-control" id="search_start_date" placeholder="起始日期">
                            <label class="form-label">&nbsp;&nbsp;-&nbsp;&nbsp;</label>
                            <input class="form_date form-control" id="search_end_date" placeholder="结束日期">
                        </form>
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
                <button class="btn btn-sm btn-default" id="export_sql">
                    <span class="glyphicon glyphicon-export"></span> <span>数据库备份</span>
                </button>
                <button class="btn btn-sm btn-default" id="import_sql">
                    <span class="glyphicon glyphicon-import"></span> <span>数据库恢复</span>
                </button>
            </div>
            <div class="col-md-5"></div>
        </div>
    </div>

    <div  id="main" style="height: 600px"></div>
</div>

<!-- 导出sql信息模态框 -->
<div class="modal fade" id="export_modal" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">数据库备份</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-3 col-sm-3" style="text-align: center;">
                        <img src="media/icons/warning-icon.png" alt=""
                             style="width: 70px; height: 70px; margin-top: 20px;">
                    </div>
                    <div class="col-md-8 col-sm-8">
                        <h3>是否确认备份当前数据库</h3>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">
                    <span>取消</span>
                </button>
                <button class="btn btn-success" type="button" id="export_sql_download">
                    <span>确认下载</span>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 数据库恢复模态框 -->
<div class="modal fade" id="import_modal" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">数据库恢复</h4>
            </div>
            <div class="modal-body">
                <div id="step3">
                    <div class="row" style="margin-top: 15px">
                        <div class="col-md-1 col-sm-1"></div>
                        <div class="col-md-8 col-sm-10">
                            <div>
                                <div>
                                    <h4>请点击下面上传文件按钮，上传备份的.sql文件</h4>
                                </div>
                                <div style="margin-top: 30px; margin-buttom: 15px">
									<span class="btn btn-info btn-file"> <span> <span
                                            class="glyphicon glyphicon-upload"></span> <span>上传文件</span>
									</span>
									<form id="import_file_upload"><input type="file" id="file" name="file"></form>
									</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="hide" id="uploading">
                    <div class="row" style="margin-top: 15px" id="import_progress_bar">
                        <div class="col-md-1 col-sm-1"></div>
                        <div class="col-md-10 col-sm-10"
                             style="margin-top: 30px; margin-bottom: 30px">
                            <div class="progress progress-striped active">
                                <div class="progress-bar progress-bar-success"
                                     role="progreessbar" aria-valuenow="60" aria-valuemin="0"
                                     aria-valuemax="100" style="width: 100%;">
                                    <span class="sr-only">请稍后...</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-1"></div>
                    </div>
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-4">
                            <div id="import_result" class="hide">
                                <div id="import_success" class="hide" style="text-align: center;">
                                    <img src="media/icons/success-icon.png" alt=""
                                         style="width: 100px; height: 100px;">
                                </div>
                                <div id="import_error" class="hide" style="text-align: center;">
                                    <img src="media/icons/error-icon.png" alt=""
                                         style="width: 100px; height: 100px;">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-3 col-sm-3"></div>
                        <div class="col-md-6 col-sm-6" style="text-align: center;">
                            <h4 id="import_info"></h4>
                        </div>
                        <div class="col-md-3 col-sm-3"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-success" type="button" id="submit">
                    <span>&nbsp;&nbsp;&nbsp;提交&nbsp;&nbsp;&nbsp;</span>
                </button>
                <button class="btn btn-success hide disabled" type="button"
                        id="confirm" data-dismiss="modal">
                    <span>&nbsp;&nbsp;&nbsp;确认&nbsp;&nbsp;&nbsp;</span>
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
