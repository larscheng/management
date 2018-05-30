package com.yr.www.web;


import com.alibaba.fastjson.JSONObject;
import com.yr.www.entity.ManUser;
import com.yr.www.enums.EnumEnOrDis;
import com.yr.www.enums.EnumUserType;
import com.yr.www.mapper.ManUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yr123
 * @since 2018-04-13
 */
@Controller
//@SessionAttributes(value = {"sessionUser","userType","loginState"})
public class BaseController {

    @Autowired
    private ManUserMapper manUserMapper;


    /**
     * 跳转登录
     * @param modelAndView
     * @return
     */
    @RequestMapping(value = {"","/"})
    public ModelAndView index(ModelAndView modelAndView){
        modelAndView.setViewName("login");
        return modelAndView;
    }

    /***
     * 注销
     * @param modelAndView
     * @param session
     * @return
     */
    @RequestMapping(value = {"/logout"})
    public ModelAndView logout(ModelAndView modelAndView,HttpSession session){
        session.invalidate();
        modelAndView.setViewName("redirect:/");
        return modelAndView;
    }


    /*
    * 跳转到首页*/
    @RequestMapping(value = {"/index"})
    public String sign(HttpServletRequest request){
        HttpSession session = request.getSession();
        ManUser user = (ManUser) session.getAttribute("sessionUser");
        if (ObjectUtils.isEmpty(user)){
            return "redirect:/";
        }
        return "index";
    }


    /**
     * 注册初始化页面
     * @param request
     * @return
     */
    @RequestMapping(value = {"/initRegister"})
    public String initRegister(HttpServletRequest request){
        return "register";
    }

    /***
     * 注册
     * @param user
     * @return
     */
    @RequestMapping(value = {"/register"})
    @ResponseBody
    public Object register(ManUser user){
        if (!ObjectUtils.isEmpty(user.getUserCode())){
            ManUser manUser = manUserMapper.selectOne(new ManUser().setUserCode(user.getUserCode()));
            if (!ObjectUtils.isEmpty(manUser)){
                return JSONObject.toJSON("该用户已存在！！！");
            }
        }
        user.setUserType(EnumUserType.USER.getValue());
        user.setGmtCreate(new Date());
        manUserMapper.insert(user);
        return JSONObject.toJSON("OK");
    }


    /***
     * 登录
     * @param user
     * @param session
     * @return
     */
    @RequestMapping("/login")
    @ResponseBody
    public String login(ManUser user, HttpSession session){
        ManUser manUser = manUserMapper.selectOne(new ManUser().setUserCode(user.getUserCode()));
        if (ObjectUtils.isEmpty(manUser)){
            return "该用户不存在，请重新登录";
        }else if (manUser.getUserStatus().equals(EnumEnOrDis.DISABLED.getValue())){
            return "该用户已被禁用，请重新登录";
        }else if (!manUser.getUserPassword().equals(user.getUserPassword())){
            return "账号密码错误，请重新登录";
        }

        session.setAttribute("sessionUser",manUser);
        session.setAttribute("userType",manUser.getUserType());
        session.setAttribute("loginState",EnumEnOrDis.DISABLED.getValue());
        return "OK";
    }

}

