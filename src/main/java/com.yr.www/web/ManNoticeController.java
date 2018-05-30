package com.yr.www.web;


import com.alibaba.fastjson.JSONObject;
import com.yr.www.entity.ManNotice;
import com.yr.www.entity.ManOrg;
import com.yr.www.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yr123
 * @since 2018-05-30
 */
@Controller
//@RequestMapping("/manNotice")
public class ManNoticeController {

    @Autowired
    private ManOrgMapper manOrgMapper;
    @Autowired
    private ManUserMapper manUserMapper;
    @Autowired
    private ManUserOrgMapper manUserOrgMapper;
    @Autowired
    private ManApplyMapper manApplyMapper;
    @Autowired
    private ManNoticeMapper manNoticeMapper;


    /***
     * 添加公告
     * @param notice
     * @return
     */
    @RequestMapping(value = {"/noticeAdd"})
    @ResponseBody
    public Object noticeAdd(ManNotice notice){
        notice.setGmtCreate(new Date());
        manNoticeMapper.insert(notice);
        return JSONObject.toJSON("OK");
    }
}

