package com.jianyun.wms.common.service.Interface;

import com.jianyun.wms.exception.BusinessException;

import java.util.Map;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/9/4 10:28
 * @Modified By:
 */
public interface MessageService {
    boolean delete(Integer id) throws BusinessException;
    boolean update(Integer id) throws BusinessException;
    Map<String,Object> selectAll(int offset, int limit) throws BusinessException;
    Integer countUnread();
}
