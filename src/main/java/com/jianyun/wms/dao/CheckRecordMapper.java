package com.jianyun.wms.dao;

import com.jianyun.wms.domain.CheckRecord;

import java.util.List;
import java.util.Map;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/22 18:40
 * @Modified By:
 */
public interface CheckRecordMapper {
    List<CheckRecord> selectAll();
    List<CheckRecord> selectByParam(Map<String,Object> params);
    Integer insert(CheckRecord record);
    Integer update(CheckRecord record);
    Integer delete(Integer id);
}
