package com.jianyun.wms.common.controller;

import com.jianyun.wms.common.service.Interface.SystemLogService;
import com.jianyun.wms.common.util.Response;
import com.jianyun.wms.common.util.ResponseUtil;
import com.jianyun.wms.domain.AccessRecordDO;
import com.jianyun.wms.domain.UserOperationRecordDTO;
import com.jianyun.wms.exception.SystemLogServiceException;
import com.jianyun.wms.util.TimeUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 系统操作日志请求 Handler
 *
 * @author Ken
 * @since 2017/4/7.
 */
@Controller
@RequestMapping(value = "/systemLog")
public class SystemLogHandler {

    @Autowired
    private SystemLogService systemLogService;
    @Autowired
    private ResponseUtil responseUtil;

    /**
     * 查询系统的登入登出日志
     *
     * @param userIDStr    用户ID
     * @param accessType   记录类型（登入、登出或全部）
     * @param startDateStr 记录的起始日期
     * @param endDateStr   记录的结束日期
     * @param offset       分页的偏移值
     * @param limit        分页的大小
     * @return 返回 JSON 数据 其中：Key为rows的值代表所有记录数据，Key为total的值代表记录的总条数
     * @throws SystemLogServiceException SystemLogServiceException
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "getAccessRecords", method = RequestMethod.GET)
    public @ResponseBody
    Map<String, Object> getAccessRecords(@RequestParam("userID") String userIDStr,
                                         @RequestParam("accessType") String accessType,
                                         @RequestParam("startDate") String startDateStr,
                                         @RequestParam("endDate") String endDateStr,
                                         @RequestParam("offset") int offset,
                                         @RequestParam("limit") int limit) throws SystemLogServiceException {
        // 创建 Response 对象
        Response response = responseUtil.newResponseInstance();
        List<AccessRecordDO> rows = null;
        long total = 0;

        // 检查参数
        String regex = "([0-9]{4})-([0-9]{2})-([0-9]{2})";
        boolean startDateFormatCheck = (StringUtils.isEmpty(startDateStr) || startDateStr.matches(regex));
        boolean endDateFormatCheck = (StringUtils.isEmpty(endDateStr) || endDateStr.matches(regex));
        boolean userIDCheck = (StringUtils.isEmpty(userIDStr) || StringUtils.isNumeric(userIDStr));

        if (startDateFormatCheck && endDateFormatCheck && userIDCheck) {
            // 转到 Service 执行查询
            Integer userID = -1;
            if (StringUtils.isNumeric(userIDStr))
                userID = Integer.valueOf(userIDStr);
            Map<String, Object> queryResult = systemLogService.selectAccessRecord(userID, accessType, startDateStr, endDateStr, offset, limit);
            if (queryResult != null) {
                rows = (List<AccessRecordDO>) queryResult.get("data");
                total = (long) queryResult.get("total");
            }
        } else
            response.setResponseMsg("Request Argument Error");

        if (rows == null)
            rows = new ArrayList<>(0);

        // 返回 Response
        response.setCustomerInfo("rows", rows);
        response.setResponseTotal(total);
        return response.generateResponse();
    }

    /**
     * 查询系统的操作日志
     *
     * @param userIDStr    用户ID
     * @param startDateStr 记录的起始日期
     * @param endDateStr   记录的结束日期
     * @param offset       分页的偏移值
     * @param limit        分页的大小
     * @return 返回 JSON 数据 其中：Key为rows的值代表所有记录数据，Key为total的值代表记录的总条数
     * @throws SystemLogServiceException SystemLogServiceException
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "getUserOperationRecords")
    public @ResponseBody
    Map<String, Object> selectUserOperationRecords(@RequestParam("userID") String userIDStr,
                                                   @RequestParam("startDate") String startDateStr,
                                                   @RequestParam("endDate") String endDateStr,
                                                   @RequestParam("offset") int offset,
                                                   @RequestParam("limit") int limit) throws SystemLogServiceException {
        // 创建 Response
        Response response = responseUtil.newResponseInstance();
        List<UserOperationRecordDTO> rows = null;
        long total = 0;

        // 检查参数
        String regex = "([0-9]{4})-([0-9]{2})-([0-9]{2})";
        boolean startDateFormatCheck = (StringUtils.isEmpty(startDateStr) || startDateStr.matches(regex));
        boolean endDateFormatCheck = (StringUtils.isEmpty(endDateStr) || endDateStr.matches(regex));
        boolean userIDCheck = (StringUtils.isEmpty(userIDStr) || StringUtils.isNumeric(userIDStr));

        if (startDateFormatCheck && endDateFormatCheck && userIDCheck) {
            // 转到 Service 进行查询
            Integer userID = -1;
            if (StringUtils.isNumeric(userIDStr))
                userID = Integer.valueOf(userIDStr);
            Map<String, Object> queryResult = systemLogService.selectUserOperationRecord(userID, startDateStr, endDateStr, offset, limit);
            if (queryResult != null) {
                rows = (List<UserOperationRecordDTO>) queryResult.get("data");
                total = (long) queryResult.get("total");
            }
        } else
            response.setResponseMsg("Request argument error");

        if (rows == null)
            rows = new ArrayList<>(0);

        response.setCustomerInfo("rows", rows);
        response.setResponseTotal(total);
        return response.generateResponse();
    }

    @RequestMapping(value = "exportSql", method = RequestMethod.GET)
    public void exportSql(HttpServletResponse response) throws IOException {
        String fileName = "wms_db_"+ TimeUtil.getCurrentTimeMillis()+".sql";

        // 获取生成的文件
        File file = systemLogService.exportSql();

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

    @RequestMapping(value = "importSql", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> importSql(@RequestParam("file") MultipartFile file) {
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();
        String result = Response.RESPONSE_RESULT_SUCCESS;

        // 读取文件内容
        if (file == null)
            result = Response.RESPONSE_RESULT_ERROR;
        Boolean importInfo = systemLogService.importSql(file);
        if (!importInfo){
            result = Response.RESPONSE_RESULT_ERROR;
        }

        // 设置 Response
        responseContent.setResponseResult(result);
        return responseContent.generateResponse();
    }
}
