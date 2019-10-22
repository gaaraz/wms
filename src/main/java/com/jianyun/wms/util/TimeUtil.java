package com.jianyun.wms.util;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

/**
 * @Author:Gaara
 * @Description:
 * @Date:Created in 2019/8/29 17:16
 * @Modified By:
 */
public class TimeUtil {
    public static String getTodayDate() {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return dtf.format(ZonedDateTime.now());
    }

    public static String getCurrentTimeMillis() {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return dtf.format(ZonedDateTime.now());
    }
}
