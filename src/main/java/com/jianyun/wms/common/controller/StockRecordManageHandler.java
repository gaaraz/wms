package com.jianyun.wms.common.controller;

import com.jianyun.wms.common.util.Response;
import com.jianyun.wms.domain.StockOutDO;
import com.jianyun.wms.domain.StockRecordDTO;
import com.jianyun.wms.common.service.Interface.StockRecordManageService;
import com.jianyun.wms.common.util.ResponseUtil;
import com.jianyun.wms.exception.StockRecordManageServiceException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 商品出入库管理请求Handler
 *
 * @author Ken
 * @since 017/4/5.
 */
@Controller
@RequestMapping(value = "stockRecordManage")
public class StockRecordManageHandler {

    @Autowired
    private ResponseUtil responseUtil;
    @Autowired
    private StockRecordManageService stockRecordManageService;

    /**
     * 货物出库操作
     * @param request      http请求
     * @return 返回一个map，key为result的值表示操作是否成功
     */
    @RequestMapping(value = "stockOut", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> stockOut(@RequestBody List<StockOutDO> stockOutList, HttpServletRequest request) throws StockRecordManageServiceException {
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();

        HttpSession session = request.getSession();
        String personInCharge = (String) session.getAttribute("userName");

        String result = stockRecordManageService.stockOutOperation(stockOutList, personInCharge);

        // 设置 Response
        responseContent.setResponseResult(result);
        return responseContent.generateResponse();
    }

    /**
     * 货物入库操作
     *
     * @param supplierID   供应商ID
     * @param goodsID      货物ID
     * @param repositoryID 仓库ID
     * @param number       入库数目
     * @param request      http 请求
     * @return 返回一个map，key为result的值表示操作是否成功
     */
    @RequestMapping(value = "stockIn", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> stockIn(@RequestParam("supplierID") Integer supplierID, @RequestParam("shelvesID") Integer shelvesID,
                                @RequestParam("goodsID") Integer goodsID, @RequestParam("repositoryID") Integer repositoryID,
                                @RequestParam("number") long number, HttpServletRequest request) throws StockRecordManageServiceException {
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();

        HttpSession session = request.getSession();
        String personInCharge = (String) session.getAttribute("userName");

        String result = stockRecordManageService.stockInOperation(supplierID, goodsID, repositoryID, shelvesID, number, personInCharge) ?
                Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;

        // 设置 Response
        responseContent.setResponseResult(result);
        return responseContent.generateResponse();
    }

    @SuppressWarnings({"SingleStatementInBlock", "unchecked"})
    @RequestMapping(value = "getStockInRecord", method = RequestMethod.GET)
    public @ResponseBody
    Map<String, Object> getStockInRecord(@RequestParam("repositoryID") String repositoryIDStr,
                                         @RequestParam("startDate") String startDateStr,
                                         @RequestParam("endDate") String endDateStr,
                                         @RequestParam("limit") int limit,
                                         @RequestParam("offset") int offset) throws ParseException, StockRecordManageServiceException{
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();
        List<StockRecordDTO> rows = null;
        long total = 0;

        // 参数检查
        String regex = "([0-9]{4})-([0-9]{2})-([0-9]{2})";
        boolean startDateFormatCheck = (StringUtils.isEmpty(startDateStr) || startDateStr.matches(regex));
        boolean endDateFormatCheck = (StringUtils.isEmpty(endDateStr) || endDateStr.matches(regex));
        boolean repositoryIDCheck = (StringUtils.isEmpty(repositoryIDStr) || StringUtils.isNumeric(repositoryIDStr));

        if (startDateFormatCheck && endDateFormatCheck && repositoryIDCheck) {
            Integer repositoryID = -1;
            if (StringUtils.isNumeric(repositoryIDStr)) {
                repositoryID = Integer.valueOf(repositoryIDStr);
            }

            // 转到 Service 执行查询
            Map<String, Object> queryResult = stockRecordManageService.selectStockInRecord(repositoryID, startDateStr, endDateStr, offset, limit);
            if (queryResult != null) {
                rows = (List<StockRecordDTO>) queryResult.get("data");
                total = (long) queryResult.get("total");
            }
        } else {
            responseContent.setResponseMsg("Request argument error");
        }

        if (rows == null)
            rows = new ArrayList<>(0);

        responseContent.setCustomerInfo("rows", rows);
        responseContent.setResponseTotal(total);
        return responseContent.generateResponse();
    }

    @SuppressWarnings({"SingleStatementInBlock", "unchecked"})
    @RequestMapping(value = "getStockOutRecord", method = RequestMethod.GET)
    public @ResponseBody
    Map<String, Object> getStockOutRecord(@RequestParam("repositoryID") String repositoryIDStr,
                                         @RequestParam("startDate") String startDateStr,
                                         @RequestParam("endDate") String endDateStr,
                                         @RequestParam("limit") int limit,
                                         @RequestParam("offset") int offset) throws ParseException, StockRecordManageServiceException{
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();
        List<StockRecordDTO> rows = null;
        long total = 0;

        // 参数检查
        String regex = "([0-9]{4})-([0-9]{2})-([0-9]{2})";
        boolean startDateFormatCheck = (StringUtils.isEmpty(startDateStr) || startDateStr.matches(regex));
        boolean endDateFormatCheck = (StringUtils.isEmpty(endDateStr) || endDateStr.matches(regex));
        boolean repositoryIDCheck = (StringUtils.isEmpty(repositoryIDStr) || StringUtils.isNumeric(repositoryIDStr));

        if (startDateFormatCheck && endDateFormatCheck && repositoryIDCheck) {
            Integer repositoryID = -1;
            if (StringUtils.isNumeric(repositoryIDStr)) {
                repositoryID = Integer.valueOf(repositoryIDStr);
            }

            // 转到 Service 执行查询
            Map<String, Object> queryResult = stockRecordManageService.selectStockOutRecord(repositoryID, startDateStr, endDateStr, offset, limit);
            if (queryResult != null) {
                rows = (List<StockRecordDTO>) queryResult.get("data");
                total = (long) queryResult.get("total");
            }
        } else {
            responseContent.setResponseMsg("Request argument error");
        }

        if (rows == null)
            rows = new ArrayList<>(0);

        responseContent.setCustomerInfo("rows", rows);
        responseContent.setResponseTotal(total);
        return responseContent.generateResponse();
    }


    @RequestMapping(value = "queryStatisticalData", method = RequestMethod.GET)
    public @ResponseBody Map<String, Object> queryStatisticalData(@RequestParam("goodID") String goodID,
                                                                  @RequestParam("startDate") String startDate,
                                                                  @RequestParam("endDate") String endDate) throws Exception{
        Response responseContent = responseUtil.newResponseInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
        if (StringUtils.isBlank(endDate)){
            endDate = sdf.format(new Date());
        }

        if (StringUtils.isBlank(startDate)){
            Date endDateObj = sdf.parse(endDate);
            Calendar startDateCal = Calendar.getInstance();
            startDateCal.setTime(endDateObj);
            startDateCal.add(Calendar.MONTH,-11);
            startDate = sdf.format(startDateCal.getTime());
        }

        Integer goodId = null;
        if (StringUtils.isNotBlank(goodID) && StringUtils.isNumeric(goodID)){
            goodId = Integer.parseInt(goodID);
        }

        Map<String, Object> resultMap = stockRecordManageService.queryStatisticalData(goodId, startDate, endDate);

        responseContent.setCustomerInfo("rows", resultMap.get("data"));
        responseContent.setResponseTotal((Integer)resultMap.get("total"));
        return responseContent.generateResponse();
    }
}
