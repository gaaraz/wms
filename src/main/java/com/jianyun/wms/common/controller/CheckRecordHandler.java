package com.jianyun.wms.common.controller;

import com.jianyun.wms.common.service.Interface.CheckRecordService;
import com.jianyun.wms.common.util.Response;
import com.jianyun.wms.common.util.ResponseUtil;
import com.jianyun.wms.domain.CheckRecord;
import com.jianyun.wms.exception.BusinessException;
import com.jianyun.wms.util.TimeUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/23 10:05
 * @Modified By:
 */
@RestController
@RequestMapping("/**/checkRecordManage")
public class CheckRecordHandler {
    @Autowired
    private CheckRecordService checkRecordService;
    @Autowired
    private ResponseUtil responseUtil;

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public Map<String, Object> list(@RequestParam Map<String,String> params) throws BusinessException {
        // 初始化 Response
        Response response = responseUtil.newResponseInstance();

        Map<String,Object> paramMap = new HashMap<>();
        String goodId = params.get("goodId");
        String repositoryId = params.get("repositoryId");
        String shelvesId = params.get("shelvesId");
        String startDate = params.get("startDate");
        String endDate = params.get("endDate");
        String offset = params.get("offset");
        String limit = params.get("limit");

        paramMap.put("offset",offset);
        paramMap.put("limit",limit);
        paramMap.put("goodId",goodId);
        paramMap.put("repositoryId",repositoryId);
        paramMap.put("shelvesId",shelvesId);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if (StringUtils.isNotBlank(startDate)){
            try {
                paramMap.put("startDate",sdf.parse(startDate));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        if (StringUtils.isNotBlank(endDate)){
            try {
                paramMap.put("endDate",sdf.parse(endDate));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        // 查询
        Map<String, Object> queryResult = checkRecordService.selectByParam(paramMap);

        // 返回 Response
        response.setCustomerInfo("rows", queryResult.get("data"));
        response.setResponseTotal((long) queryResult.get("total"));
        return response.generateResponse();
    }


    @RequestMapping(value = "add", method = RequestMethod.POST)
    public Map<String, Object> add(@RequestBody CheckRecord record) throws BusinessException {
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();

        // 添加记录
        String result = checkRecordService.insert(record) ? Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;

        // 设置 Response
        responseContent.setResponseResult(result);

        return responseContent.generateResponse();
    }

    @RequestMapping(value = "exportCheckRecord", method = RequestMethod.GET)
    public void exportCheckRecord(@RequestParam Map<String,String> params,
                              HttpServletResponse response) throws BusinessException, IOException {

        String fileName = "checkRecordInfo"+ TimeUtil.getTodayDate()+".xlsx";

        Map<String,Object> paramMap = new HashMap<>();
        String goodId = params.get("goodId");
        String repositoryId = params.get("repositoryId");
        String shelvesId = params.get("shelvesId");
        String startDate = params.get("startDate");
        String endDate = params.get("endDate");

        paramMap.put("offset",-1);
        paramMap.put("limit",-1);
        paramMap.put("goodId",goodId);
        paramMap.put("repositoryId",repositoryId);
        paramMap.put("shelvesId",shelvesId);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if (StringUtils.isNotBlank(startDate)){
            try {
                paramMap.put("startDate",sdf.parse(startDate));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        if (StringUtils.isNotBlank(endDate)){
            try {
                paramMap.put("endDate",sdf.parse(endDate));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }


        List<CheckRecord> records = null;
        // 查询
        Map<String, Object> queryResult = checkRecordService.selectByParam(paramMap);

        if (queryResult != null) {
            records = (List<CheckRecord>) queryResult.get("data");
        }

        // 获取生成的文件
        File file = checkRecordService.exportRecord(records);

        // 写出文件
        if (file != null) {
            // 设置响应头
            response.addHeader("Content-Disposition", "attachment;filename=" + fileName);
            FileInputStream inputStream = new FileInputStream(file);
            OutputStream outputStream = response.getOutputStream();
            byte[] buffer = new byte[8192];

            int len;
            while ((len = inputStream.read(buffer, 0, buffer.length)) > 0) {
                outputStream.write(buffer, 0, len);
                outputStream.flush();
            }

            inputStream.close();
            outputStream.close();
        }
    }
}
