package com.yr.www.filter;
/**
 * @author zhengql
 * @description
 * @className LoginInterceptor
 * @create 2018年04月02日  15:02
 */

import com.yr.www.entity.ManUser;
import org.springframework.util.ObjectUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;
import java.util.Arrays;

/**
 * 登录认证的拦截器
 */

public class LoginInterceptor extends HandlerInterceptorAdapter {

    /***
     * 不过滤的请求
     */
    private static final String[] IGNORE_URI={"/initRegister","/","","/login","/register"};   //填写XX.do


    /**
     * Handler执行之前调用这个方法
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        final HttpServletRequest httpRequest = (HttpServletRequest) request;
         final HttpServletResponse httpResponse = (HttpServletResponse) response;
        ManUser admin=(ManUser) request.getSession().getAttribute("sessionUser");

        if (!(handler instanceof HandlerMethod)) {
            return true;
        }

        String name = request.getServletPath();
        String ip  = request.getRemoteAddr();
        HandlerMethod handlerMethod = (HandlerMethod) handler;
        Method method = handlerMethod.getMethod();

        boolean contains = Arrays.asList(IGNORE_URI).contains(name);
        if (!contains){
            if (ObjectUtils.isEmpty(admin)){
                response.getWriter().write("<script>window.open('/','_top')</script>");
                return false;
            }
        }

        System.out.println("========"+name+"===>LoginInterceptor preHandle 没加验证注解放行  ip:"+ip);
        return true;
    }

    /**
     * Handler执行之后，ModelAndView返回之前调用这个方法
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object handler, ModelAndView modelAndView) throws Exception {

    }

    /**
     * Handler执行完成之后调用这个方法
     */
    @Override
    public void afterCompletion(HttpServletRequest request,
                                HttpServletResponse response, Object handler, Exception exc)
            throws Exception {

    }
}
