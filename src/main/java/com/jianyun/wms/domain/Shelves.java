package com.jianyun.wms.domain;

import java.io.Serializable;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/19 14:15
 * @Modified By:
 */
public class Shelves implements Serializable{
    private Integer id;
    private String name;
    private Integer repoId;
    private String repoName;
    private String goodIds;
    private String goodNames;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getRepoId() {
        return repoId;
    }

    public void setRepoId(Integer repoId) {
        this.repoId = repoId;
    }

    public String getRepoName() {
        return repoName;
    }

    public void setRepoName(String repoName) {
        this.repoName = repoName;
    }

    public String getGoodIds() {
        return goodIds;
    }

    public void setGoodIds(String goodIds) {
        this.goodIds = goodIds;
    }

    public String getGoodNames() {
        return goodNames;
    }

    public void setGoodNames(String goodNames) {
        this.goodNames = goodNames;
    }
}
