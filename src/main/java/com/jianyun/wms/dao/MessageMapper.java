package com.jianyun.wms.dao;

import com.jianyun.wms.domain.Message;

import java.util.List;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/9/4 9:14
 * @Modified By:
 */
public interface MessageMapper {
    List<Message> selectAll();
    Integer countUnread();
    Integer updateStatus(Integer id);
    Integer insert(Message msg);
    Integer delete(Integer id);
}
