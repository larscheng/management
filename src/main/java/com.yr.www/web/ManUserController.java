package com.yr.www.web;


import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.yr.www.entity.ManUser;
import com.yr.www.entity.ManUserOrg;
import com.yr.www.entity.dto.ManUserDto;
import com.yr.www.enums.EnumUserType;
import com.yr.www.mapper.ManUserMapper;
import com.yr.www.mapper.ManUserOrgMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;
import java.util.stream.Collectors;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yr123
 * @since 2018-05-22
 */
@Controller
public class ManUserController {

    @Autowired
    private ManUserMapper manUserMapper;
    @Autowired
    private ManUserOrgMapper manUserOrgMapper;



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


    /***
     * 用户编辑初始化
     * @param modelAndView
     * @param id
     * @return
     */
    @RequestMapping(value = {"/userInitUpdate"})
    public ModelAndView userInitUpdate(ModelAndView modelAndView,Integer id){

        ManUser manUser = manUserMapper.selectById(id);
        modelAndView.addObject("user",manUser);
        modelAndView.setViewName("user/userInfo");
        return modelAndView;
    }

    /***
     * 用户列表
     * @param user
     * @return
     */
    @RequestMapping(value = {"/userList"})
    @ResponseBody
    public Object userList(ManUser user){
        List<ManUser> users = manUserMapper.selectList(new EntityWrapper<>());
        //adm
        if (!ObjectUtils.isEmpty(user.getUserType())&&user.getUserType().equals(EnumUserType.adm.getValue())){
            users = users.stream().filter(user1 -> user1.getUserType().equals(EnumUserType.adm.getValue())).collect(Collectors.toList());
        }
        //user
        if (!ObjectUtils.isEmpty(user.getUserType())&&user.getUserType().equals(EnumUserType.orgAdm.getValue())){
            users = users.stream().filter(user1 -> user1.getUserType().equals(EnumUserType.orgAdm.getValue())||user1.getUserType().equals(EnumUserType.user.getValue())).collect(Collectors.toList());
        }
        users.sort(Comparator.comparing(ManUser::getGmtCreate).reversed());
        return JSONObject.toJSON(users);
    }



    /***
     * 近一个月新增用户列表
     * @param user
     * @return
     */
    @RequestMapping(value = {"/newUserList"})
    @ResponseBody
    public Object newUserList(ManUser user){
//        List<ManUserDto> users = manUserMapper.selectUserDtoList();

        List<ManUser> users = new ArrayList<>();
        //adm总数
        if (!ObjectUtils.isEmpty(user.getUserType())&&user.getUserType().equals(1)){
            users = manUserMapper.selectList(new EntityWrapper<>(user));
            users = users.stream().filter(user1 -> user1.getUserType().equals(user.getUserType())).collect(Collectors.toList());
        }
        //user近30天
        if (!ObjectUtils.isEmpty(user.getUserType())&&user.getUserType().equals(2)){
            users = manUserMapper.selectNewUserList();
            users = users.stream().filter(user1 -> user1.getUserType().equals(user.getUserType()))
                    .collect(Collectors.toList());
        }
        return JSONObject.toJSON(users);
    }

    /***
     * 删除用户
     * @param id
     * @return
     */
    @RequestMapping(value = {"/userDel"})
    @ResponseBody
    public Object userDel(Integer id){
        ManUserOrg userOrg = new ManUserOrg();
        userOrg.setuId(id);
        ManUserOrg manUserOrg = manUserOrgMapper.selectOne(userOrg);
        if (!ObjectUtils.isEmpty(manUserOrg)){
            return JSONObject.toJSON("该用户已加入社团不可删除！！！");
        }
        manUserMapper.deleteById(id);
        return JSONObject.toJSON("OK");
    }

    /***
     * 批量删除用户
     * @param delIds
     * @return
     */
    @RequestMapping(value = {"/userDelAll"})
    @ResponseBody
    public Object userDelAll(Integer[] delIds){
        for (Integer id:delIds
             ) {
            ManUserOrg userOrg = new ManUserOrg();
            userOrg.setuId(id);
            ManUserOrg manUserOrg = manUserOrgMapper.selectOne(userOrg);
            if (!ObjectUtils.isEmpty(manUserOrg)){
                return JSONObject.toJSON("用户已加入社团不可删除！！！");
            }
        }
        manUserMapper.deleteBatchIds(Arrays.asList(delIds));
        return JSONObject.toJSON("OK");
    }

    /***
     * 添加用户
     * @param user
     * @return
     */
    @RequestMapping(value = {"/userAdd"})
    @ResponseBody
    public Object userAdd(ManUser user){
        ManUser user1 = manUserMapper.selectOne(new ManUser().setUserCode(user.getUserCode()));
        if (!ObjectUtils.isEmpty(user1)){
            return JSONObject.toJSON("该账号已被注册，请重新添加！");
        }
        user.setGmtCreate(new Date());
        user.setUserPassword("123456");
        manUserMapper.insert(user);
        return JSONObject.toJSON("OK");
    }

    /***
     * 启用禁用用户
     * @param user
     * @return
     */
    @RequestMapping(value = {"/userAble"})
    @ResponseBody
    public Object userAble(ManUser user){
        ManUserOrg userOrg = new ManUserOrg();
        userOrg.setuId(user.getId());
        ManUserOrg manUserOrg = manUserOrgMapper.selectOne(userOrg);
        if (!ObjectUtils.isEmpty(manUserOrg)){
            return JSONObject.toJSON("该用户已加入社团不可操作！！！");
        }
        manUserMapper.updateById(user);
        return JSONObject.toJSON("OK");
    }


    /***
     * 用户更新
     * @param modelAndView
     * @param user
     * @return
     */
    @RequestMapping(value = {"/userUpdate"})
    public ModelAndView userUpdate( ModelAndView modelAndView ,ManUser user){
        if (!ObjectUtils.isEmpty(user)){
            manUserMapper.updateById(user);
        }
        modelAndView.setViewName("redirect:/userInfo");
        return modelAndView;
    }


    /**
     * 修改密码初始化
     * @param modelAndView
     * @param session
     * @return
     */
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

    /***
     * 修改密码
     * @param modelAndView
     * @param user
     * @param session
     * @return
     */
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

