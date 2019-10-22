<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<script>
    // 出入库记录查询参数
    var search_repositoryID = '';
    var search_start_date = null;
    var search_end_date = null;
    var stockOutList = new Array();

    $(function(){
        repositoryOptionInit();
        datePickerInit();
        storageListInit();
        searchAction();

        stockDetailInit();
        infoModalHidden();
    })

    // 仓库下拉框数据初始化
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
				$.each(response.rows,function(index,elem){
					$('#search_repository_ID').append("<option value='" + elem.id + "'>" + elem.id +"号仓库</option>");
				})
			},
			error : function(response){
			}
		});
		//$('#search_repository_ID').append("<option value='all'>所有仓库</option>");
	}

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

	// 表格初始化
	function storageListInit() {
		$('#stockRecords')
				.bootstrapTable(
						{
							columns : [
									{
										field : 'batchId',
										title : '记录ID'
									//sortable: true
									},
									{
										field : 'customerName',
										title : '客户名称'
									},
									{
										field : 'goodName',
										title : '商品名称'
									},
                                    {
                                        field : 'repository',
                                        title : '入库仓库',
                                        //visible : false
                                    },
                                    {
                                        field : 'shelves',
                                        title : '入库货架',
                                        //visible : false
                                    },
                                    {
                                        field : 'number',
                                        title : '数量',
                                        formatter: function (value, row, index) {
                                            if(value === 0){
                                                return "见详情";
                                            }else{
                                                return value;
                                            }
                                        }
                                    },
									{
										field : 'time',
										title : '日期',
                                        formatter: function (value, row, index) {
                                            return changeDateFormat(value)
                                        }
									},
                                    {
                                        field : 'personInCharge',
                                        title : '制单'
                                    },
                                    {
                                        field : 'operation',
                                        title : '操作',
                                        formatter : function(value, row, index) {
                                            var d = '';
                                            var p = '<button class="btn btn-danger btn-sm preview"><span>打印预览</span></button>';
                                            if(row.detail != null){
                                                d = '<button class="btn btn-danger btn-sm detail"><span>详情</span></button>';
                                            }
                                            return d+' '+p;
                                        },
                                        events : {
                                            // 操作列中详情按钮的动作
                                            'click .detail' : function(e,value, row, index) {
                                                $('#stockDetail').bootstrapTable('append', row.detail);
                                                $('#info_modal').modal("show");
                                            },
                                            'click .preview' : function(e,value, row, index) {
                                                preview(row);
                                            }
                                        }
                                    }
                            ],
							url : 'stockRecordManage/getStockOutRecord',
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

    function stockDetailInit() {
        $('#stockDetail')
            .bootstrapTable(
                {
                    columns : [
                        {
                            field : 'batchId',
                            title : '记录ID'
                            //sortable: true
                        },
                        {
                            field : 'customerName',
                            title : '客户名称'
                        },
                        {
                            field : 'goodName',
                            title : '商品名称'
                        },
                        {
                            field : 'repository',
                            title : '入库仓库',
                            //visible : false
                        },
                        {
                            field : 'shelves',
                            title : '入库货架',
                            //visible : false
                        },
                        {
                            field : 'number',
                            title : '数量',
                            formatter: function (value, row, index) {
                                if(value === 0){
                                    return "见详情";
                                }else{
                                    return value;
                                }
                            }
                        },
                        {
                            field : 'time',
                            title : '日期',
                            formatter: function (value, row, index) {
                                return changeDateFormat(value)
                            }
                        },
                        {
                            field : 'personInCharge',
                            title : '制单'
                        }
                    ],
                    data : stockOutList,
                    sidePagination : "server",
                    dataType : 'json',
                    pagination : false,
                    clickToSelect : true
                });
    }

    function preview(row){
        $("#previewTable tbody td").empty();
        var head_tr = $("#previewTable thead").find(">tr");
        var date = new Date(row.time);
        head_tr.eq(0).find(">td").eq(1).html("单据编号: "+row.batchId);
        head_tr.eq(1).find(">td").eq(0).html("制单日期: "+date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate());
        head_tr.eq(2).find(">td").eq(0).html("客户名称: "+row.customerName);
        var foot_tr = $("#previewTable tfoot").find(">tr");
        foot_tr.eq(1).find(">td").eq(1).html("库管: "+row.storeman);
        foot_tr.eq(1).find(">td").eq(2).html("入库人员: "+row.inputman);

        var data = new Array();
        if (row.detail){
            data = row.detail;
        }else{
            data[0] = row;
        }
        console.log(data);
        var body_tr = $("#previewTable tbody").find(">tr");
        for(var i=0;i<data.length;i++){
            if (i < 12){
                var td = body_tr.eq(i).find(">td");
                td.eq(0).html(i+1);
                td.eq(1).html(data[i].goodName);
                td.eq(2).html(data[i].size);
                td.eq(3).html("");
                td.eq(4).html(data[i].number);
                td.eq(5).html(data[i].value);
                td.eq(6).html(data[i].total);
                td.eq(7).html(data[i].packages);
                td.eq(8).html(data[i].remark);
            }else{
                $("<tr height='20'><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+(i+1)
                    +"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+data[i].name
                    +"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+data[i].size
                    +"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"
                    +"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+data[i].number
                    +"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+data[i].value
                    +"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+data[i].total
                    +"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+data[i].packages
                    +"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+data[i].remark
                    +"</td></tr>").insertAfter($('#previewTable tbody tr:eq('+(i-1)+')'));
            }
        }


        LODOP.PRINT_INIT("出库单");
        LODOP.SET_PRINT_PAGESIZE(1, 2410,1400,"");
        LODOP.ADD_PRINT_TEXT("5mm","80mm","80mm","5mm","常州市剑云医疗器械厂");
        LODOP.SET_PRINT_STYLEA(0,"ItemType", 1);
        LODOP.SET_PRINT_STYLEA(0,"FontSize", 20);
        LODOP.SET_PRINT_STYLEA(0,"Bold", 1);
        LODOP.ADD_PRINT_LINE("12mm","30mm", "12mm", "210mm",0, 1);
        LODOP.ADD_PRINT_TABLE("20mm","30mm","181mm","70mm",document.getElementById('previewDiv').innerHTML);
        LODOP.PREVIEW();

    }

    function changeDateFormat(cellval) {
        var dateVal = cellval + "";
        if (cellval != null) {
            var date = new Date(parseInt(dateVal.replace("/Date(", "").replace(")/", ""), 10));
            var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
            var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();

            var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
            var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
            var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();

            return date.getFullYear() + "-" + month + "-" + currentDate + " " + hours + ":" + minutes + ":" + seconds;
        }
    }

	// 表格刷新
	function tableRefresh() {
		$('#stockRecords').bootstrapTable('refresh', {
			query : {}
		});
	}

	// 分页查询参数
	function queryParams(params) {
		var temp = {
			limit : params.limit,
			offset : params.offset,
			repositoryID : search_repositoryID,
			startDate : search_start_date,
			endDate : search_end_date
		}
		return temp;
	}

	// 查询操作
	function searchAction(){
	    $('#search_button').click(function(){
	        search_repositoryID = $('#search_repository_ID').val();
	        search_start_date = $('#search_start_date').val();
	        search_end_date = $('#search_end_date').val();
	        tableRefresh();
	    })
	}

    function infoModalHidden(){
        $("#info_modal").on('hide.bs.modal',function(){
            $('#stockDetail').bootstrapTable('removeAll');
        })
    }
</script>

<div class="panel panel-default">
    <ol class="breadcrumb">
        <li>业务流水</li>
    </ol>
    <div class="panel-body">
        <div class="row">
            <div class="col-md-4">
                <form action="" class="form-inline">
                    <div class="form-group">
                        <label class="form-label">仓库编号：</label>
                        <select class="form-control" id="search_repository_ID">
                            <option value="">请选择仓库</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="col-md-4">
                <button class="btn btn-success" id="search_button">
                    <span class="glyphicon glyphicon-search"></span> <span>查询</span>
                </button>
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
        <div class="row" style="margin-top:50px">
            <div class="col-md-12">
                <table id="stockRecords" class="table table-striped"></table>
            </div>
        </div>
    </div>
</div>

<!-- 提示消息模态框 -->
<div class="modal fade" id="info_modal" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 1200px;">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">出库详情</h4>
            </div>
            <div class="modal-body">
                <div class="row" style="margin-top:50px">
                    <div class="col-md-12">
                        <table id="stockDetail" class="table table-striped"></table>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" id="info_modal_hidden" data-dismiss="modal">
                    <span>&nbsp;&nbsp;&nbsp;关闭&nbsp;&nbsp;&nbsp;</span>
                </button>
            </div>
        </div>
    </div>
</div>


<div id="previewDiv" style="display: none"  class="printTable">
    <table  width='100%' border="0" height="" cellspacing="0" cellpadding="0" id="previewTable">
        <thead>
        <tr height="20" >
            <td align='right' colspan="6" rowspan="2" valign="top" style="font-size: 25px;font-weight:bold;padding-right: 25px">成品出库单</td>
            <td align='left' colspan="3"></td>
        </tr>
        <tr height="20" >
            <td align='left' colspan="3"></td>
        </tr>
        <tr height="20" >
            <td align='left' colspan="9"></td>
        </tr>
        <tr height="20" >
            <td align='center' width="3%" style="border: 1px solid #000;border-collapse:collapse;">序</td>
            <td align='center' width="28%" style="border: 1px solid #000;border-collapse:collapse;">品名</td>
            <td align='center' width="13%" style="border: 1px solid #000;border-collapse:collapse;">规格</td>
            <td align='center' width="6%" style="border: 1px solid #000;border-collapse:collapse;">单位</td>
            <td align='center' width="6%" style="border: 1px solid #000;border-collapse:collapse;">数量</td>
            <td align='center' width="9%" style="border: 1px solid #000;border-collapse:collapse;">单价</td>
            <td align='center' width="9%" style="border: 1px solid #000;border-collapse:collapse;">金额</td>
            <td align='center' width="9%" style="border: 1px solid #000;border-collapse:collapse;">件数</td>
            <td align='center' width="17%" style="border: 1px solid #000;border-collapse:collapse;">备注</td>
        </tr>
        </thead>
        <tbody>
        <tr height="20" >
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
        </tr>
        <tr height="20" >
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
        </tr>
        <tr height="20" >
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
        </tr>
        <tr height="20" >
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
        </tr>
        <tr height="20" >
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
        </tr>
        <tr height="20" >
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
        </tr>
        <tr height="20" >
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
        </tr>
        <tr height="20" >
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
        </tr>
        <tr height="20" >
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
        </tr>
        <tr height="20" >
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
        </tr>
        <tr height="20" >
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
        </tr>
        <tr height="20" >
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
        </tr>
        <tr height="20" >
            <td colspan='4' align='center' style="border: 1px solid #000;border-collapse:collapse;">合计</td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;" tdata="AllSum" format="#">##</td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;" tdata="AllSum" format="#,##0.00">##</td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;" tdata="AllSum" format="#">##</td>
            <td align='center' style="border: 1px solid #000;border-collapse:collapse;"></td>
        </tr>
        </tbody>
        <tfoot>
        <tr height="30" >
            <td></td>
            <td align='left' colspan="3">地址:江苏省常州市金坛区直溪工业园区</td>
            <td align='left' colspan="3">电话:0519-82444935</td>
            <td align='left' colspan="2">传真:0519-82444723</td>
        </tr>
        <tr height="25" >
            <td></td>
            <td align='left'></td>
            <td align='left' colspan="3"></td>
            <td align='left' colspan="4">制单:${sessionScope.userName}</td>
        </tr>
        <tr height="20" >
            <td colspan="7"></td>
            <td align='left' colspan="2">第<font tdata="PageNO">#</font>页&nbsp;&nbsp;&nbsp;&nbsp;共<font tdata="PageCount">#</font>页</td>
        </tr>
        </tfoot>
    </table>
</div>