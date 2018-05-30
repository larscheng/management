<%--
  Created by IntelliJ IDEA.
  User: zhengqilong
  Date: 2018/5/22
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>个人资料--layui后台管理模板</title>
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
<form class="layui-form" id="orgUpdateForm">
    <div class="user_left">
        <div class="layui-form-item">
            <label class="layui-form-label">转让对象</label>
            <div class="layui-input-inline">
                <select name="orgFounder" class="newsLook" lay-filter="browseLook">
                   <c:forEach items="${manUsers}" var="user">
                       <option value="${user.id}">${user.userName}</option>
                   </c:forEach>
                </select>
                <input type="hidden" id="orgId" name="id" value="${orgId}" disabled class="layui-input layui-disabled">
            </div>
        </div>


    </div>
    <div class="layui-form-item" style="margin-left: 5%;">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="changeUser">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<%--<script src="${ctx}/layui-admin/js/jquery-2.2.3.min.js" type="text/javascript" charset="utf-8"></script>--%>

<script type="text/javascript" src="${ctx}/layui-admin/layui/layui.js"></script>
<script type="text/javascript" src="${ctx}/layui-admin/page/user/address.js"></script>

<script type="text/javascript">
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
        layui.upload({
            url : "/layui-admin/json/userface.json",
            success: function(res){
                var num = parseInt(4*Math.random());  //生成0-4的随机数
                //随机显示一个头像信息
                userFace.src = res.data[num].src;
                window.sessionStorage.setItem('userFace',res.data[num].src);
            }
        });

        //添加验证规则
        form.verify({
            oldPwd : function(value, item){
                if(value != "123456"){
                    return "密码错误，请重新输入！";
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

        //提交个人资料
        form.on("submit(changeUser)",function(data){
            layer.confirm('确定转让社团吗？',{icon:3, title:'提示信息'},function(index){

                var formData = new FormData($( "#orgUpdateForm" )[0]);  // 要求使用的html对象
                formData.append("id",$("#orgId").val())
                $.ajax({
                    type: "post",
                    url: "/orgChangeUser",
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
                            var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
                            setTimeout(function(){
                                top.layer.close(index);
                                top.layer.msg("社团转让成功！");
                                layer.closeAll("iframe");
                                //刷新父页面
                                parent.location.reload();
                            },1000);
                        } else{
                            layer.alert(msg)
                        }

                    },
                    error: function (e) {
//                    alert(" 😥 系统异常，请与我们的工程师小哥哥联系！");
                        layer.alert(" 😥 系统异常，请与我们的工程师小哥哥联系！", {
                            title: '信息'
                        });
                    }
                });
                layer.close(index);
            });
            return false;
        })


        //
        // //修改密码
        // form.on("submit(changePwd)",function(data){
        // 	var index = layer.msg('提交中，请稍候',{icon: 16,time:false,shade:0.8});
        //     setTimeout(function(){
        //         layer.close(index);
        //         layer.msg("密码修改成功！");
        //         $(".pwd").val('');
        //     },2000);
        // 	return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        // })

    })



</script>
</body>
</html>
