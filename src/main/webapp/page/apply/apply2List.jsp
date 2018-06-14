<%--
  Created by IntelliJ IDEA.
  User: zhengqilong
  Date: 2018/5/23
  Time: 18:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: zhengqilong
  Date: 2018/5/23
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>文章列表--layui后台管理模板</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${ctx}/layui-admin/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${ctx}/layui-admin/css/font_eolqem241z66flxr.css" media="all" />
    <link rel="stylesheet" href="${ctx}/layui-admin/css/news.css" media="all" />
</head>
<body class="childrenBody">
<blockquote class="layui-elem-quote news_search">
    <div class="layui-inline">
        <div class="layui-form-mid" style="font-size: 20px">申请入团记录</div>
    </div>
    <%--<div class="layui-inline">--%>
        <%--<a class="layui-btn layui-btn-normal newsAdd_btn">添加用户</a>--%>
    <%--</div>--%>
    <%--<div class="layui-inline">--%>
        <%--<a class="layui-btn recommend" style="background-color:#5FB878">推荐文章</a>--%>
    <%--</div>--%>
    <%--<div class="layui-inline">--%>
        <%--<a class="layui-btn audit_btn">审核文章</a>--%>
    <%--</div>--%>
    <%--<div class="layui-inline">--%>
        <%--<a class="layui-btn layui-btn-danger batchDel">批量删除</a>--%>
    <%--</div>--%>
    <%--<div class="layui-inline">--%>
        <%--<div class="layui-form-mid layui-word-aux">本页面刷新后除新添加的文章外所有操作无效，关闭页面所有数据重置</div>--%>
    <%--</div>--%>
</blockquote>
<div class="layui-form news_list">
    <table class="layui-table">
        <colgroup>
            <col width="50">
            <col >
            <col width="9%">
            <col width="15%">
            <col width="9%">
            <col width="20%">
            <col width="9%">
            <col width="15%">
        </colgroup>
        <thead>
        <tr>
            <th><input type="checkbox" name="" lay-skin="primary" lay-filter="allChoose" id="allChoose"></th>
            <th>社团名称</th>
            <th>申请人</th>
            <th>申请时间</th>
            <th>审核状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody class="news_content">


        </tbody>
    </table>
</div>
<div id="page"></div>
<script type="text/javascript" src="${ctx}/layui-admin/layui/layui.js"></script>
<%--<script type="text/javascript" src="${ctx}/layui-admin/page/news/newsList.js"></script>--%>
<script>
    layui.config({
        base : "js/"
    }).use(['form','layer','jquery','laypage'],function(){
        var form = layui.form(),
            layer = parent.layer === undefined ? layui.layer : parent.layer,
            laypage = layui.laypage,
            $ = layui.jquery;

        //加载页面数据
        var newsData = '';
        $.get(/*"/layui-admin/json/newsList.json",*/"/apply2List?auditStatus=1", function(data){
            var newArray = [];
            data = JSON.parse(data);

            //单击首页“待审核文章”加载的信息
            if($(".top_tab li.layui-this cite",parent.document).text() == "待审核文章"){
                if(window.sessionStorage.getItem("addNews")){
                    var addNews = window.sessionStorage.getItem("addNews");
                    newsData = JSON.parse(addNews).concat(data);
                }else{
                    newsData = data;
                }
                for(var i=0;i<newsData.length;i++){
                    if(newsData[i].newsStatus == "待审核"){
                        newArray.push(newsData[i]);
                    }
                }
                newsData = newArray;
                newsList(newsData);
            }else{    //正常加载信息
                newsData = data;
                if(window.sessionStorage.getItem("addNews")){
                    var addNews = window.sessionStorage.getItem("addNews");
                    newsData = JSON.parse(addNews).concat(newsData);
                }
                //执行加载数据的方法
                newsList();
            }
        })

        //查询


        //添加文章
        $(".newsAdd_btn").click(function(){
            var index = layui.layer.open({
                title : "添加用户",
                type : 2,
                content : "addUser.jsp",
                success : function(layero, index){
                    layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                }
            })
            //改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
            $(window).resize(function(){
                layui.layer.full(index);
            })
            layui.layer.full(index);
        })

        //推荐文章
        $(".recommend").click(function(){
            var $checkbox = $(".news_list").find('tbody input[type="checkbox"]:not([name="show"])');
            if($checkbox.is(":checked")){
                var index = layer.msg('推荐中，请稍候',{icon: 16,time:false,shade:0.8});
                setTimeout(function(){
                    layer.close(index);
                    layer.msg("推荐成功");
                },2000);
            }else{
                layer.msg("请选择需要推荐的文章");
            }
        })

        //审核文章
        $(".audit_btn").click(function(){
            var $checkbox = $('.news_list tbody input[type="checkbox"][name="checked"]');
            var $checked = $('.news_list tbody input[type="checkbox"][name="checked"]:checked');
            if($checkbox.is(":checked")){
                var index = layer.msg('审核中，请稍候',{icon: 16,time:false,shade:0.8});
                setTimeout(function(){
                    for(var j=0;j<$checked.length;j++){
                        for(var i=0;i<newsData.length;i++){
                            if(newsData[i].newsId == $checked.eq(j).parents("tr").find(".news_del").attr("data-id")){
                                //修改列表中的文字
                                $checked.eq(j).parents("tr").find("td:eq(3)").text("审核通过").removeAttr("style");
                                //将选中状态删除
                                $checked.eq(j).parents("tr").find('input[type="checkbox"][name="checked"]').prop("checked",false);
                                form.render();
                            }
                        }
                    }
                    layer.close(index);
                    layer.msg("审核成功");
                },2000);
            }else{
                layer.msg("请选择需要审核的文章");
            }
        })

        //批量删除
        $(".batchDel").click(function(){
            var arrayid = new Array();
            $('tbody input[name="checked"]:checked').each(function(){arrayid.push($(this).val());});
            console.log(arrayid)
            var $checkbox = $('.news_list tbody input[type="checkbox"][name="checked"]');
            var $checked = $('.news_list tbody input[type="checkbox"][name="checked"]:checked');
            if($checkbox.is(":checked")){
                layer.confirm('确定删除选中的信息？',{icon:3, title:'提示信息'},function(index){

                    setTimeout(function(){
                        $.ajax({
                            type: "post",
                            url: "${ctx}/userDelAll",
                            data: {"delIds":arrayid},
                            traditional: true,
                            dataType: "json",
                            success: function (msg) {
                                if ("OK" == msg) {
                                    location.reload();
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
                        layer.close(index);
                        layer.msg("删除成功");
                    },1000);
                })

            }else{
                layer.msg("请选择需要删除的文章");
            }
        })

        //全选
        form.on('checkbox(allChoose)', function(data){
            var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]:not([name="show"])');
            child.each(function(index, item){
                item.checked = data.elem.checked;
            });
            form.render('checkbox');
        });

        //通过判断文章是否全部选中来确定全选按钮是否选中
        form.on("checkbox(choose)",function(data){

            var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]:not([name="show"])');
            var childChecked = $(data.elem).parents('table').find('tbody input[type="checkbox"]:not([name="show"]):checked')
            if(childChecked.length == child.length){
                $(data.elem).parents('table').find('thead input#allChoose').get(0).checked = true;
            }else{
                $(data.elem).parents('table').find('thead input#allChoose').get(0).checked = false;
            }
            form.render('checkbox');
        })

        //是否展示
//        form.on('switch(isShow)', function(data){
//            var index = layer.msg('修改中，请稍候',{icon: 16,time:false,shade:0.8});
//            setTimeout(function(){
//                var _this = $(this);
//
//                console.log(_this.attr("data-id"));
//                layer.close(index);
//                layer.msg("展示状态修改成功！");
//            },2000);
//        })

        //操作
        $("body").on("click",".news_edit",function(){  //编辑
            location.href="/userInitUpdate?id="+$(this).attr("data-id")
        })

        $("body").on("click",".news_collect",function(){  //收藏.
            if($(this).text().indexOf("已收藏") > 0){
                layer.msg("取消收藏成功！");
                $(this).html("<i class='layui-icon'>&#xe600;</i> 收藏");
            }else{
                layer.msg("收藏成功！");
                $(this).html("<i class='iconfont icon-star'></i> 已收藏");
            }
        })

        $("body").on("click",".news_fault",function(){  //审核不通过
            var _this = $(this);
            //例子2
            layer.prompt({
                formType: 2,
                value: '初始值',
                title: '请输入值',
                area: ['400px', '250px'] //自定义文本域宽高
            }, function(value, index, elem){
//                alert(value); //得到value
                $.ajax({
                    type: "post",
                    url: "${ctx}/applyAudit",
                    data: {"id":_this.attr("data-id"),"auditStatus":3,"auditContent":value},
                    async: true,
                    dataType: "json",
                    success: function (msg) {
                        if ("OK" == msg) {
                            location.reload();
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
                layer.close(index);
            });


        })

        $("body").on("click",".news_success",function(){  //审核通过
            var _this = $(this);
            layer.confirm('确定通过审核吗？',{icon:3, title:'提示信息'},function(index){
                //_this.parents("tr").remove();
                console.log(_this.attr("data-id"))
                $.ajax({
                    type: "post",
                    url: "${ctx}/applyAudit",
                    data: {"id":_this.attr("data-id"),"auditStatus":2},
                    async: true,
                    dataType: "json",
                    success: function (msg) {
                        if ("OK" == msg) {
                            location.reload();
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
                layer.close(index);
            });
        })

        function newsList(that){
            //渲染数据
            function renderDate(data,curr){
                var dataHtml = '';
                if(!that){
                    currData = newsData.concat().splice(curr*nums-nums, nums);
                }else{
                    currData = that.concat().splice(curr*nums-nums, nums);
                }
                if(currData.length != 0){
                    for(var i=0;i<currData.length;i++){
                        if(currData[i].auditStatus == 1){
                            dataHtml += '<tr>'
                                +'<td><input type="checkbox" name="checked" value="'+currData[i].id+'" lay-skin="primary" lay-filter="choose"></td>'
                                +'<td>'+currData[i].orgName+'</td>'
                                +'<td>'+currData[i].userName+'</td>'
                                +'<td>'+timestampToTime(currData[i].gmtCreate)+'</td>';
                            if(currData[i].auditStatus == 1){
                                dataHtml += '<td style="color:#ff6b77">未处理</td>';
                            }else  if(currData[i].auditStatus == 2){
                                dataHtml += '<td style="color:#8eff3a">审核通过</td>';
                            }else{
                                dataHtml += '<td style="color:#ff3225">审核不通过</td>';
                            }

                            dataHtml +=  '<td><a class="layui-btn layui-btn-mini news_success"  data-id="'+currData[i].id+'"><i class="iconfont icon-edit"></i> 通过</a>'
                                //                            +  '<a class="layui-btn layui-btn-normal layui-btn-mini news_collect"><i class="layui-icon">&#xe600;</i> 收藏</a>'
                                +  '<a class="layui-btn layui-btn-danger layui-btn-mini news_fault" data-id="'+currData[i].id+'"><i class="layui-icon">&#xe640;</i> 不通过</a>'
                                +'</td>'
                                +'</tr>';
                        }
                    }
                }else{
                    dataHtml = '<tr><td colspan="6">暂无数据</td></tr>';
                }
                return dataHtml;
            }

            //分页
            var nums = 10; //每页出现的数据量
            if(that){
                newsData = that;
            }
            laypage({
                cont : "page",
                pages : Math.ceil(newsData.length/nums),
                jump : function(obj){
                    $(".news_content").html(renderDate(newsData,obj.curr));
                    $('.news_list thead input[type="checkbox"]').prop("checked",false);
                    form.render();
                }
            })
        }
    })
    function timestampToTime(timestamp) {
        var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        Y = date.getFullYear() + '-';
        M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        D = date.getDate() + ' ';
        h = date.getHours() + ':';
        m = date.getMinutes() + ':';
        s = date.getSeconds();
        return Y+M+D+h+m+s;
//        return Y+M+D;
    }
    timestampToTime(1403058804);
</script>
</body>
</html>

