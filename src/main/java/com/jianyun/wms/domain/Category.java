package com.jianyun.wms.domain;

import java.io.Serializable;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/15 11:02
 * @Modified By:
 */
public class Category implements Serializable{
    private Integer id;
    private String name;

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
}
