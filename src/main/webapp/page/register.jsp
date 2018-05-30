<%--
  Created by IntelliJ IDEA.
  User: zhengqilong
  Date: 2018/5/22
  Time: 13:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>后台登录</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/layui-admin/layui/css/layui.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/layui-admin/css/login.css" />
</head>

<body>
<div class="m-login-bg">
    <div class="m-login">
        <h3>社团管理系统注册</h3>
        <div class="m-login-warp">
            <form class="layui-form" id="loginForm" method="post">
                <div class="layui-form-item">
                    <input type="text"  name="userName" id="" lay-verify="required" placeholder="请输入真实姓名" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-item">
                    <input type="text"  name="userCode" id="title" lay-verify="required|userCode" placeholder="请输入账号" autocomplete="off" class="layui-input">
                </div>
                <%--<div class="layui-form-item">--%>
                    <%--<input type="password" name="userPassword" id="password" required lay-verify="required" placeholder="密码" autocomplete="off" class="layui-input">--%>
                <%--</div>--%>




                <div class="layui-form-item">

                        <input type="password" value="" name="userPassword" placeholder="请输入新密码" lay-verify="required|newPwd" id="oldPwd" class="layui-input pwd">
                </div>

                <div class="layui-form-item">

                        <input type="password" value="" placeholder="请确认密码" lay-verify="required|confirmPwd" class="layui-input pwd">
                </div>

                <div class="layui-form-item">

                </div>
                <div class="layui-form-item m-login-btn">
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-normal" lay-submit lay-filter="register" <%--onclick="loginSubmit()"--%>>注册</button>
                    </div>
                    <div class="layui-inline">
                        <button type="button" class="layui-btn layui-btn-primary " onclick="window.location.href='${ctx}/'">去登录</button>
                    </div>
                </div>
            </form>
        </div>
        <p class="copyright">Copyright 2018 by yangrui</p>
    </div>
</div>
<script src="${ctx}/layui-admin/layui/layui.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctx}/layui-admin/js/jquery-2.2.3.min.js" type="text/javascript" charset="utf-8"></script>
<script>
    layui.use(['form', 'layedit', 'laydate'], function() {
        var form = layui.form(),
            layer = layui.layer;

        //添加验证规则
        form.verify({
            userCode: function(value) {
                if(value.length !== 8) {
                    return '账号必须为8为数字';
                }
            },
            newPwd : function(value, item){
                if(value.length < 6){
                    return "密码长度不能小于6位";
                }
            },
            confirmPwd : function(value, item){
                if(/*!new RegExp($("#oldPwd").val()).test(value)*/$("#oldPwd").val()!==value){
                    return "两次输入密码不一致，请重新输入！";
                }
            }
        })
        //自定义验证规则


        //监听提交
        form.on('submit(register)', function(data) {
//            layer.alert(JSON.stringify(data.field), {
//                title: '最终的提交信息'
//            })
//            return false;
            console.log($("#loginForm").serialize());
            window.sessionStorage.clear();
            var formData = new FormData($( "#loginForm" )[0]);  // 要求使用的html对象
            $.ajax({
                type: "post",
                url: "/register",
                data: formData,
//                data: $("#addOrgForm").serialize(),
                async: true,
                // 下面三个参数要指定，如果不指定，会报一个JQuery的错误
                cache: false,
                contentType: false,
                processData: false,
                dataType: "json",
                success: function (msg) {
                    if ("OK" == msg) {
                        var index = top.layer.msg('注册成功，跳转至登录',{icon: 16,time:false,shade:0.8});
                        setTimeout(function(){
                            top.layer.close(index);
                            layer.closeAll("iframe");
                            //刷新父页面
                            location.href="/"
                        },1000);
                    } else{
                        var index = top.layer.msg(msg);
                        setTimeout(function(){
                            top.layer.close(index);
                            top.layer.msg(msg);
                            layer.closeAll("iframe");
                            //刷新父页面
                            parent.location.reload();
                        },2000);
//                        layer.msg(msg)
                    }

                },
                error: function (e) {
//                    alert(" 😥 系统异常，请与我们的工程师小哥哥联系！");
                    layer.alert(" 😥 系统异常，请与我们的工程师小哥哥联系！", {
                        title: '信息'
                    });
                }
            });
            return false;
            <%--$.ajax({--%>
                <%--type: "post",--%>
                <%--url: "${ctx}/login",--%>
                <%--data: $("#loginForm").serialize(),--%>
                <%--async: true,--%>
                <%--dataType: "json",--%>
                <%--success: function (msg) {--%>
                    <%--if ("OK" == msg) {--%>
                        <%--location.href = "${ctx}/index";--%>
                    <%--} else{--%>

                        <%--alert(msg)--%>
                        <%--location.href = "${ctx}/";--%>
                    <%--}--%>

                <%--},--%>
                <%--error: function (e) {--%>
<%--//                    alert(" 😥 系统异常，请与我们的工程师小哥哥联系！");--%>
                    <%--layer.alert(" 😥 系统异常，请与我们的工程师小哥哥联系！", {--%>
                        <%--title: '信息'--%>
                    <%--});--%>
                <%--}--%>
            <%--});--%>
        });

    });
    <%--function loginSubmit() {--%>
        <%--$.ajax({--%>
            <%--type: "post",--%>
            <%--url: "${ctx}/login",--%>
            <%--data: $("#loginForm").serialize(),--%>
            <%--async: true,--%>
            <%--dataType: "json",--%>
            <%--success: function (msg) {--%>
                <%--if ("OK" == msg) {--%>
                    <%--location.href = "${ctx}/index";--%>
                <%--} else{--%>
                    <%--layer.alert(msg, {--%>
                        <%--title: '信息',--%>
                        <%--&lt;%&ndash;yes: function(index, layero){&ndash;%&gt;--%>
                            <%--&lt;%&ndash;//do something&ndash;%&gt;--%>
                            <%--&lt;%&ndash;location.href = "${ctx}/";&ndash;%&gt;--%>
                            <%--&lt;%&ndash;layer.close(index); //如果设定了yes回调，需进行手工关闭&ndash;%&gt;--%>
                        <%--&lt;%&ndash;}&ndash;%&gt;--%>
                    <%--});--%>

<%--//                    --%>
                <%--}--%>

            <%--},--%>
            <%--error: function (e) {--%>
<%--//                    alert(" 😥 系统异常，请与我们的工程师小哥哥联系！");--%>
                <%--layer.alert(" 😥 系统异常，请与我们的工程师小哥哥联系！", {--%>
                    <%--title: '信息'--%>
                <%--});--%>
            <%--}--%>
        <%--});--%>
    <%--}--%>


    $(".register").click(function(){
        location.href="register.jsp"
    })
</script>
</body>

</html>
