package com.jianyun.wms.dao;

import com.jianyun.wms.domain.Shelves;

import java.util.List;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/19 14:24
 * @Modified By:
 */
public interface ShelvesMapper {
    List<Shelves> selectAll();
    List<Shelves> selectByName(String name);
    List<Shelves> selectByRepos(Integer repoId);
    List<Shelves> selectByGoods(String goodId);
    Shelves selectById(Integer id);
    void insert(Shelves shelves);
    void update(Shelves shelves);
    void deleteByID(Integer shelvesID);
}
