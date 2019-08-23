package com.jianyun.wms.common.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jianyun.wms.common.service.Interface.CategoryService;
import com.jianyun.wms.dao.CategoryMapper;
import com.jianyun.wms.dao.GoodsMapper;
import com.jianyun.wms.domain.Category;
import com.jianyun.wms.domain.Goods;
import com.jianyun.wms.exception.BusinessException;
import com.jianyun.wms.util.aop.UserOperation;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/15 17:23
 * @Modified By:
 */
@Service
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private GoodsMapper goodsMapper;

    @Override
    public Map<String, Object> selectAll(int offset, int limit) throws BusinessException {
        Map<String, Object> resultSet = new HashMap<>();
        List<Category> categoryList;

        long total = 0;
        boolean isPagination = true;

        if (offset < 0 || limit < 0)
            isPagination = false;

        // query
        try {
            if (isPagination) {
                PageHelper.offsetPage(offset, limit);
                categoryList = categoryMapper.categoryList();
                if (categoryList != null) {
                    PageInfo<Category> pageInfo = new PageInfo<>(categoryList);
                    total = pageInfo.getTotal();
                } else
                    categoryList = new ArrayList<>();
            } else {
                categoryList = categoryMapper.categoryList();
                if (categoryList != null)
                    total = categoryList.size();
                else
                    categoryList = new ArrayList<>();
            }
        } catch (PersistenceException e) {
            throw new BusinessException(e);
        }

        resultSet.put("data", categoryList);
        resultSet.put("total", total);
        return resultSet;
    }

    @UserOperation(value = "添加分类信息")
    @Override
    public boolean addCategory(Category category) throws BusinessException {
        try {
            // 插入新的记录
            if (category != null) {
                // 验证
                if (StringUtils.isNotBlank(category.getName())) {
                    categoryMapper.insertCategory(category);
                    return true;
                }
            }
            return false;
        } catch (PersistenceException e) {
            throw new BusinessException(e);
        }
    }

    @UserOperation(value = "删除分类信息")
    @Override
    public boolean deleteCategory(Integer id) throws BusinessException {
        try {
            List<Goods> goods = goodsMapper.selectByCategoryId(id);
            if (CollectionUtils.isNotEmpty(goods)){
                return false;
            }
            categoryMapper.deleteCategory(id);
            return true;
        }catch (PersistenceException e){
            throw new BusinessException(e);
        }
    }

    @UserOperation(value = "更新分类信息")
    @Override
    public boolean updateCategory(Category category) throws BusinessException {
        try {
            if (category != null && StringUtils.isNotBlank(category.getName())){
                categoryMapper.updateCategory(category);
                return true;
            }
            return false;
        }catch (PersistenceException e){
            throw new BusinessException(e);
        }
    }
}
