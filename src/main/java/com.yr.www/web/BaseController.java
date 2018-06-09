package com.yr.www.web;


import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.yr.www.entity.ManOrg;
import com.yr.www.entity.ManUser;
import com.yr.www.entity.ManUserOrg;
import com.yr.www.enums.EnumEnOrDis;
import com.yr.www.enums.EnumUserType;
import com.yr.www.mapper.ManOrgMapper;
import com.yr.www.mapper.ManUserMapper;
import com.yr.www.mapper.ManUserOrgMapper;
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
    @Autowired
    private ManOrgMapper manOrgMapper;
    @Autowired
    private ManUserOrgMapper manUserOrgMapper;

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
        //近三十天审核通过的社团（新增社团）
        request.getSession().setAttribute("newOrg",manOrgMapper.countNewOrg());
        //近30天新注册的用户数（新增人数）
        request.getSession().setAttribute("newUser",manUserMapper.countNewUser());
        //用户总数（用户类型）
        request.getSession().setAttribute("userNum",manUserMapper.countUserNum());
        //管理员总数
        request.getSession().setAttribute("admNum",manUserMapper.countAdmNum());
        //社团总数
        request.getSession().setAttribute("orgNum", manOrgMapper.countOrgNum());
        //待审核社团
        request.getSession().setAttribute("org2Num",manOrgMapper.countOrg2Num());


        //我加入的社团数
        request.getSession().setAttribute("myOrgNum",manUserOrgMapper.selectCount(new EntityWrapper<ManUserOrg>().and("u_id={0}",user.getId())));
        //我管理的社团数
        request.getSession().setAttribute("myCreateOrgNum",manOrgMapper.selectCount(new EntityWrapper<ManOrg>()
                .and("org_founder={0}",user.getId())
                .and("audit_status={0}",2)));
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
        ManUser manUser = manUserMapper.selectOne(new ManUser().setUserCode(user.getUserCode()).setUserType(user.getUserType()));
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

