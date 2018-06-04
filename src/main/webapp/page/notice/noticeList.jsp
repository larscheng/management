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
    <title>公告列表--layui后台管理模板</title>
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
        <div class="layui-form-mid" style="font-size: 20px">公告列表</div>
    </div>
    <div class="layui-inline">
        <a class="layui-btn layui-btn-normal newsAdd_btn">添加公告</a>
    </div>
    <%--<div class="layui-inline">--%>
        <%--<a class="layui-btn recommend" style="background-color:#5FB878">推荐文章</a>--%>
    <%--</div>--%>
    <%--<div class="layui-inline">--%>
        <%--<a class="layui-btn audit_btn">审核文章</a>--%>
    <%--</div>--%>
    <div class="layui-inline">
        <a class="layui-btn layui-btn-danger batchDel">批量删除</a>
    </div>
    <%--<div class="layui-inline">--%>
        <%--<div class="layui-form-mid layui-word-aux">本页面刷新后除新添加的文章外所有操作无效，关闭页面所有数据重置</div>--%>
    <%--</div>--%>
</blockquote>
<div class="layui-form news_list">
    <table class="layui-table">
        <colgroup>
            <col width="50">
            <col>
            <col width="9%">
            <col width="9%">
            <col width="20%">
            <col width="25%">
        </colgroup>
        <thead>
        <tr>
            <th><input type="checkbox" name="" lay-skin="primary" lay-filter="allChoose" id="allChoose"></th>
            <th>公告标题</th>
            <th>发布人</th>
            <th>所属社团</th>
            <th>发布时间</th>
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
        form.render();
        //加载页面数据
        var newsData = '';
        $.get(/*"/layui-admin/json/newsList.json",*/"/noticeList?orgId=${id}", function(data){
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
        $("body").on("click",".news_quit",function(){  //转让
           location.href="${ctx}/changeUserInit?id="+$(this).attr("data-id");
        })
        //查询
        $(".search_btn").click(function(){
            var newArray = [];
            if($(".search_input").val() != ''){
                var index = layer.msg('查询中，请稍候',{icon: 16,time:false,shade:0.8});
                setTimeout(function(){
                    $.ajax({
                        url : "/layui-admin/json/newsList.json",
                        type : "get",
                        dataType : "json",
                        success : function(data){
                            if(window.sessionStorage.getItem("addNews")){
                                var addNews = window.sessionStorage.getItem("addNews");
                                newsData = JSON.parse(addNews).concat(data);
                            }else{
                                newsData = data;
                            }
                            for(var i=0;i<newsData.length;i++){
                                var newsStr = newsData[i];
                                var selectStr = $(".search_input").val();
                                function changeStr(data){
                                    var dataStr = '';
                                    var showNum = data.split(eval("/"+selectStr+"/ig")).length - 1;
                                    if(showNum > 1){
                                        for (var j=0;j<showNum;j++) {
                                            dataStr += data.split(eval("/"+selectStr+"/ig"))[j] + "<i style='color:#03c339;font-weight:bold;'>" + selectStr + "</i>";
                                        }
                                        dataStr += data.split(eval("/"+selectStr+"/ig"))[showNum];
                                        return dataStr;
                                    }else{
                                        dataStr = data.split(eval("/"+selectStr+"/ig"))[0] + "<i style='color:#03c339;font-weight:bold;'>" + selectStr + "</i>" + data.split(eval("/"+selectStr+"/ig"))[1];
                                        return dataStr;
                                    }
                                }
                                //文章标题
                                if(newsStr.newsName.indexOf(selectStr) > -1){
                                    newsStr["newsName"] = changeStr(newsStr.newsName);
                                }
                                //发布人
                                if(newsStr.newsAuthor.indexOf(selectStr) > -1){
                                    newsStr["newsAuthor"] = changeStr(newsStr.newsAuthor);
                                }
                                //审核状态
                                if(newsStr.newsStatus.indexOf(selectStr) > -1){
                                    newsStr["newsStatus"] = changeStr(newsStr.newsStatus);
                                }
                                //浏览权限
                                if(newsStr.newsLook.indexOf(selectStr) > -1){
                                    newsStr["newsLook"] = changeStr(newsStr.newsLook);
                                }
                                //发布时间
                                if(newsStr.newsTime.indexOf(selectStr) > -1){
                                    newsStr["newsTime"] = changeStr(newsStr.newsTime);
                                }
                                if(newsStr.newsName.indexOf(selectStr)>-1 || newsStr.newsAuthor.indexOf(selectStr)>-1 || newsStr.newsStatus.indexOf(selectStr)>-1 || newsStr.newsLook.indexOf(selectStr)>-1 || newsStr.newsTime.indexOf(selectStr)>-1){
                                    newArray.push(newsStr);
                                }
                            }
                            newsData = newArray;
                            newsList(newsData);
                        }
                    })

                    layer.close(index);
                },2000);
            }else{
                layer.msg("请输入需要查询的内容");
            }
        })

        //添加文章
        $(".newsAdd_btn").click(function(){
//            var _this = $(this);
//            console.log(_this.attr("data-id"))
            window.sessionStorage.setItem("orgId",${id});
            var index = layui.layer.open({
                title : "发布新公告",
                type : 2,
                content : "/page/notice/addNotice.jsp",
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
                    var index = layer.msg('删除中，请稍候',{icon: 16,time:false,shade:0.8});
                    setTimeout(function(){
                        //删除数据
                        $.ajax({
                            type: "post",
                            url: "${ctx}/noticeDelAll",
                            data: {"delIds":arrayid},
                            traditional: true,
                            dataType: "json",
                            success: function (msg) {
                                if ("OK" == msg) {
                                    location.reload();
                                } else{
                                    layer.msg(msg)
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
                    },2000);
                })
            }else{
                layer.msg("请选择需要删除的公告");
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
        form.on('switch(isShow)', function(data){
            var index = layer.msg('修改中，请稍候',{icon: 16,time:false,shade:0.8});
            setTimeout(function(){
                layer.close(index);
                layer.msg("展示状态修改成功！");
            },2000);
        })

        //操作
        $("body").on("click",".news_view",function(){  //编辑
            location.href="/noticeDetail?id="+$(this).attr("data-id")
        })
        //操作
        $("body").on("click",".news_home",function(){  //编辑
            location.href="/orgHome?id="+$(this).attr("data-id")
        })



        $("body").on("click",".news_pub",function(){  //删除
            var _this = $(this);
            console.log(_this.attr("data-id"))
            window.sessionStorage.setItem("orgId",_this.attr("data-id"));
            var index = layui.layer.open({
                title : "发布新公告",
                type : 2,
                content : "addNotice.jsp",
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



        $("body").on("click",".news_del",function(){  //删除
            var _this = $(this);
            layer.confirm('确定删除该公告吗？',{icon:3, title:'提示信息'},function(index){
                //_this.parents("tr").remove();
                console.log(_this.attr("data-id"))
                $.ajax({
                    type: "post",
                    url: "${ctx}/noticeDel",
                    data: {"id":_this.attr("data-id")},
                    async: true,
                    dataType: "json",
                    success: function (msg) {
                        if ("OK" == msg) {
                            var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
                            setTimeout(function(){
                                top.layer.close(index);
                                top.layer.msg("删除成功！");
                                layer.closeAll("iframe");
                                //刷新父页面
                                location.reload();
                            },500);
                        } else{
                            layer.msg(msg)
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
                        dataHtml += '<tr>'
                            +'<td><input type="checkbox" name="checked" lay-skin="primary" value="'+currData[i].id+'" lay-filter="choose"></td>'
                            +'<td>'+currData[i].noticeTitle+'</td>'
                            +'<td>'+currData[i].userName+'</td>'
                            +'<td style="">'+currData[i].orgName+'</td>'
                            +'<td>'+timestampToTime(currData[i].gmtCreate)+'</td>';
//
//                        if(currData[i].auditStatus == 1){
//                            dataHtml += '<td style="color:#ff6a33">未处理</td>';
//                        }else  if(currData[i].auditStatus == 2){
//                            dataHtml += '<td style="color:#8eff3a">审核通过</td>';
//                        }else{
//                            dataHtml += '<td style="color:#ff3225">审核不通过</td>';
//                        }
//                        dataHtml += '<td>'+timestampToTime(currData[i].gmtCreate)+'</td>'
//                            +'<td>'+currData[i].nowNum+'人/'+currData[i].orgNum+'人</td>';
//                        if(currData[i].orgStatus == 1){
//                            dataHtml += '<td style="color:green">启用</td>';
////                                +'<td><a class="layui-btn layui-btn-warm layui-btn-mini news_able" data-id="'+currData[i].id+'" data-state="0"><i class="iconfont icon-edit"></i> 禁用</a>';
//                        }else{
//                            dataHtml += '<td style="color:#ff3225">禁用</td>';
////                                +'<td><a class="layui-btn layui-btn-mini news_able" data-id="'+currData[i].id+'" data-state="1"><i class="iconfont icon-edit"></i> 启用</a>';
//                        }

                        dataHtml += '<td><a class="layui-btn layui-btn-normal layui-btn-mini news_view" data-id="'+currData[i].id+'"><i class="layui-icon"></i> 详情</a>'
                            +  '<a class="layui-btn layui-btn-danger layui-btn-mini news_del" data-id="'+currData[i].id+'"><i class="layui-icon "></i> 删除</a>'
                            +'</td>'
                            +'</tr>';
                    }
                }else{
                    dataHtml = '<tr><td colspan="9">暂无数据</td></tr>';
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
        m = date.getMinutes();
        s = date.getSeconds();
        return Y+M+D+h+m;
//        return Y+M+D;
    }
    timestampToTime(1403058804);
</script>
</body>
</html>
