var navs = [{
    "title" : "系统首页",
    "icon" : "icon-computer",
    "href" : "",
    "spread" : false
},{
    "title" : "用户管理",
    "icon" : "icon-text",
    "href" : "/page/user/userList.jsp",
    "spread" : false
},{
    "title" : "社团管理",
    "icon" : "&#xe61c;",
    "href" : "",
    "spread" : false,
    "children" : [
        {
            "title" : "社团列表",
            "icon" : "&#xe631;",
            "href" : "/page/org/orgList.jsp",
            "spread" : false
        },
        {
            "title" : "待审核列表",
            "icon" : "&#xe631;",
            "href" : "/page/org/org2List.jsp",
            "spread" : false
        }
    ]
},{
    "title" : "管理员列表",
    "icon" : "icon-text",
    "href" : "/page/user/admList.jsp",
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
}]