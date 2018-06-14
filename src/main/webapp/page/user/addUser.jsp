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
        <label class="layui-form-label">账号</label>
        <div class="layui-input-block">
            <input type="text" name="userCode" class="layui-input userName" lay-verify="required" placeholder="请输入账号">
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
        <label class="layui-form-label">手机号码</label>
        <div class="layui-input-block">
            <input type="tel" name="userPhone" placeholder="请输入手机号码" lay-verify="required|phone" class="layui-input">
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
            <c:if test="${sessionScope.sessionUser.userType eq 0}">
                <option value="3">普通用户</option>
                <option value="1">管理员</option>
            </c:if>
                <c:if test="${sessionScope.sessionUser.userType eq 1}">
                    <option value="3">普通用户</option>
                </c:if>
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
<%--<script type="text/javascript" src="${ctx}/layui-admin/page/user/addUser.js"></script>--%>
<script>
    var $;
    layui.config({
        base : "js/"
    }).use(['form','layer','jquery'],function(){
        var form = layui.form(),
            layer = parent.layer === undefined ? layui.layer : parent.layer,
            laypage = layui.laypage;
        $ = layui.jquery;

        var addUserArray = [],addUser;
        form.on("submit(addUser)",function(data){

            $.ajax({
                type: "post",
                url: "/userAdd",
                data: $("#addUserForm").serialize(),
                dataType: "json",
                success: function (msg) {
                    if ("OK" == msg) {
                        var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
                        setTimeout(function(){
                            top.layer.close(index);
                            top.layer.msg("用户添加成功！");
                            layer.closeAll("iframe");
                            //刷新父页面
                            parent.location.reload();
                        },500);
                    } else{
                        alert(msg)
                    }

                },
                error: function (e) {
//                    alert(" 😥 系统异常，请与我们的工程师小哥哥联系！");
                    layer.alert(" 😥 系统异常，请与我们的工程师小哥哥联系！", {
                        title: '信息'
                    });
                }
            });
            // 弹出loading

            return false;
        })

    })

    //格式化时间
    function formatTime(_time){
        var year = _time.getFullYear();
        var month = _time.getMonth()+1<10 ? "0"+(_time.getMonth()+1) : _time.getMonth()+1;
        var day = _time.getDate()<10 ? "0"+_time.getDate() : _time.getDate();
        var hour = _time.getHours()<10 ? "0"+_time.getHours() : _time.getHours();
        var minute = _time.getMinutes()<10 ? "0"+_time.getMinutes() : _time.getMinutes();
        return year+"-"+month+"-"+day+" "+hour+":"+minute;
    }

</script>
</body>
</html>
