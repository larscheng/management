<%--
  Created by IntelliJ IDEA.
  User: zhengqilong
  Date: 2018/5/24
  Time: 13:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>文章添加--layui后台管理模板</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${ctx}/layui-admin/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${ctx}/layui-admin/css/font_eolqem241z66flxr.css" media="all" />
</head>
<body class="childrenBody">
<form class="layui-form" id="addOrgForm">
    <div class="layui-form-item">
        <label class="layui-form-label">社团名称</label>
        <div class="layui-input-block">
            <input type="text" name="orgName" disabled value="${org.orgName}" class="layui-input newsName" lay-verify="required" placeholder="请输入社团名称">
            <input type="hidden" name="id" value="${org.id}" class="layui-input newsName" lay-verify="required" placeholder="请输入社团名称">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">社团类型</label>
            <div class="layui-input-inline">
                <select name="orgType" class="newsLook" lay-filter="browseLook">
                    <c:choose>
                        <c:when test="${org.orgType eq 1}">
                            <option value="1" selected>专业学术类</option>
                            <option value="2">艺术兴趣类</option>
                            <option value="3">体育健身类</option>
                            <option value="4">公益服务类</option>
                        </c:when>
                        <c:when test="${org.orgType eq 2}">
                            <option value="1" >专业学术类</option>
                            <option value="2" selected>艺术兴趣类</option>
                            <option value="3">体育健身类</option>
                            <option value="4">公益服务类</option>
                        </c:when>
                        <c:when test="${org.orgType eq 3}">
                            <option value="1" >专业学术类</option>
                            <option value="2" >艺术兴趣类</option>
                            <option value="3" selected>体育健身类</option>
                            <option value="4">公益服务类</option>
                        </c:when>
                        <c:otherwise>
                            <option value="1" >专业学术类</option>
                            <option value="2" >艺术兴趣类</option>
                            <option value="3" >体育健身类</option>
                            <option value="4" selected>公益服务类</option>
                        </c:otherwise>
                    </c:choose>

                </select>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">社团人数</label>
            <div class="layui-input-inline">
                <select name="orgNum" class="newsLook" lay-filter="browseLook">
                    <c:choose>
                        <c:when test="${org.orgNum eq 50}">
                            <option value="50" selected>50人</option>
                            <option value="100">100人</option>
                            <option value="150">150人</option>
                            <option value="200">200人</option>
                        </c:when>
                        <c:when test="${org.orgNum eq 100}">
                            <option value="50" >50人</option>
                            <option value="100" selected>100人</option>
                            <option value="150">150人</option>
                            <option value="200">200人</option>
                        </c:when>
                        <c:when test="${org.orgNum eq 150}">
                        <option value="50" >50人</option>
                        <option value="100">100人</option>
                        <option value="150" selected>150人</option>
                        <option value="200">200人</option>
                        </c:when>
                        <c:when test="${org.orgNum eq 200}">
                        <option value="50" >50人</option>
                        <option value="100">100人</option>
                        <option value="150">150人</option>
                        <option value="200" selected>200人</option>
                    </c:when>
                    </c:choose>

                </select>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">社长:&nbsp;&nbsp;&nbsp;&nbsp;${org.userName}</label>

    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">社团介绍</label>
        <div class="layui-input-block">
            <textarea class="layui-textarea layui-hide" name="orgInfo" lay-verify="content" id="news_content">${org.orgInfo}</textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="addNews">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
    </div>
</form>
<script type="text/javascript" src="${ctx}/layui-admin/layui/layui.js"></script>
<%--<script type="text/javascript" src="${ctx}/layui-admin/page/news/newsAdd.js"></script>--%>
<script>
    layui.config({
        base : "js/"
    }).use(['form','layer','jquery','layedit','laydate'],function(){
        var form = layui.form(),
            layer = parent.layer === undefined ? layui.layer : parent.layer,
            laypage = layui.laypage,
            layedit = layui.layedit,
            laydate = layui.laydate,
            $ = layui.jquery;

        //创建一个编辑器
        var editIndex = layedit.build('news_content');
        var addNewsArray = [],addNews;
        <%--layedit.setContent(editIndex,${org.orgInfo}})--%>

        form.on("submit(addNews)",function(data){
            console.log(layedit.getContent(editIndex));
            var formData = new FormData($( "#addOrgForm" )[0]);  // 要求使用的html对象
            formData.append("orgInfo",layedit.getContent(editIndex));
            $.ajax({
                type: "post",
                url: "/orgAble",
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
                            top.layer.msg("社团添加成功！");
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
            return false;
        })

    })

</script>
</body>
</html>
