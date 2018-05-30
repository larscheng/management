<%--
  Created by IntelliJ IDEA.
  User: zhengqilong
  Date: 2018/5/23
  Time: 21:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>会员添加--layui后台管理模板</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${ctx}/layui-admin/layui/css/layui.css" media="all" />
    <style type="text/css">
        .layui-form-item .layui-inline{ width:33.333%; float:left; margin-right:0; }
        @media(max-width:1240px){
            .layui-form-item .layui-inline{ width:100%; float:none; }
        }
    </style>
</head>
<body class="childrenBody">
<form class="layui-form" id="addUserForm" style="width:80%;">
    <div class="layui-form-item">
        <label class="layui-form-label">登录名</label>
        <div class="layui-input-block">
            <input type="text" name="userCode" class="layui-input userName" lay-verify="required" placeholder="请输入登录名">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">真实姓名</label>
        <div class="layui-input-block">
            <input type="text" name="userName" class="layui-input " lay-verify="required" placeholder="请输入真实姓名">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">邮箱</label>
        <div class="layui-input-block">
            <input type="text" name="userMail" class="layui-input userEmail" lay-verify="email" placeholder="请输入邮箱">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-block userSex">
            <input type="radio" name="userSex" value="1" title="男" checked>
            <input type="radio" name="userSex" value="2" title="女">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">用户类型</label>
        <div class="layui-input-block">
            <select name="userType" class="userGrade" lay-filter="userGrade">
                <option value="4">普通用户</option>
                <option value="1">超级管理员</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">

            <label class="layui-form-label">用户状态</label>
            <div class="layui-input-block">
                <select name="userStatus" class="userStatus" lay-filter="userStatus">
                    <option value="1">启用</option>
                    <option value="0">禁用</option>
                </select>
            </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">用户描述</label>
        <div class="layui-input-block">
            <textarea placeholder="请输入站点描述" name="userEvaluate" class="layui-textarea linksDesc"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="addUser">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<script type="text/javascript" src="${ctx}/layui-admin/layui/layui.js"></script>
<script type="text/javascript" src="${ctx}/layui-admin/page/user/addUser.js"></script>
</body>
</html>
