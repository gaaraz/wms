package com.jianyun.wms.common.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jianyun.wms.common.service.Interface.MessageService;
import com.jianyun.wms.dao.MessageMapper;
import com.jianyun.wms.domain.Message;
import com.jianyun.wms.exception.BusinessException;
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
 * @Date:Created in 2019/9/4 13:56
 * @Modified By:
 */
@Service
public class MessageServiceImpl implements MessageService{
    @Autowired
    private MessageMapper messageMapper;

    @Override
    public boolean delete(Integer id) throws BusinessException {
        try {
            messageMapper.delete(id);
            return true;
        } catch (PersistenceException e) {
            throw new BusinessException(e);
        }
    }

    @Override
    public boolean update(Integer id) throws BusinessException {
        try {
            if (id != null) {
                messageMapper.updateStatus(id);
                return true;
            }
            return false;
        } catch (PersistenceException e) {
            throw new BusinessException(e);
        }
    }

    @Override
    public Map<String, Object> selectAll(int offset, int limit) throws BusinessException {
        Map<String, Object> resultSet = new HashMap<>();
        List<Message> messageList;
        long total = 0;
        boolean isPagination = true;

        // validate
        if (offset < 0 || limit < 0)
            isPagination = false;

        // query
        try {
            if (isPagination) {
                PageHelper.offsetPage(offset, limit);
                messageList = messageMapper.selectAll();
                if (messageList != null) {
                    PageInfo<Message> pageInfo = new PageInfo<>(messageList);
                    total = pageInfo.getTotal();
                } else
                    messageList = new ArrayList<>();
            } else {
                messageList = messageMapper.selectAll();
                if (messageList != null)
                    total = messageList.size();
                else
                    messageList = new ArrayList<>();
            }
        } catch (PersistenceException e) {
            throw new BusinessException(e);
        }

        resultSet.put("data", messageList);
        resultSet.put("total", total);
        return resultSet;
    }

    @Override
    public Integer countUnread() {
        return messageMapper.countUnread();
    }
}
