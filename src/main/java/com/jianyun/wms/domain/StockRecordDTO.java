package com.jianyun.wms.domain;

/**
 * 出库/入库记录DO
 *
 * @author Ken
 * @since 2017/4/5.
 */
public class StockRecordDTO {

    /**
     * 记录ID
     */
    private String recordID;

    /**
     * 记录的类型（出库/入库）
     */
    private String type;
    
    /**
     * 供应商（入库）或客户（出库）名称
     */
    private String supplierOrCustomerName;

    /**
     * 商品名称
     */
    private String goodsName;

    /**
     * 出库或入库仓库ID
     */
    private Integer repositoryID;
    private String repository;

    /**
     * 出库或入库货架ID
     */
    private Integer shelvesID;
    private String shelves;

    /**
     * 出库或入库数量
     */
    private long number;

    /**
     * 出库或入库时间
     */
    private String time;

    /**
     * 出库或入库经手人
     */
    private String personInCharge;


    public String getRepository() {
        return repository;
    }

    public void setRepository(String repository) {
        this.repository = repository;
    }

    public String getShelves() {
        return shelves;
    }

    public void setShelves(String shelves) {
        this.shelves = shelves;
    }

    public String getRecordID() {
        return recordID;
    }

    public void setRecordID(String recordID) {
        this.recordID = recordID;
    }

    public String getType() {
        return type;
    }

    public String getSupplierOrCustomerName() {
        return supplierOrCustomerName;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public Integer getRepositoryID() {
        return repositoryID;
    }

    public long getNumber() {
        return number;
    }

    public String getTime() {
        return time;
    }

    public String getPersonInCharge() {
        return personInCharge;
    }


    public void setType(String type) {
        this.type = type;
    }

    public void setSupplierOrCustomerName(String supplierOrCustomerName) {
        this.supplierOrCustomerName = supplierOrCustomerName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public void setRepositoryID(Integer repositoryID) {
        this.repositoryID = repositoryID;
    }

    public void setNumber(long number) {
        this.number = number;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public void setPersonInCharge(String personInCharge) {
        this.personInCharge = personInCharge;
    }

    public Integer getShelvesID() {
        return shelvesID;
    }

    public void setShelvesID(Integer shelvesID) {
        this.shelvesID = shelvesID;
    }

    @Override
    public String toString() {
        return "StockRecordDTO{" +
                "recordID=" + recordID +
                ", type='" + type + '\'' +
                ", supplierOrCustomerName='" + supplierOrCustomerName + '\'' +
                ", goodsName='" + goodsName + '\'' +
                ", repositoryID=" + repositoryID +
                ", number=" + number +
                ", time=" + time +
                ", personInCharge='" + personInCharge + '\'' +
                '}';
    }
}
