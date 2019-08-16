package com.jianyun.wms.common.controller;

import com.jianyun.wms.common.service.Interface.CategoryService;
import com.jianyun.wms.common.util.Response;
import com.jianyun.wms.common.util.ResponseUtil;
import com.jianyun.wms.domain.Category;
import com.jianyun.wms.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/15 17:23
 * @Modified By:
 */
@RestController
@RequestMapping("/**/categoryManage")
public class CategoryHandler {
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ResponseUtil responseUtil;

    @RequestMapping(value = "getCategoryList", method = RequestMethod.GET)
    public Map<String, Object> getCategoryList(@RequestParam("offset") int offset, @RequestParam("limit") int limit,
                                     @RequestParam("keyWord") String keyWord) throws BusinessException {
        // 初始化 Response
        Response response = responseUtil.newResponseInstance();

        // 查询
        Map<String, Object> queryResult = categoryService.selectAll(offset,limit);

        // 返回 Response
        response.setCustomerInfo("rows", queryResult.get("data"));
        response.setResponseTotal((long) queryResult.get("total"));
        return response.generateResponse();
    }

    @RequestMapping(value = "addCategory", method = RequestMethod.POST)
    public Map<String, Object> addCategory(@RequestBody Category category) throws BusinessException {
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();

        // 添加记录
        String result = categoryService.addCategory(category) ? Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;

        // 设置 Response
        responseContent.setResponseResult(result);

        return responseContent.generateResponse();
    }

    @RequestMapping(value = "deleteCategory", method = RequestMethod.GET)
    public Map<String, Object> deleteCategory(@RequestParam("id") Integer id) throws BusinessException {
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();

        // 删除
        String result = categoryService.deleteCategory(id) ? Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;

        // 设置 Response
        responseContent.setResponseResult(result);
        return responseContent.generateResponse();
    }

    @RequestMapping(value = "updateCategory", method = RequestMethod.POST)
    public Map<String, Object> updateCategory(@RequestBody Category category) throws BusinessException {
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();

        // 更新
        String result = categoryService.updateCategory(category) ? Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;

        // 设置 Response
        responseContent.setResponseResult(result);
        return responseContent.generateResponse();
    }
}
