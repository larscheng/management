<%--
  Created by IntelliJ IDEA.
  User: zhengqilong
  Date: 2018/5/22
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>首页--layui后台管理模板</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${ctx}/layui-admin/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${ctx}/layui-admin/css/font_eolqem241z66flxr.css" media="all" />
    <link rel="stylesheet" href="${ctx}/layui-admin/css/main.css" media="all" />
</head>
<body class="childrenBody">
<div class="panel_box row" style="margin-left: 26%">

    <div class="panel col">
        <a href="javascript:;" data-url="page/org/myOrgList.jsp">
            <div class="panel_icon" style="background-color:#FF5722;">
                <%--<i class="iconfont icon-dongtaifensishu" data-icon="icon-dongtaifensishu"></i>--%>
                    <i class="layui-icon" data-icon="&#xe609;">&#xe609;</i>
            </div>
            <div class="panel_word userAll">
                <span>${sessionScope.myOrgNum}</span>
                <cite>我加入的社团数</cite>
            </div>
        </a>
    </div>
    <div class="panel col">
        <a href="javascript:;" data-url="page/org/myCreateOrgList.jsp">
            <div class="panel_icon" style="background-color:#009688;">
                <i class="layui-icon" data-icon="&#xe612;">&#xe612;</i>
            </div>
            <div class="panel_word userAll">
                <span>${sessionScope.myCreateOrgNum}</span>
                <cite>我管理的社团数</cite>
            </div>
        </a>
    </div>

    <div class="panel col">
        <a href="javascript:;" data-url="page/org/ableOrgList.jsp">
            <div class="panel_icon" style="background-color:#5FB878;">
                <i class="layui-icon" data-icon="&#xe60b;">&#xe60b;</i>
            </div>
            <div class="panel_word imgAll">
                <span>${sessionScope.orgNum}</span>
                <cite>社团总数</cite>
            </div>
        </a>
    </div>

</div>


<%--<!--图表-->--%>
<%--<div class="chart-panel panel panel-default" style="margin: auto; width: 80%">--%>
    <%--<div class="panel-body" id="chart" style="height: 400px;">--%>
    <%--</div>--%>
<%--</div>--%>


<script type="text/javascript" src="${ctx}/layui-admin/layui/layui.js"></script>
<script>

    layui.config({
        base : "/layui-admin/js/"
    }).use(['form','element','layer','jquery'],function(){
        var form = layui.form(),
            layer = parent.layer === undefined ? layui.layer : parent.layer,
            element = layui.element(),
            $ = layui.jquery;

        $(".panel a").on("click",function(){
            window.parent.addTab($(this));
        })
    })
</script>
</body>
</html>
