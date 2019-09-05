package com.jianyun.wms.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/9/4 9:10
 * @Modified By:
 */
public class Message {
    private Integer id;
    private String title;
    private String content;
    private Integer status;
    private Date time;
    private String timeStr;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getTimeStr() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(time);
    }

    public void setTimeStr(String timeStr) {
        this.timeStr = timeStr;
    }
}
