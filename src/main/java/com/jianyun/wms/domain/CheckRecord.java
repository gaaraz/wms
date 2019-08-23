package com.jianyun.wms.domain;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/22 18:10
 * @Modified By:
 */
public class CheckRecord implements Serializable{
    private Integer id;
    private Integer respositoryID;
    private String respository;
    private Integer shelvesID;
    private String shelves;
    private Integer goodID;
    private String good;
    private Integer recordNum;
    private Integer realNum;
    private String person;
    private Date checkTime;
    private String checkTimeStr;
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRespositoryID() {
        return respositoryID;
    }

    public void setRespositoryID(Integer respositoryID) {
        this.respositoryID = respositoryID;
    }

    public String getRespository() {
        return respository;
    }

    public void setRespository(String respository) {
        this.respository = respository;
    }

    public Integer getShelvesID() {
        return shelvesID;
    }

    public void setShelvesID(Integer shelvesID) {
        this.shelvesID = shelvesID;
    }

    public String getShelves() {
        return shelves;
    }

    public void setShelves(String shelves) {
        this.shelves = shelves;
    }

    public Integer getGoodID() {
        return goodID;
    }

    public void setGoodID(Integer goodID) {
        this.goodID = goodID;
    }

    public String getGood() {
        return good;
    }

    public void setGood(String good) {
        this.good = good;
    }

    public Integer getRecordNum() {
        return recordNum;
    }

    public void setRecordNum(Integer recordNum) {
        this.recordNum = recordNum;
    }

    public Integer getRealNum() {
        return realNum;
    }

    public void setRealNum(Integer realNum) {
        this.realNum = realNum;
    }

    public String getPerson() {
        return person;
    }

    public void setPerson(String person) {
        this.person = person;
    }

    public Date getCheckTime() {
        return checkTime;
    }

    public void setCheckTime(Date checkTime) {
        this.checkTime = checkTime;
    }

    public String getCheckTimeStr() {
        return sdf.format(checkTime);
    }

    public void setCheckTimeStr(String checkTimeStr) {
        this.checkTimeStr = checkTimeStr;
    }

    @Override
    public String toString() {
        return "CheckRecord{" +
                "id=" + id +
                ", respositoryID=" + respositoryID +
                ", respository='" + respository + '\'' +
                ", shelvesID=" + shelvesID +
                ", shelves='" + shelves + '\'' +
                ", goodID=" + goodID +
                ", good='" + good + '\'' +
                ", recordNum=" + recordNum +
                ", realNum=" + realNum +
                ", checkTime=" + checkTime +
                ", checkTimeStr='" + checkTimeStr + '\'' +
                '}';
    }
}
