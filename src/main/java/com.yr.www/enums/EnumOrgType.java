package com.yr.www.enums;

import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName           : EnumOrgType
 * @Description         : 社团类型枚举类
 * @Author              : yr
 * @CreationDate        : 2018年1月7日 下午2:24:25
 * @Version             : v0.0.1
 *
 */
public enum EnumOrgType {
    stu(1, "专业学术类"),
    art(2, "艺术兴趣类"),
    spr(3, "体育健身类"),
    ser(4, "公益服务类"),
    ;

    private Integer      value;

    private String      name;

    /**
     * 全局索引池
     */
    private static Map<Integer, EnumOrgType> pool = new HashMap<Integer, EnumOrgType>();
    static {
        for (EnumOrgType et : EnumOrgType.values()) {
            pool.put(et.value, et);
        }
    }

    public static Map<Integer, String> toMap() {
        Map<Integer, String> enumDataMap = new HashMap<Integer, String>();
        for (EnumOrgType type : EnumOrgType.values()) {
            enumDataMap.put(type.getValue(), type.getName());
        }
        return enumDataMap;
    }

    /**
     * 根据内容索引
     * @param value
     * @return
     */
    public static EnumOrgType indexByValue(Integer value) {
        return pool.get(value);
    }

    private EnumOrgType(Integer value, String name) {
        this.value = value;
        this.name = name;
    }

    public Integer getValue() {
        return value;
    }

    public String getName() {
        return name;
    }
}
