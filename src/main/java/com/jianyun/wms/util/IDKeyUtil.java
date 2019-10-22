package com.jianyun.wms.util;

import java.util.UUID;

/**
 * @Description:
 * @author chenchen
 * @date 2019/8/20 14:36
 */
public class IDKeyUtil {

    public static Long generateSnowFlakeSnowId(){
        return Math.abs(UUID.randomUUID().getLeastSignificantBits());
    }

    /**
     * UUID
     *
     * @return
     */
    public static String generateUUID(){
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        return uuid;
    }

    public static void main(String[] args) {
        System.out.println(generateSnowFlakeSnowId());
    }
}
