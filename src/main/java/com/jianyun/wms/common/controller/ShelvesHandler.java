package com.jianyun.wms.common.controller;

import com.jianyun.wms.common.service.Interface.GoodsManageService;
import com.jianyun.wms.common.service.Interface.ShelvesService;
import com.jianyun.wms.common.util.Response;
import com.jianyun.wms.common.util.ResponseUtil;
import com.jianyun.wms.domain.Goods;
import com.jianyun.wms.domain.Shelves;
import com.jianyun.wms.exception.BusinessException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/19 17:05
 * @Modified By:
 */
@RestController
@RequestMapping(value = "/**/shelvesManage")
public class ShelvesHandler {
    @Autowired
    private ShelvesService shelvesService;
    @Autowired
    private ResponseUtil responseUtil;
    @Autowired
    private GoodsManageService goodsManageService;

    private static final String SEARCH_BY_NAME = "searchByName";
    private static final String SEARCH_BY_REPOS = "searchByRepos";
    private static final String SEARCH_ALL = "searchAll";

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public Map<String, Object> list(@RequestParam("searchType") String searchType,
                                          @RequestParam("offset") int offset, @RequestParam("limit") int limit,
                                          @RequestParam("keyWord") String keyWord) throws BusinessException {
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();

        List<Shelves> rows = null;
        long total = 0;

        // 查询
        Map<String, Object> queryResult = query(searchType, keyWord, offset, limit);

        if (queryResult != null) {
            rows = (List<Shelves>) queryResult.get("data");
            total = (long) queryResult.get("total");

            for (Shelves shelves:rows){
                List<String> goodNames = new ArrayList<>();
                String goodIds = shelves.getGoodIds();
                List<String> goodIdsList = Arrays.asList(goodIds.split(","));
                for(String id:goodIdsList){
                    Goods good = goodsManageService.selectOneById(Integer.parseInt(id));
                    goodNames.add(good.getName());
                }
                shelves.setGoodNames(StringUtils.join(goodNames.toArray()," , "));
            }
        }

        // 设置 Response
        responseContent.setCustomerInfo("rows", rows);
        responseContent.setResponseTotal(total);
        return responseContent.generateResponse();
    }

    private Map<String, Object> query(String searchType, String keyword, int offset, int limit) throws BusinessException {
        Map<String, Object> queryResult = null;

        switch (searchType) {
            case SEARCH_BY_NAME:
                if (StringUtils.isNotBlank(keyword)) {
                    queryResult = shelvesService.selectByName(keyword);
                }
                break;
            case SEARCH_BY_REPOS:
                if (StringUtils.isNumeric(keyword)) {
                    queryResult = shelvesService.selectByRepos(Integer.parseInt(keyword));
                }
                break;
            case SEARCH_ALL:
                queryResult = shelvesService.selectAll(offset, limit);
                break;
            default:
                // do other thing
                break;
        }

        return queryResult;
    }


    @RequestMapping(value = "queryByReposAndGood", method = RequestMethod.GET)
    public Map<String, Object> queryByReposAndGood(@RequestParam("repositoryId") Integer repositoryId,
                                                   @RequestParam("goodId") String goodId) throws BusinessException{
        Response responseContent = responseUtil.newResponseInstance();
        Map<String, Object> queryByReposAndGood = shelvesService.queryByReposAndGood(repositoryId, goodId);

        responseContent.setCustomerInfo("rows", queryByReposAndGood.get("data"));
        responseContent.setResponseTotal(Long.parseLong(queryByReposAndGood.get("total").toString()));
        return responseContent.generateResponse();
    }


    @RequestMapping(value = "add", method = RequestMethod.POST)
    public Map<String, Object> add(@RequestBody Shelves shelves) throws BusinessException {
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();

        // 添加记录
        String result = shelvesService.addShelves(shelves) ? Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;

        // 设置 Response
        responseContent.setResponseResult(result);
        return responseContent.generateResponse();
    }

    @RequestMapping(value = "update", method = RequestMethod.POST)
    public Map<String, Object> update(@RequestBody Shelves shelves) throws BusinessException {
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();

        // 更新
        String result = shelvesService.updateShelves(shelves) ? Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;

        // 设置 Response
        responseContent.setResponseResult(result);
        return responseContent.generateResponse();
    }

    @RequestMapping(value = "delete", method = RequestMethod.GET)
    public Map<String, Object> delete(@RequestParam("id") Integer id) throws BusinessException {
        // 初始化 Response
        Response responseContent = responseUtil.newResponseInstance();

        // 删除记录
        String result = shelvesService.deleteShelves(id) ? Response.RESPONSE_RESULT_SUCCESS : Response.RESPONSE_RESULT_ERROR;

        // 设置 Response
        responseContent.setResponseResult(result);
        return responseContent.generateResponse();
    }
}
