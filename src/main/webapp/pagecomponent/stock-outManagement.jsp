<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
</object>
<script>
var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));
var stockout_repository = null;
var stockout_shelves = null;
var stockout_customer = null;
var stockout_goods = null;
var deleteIndex = null;

var customerCache = new Array();
var goodsCache = new Array();

var stockOutList = new Array();
var batchId = null;

$(function(){
	dataValidateInit();
	detilInfoToggle();
	stockoutOperation();
    stockOutListInit();

	fetchStorage();
    fetchShelves();
    getAllGoods();
	goodsAutocomplete();
    getAllCustomer();
	customerAutocomplete();
    addStockout();
    deleteStockout();

//    preview();
    infoModalHidden();
})


function preview(){
        var head_tr = $("#previewTable thead").find(">tr");
		var date = new Date();
    	head_tr.eq(0).find(">td").eq(1).html("单据编号: "+batchId);
		head_tr.eq(1).find(">td").eq(0).html("制单日期: "+date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate());
        head_tr.eq(2).find(">td").eq(0).html("客户名称: "+$('#customer_input').val());
    	var foot_tr = $("#previewTable tfoot").find(">tr");
    	foot_tr.eq(1).find(">td").eq(1).html("库管: "+$('#storeman').val());
    	foot_tr.eq(1).find(">td").eq(2).html("入库人员: "+$('#inputman').val());

        var body_tr = $("#previewTable tbody").find(">tr");
		for(var i=0;i<stockOutList.length;i++){
			if (i < 12){
                var td = body_tr.eq(i).find(">td");
			    td.eq(0).html(i+1);
                td.eq(1).html(stockOutList[i].name);
                td.eq(2).html(stockOutList[i].size);
                td.eq(3).html("");
                td.eq(4).html(stockOutList[i].number);
                td.eq(5).html(stockOutList[i].value);
                td.eq(6).html(stockOutList[i].total);
                td.eq(7).html(stockOutList[i].packages);
                td.eq(8).html(stockOutList[i].remark);
			}else{
				$("<tr height='20'><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+(i+1)
					+"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+stockOutList[i].name
					+"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+stockOutList[i].size
					+"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"
					+"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+stockOutList[i].number
					+"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+stockOutList[i].value
					+"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+stockOutList[i].total
					+"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+stockOutList[i].packages
					+"</td><td align='center' style='border: 1px solid #000;border-collapse:collapse;'>"+stockOutList[i].remark
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

function dataValidateInit(){
	$('#stockout_form').bootstrapValidator({
		message : 'This is not valid',
		
		fields : {
			stockout_input : {
				validators : {
					notEmpty : {
						message : '出库数量不能为空'
					},
					greaterThan: {
                        value: 1,
                        message: '出库数量不能小于1'
                    },
                    digits:{
                        message: '请输入数字'
					}
				}
			}
		}
	});

    $('#stockout_packages_form').bootstrapValidator({
        message : 'This is not valid',

        fields : {
            stockout_packages : {
                validators : {
                    notEmpty : {
                        message : '出库件数不能为空'
                    },
                    greaterThan: {
                        value: 1,
                        message: '出库件数不能小于1'
                    },
                    digits:{
                        message: '请输入数字'
                    }
                }
            }
        }
    });
}

function getAllGoods() {
    $.ajax({
        type : 'GET',
        url : 'goodsManage/getGoodsList',
        dataType : 'json',
        contentType : 'application/json',
        data : {
            offset : -1,
            limit : -1,
            keyWord : '',
            searchType : 'searchAll'
        },
        success : function(data){
            goodsCache = data.rows;
        }
    });
}

//货物信息自动匹配
function goodsAutocomplete(){
	$('#goods_input').autocomplete({
		minLength : 0,
		delay : 500,
		source : function(request, response){
            var autoCompleteInfo = new Array();
            var goodsFilter = goodsCache.filter(
                function (item) {
                    return item.name.indexOf(request.term) > -1
				}
			)
            $.each(goodsFilter, function(index,elem){
                autoCompleteInfo.push({label:elem.name,value:elem.id});
            });
            response(autoCompleteInfo);
		},
		focus : function(event, ui){
			$('#goods_input').val(ui.item.label);
			return false;
		},
		select : function(event, ui){
			$('#goods_input').val(ui.item.label);
			stockout_goods = ui.item.value;
			goodsInfoSet(stockout_goods);
            repositorySelectorInit(stockout_goods);
			return false;
		}
	})
}

function getAllCustomer() {
    $.ajax({
        type : 'GET',
        url : 'customerManage/getCustomerList',
        dataType : 'json',
        contentType : 'application/json',
        data : {
            offset : -1,
            limit : -1,
            keyWord : '',
            searchType : 'searchAll'
        },
        success : function(data){
            customerCache = data.rows;
        }
    });
}

function customerAutocomplete(){
	$('#customer_input').autocomplete({
		minLength : 0,
		delay : 500,
		source : function(request, response){
            var autoCompleteInfo = Array();
            var customerFilter = customerCache.filter(
                function (item) {
                    return item.name.indexOf(request.term) > -1
				}
			)
            $.each(customerFilter,function(index,elem){
                autoCompleteInfo.push({label:elem.name,value:elem.id});
            });
            response(autoCompleteInfo);
		},
		focus : function(event,ui){
			$('#customer_input').val(ui.item.label);
			return false;
		},
		select : function(event,ui){
			$('#customer_input').val(ui.item.label);
			stockout_customer = ui.item.value;
			customerInfoSet(stockout_customer);
			loadStorageInfo();
			return false;
		}
	})
}

function goodsInfoSet(goodsID){
	var detailInfo;
	$.each(goodsCache,function(index,elem){
		if(elem.id == goodsID){
			detailInfo = elem;
			if(detailInfo.id==null)
				$('#info_goods_ID').text('-');
			else
				$('#info_goods_ID').text(detailInfo.id);
			
			if(detailInfo.name==null)
				$('#info_goods_name').text('-');
			else
				$('#info_goods_name').text(detailInfo.name);
			
			if(detailInfo.category==null)
				$('#info_goods_type').text('-');
			else
				$('#info_goods_type').text(detailInfo.category);
			
			if(detailInfo.size==null)
				$('#info_goods_size').text('-');
			else
				$('#info_goods_size').text(detailInfo.size);
			
			if(detailInfo.value==null)
				$('#info_goods_value').text('-');
			else
				$('#info_goods_value').text(detailInfo.value);
		}
	})
}

function customerInfoSet(customerID){
	var detailInfo;
	$.each(customerCache,function(index,elem){
		if(elem.id == customerID){
			detailInfo = elem;

			if(detailInfo.id == null)
				$('#info_customer_ID').text('-');
			else
				$('#info_customer_ID').text(detailInfo.id);
			
			if(detailInfo.name == null)
				$('#info_customer_name').text('-');
			else
				$('#info_customer_name').text(detailInfo.name);
			
			if(detailInfo.tel == null)
				$('#info_customer_tel').text('-');
			else
				$('#info_customer_tel').text(detailInfo.tel);
			
			if(detailInfo.address == null)
				$('#info_customer_address').text('-');
			else
				$('#info_customer_address').text(detailInfo.address);
			
			if(detailInfo.email == null)
				$('#info_customer_email').text('-');
			else
				$('#info_customer_email').text(detailInfo.email);
			
			if(detailInfo.personInCharge == null)
				$('#info_customer_person').text('-');
			else
				$('#info_customer_person').text(detailInfo.personInCharge);
				
		}
	})
}

function detilInfoToggle(){
	$('#info-show-good,#info-show-customer').click(function(){
		$('#goodDetailInfo,#customerDetailInfo').removeClass('hide');
		$('#info-show-good,#info-show-customer').addClass('hide');
		$('#info-hidden-good,#info-hidden-customer').removeClass('hide');
	});

	$('#info-hidden-good,#info-hidden-customer').click(function(){
		$('#goodDetailInfo,#customerDetailInfo').removeClass('hide').addClass('hide');
		$('#info-hidden-good,#info-hidden-customer').addClass('hide');
		$('#info-show-good,#info-show-customer').removeClass('hide');
	});
}

// 仓库下拉列表初始化
function repositorySelectorInit(goodsID){
    $.ajax({
        type : 'GET',
        url : 'repositoryManage/getRepositoryByGoodId',
        dataType : 'json',
        contentType : 'application/json',
        data : {
            goodId : goodsID
        },
        success : function(response){
            $('#repository_selector').empty();
            $('#repository_selector').append("<option value='' selected>请选择仓库</option>");
            $.each(response.data,function(index,elem){
                $('#repository_selector').append("<option value='" + elem.id + "'>" + elem.name +"</option>");
            });
        },
        error : function(response){
            $('#repository_selector').append("<option value='-1'>加载失败</option>");
        }

    })
}

// 获取仓库的货架
function fetchShelves(){
    $('#repository_selector').change(function(){
        stockout_repository = $(this).val();
        loadShelvesInfo();
    });
}

// 获取仓库当前货架库存量
function fetchStorage(){
    $('#shelves_selector').change(function(){
        stockout_shelves = $(this).val();
        loadStorageInfo();
    });
}

function loadShelvesInfo(){
    if(stockout_repository != null && stockout_goods != null){
        $.ajax({
            type : 'GET',
            url : 'shelvesManage/queryByReposAndGood',
            dataType : 'json',
            contentType : 'application/json',
            data : {
                repositoryId : stockout_repository,
                goodId : stockout_goods
            },
            success : function(response){
                $('#shelves_selector').empty();
                $('#shelves_selector').append("<option value='' selected>请选择货架</option>");
                $.each(response.rows,function(index,elem){
                    $('#shelves_selector').append("<option value='" + elem.id + "'>" + elem.name +"</option>");
                });
            },
            error : function(response){
                $('#shelves_selector').append("<option value='-1'>加载失败</option>");
            }
        })
    }
}

function loadStorageInfo(){
    if(stockout_repository != null && stockout_goods != null && stockout_shelves != null){
        $.ajax({
            type : 'GET',
            url : 'storageManage/getStorageListWithRepository',
            dataType : 'json',
            contentType : 'application/json',
            data : {
                offset : -1,
                limit : -1,
                searchType : 'searchByGoodsID',
                repositoryBelong : stockout_repository,
                shelvesBelong : stockout_shelves,
                keyword : stockout_goods
            },
            success : function(response){
                if(response.total > 0){
                    data = response.rows[0].number;
                    $('#info_storage').text(data);
                }else{
                    $('#info_storage').text('0');
                }
            },
            error : function(response){

            }
        })
    }
}

//执行货物添加出库
function addStockout(){
    $('#add').click(function(){
        // data validate
        $('#stockout_form').data('bootstrapValidator').validate();
        if (!$('#stockout_form').data('bootstrapValidator').isValid()) {
            return;
        }
        $('#stockout_packages_form').data('bootstrapValidator').validate();
        if (!$('#stockout_packages_form').data('bootstrapValidator').isValid()) {
            return;
        }

        var item = {
            customerID : stockout_customer,
            goodID : stockout_goods,
            repositoryID : stockout_repository,
            shelvesID : stockout_shelves,
            number : $('#stockout_input').val(),
			packages : $('#stockout_packages').val(),
			remark : $('#stockout_remark').val(),
			name : $('#info_goods_name').text(),
			size :$('#info_goods_size').text(),
			value:$('#info_goods_value').text(),
            storeman:$('#storeman').val(),
            inputman:$('#inputman').val()
        }
        item.total = (item.number * item.value).toFixed(2);

        stockOutList.push(item);
        tableRefresh(item);
        goodReset();
    });
}

// 刪除货物信息
function deleteStockout(){
    $('#delete_confirm').click(function(){
        $('#stockOutList').bootstrapTable('removeByIndex',deleteIndex);

        stockOutList.splice(deleteIndex,1);

        $('#deleteWarning_modal').modal('hide');
    })
}

//执行货物出库操作
function stockoutOperation(){
	$('#submit').click(function(){
		$.ajax({
			type : 'POST',
			url : 'stockRecordManage/stockOut',
			dataType : 'json',
            contentType: "application/json; charset=utf-8",
			data : JSON.stringify(stockOutList),
			success : function(response){
				var msg;
				var type;
				
				if(response.result == "error"){
                    type = 'error';
                    msg = '货物出库失败';
				}else{
                    batchId = response.result;
                    type = 'success';
                    msg = '货物出库成功<br>点击<a onclick="preview();"  href="javascript:void(0);">打印预览</a>出库单';
				}

                infoModal(type, msg);
			},
			error : function(response){
				var msg = "服务器错误";
				var type = "error";
				infoModal(type, msg);
			}
		})
	});
}

function inputReset(){
	$('#customer_input').val('');
    $('#storeman').val('');
    $('#inputman').val('');
	$('#goods_input').val('');
	$('#stockout_input').val('');
    $('#stockout_packages').val('');
    $('#stockout_remark').val('');
	$('#info_customer_ID').text('-');
	$('#info_customer_name').text('-');
	$('#info_customer_tel').text('-');
	$('#info_customer_address').text('-');
	$('#info_customer_email').text('-');
	$('#info_customer_person').text('-');
	$('#info_goods_ID').text('-');
	$('#info_goods_name').text('-');
	$('#info_goods_size').text('-');
	$('#info_goods_type').text('-');
	$('#info_goods_value').text('-');
	$('#info_storage').text('-');
    $('#shelves_selector').empty();
    $('#shelves_selector').append("<option value='' selected>请选择货架</option>");
    $('#repository_selector').empty();
    $('#repository_selector').append("<option value='' selected>请选择仓库</option>");
	$('#stockout_form').bootstrapValidator("resetForm",true); 
}

function goodReset(){
    $('#goods_input').val('');
    $('#stockout_input').val('');
    $('#stockout_packages').val('');
    $('#stockout_remark').val('');
    $('#info_goods_ID').text('-');
    $('#info_goods_name').text('-');
    $('#info_goods_size').text('-');
    $('#info_goods_type').text('-');
    $('#info_goods_value').text('-');
    $('#info_storage').text('-');
    $('#shelves_selector').empty();
    $('#shelves_selector').append("<option value='' selected>请选择货架</option>");
    $('#repository_selector').empty();
    $('#repository_selector').append("<option value='' selected>请选择仓库</option>");
    $('#stockout_form').bootstrapValidator("resetForm",true);
}

function infoModal(type, msg) {
	$('#info_success').removeClass("hide");
	$('#info_error').removeClass("hide");
	if (type == "success") {
		$('#info_error').addClass("hide");
	} else if (type == "error") {
		$('#info_success').addClass("hide");
	}
	$('#info_content').html(msg);
	$('#info_modal').modal("show");
}

function infoModalHidden(){
    $("#info_modal").on('hide.bs.modal',function(){
        inputReset();
        $('#stockOutList').bootstrapTable('removeAll');
        stockOutList = new Array();
        batchId = null;
	})
}

// 表格刷新
function tableRefresh(data) {
    $("#stockOutList").bootstrapTable('append', data);
}

function stockOutListInit() {
    $('#stockOutList')
        .bootstrapTable(
            {
                columns : [
					{
                        filed: 'Num',
					    formatter:function (value, row, index) {
							return index + 1;
                        },
                        footerFormatter:function (value) {
                            return "合计";
                        }
					},
                    {
                        field : 'name',
                        title : '品名'
                    },
                    {
                        field : 'size',
                        title : '规格'
                    },
                    {
                        field : 'unit',
                        title : '单位'
                    },
                    {
                        field : 'number',
                        title : '数量',
                        footerFormatter:function (value) {
                            var count = 0;
                            for (var i in value){
                                if (value[i].number != null){
                                    count += parseInt(value[i].number);
                                }
                            }
                            count = count.toFixed(0);
                            return count;
                        }
                    },
                    {
                        field : 'value',
                        title : '单价',
                    },
                    {
                        field : 'total',
                        title : '金额',
						footerFormatter:function (value) {
							var count = 0;
							for (var i in value){
							    if (value[i].total != null){
							        count += Number(value[i].total);
								}
							}
                            count = count.toFixed(2);
							return count;
                        }
                    },
                    {
                        field : 'packages',
                        title : '件数',
                        footerFormatter:function (value) {
                            var count = 0;
                            for (var i in value){
                                if (value[i].packages != null){
                                    count += parseInt(value[i].packages);
                                }
                            }
                            count = count.toFixed(0);
                            return count;
                        }
                    },
                    {
                        field : 'remark',
                        title : '备注',
                    },
                    {
                        field : 'operation',
                        title : '操作',
                        formatter : function(value, row, index) {
                            var d = '<button class="btn btn-danger btn-sm delete"><span>删除</span></button>';
                            return d;
                        },
                        events : {
                            // 操作列中编辑按钮的动作
                            'click .delete' : function(e,value, row, index) {
                                deleteIndex = index;

                                $('#deleteWarning_modal').modal('show');
                            }
                        }
                    } ],
                data : stockOutList,
                sidePagination : "server",
                dataType : 'json',
                pagination : false,
                clickToSelect : true,
				showFooter : true,
                onPostBody:function () {
                    //合并页脚
                    merge_footer();
                }
            });
}

//合并页脚
function merge_footer() {
    var footer_tbody = $('.fixed-table-footer table tbody');
    var footer_tr = footer_tbody.find('>tr');
    var footer_td = footer_tr.find('>td');
    var footer_td_1 = footer_td.eq(0);

    var body_thead = $('.fixed-table-body table thead');
    var body_tr = body_thead.find('>tr');
    var body_th = body_tr.find('>th');

    var width = 0;
    for(var i=0;i<4;i++) {
        footer_td.eq(i).hide();
        width += body_th.eq(i).width();
    }
    width += 3;
    footer_td_1.attr('width', width+"px").show();

    for(var i=4;i<body_th.length-1;i++){
        var w = body_th.eq(i).width()+1;
        footer_td.eq(i).attr('width', w+"px").show();
	}
}
</script>

<div class="panel panel-default">
	<ol class="breadcrumb">
		<li>选择客户</li>
	</ol>
	<div class="row" style="margin-bottom: 15px;">
		<div class="col-md-4 col-sm-4">
			<div class="row">
				<div class="col-md-1 col-sm-1"></div>
				<div class="col-md-10 col-sm-11">
					<form action="" class="form-inline">
						<div class="form-group">
							<label for="" class="form-label">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;客户：</label>
							<input type="text" class="form-control" id="customer_input" placeholder="请输入客户名称">
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="col-md-4 col-sm-4">
			<div class="row">
				<div class="col-md-1 col-sm-1"></div>
				<div class="col-md-10 col-sm-11">
					<form action="" class="form-inline">
						<div class="form-group">
							<label for="" class="form-label">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;库管：</label>
							<input type="text" class="form-control" id="storeman" placeholder="请输入库管姓名">
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="col-md-4 col-sm-4">
			<div class="row">
				<div class="col-md-1 col-sm-1"></div>
				<div class="col-md-10 col-sm-11">
					<form action="" class="form-inline">
						<div class="form-group">
							<label for="" class="form-label">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;入库人员：</label>
							<input type="text" class="form-control" id="inputman" placeholder="请输入入库人员">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="row visible-md visible-lg" style="margin: 5px;">
		<div class="col-md-12">
			<div class='pull-right' style="cursor:pointer" id="info-show-customer">
				<span>显示详细信息</span>
				<span class="glyphicon glyphicon-chevron-down"></span>
			</div>
			<div class='pull-right hide' style="cursor:pointer" id="info-hidden-customer">
				<span>隐藏详细信息</span>
				<span class="glyphicon glyphicon-chevron-up"></span>
			</div>
		</div>
	</div>
	<div class="row hide" id="customerDetailInfo" style="margin-bottom:30px">
		<div class="col-xs-12  visible-md visible-lg">
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<label for="" class="text-info">客户信息</label>
				</div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-11">
					<div class="col-md-5">
						<div style="margin-top:5px">
							<div class="col-md-6">
								<span for="" class="pull-right">客户ID：</span>
							</div>
							<div class="col-md-6">
								<span id="info_customer_ID">-</span>
							</div>
						</div>
						<div style="margin-top:5px">
							<div class="col-md-6">
								<span for="" class="pull-right">负责人：</span>
							</div>
							<div class="col-md-6">
								<span id="info_customer_person">-</span>
							</div>
						</div>
						<div style="margin-top:5px">
							<div class="col-md-6">
								<span for="" class="pull-right">电子邮件：</span>
							</div>
							<div class="col-md-6">
								<span id="info_customer_email">-</span>
							</div>
						</div>
					</div>
					<div class="col-md-7">
						<div style="margin-top:5px">
							<div class="col-md-6">
								<span for="" class="pull-right">客户名：</span>
							</div>
							<div class="col-md-6">
								<span id="info_customer_name">-</span>
							</div>
						</div>
						<div style="margin-top:5px">
							<div class="col-md-6">
								<span for="" class="pull-right">联系电话：</span>
							</div>
							<div class="col-md-6">
								<span id="info_customer_tel">-</span>
							</div>
						</div>
						<div style="margin-top:5px">
							<div class="col-md-6">
								<span for="" class="pull-right">联系地址：</span>
							</div>
							<div class="col-md-6">
								<span id="info_customer_address">-</span>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<ol class="breadcrumb">
		<li>选择出库货物</li>
	</ol>
	<div class="panel-body">
		<div class="row">
			<div class="col-md-6 col-sm-6">
				<div class="row">
					<div class="col-md-1 col-sm-1"></div>
					<div class="col-md-10 col-sm-11">
						<form action="" class="form-inline">
							<div class="form-group">
								<label for="" class="form-label">出库货物：</label>
								<input type="text" class="form-control" id="goods_input" placeholder="请输入货物名称">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="row visible-md visible-lg">
			<div class="col-md-12">
				<div class='pull-right' style="cursor:pointer" id="info-show-good">
					<span>显示详细信息</span>
					<span class="glyphicon glyphicon-chevron-down"></span>
				</div>
				<div class='pull-right hide' style="cursor:pointer" id="info-hidden-good">
					<span>隐藏详细信息</span>
					<span class="glyphicon glyphicon-chevron-up"></span>
				</div>
			</div>
		</div>
		<div class="row hide" id="goodDetailInfo" style="margin-bottom:30px">
			<div class="col-xs-12 visible-md visible-lg">
				<div class="row">
					<div class="col-md-1 col-sm-1"></div>
					<div class="col-md-11 col-sm-11">
						<label for="" class="text-info">货物信息</label>
					</div>
				</div>
				<div class="row">
					<div class="col-md-1"></div>
					<div class="col-md-11">
						<div class="col-md-6">
							<div style="margin-top:5px">
								<div class="col-md-6">
									<span for="" class="pull-right">货物ID：</span>
								</div>
								<div class="col-md-6">
									<span id="info_goods_ID">-</span>
								</div>
							</div>
							<div style="margin-top:5px">
								<div class="col-md-6">
									<span for="" class="pull-right">货物类型：</span>
								</div>
								<div class="col-md-6">
									<span id="info_goods_type">-</span>
								</div>
							</div>
							<div style="margin-top:5px">
								<div class="col-md-6">
									<span for="" class="pull-right">货物名：</span>
								</div>
								<div class="col-md-6">
									<span id="info_goods_name">-</span>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div style="margin-top:5px">
								<div class="col-md-6">
									<span for="" class="pull-right">货物规格：</span>
								</div>
								<div class="col-md-6">
									<span id="info_goods_size">-</span>
								</div>
							</div>
							<div style="margin-top:5px">
								<div class="col-md-6">
									<span for="" class="pull-right">货物价值：</span>
								</div>
								<div class="col-md-6">
									<span id="info_goods_value">-</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="margin-top: 10px">
			<div class="col-md-6 col-sm-6">
				<div class="row">
					<div class="col-md-1 col-sm-1"></div>
					<div class="col-md-10 col-sm-11">
						<form action="" class="form-inline">
							<div class="form-group">
								<label for="" class="form-label">出库仓库：</label>
								<select name="" id="repository_selector" class="form-control">
									<option value="">请选择仓库</option>
								</select>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<div class="row">
					<div class="col-md-1 col-sm-1"></div>
					<div class="col-md-10 col-sm-11">
						<form action="" class="form-inline">
							<div class="form-group">
								<label for="" class="form-label">出库货架：</label>
								<select name="" id="shelves_selector" class="form-control">
									<option value="">请选择货架</option>
								</select>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="margin-top:20px">
			<div class="col-md-6 col-sm-6">
				<div class="row">
					<div class="col-md-1 col-sm-1"></div>
					<div class="col-md-20 col-sm-11">
						<form action="" class="form-inline" id="stockout_form">
							<div class="form-group">
								<label for="" class="form-label">出库数量：</label>
								<input type="text" class="form-control" placeholder="请输入数量" id="stockout_input" name="stockout_input">
								<span>(当前库存量：</span>
								<span id="info_storage">-</span>
								<span>)</span>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<div class="row">
					<div class="col-md-1 col-sm-1"></div>
					<div class="col-md-20 col-sm-11">
						<form action="" class="form-inline" id="stockout_packages_form">
							<div class="form-group">
								<label for="" class="form-label">出库件数：</label>
								<input type="text" class="form-control" placeholder="请输入件数" id="stockout_packages" name="stockout_packages">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="margin-top:20px">
			<div class="col-md-6 col-sm-6">
				<div class="row">
					<div class="col-md-1 col-sm-1"></div>
					<div class="col-md-20 col-sm-11">
						<form action="" class="form-inline" >
							<div class="form-group" style="width: 100%;" >
								<label for="" class="form-label">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：</label>
								<input type="text" class="form-control" id="stockout_remark" name="stockout_remark" style="width: 80%;">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div style="text-align:right;padding-right: 18px;">
				<button class="btn btn-success" id="add">添加出库</button>
			</div>
		</div>
	</div>

	<ol class="breadcrumb">
		<li>出库货物列表</li>
	</ol>
	<div class="row" style="margin-top: 15px">
		<div class="col-md-12" id="list">
			<table id="stockOutList" class="table table-striped"></table>
		</div>
	</div>
	<div class="panel-footer">
		<div style="text-align:right">
			<button class="btn btn-success" id="submit">提交出库</button>
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
						<h3>是否确认移除该条货物信息</h3>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" type="button" data-dismiss="modal">
					<span>取消</span>
				</button>
				<button class="btn btn-danger" type="button" id="delete_confirm">
					<span>确认</span>
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
