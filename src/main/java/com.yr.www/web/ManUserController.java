package com.yr.www.web;


import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.yr.www.entity.ManUser;
import com.yr.www.entity.dto.ManUserDto;
import com.yr.www.mapper.ManUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
 * @since 2018-05-22
 */
@Controller
//@RequestMapping("/manUser")
public class ManUserController {

    @Autowired
    private ManUserMapper manUserMapper;

    /***
     * 个人信息
     * @param modelAndView
     * @param session
     * @return
     */
    @RequestMapping(value = {"/userInfo"})
    public ModelAndView userInfo(ModelAndView modelAndView, HttpSession session){
        ManUser user = (ManUser)session.getAttribute("sessionUser");
        if (!ObjectUtils.isEmpty(user)){
            ManUser manUser = manUserMapper.selectById(user.getId());
            modelAndView.addObject("user",manUser);
        }
        modelAndView.setViewName("user/userInfo");
        return modelAndView;
    }


    @RequestMapping(value = {"/userInitUpdate"})
    public ModelAndView userInitUpdate(ModelAndView modelAndView,Integer id){

        ManUser manUser = manUserMapper.selectById(id);
        modelAndView.addObject("user",manUser);
        modelAndView.setViewName("user/userInfo");
        return modelAndView;
    }

    @RequestMapping(value = {"/userList"})
    @ResponseBody
    public Object userList(){
//        List<ManUserDto> users = manUserMapper.selectUserDtoList();
        List<ManUser> users = manUserMapper.selectList(new EntityWrapper<>());
        return JSONObject.toJSON(users);
    }


    @RequestMapping(value = {"/userDel"})
    @ResponseBody
    public Object userDel(Integer id){
        manUserMapper.deleteById(id);
        return JSONObject.toJSON("OK");
    }

    @RequestMapping(value = {"/userDelAll"})
    @ResponseBody
    public Object userDelAll(Integer[] delIds){
        manUserMapper.deleteBatchIds(Arrays.asList(delIds));
        return JSONObject.toJSON("OK");
    }

    @RequestMapping(value = {"/userAdd"})
    @ResponseBody
    public Object userAdd(ManUser user){
        user.setGmtCreate(new Date());
        user.setUserPassword("123456");
        manUserMapper.insert(user);
        return JSONObject.toJSON("OK");
    }

    @RequestMapping(value = {"/userAble"})
    @ResponseBody
    public Object userAble(ManUser user){
        manUserMapper.updateById(user);
        return JSONObject.toJSON("OK");
    }

    @RequestMapping(value = {"/userUpdate"})
    public ModelAndView userUpdate( ModelAndView modelAndView ,ManUser user){
        if (!ObjectUtils.isEmpty(user)){
            manUserMapper.updateById(user);
        }
        modelAndView.setViewName("redirect:/userInfo");
        return modelAndView;
    }


    @RequestMapping(value = {"/initChangePw"})
    public ModelAndView initChangePw(ModelAndView modelAndView, HttpSession session){
        ManUser user = (ManUser)session.getAttribute("sessionUser");
        if (!ObjectUtils.isEmpty(user)){
            ManUser manUser = manUserMapper.selectById(user.getId());
            modelAndView.addObject("user",manUser);
        }
        modelAndView.setViewName("user/changePw");
        return modelAndView;
    }


    @RequestMapping(value = {"/changePw"})
    public ModelAndView changePw( ModelAndView modelAndView ,ManUser user,HttpSession session){
        ManUser manUser = (ManUser)session.getAttribute("sessionUser");
        if (ObjectUtils.isEmpty(manUser)){
            modelAndView.setViewName("redirect:/");
        }
        if (!ObjectUtils.isEmpty(user.getUserPassword())){
            user.setId(manUser.getId());
            manUserMapper.updateById(user);
            modelAndView.setViewName("redirect:/initChangePw");
        }

        return modelAndView;
    }




}

