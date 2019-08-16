package com.jianyun.wms.common.service.Interface;

import com.jianyun.wms.domain.Category;
import com.jianyun.wms.exception.BusinessException;

import java.util.Map;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/15 17:23
 * @Modified By:
 */
public interface CategoryService {
    Map<String, Object> selectAll(int offset, int limit) throws BusinessException;

    boolean addCategory(Category category) throws BusinessException;

    boolean deleteCategory(Integer id) throws BusinessException;

    boolean updateCategory(Category category) throws BusinessException;
}
