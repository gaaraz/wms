package com.jianyun.wms.common.service.Interface;

import com.jianyun.wms.domain.CheckRecord;
import com.jianyun.wms.exception.BusinessException;

import java.util.Map;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/23 9:47
 * @Modified By:
 */
public interface CheckRecordService {
    Map<String, Object> selectByParam(Map<String,Object> param) throws BusinessException;
    boolean insert(CheckRecord record) throws BusinessException;
}
