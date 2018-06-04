package com.yr.www.web;


import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.yr.www.common.ManMapStructMapper;
import com.yr.www.entity.ManNotice;
import com.yr.www.entity.ManOrg;
import com.yr.www.entity.ManUser;
import com.yr.www.entity.ManUserOrg;
import com.yr.www.entity.dto.ManNoticeDto;
import com.yr.www.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

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


    @RequestMapping(value = {"/noticeListInit"})
    public ModelAndView noticeListInit(Integer id, ModelAndView modelAndView){
        modelAndView.addObject("id",id);
        modelAndView.setViewName("/notice/noticeList");
        return modelAndView;
    }

    @RequestMapping(value = {"/noticeDetail"})
    public ModelAndView noticeDetail(Integer id, ModelAndView modelAndView){
        ManNotice notice = manNoticeMapper.selectById(new ManNotice().setId(id));
        ManNoticeDto dto = ManMapStructMapper.INSTANCE.ManOrgDto2Po(notice);
        dto.setUserName(manUserMapper.selectById(new ManUser().setId(dto.getNoticeAuth())).getUserName());
        dto.setOrgName(manOrgMapper.selectById(new ManOrg().setId(dto.getOrgId())).getOrgName());
        modelAndView.addObject("dto",dto);
        modelAndView.setViewName("/notice/noticeDetail");
        return modelAndView;
    }

    /***
     * 添加公告
     * @param notice
     * @return
     */
    @RequestMapping(value = {"/noticeList"})
    @ResponseBody
    public Object noticeList(ManNotice notice){
        List<ManNoticeDto> noticeDtos = manNoticeMapper.selectDtoList(notice);
        return JSONObject.toJSON(noticeDtos);
    }


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


    @RequestMapping(value = {"/noticeDel"})
    @ResponseBody
    public Object noticeAdd(Integer id){
        manNoticeMapper.deleteById(id);
        return JSONObject.toJSON("OK");
    }

    @RequestMapping(value = {"/noticeDelAll"})
    @ResponseBody
    @Transactional
    public Object noticeDelAll(Integer[] delIds){
        manNoticeMapper.deleteBatchIds(Arrays.asList(delIds));
        return JSONObject.toJSON("OK");
    }
}

