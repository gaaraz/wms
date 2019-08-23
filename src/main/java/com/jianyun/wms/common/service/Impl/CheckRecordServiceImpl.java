package com.jianyun.wms.common.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jianyun.wms.common.service.Interface.CheckRecordService;
import com.jianyun.wms.dao.CheckRecordMapper;
import com.jianyun.wms.dao.StorageMapper;
import com.jianyun.wms.domain.CheckRecord;
import com.jianyun.wms.domain.Storage;
import com.jianyun.wms.exception.BusinessException;
import com.jianyun.wms.util.aop.UserOperation;
import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/23 9:52
 * @Modified By:
 */
@Service
public class CheckRecordServiceImpl implements CheckRecordService{
    @Autowired
    private CheckRecordMapper checkRecordMapper;
    @Autowired
    private StorageMapper storageMapper;

    @Override
    public Map<String, Object> selectByParam(Map<String, Object> params) throws BusinessException {
        Map<String, Object> resultSet = new HashMap<>();
        List<CheckRecord> records;
        Integer offset = Integer.parseInt(params.get("offset").toString());
        Integer limit = Integer.parseInt(params.get("limit").toString());

        long total = 0;
        boolean isPagination = true;

        if (offset < 0 || limit < 0)
            isPagination = false;

        try {
            if (isPagination) {
                PageHelper.offsetPage(offset, limit);
                records = checkRecordMapper.selectByParam(params);
                if (records != null) {
                    PageInfo<CheckRecord> pageInfo = new PageInfo<>(records);
                    total = pageInfo.getTotal();
                } else
                    records = new ArrayList<>();
            }else{
                records = checkRecordMapper.selectByParam(params);
                if (records != null) {
                    total = records.size();
                } else
                    records = new ArrayList<>();
            }
        }catch (PersistenceException e){
            throw new BusinessException(e);
        }

        resultSet.put("data", records);
        resultSet.put("total", total);
        return resultSet;
    }

    @UserOperation(value = "添加盘点记录")
    @Override
    public boolean insert(CheckRecord record) throws BusinessException {
        try {
            if (record != null){
                Subject currentSubject = SecurityUtils.getSubject();
                Session session = currentSubject.getSession();
                String userName = (String) session.getAttribute("userName");
                record.setPerson(userName);
                List<Storage> storages = storageMapper.selectByGoodsIDAndRepositoryID(record.getGoodID(), record.getRespositoryID(), record.getShelvesID());
                record.setRecordNum(storages.get(0).getNumber().intValue());
                checkRecordMapper.insert(record);
                return true;
            }
            return false;
        } catch (PersistenceException e) {
            throw new BusinessException(e);
        }
    }
}
