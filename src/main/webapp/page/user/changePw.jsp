<%--
  Created by IntelliJ IDEA.
  User: zhengqilong
  Date: 2018/5/22
  Time: 16:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改密码--layui后台管理模板</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${ctx}/layui-admin/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${ctx}/layui-admin/css/user.css" media="all" />
</head>
<body class="childrenBody">
<form class="layui-form changePwd" action="${ctx}/changePw">
    <%--<div style="margin:0 0 15px 110px;color:#f00;">旧密码请输入“123456”，新密码必须两次输入一致才能提交</div>--%>
    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input type="text" value="${sessionScope.sessionUser.userName}" disabled class="layui-input layui-disabled">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">旧密码</label>
        <div class="layui-input-block">
            <input type="password" value="" placeholder="请输入旧密码" lay-verify="required|oldPwd" class="layui-input pwd">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">新密码</label>
        <div class="layui-input-block">
            <input type="password" value="" name="userPassword" placeholder="请输入新密码" lay-verify="required|newPwd" id="oldPwd" class="layui-input pwd">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">确认密码</label>
        <div class="layui-input-block">
            <input type="password" value="" placeholder="请确认密码" lay-verify="required|confirmPwd" class="layui-input pwd">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="changePwd">立即修改</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>

<script type="text/javascript" src="${ctx}/layui-admin/layui/layui.js"></script>
<script type="text/javascript" src="${ctx}/layui-admin/page/user/address.js"></script>
<%--<script type="text/javascript" src="${ctx}/layui-admin/page/user/user.js"></script>--%>
<script>
    var areaData = address;
    var $form;
    var form;
    var $;
    layui.config({
        base : "/layui-admin/js/"
    }).use(['form','layer','upload','laydate'],function(){
        form = layui.form();
        var layer = parent.layer === undefined ? layui.layer : parent.layer;
        $ = layui.jquery;
        $form = $('form');
        laydate = layui.laydate;
//        loadProvince();
        layui.upload({
            url : "/layui-admin/json/userface.json",
            success: function(res){
                var num = parseInt(4*Math.random());  //生成0-4的随机数
                //随机显示一个头像信息
                userFace.src = res.data[num].src;
                window.sessionStorage.setItem('userFace',res.data[num].src);
            }
        });
        var pw = ${sessionScope.sessionUser.userPassword}
//            console.log(pw)
        //添加验证规则
        form.verify({
            oldPwd : function(value, item){
                if(value != pw){
                    return "旧密码错误，请重新输入！";
                }
            },
            newPwd : function(value, item){
                if(value.length < 6){
                    return "密码长度不能小于6位";
                }
            },
            confirmPwd : function(value, item){
                if(!new RegExp($("#oldPwd").val()).test(value)){
                    return "两次输入密码不一致，请重新输入！";
                }
            }
        })

        //判断是否修改过头像，如果修改过则显示修改后的头像，否则显示默认头像
        if(window.sessionStorage.getItem('userFace')){
            $("#userFace").attr("src",window.sessionStorage.getItem('userFace'));
        }else{
            $("#userFace").attr("src","/layui-admin/images/face.jpg");
        }


        //修改密码
        form.on("submit(changePwd)",function(data){
            layer.msg("密码修改成功，下次登录生效")
        })

    })


</script>
</body>
</html>