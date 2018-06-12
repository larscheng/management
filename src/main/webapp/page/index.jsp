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
    <title>商洛学院社团管理系统</title>
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
            <a href="#" class="logo"> <i class="layui-icon" data-icon="&#xe609;" style="font-size: 25px">&#xe609;</i> 商洛学院社团管理系统</a>

            <!-- 顶部右侧菜单 -->
            <ul class="layui-nav top_menu">

                <li class="layui-nav-item">
                    <a href="javascript:;" id="Date" > </a>
                </li>
                <li class="layui-nav-item " pc>
                    <a href="javascript:;"><i class="layui-icon">&#xe612;</i>   <cite>
                        <c:choose>
                            <c:when test="${sessionScope.userType eq 0}">
                                <span class="layui-badge-rim">超级管理员</span>
                            </c:when>
                            <c:when test="${sessionScope.userType eq 1}">
                                <span class="layui-badge-rim">系统管理员</span>
                            </c:when>
                            <c:when test="${sessionScope.userType eq 2}">
                                <span class="layui-badge-rim ">社团管理员</span>
                            </c:when>
                            <c:when test="${sessionScope.userType eq 3}">
                                <span class="layui-badge-rim">普通用户</span>
                            </c:when>
                            <c:otherwise>
                                <span class="layui-badge-rim">普通用户</span>
                            </c:otherwise>
                        </c:choose>
                    </cite></a>
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
                <li class="layui-this" lay-id=""><i class="iconfont icon-computer"></i> <cite>系统首页</cite></li>
            </ul>
            <div class="layui-tab-content clildFrame">
                <div class="layui-tab-item layui-show">
                    <c:choose>
                        <c:when test="${sessionScope.userType eq 0}">
                            <iframe src="${ctx}/page/main.jsp"></iframe>
                        </c:when>
                        <c:when test="${sessionScope.userType eq 1}">
                            <iframe src="${ctx}/page/main.jsp"></iframe>
                        </c:when>
                        <c:when test="${sessionScope.userType eq 2}">
                            <iframe src="${ctx}/page/main2.jsp"></iframe>
                        </c:when>
                        <c:otherwise>
                            <iframe src="${ctx}/page/main2.jsp"></iframe>
                        </c:otherwise>
                    </c:choose>

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
    <c:when test="${sessionScope.sessionUser.userType eq 0}">
        <script type="text/javascript" src="${ctx}/layui-admin/js/nav.js"></script>
    </c:when>
    <c:when test="${sessionScope.sessionUser.userType eq 1}">
        <script type="text/javascript" src="${ctx}/layui-admin/js/nav1.js"></script>
    </c:when>
    <c:when test="${sessionScope.sessionUser.userType eq 2}">
        <script type="text/javascript" src="${ctx}/layui-admin/js/nav2.js"></script>
    </c:when>
    <c:otherwise>
        <script type="text/javascript" src="${ctx}/layui-admin/js/nav3.js"></script>
    </c:otherwise>
</c:choose>
<script type="text/javascript" src="${ctx}/layui-admin/js/leftNav.js"></script>
<script type="text/javascript" src="${ctx}/layui-admin/js/index.js"></script>
<script>
    window.onload=function(){
        setInterval(function(){
//            var weeks = ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'];
//            var date=new Date();
//            var year=date.getFullYear(); //获取当前年份
//            var mon=date.getMonth()+1; //获取当前月份
//            var da=date.getDate(); //获取当前日
//            var day=date.getDay(); //获取当前星期几
//
//            var h=date.getHours(); //获取小时
//            var m=date.getMinutes(); //获取分钟
//            var s=date.getSeconds(); //获取秒
            var d = new Date();
// Mon Dec 18 2017 21:29:58 GMT+0800 (中国标准时间)
            var weeks = ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'];
//定义一个从星期日到星期六的数组，因为后面获取的星期数返回的是0-6
//在西方看来，星期日才是一周的开始
            var year = d.getFullYear();
//获取年份
            var mouth = d.getMonth() + 1;
//获取月份，返回值是0-11，因此需要加1
            var day = d.getDate();
//获取日期
            var hour = d.getHours() < 10 ? '0' + d.getHours() : d.getHours();
//获取小时，三元表达式，判断是否小于10，小于10就在前面加0（字符串拼接），例如：08
            var minutes = d.getMinutes() < 10 ? '0' + d.getMinutes() : d.getMinutes();
//获取分钟
            var second = d.getSeconds() < 10 ? '0' + d.getSeconds() : d.getSeconds();
//获取秒数
            var weekIndex = d.getDay();
//获取星期数，返回0-6
            var week = weeks[weekIndex];
//            var time = "<i class=\"layui-icon\">&#xe612;</i>"+'当前时间:'+year+'年'+mon+'月'+da+'日'+'星期'+day+' '+h+':'+m+':'+s;
            var time =  "<i class=\"layui-icon\">&#xe60e;</i>"+'&nbsp;&nbsp;'+year + '年' + mouth + '月' + day + '日' + hour + ':' + minutes + ':' + second + week;
//            console.log(time)
            var d=document.getElementById('Date');
            d.innerHTML=time  },50)  }
</script>
</body>
</html>
