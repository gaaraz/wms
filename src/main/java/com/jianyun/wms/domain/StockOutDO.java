package com.jianyun.wms.domain;


import java.util.Date;
import java.util.List;

/**
 * 出库记录
 *
 * @author Ken
 */
public class StockOutDO {

    /**
     * 出库记录ID
     */
    private String id;

    private String batchId;

    /**
     * 客户ID
     */
    private Integer customerID;

    /**
     * 客户名称
     */
    private String customerName;

    /**
     * 商品ID
     */
    private Integer goodID;

    /**
     * 商品名称
     */
    private String goodName;
    private String goodSize;
    private String goodValue;

    /**
     * 出库仓库ID
     */
    private Integer repositoryID;
    private String repository;

    /**
     * 出库货架ID
     */
    private Integer shelvesID;

    private String shelves;

    /**
     * 商品出库数量
     */
    private long number;

    private Integer packages;

    private String remark;
    /**
     * 出库日期
     */
    private Date time;

    /**
     * 出库经手人
     */
    private String personInCharge;  // 经手人
    private String storeman;        // 库管
    private String inputman;        // 入库人员

    private List<StockOutDO> detail;

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

    public Integer getShelvesID() {
        return shelvesID;
    }

    public void setShelvesID(Integer shelvesID) {
        this.shelvesID = shelvesID;
    }

    public Integer getRepositoryID() {
        return repositoryID;
    }

    public void setRepositoryID(Integer repositoryID) {
        this.repositoryID = repositoryID;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBatchId() {
        return batchId;
    }

    public void setBatchId(String batchId) {
        this.batchId = batchId;
    }

    public Integer getCustomerID() {
        return customerID;
    }

    public void setCustomerID(Integer customerID) {
        this.customerID = customerID;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Integer getGoodID() {
        return goodID;
    }

    public void setGoodID(Integer goodID) {
        this.goodID = goodID;
    }

    public String getGoodName() {
        return goodName;
    }

    public void setGoodName(String goodName) {
        this.goodName = goodName;
    }

    public String getGoodSize() {
        return goodSize;
    }

    public void setGoodSize(String goodSize) {
        this.goodSize = goodSize;
    }

    public String getGoodValue() {
        return goodValue;
    }

    public void setGoodValue(String goodValue) {
        this.goodValue = goodValue;
    }

    public long getNumber() {
        return number;
    }

    public void setNumber(long number) {
        this.number = number;
    }

    public Integer getPackages() {
        return packages;
    }

    public void setPackages(Integer packages) {
        this.packages = packages;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getPersonInCharge() {
        return personInCharge;
    }

    public void setPersonInCharge(String personInCharge) {
        this.personInCharge = personInCharge;
    }

    public String getStoreman() {
        return storeman;
    }

    public void setStoreman(String storeman) {
        this.storeman = storeman;
    }

    public String getInputman() {
        return inputman;
    }

    public void setInputman(String inputman) {
        this.inputman = inputman;
    }

    public List<StockOutDO> getDetail() {
        return detail;
    }

    public void setDetail(List<StockOutDO> detail) {
        this.detail = detail;
    }

    @Override
    public String toString() {
        return "StockOutDO [id=" + id + ", customerID=" + customerID + ", customerName=" + customerName + ", goodID="
                + goodID + ", goodName=" + goodName + ", repositoryID=" + repositoryID + ", number=" + number
                + ", time=" + time + ", personInCharge=" + personInCharge + "]";
    }

}
