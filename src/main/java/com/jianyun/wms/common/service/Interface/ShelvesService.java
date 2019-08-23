package com.jianyun.wms.common.service.Interface;

import com.jianyun.wms.domain.Shelves;
import com.jianyun.wms.exception.BusinessException;

import java.util.Map;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/19 16:25
 * @Modified By:
 */
public interface ShelvesService {
    Map<String, Object> selectAll(int offset, int limit) throws BusinessException;
    Map<String, Object> selectByName(String name) throws BusinessException;
    Map<String, Object> selectByRepos(Integer repoId) throws BusinessException;
    Map<String,Object> queryByReposAndGood(Integer repositoryID,String goodID) throws BusinessException;
    boolean addShelves(Shelves shelves) throws BusinessException;
    boolean updateShelves(Shelves shelves) throws BusinessException;
    boolean deleteShelves(Integer id) throws BusinessException;
}
