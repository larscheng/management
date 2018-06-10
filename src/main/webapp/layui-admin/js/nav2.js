var navs = [{
	"title" : "系统首页",
	"icon" : "icon-computer",
	"href" : "",
	"spread" : false
},{
    "title" : "我的社团",
    "icon" : "&#xe61c;",
    "href" : "",
    "spread" : false,
    "children" : [
        {
            "title" : "已加入社团",
            "icon" : "&#xe631;",
            "href" : "/page/org/myOrgList.jsp",
            "spread" : false
        },
        {
            "title" : "申请记录",
            "icon" : "&#xe631;",
            "href" : "/page/apply/applyList.jsp",
            "spread" : false
        }
    ]
},{
    "title" : "查看社团",
    "icon" : "icon-text",
    "href" : "/page/org/ableOrgList.jsp",
    "spread" : false
},{
    "title" : "我管理的社团",
    "icon" : "&#xe61c;",
    "href" : "",
    "spread" : false,
    "children" : [
        {
            "title" : "管理社团",
            "icon" : "&#xe631;",
            "href" : "/page/org/myCreateOrgList.jsp",
            "spread" : false
        },
        {
            "title" : "审核申请",
            "icon" : "&#xe631;",
            "href" : "/page/apply/apply2List.jsp",
            "spread" : false
        }
    ]
},{
    "title" : "创建社团",
    "icon" : "&#xe61c;",
    "href" : "",
    "spread" : false,
    "children" : [
        {
            "title" : "申请建团",
            "icon" : "&#xe631;",
            "href" : "page/org/addOrg.jsp",
            "spread" : false
        },
        {
            "title" : "创建记录",
            "icon" : "&#xe631;",
            "href" : "/page/apply/createList.jsp",
            "spread" : false
        }
    ]
},{
    "title" : "管理公告",
    "icon" : "&#xe61c;",
    "href" : "page/notice/noticeMyList.jsp",
    "spread" : false
},{
    "title" : "个人信息管理",
    "icon" : "&#xe61c;",
    "href" : "",
    "spread" : false,
    "children" : [
        {
            "title" : "资料修改",
            "icon" : "&#xe631;",
            "href" : "/userInfo",
            "spread" : false
        },
        {
            "title" : "密码修改",
            "icon" : "&#xe631;",
            "href" : "/initChangePw",
            "spread" : false
        }
    ]
},{
    "title" : "退出登录",
    "icon" : "&#xe61c;",
    "href" : "/logout",
    "spread" : false
}/*,{
	"title" : "系统基本参数",
	"icon" : "&#xe631;",
	"href" : "page/systemParameter/systemParameter.html",
	"spread" : false
}*/]