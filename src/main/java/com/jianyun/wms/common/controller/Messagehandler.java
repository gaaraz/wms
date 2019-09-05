package com.jianyun.wms.common.controller;

import com.jianyun.wms.common.service.Interface.MessageService;
import com.jianyun.wms.common.util.Response;
import com.jianyun.wms.common.util.ResponseUtil;
import com.jianyun.wms.domain.Message;
import com.jianyun.wms.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/9/4 14:09
 * @Modified By:
 */
@RestController
@RequestMapping(value = "/**/messageManage")
public class Messagehandler {
    @Autowired
    private MessageService messageService;
    @Autowired
    private ResponseUtil responseUtil;

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public Map<String, Object> list(@RequestParam("offset") int offset, @RequestParam("limit") int limit) throws BusinessException {
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();
        List<Message> rows = null;
        long total = 0;

        // 查询
        Map<String, Object> queryResult = messageService.selectAll(offset,limit);

        if (queryResult != null) {
            rows = (List<Message>) queryResult.get("data");
            total = (long) queryResult.get("total");
        }

        // 设置 Response
        responseContent.setCustomerInfo("rows", rows);
        responseContent.setResponseTotal(total);
        return responseContent.generateResponse();
    }

    @RequestMapping(value = "update", method = RequestMethod.POST)
    public Map<String, Object> update(@RequestParam("id") Integer id) throws BusinessException {
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();

        // 更新
        String result = messageService.update(id) ? Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;

        // 设置 Response
        responseContent.setResponseResult(result);
        return responseContent.generateResponse();
    }

    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public Map<String, Object> delete(@RequestParam("id") Integer id) throws BusinessException {
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();

        // 删除
        String result = messageService.delete(id) ? Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;

        // 设置 Response
        responseContent.setResponseResult(result);
        return responseContent.generateResponse();
    }

    @RequestMapping(value = "countUnread", method = RequestMethod.GET)
    public Map<String, Object> countUnread(){
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();

        Integer unread = messageService.countUnread();

        // 设置 Response
        responseContent.setResponseData(unread);
        return responseContent.generateResponse();
    }
}
