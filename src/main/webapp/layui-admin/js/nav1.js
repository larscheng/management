var navs = [{
	"title" : "后台首页",
	"icon" : "icon-computer",
	"href" : "",
	"spread" : false
},{
    "title" : "社团列表",
    "icon" : "icon-text",
    "href" : "/page/org/ableOrgList.jsp",
    "spread" : false
},{
    "title" : "我加入的社团",
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
    "title" : "我创建的社团",
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
        },
        {
            "title" : "创建记录",
            "icon" : "&#xe631;",
            "href" : "/page/apply/createList.jsp",
            "spread" : false
        }
    ]
}/*,{
	"title" : "404页面",
	"icon" : "&#xe61c;",
	"href" : "page/404.html",
	"spread" : false
},{
	"title" : "系统基本参数",
	"icon" : "&#xe631;",
	"href" : "page/systemParameter/systemParameter.html",
	"spread" : false
}*/]