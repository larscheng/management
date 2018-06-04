<%--
  Created by IntelliJ IDEA.
  User: zhengqilong
  Date: 2018/5/22
  Time: 14:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui后台管理模板</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="${ctx}/layui-admin/favicon.ico">
    <link rel="stylesheet" href="${ctx}/layui-admin/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${ctx}/layui-admin/css/font_eolqem241z66flxr.css" media="all" />
    <link rel="stylesheet" href="${ctx}/layui-admin/css/main.css" media="all" />
</head>
<body class="main_body">
<div class="layui-layout layui-layout-admin">
    <!-- 顶部 -->
    <div class="layui-header header">
        <div class="layui-main">
            <a href="#" class="logo">社团管理系统</a>

            <!-- 顶部右侧菜单 -->
            <ul class="layui-nav top_menu">
                <li class="layui-nav-item showNotice" id="showNotice" pc>
                    <a href="javascript:;"><i class="iconfont icon-gonggao"></i><cite>系统公告</cite></a>
                </li>
                <li class="layui-nav-item" mobile>
                    <a href="javascript:;" data-url="page/user/changePwd.html"><i class="iconfont icon-shezhi1" data-icon="icon-shezhi1"></i><cite>设置</cite></a>
                </li>
                <li class="layui-nav-item" mobile>
                    <a href="javascript:;"><i class="iconfont icon-loginout"></i> 退出</a>
                </li>
                <li class="layui-nav-item lockcms" pc>
                    <a href="javascript:;"><i class="iconfont icon-lock1"></i><cite>锁屏</cite></a>
                </li>
                <li class="layui-nav-item" pc>
                    <a href="javascript:;">
                        <img src="${ctx}/layui-admin/images/face.jpg" class="layui-circle" width="35" height="35">
                        <cite>${sessionScope.sessionUser.userName}</cite>
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" data-url="${ctx}/userInfo"><i class="iconfont icon-zhanghu" data-icon="icon-zhanghu"></i><cite>个人资料</cite></a></dd>
                        <dd><a href="javascript:;" data-url="${ctx}/initChangePw"><i class="iconfont icon-shezhi1" data-icon="icon-shezhi1"></i><cite>修改密码</cite></a></dd>
                        <dd><a href="${ctx}/logout"><i class="iconfont icon-loginout"></i><cite>退出</cite></a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>
    <!-- 左侧导航 -->
    <div class="layui-side layui-bg-black">
        <div class="user-photo">
            <a class="img" title="我的头像" ><img src="${ctx}/layui-admin/images/face.jpg"></a>
            <p>你好！<span class="userName">${sessionScope.sessionUser.userName}</span>, 欢迎登录</p>
        </div>
        <div class="navBar layui-side-scroll"></div>
    </div>
    <!-- 右侧内容 -->
    <div class="layui-body layui-form">
        <div class="layui-tab marg0" lay-filter="bodyTab">
            <ul class="layui-tab-title top_tab">
                <li class="layui-this" lay-id=""><i class="iconfont icon-computer"></i> <cite>后台首页</cite></li>
            </ul>
            <div class="layui-tab-content clildFrame">
                <div class="layui-tab-item layui-show">
                    <iframe src="${ctx}/page/main.jsp"></iframe>
                </div>
            </div>
        </div>
    </div>
    <!-- 底部 -->
    <div class="layui-footer footer">
        <p>copyright @2018 商洛学院社团管理系统 </p>
    </div>
</div>

<!-- 锁屏 -->
<div class="admin-header-lock" id="lock-box" style="display: none;">
    <div class="admin-header-lock-img"><img src="${ctx}/layui-admin/images/face.jpg"/></div>
    <div class="admin-header-lock-name" id="lockUserName">社团管理</div>
    <div class="input_btn">
        <input type="password" class="admin-header-lock-input layui-input" placeholder="请输入密码解锁.." name="lockPwd" id="lockPwd" />
        <button class="layui-btn" id="unlock">解锁</button>
    </div>
    <p>请输入“123456”，否则不会解锁成功哦！！！</p>
</div>
<!-- 移动导航 -->
<div class="site-tree-mobile layui-hide"><i class="layui-icon">&#xe602;</i></div>
<div class="site-mobile-shade"></div>

<script type="text/javascript" src="${ctx}/layui-admin/layui/layui.js"></script>

<c:choose>
    <c:when test="${sessionScope.sessionUser.userType eq 1}">
        <script type="text/javascript" src="${ctx}/layui-admin/js/nav.js"></script>
    </c:when>
    <c:when test="${sessionScope.sessionUser.userType eq 0}">
        <script type="text/javascript" src="${ctx}/layui-admin/js/nav.js"></script>
    </c:when>
    <c:otherwise>
        <script type="text/javascript" src="${ctx}/layui-admin/js/nav1.js"></script>
    </c:otherwise>
</c:choose>
<script type="text/javascript" src="${ctx}/layui-admin/js/leftNav.js"></script>
<script type="text/javascript" src="${ctx}/layui-admin/js/index.js"></script>
</body>
</html>
