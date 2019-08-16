package com.jianyun.wms.dao;

import com.jianyun.wms.domain.Category;

import java.util.List;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/15 10:51
 * @Modified By:
 */
public interface CategoryMapper {
    List<Category> categoryList();
    Integer insertCategory(Category category);
    Integer deleteCategory(Integer id);
    Integer updateCategory(Category category);
}
