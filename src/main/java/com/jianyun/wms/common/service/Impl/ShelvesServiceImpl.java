package com.jianyun.wms.common.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jianyun.wms.common.service.Interface.ShelvesService;
import com.jianyun.wms.dao.ShelvesMapper;
import com.jianyun.wms.domain.Shelves;
import com.jianyun.wms.exception.BusinessException;
import com.jianyun.wms.util.aop.UserOperation;
import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/19 16:45
 * @Modified By:
 */
@Service
public class ShelvesServiceImpl implements ShelvesService {
    @Autowired
    private ShelvesMapper shelvesMapper;

    @Override
    public Map<String, Object> selectAll(int offset, int limit) throws BusinessException {
        // 初始化结果集
        Map<String, Object> resultSet = new HashMap<>();
        List<Shelves> shelves;
        long total = 0;
        boolean isPagination = true;

        // validate
        if (offset < 0 || limit < 0)
            isPagination = false;

        //query
        try {
            if (isPagination) {
                PageHelper.offsetPage(offset, limit);
                shelves = shelvesMapper.selectAll();
                if (shelves != null) {
                    PageInfo<Shelves> pageInfo = new PageInfo<>(shelves);
                    total = pageInfo.getTotal();
                } else
                    shelves = new ArrayList<>();
            } else {
                shelves = shelvesMapper.selectAll();
                if (shelves != null)
                    total = shelves.size();
                else
                    shelves = new ArrayList<>();
            }
        } catch (PersistenceException e) {
            throw new BusinessException();
        }

        resultSet.put("data", shelves);
        resultSet.put("total", total);
        return resultSet;
    }

    @Override
    public Map<String, Object> selectByName(String name) throws BusinessException {
        // 初始化結果集
        Map<String, Object> resultSet = new HashMap<>();
        List<Shelves> shelves = new ArrayList<>();
        long total = 0;

        try {
            shelves = shelvesMapper.selectByName(name);
            total = shelves.size();
        } catch (PersistenceException e) {
            throw new BusinessException(e);
        }

        resultSet.put("data", shelves);
        resultSet.put("total", total);
        return resultSet;
    }

    @Override
    public Map<String, Object> selectByRepos(Integer repoId) throws BusinessException {
        // 初始化結果集
        Map<String, Object> resultSet = new HashMap<>();
        List<Shelves> shelves = new ArrayList<>();
        long total = 0;

        try {
            shelves = shelvesMapper.selectByRepos(repoId);
            total = shelves.size();
        } catch (PersistenceException e) {
            throw new BusinessException(e);
        }

        resultSet.put("data", shelves);
        resultSet.put("total", total);
        return resultSet;
    }

    @Override
    public Map<String, Object> queryByReposAndGood(Integer repositoryID, String goodID) throws BusinessException{
        Map<String, Object> resultSet = new HashMap<>();
        try {
            List<Shelves> shelves = shelvesMapper.selectByGoods(goodID);
            List<Shelves> shelvesList = shelves.stream()
                    .filter(she -> repositoryID.equals(she.getRepoId()))
                    .collect(Collectors.toList());
            resultSet.put("data",shelvesList);
            resultSet.put("total", shelvesList.size());
        } catch (PersistenceException e) {
            throw new BusinessException(e);
        }

        return resultSet;
    }

    @UserOperation(value = "添加货架信息")
    @Override
    public boolean addShelves(Shelves shelves) throws BusinessException {
        // 插入一条新的记录
        if (shelves != null) {
            try {
                // 有效性验证
                if (shelves.getName() != null && shelves.getRepoId() != null){
                    shelvesMapper.insert(shelves);
                    return true;
                }
            } catch (PersistenceException e) {
                throw new BusinessException(e);
            }
        }
        return false;
    }

    @UserOperation(value = "更新货架信息")
    @Override
    public boolean updateShelves(Shelves shelves) throws BusinessException {
        if (shelves != null) {
            try {
                if (shelves.getName() != null && shelves.getRepoId() != null) {
                    if (shelves.getId() != null) {
                        shelvesMapper.update(shelves);
                        return true;
                    }
                }
            } catch (PersistenceException e) {
                throw new BusinessException(e);
            }
        }
        return false;
    }

    @UserOperation(value = "删除分类信息")
    @Override
    public boolean deleteShelves(Integer id) throws BusinessException {
        try {
            // todo 相关验证
            // 检查是否存在出库记录
            // 检查是否存在入库记录
            // 检查是否存在库存记录

            // 删除记录
            shelvesMapper.deleteByID(id);

            return true;
        } catch (PersistenceException e) {
            throw new BusinessException(e);
        }
    }
}
