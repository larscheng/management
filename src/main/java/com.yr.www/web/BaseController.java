package com.yr.www.web;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.yr.www.entity.ManUser;
import com.yr.www.entity.TravelUser;
import com.yr.www.enums.EnumEnOrDis;
import com.yr.www.mapper.ManUserMapper;
import com.yr.www.mapper.TravelUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

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

    @RequestMapping(value = {"","/"})
    public ModelAndView index(ModelAndView modelAndView){
        modelAndView.setViewName("login");
        return modelAndView;
    }
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

    @RequestMapping(value = {"/initRegister"})
    public String initRegister(HttpServletRequest request){
        return "register";
    }

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

//    @RequestMapping(value = {"/orgList"})
//    @ResponseBody
//    public Object orgList(ModelAndView modelAndView,HttpSession session){
//        List<ManUser> userList = manUserMapper.selectList(new EntityWrapper<>());
//        modelAndView.addObject("userList",userList);
//        modelAndView.setViewName("org/orgList");
//        return JSONObject.toJSON(userList);
////        return userList.toString();
//    }
}

