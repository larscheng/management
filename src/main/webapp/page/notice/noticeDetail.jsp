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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    <blockquote class="layui-elem-quote news_search">
        <div class="layui-inline">
            <div class="layui-form-mid" style="font-size: 20px">公告详情</div>
        </div>
    <%--<div class="layui-inline">--%>
            <%--<div class="layui-input-inline">--%>
                <%--<input type="text" value="" placeholder="请输入关键字" class="layui-input search_input">--%>
            <%--</div>--%>
            <%--<a class="layui-btn search_btn">查询</a>--%>
        <%--</div>--%>
        <%--<c:if test="${org.auditStatus eq 2}">--%>
            <%--<div class="layui-inline">--%>
                <%--<a class="layui-btn layui-btn-normal" onclick="userList(${org.id})">社团成员</a>--%>
            <%--</div>--%>
            <%--&lt;%&ndash;<div class="layui-inline">&ndash;%&gt;--%>
                <%--&lt;%&ndash;<a class="layui-btn layui-btn-danger batchDel">发布公告</a>&ndash;%&gt;--%>
            <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
        <%--</c:if>--%>
    </blockquote>


    <div class="layui-form-item">
        <label class="layui-form-label">公告标题</label>
        <div class="layui-input-inline">
            <input type="text" name="orgName" disabled value="${dto.noticeTitle}" class="layui-input newsName" lay-verify="required" placeholder="">
            <%--<input type="hidden" name="id" value="${org.id}" class="layui-input newsName" lay-verify="required" placeholder="请输入社团名称">--%>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">发布人</label>
            <div class="layui-input-inline">
                <input type="text" name="orgName" disabled value="${dto.userName}" class="layui-input newsName" lay-verify="required" placeholder="">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">发布时间</label>
            <div class="layui-input-inline">
                <input type="text" name="orgName" disabled value=" <fmt:formatDate value="${dto.gmtCreate}" pattern="yyyy-MM-dd HH:mm:ss"/>" class="layui-input newsName" lay-verify="required" placeholder="">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">公告内容</label>
        <div class="layui-input-block">
            <div style="padding-top: 8px;">${dto.noticeContent}</div>
        </div>
    </div>

</form>



<script type="text/javascript" src="${ctx}/layui-admin/layui/layui.js"></script>
<%--<script type="text/javascript" src="${ctx}/layui-admin/page/news/newsAdd.js"></script>--%>
<script>
    function userList(id) {
        location.href="${ctx}/orgUserPage?id="+id;
    }
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



        layui.use('element', function(){
            var element = layui.element;

            //…
        });
    })

</script>
</body>
</html>
