<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>首页</title>
    <link rel="stylesheet" type="text/css" href="css/easyui.css">
    <link rel="stylesheet" type="text/css" href="css/icon.css">
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
</head>
<body>

<script type="text/javascript">
    function addTab(title, url) {
        if ($('#tab').tabs('exists', title)) {
            $('#tab').tabs('select', title);
        } else {
            $('#tab').tabs('add', {
                title : title,
                closable : true,
                href : url
            });
        }
    }
    /* 这种方法存在bug，加载页面后无法加载其他tab的页面。
     function getcharts(title, url) {
     if ($('#tab').tabs('exists', title)) {
     $('#tab').tabs('select', title);
     } else {
     $('#tab').tabs('add', {
     title : title,
     closable : true,
     href:"charts.jsp" //这里的href只能加载页面body中的信息
     });
     }
     }  */
    function getcharts(title, url) {
        var jq = top.jQuery;
        if (jq("#tab").tabs('exists', title)) {
            jq("#tab").tabs('select', title);
        } else {
            //使用iframe标签来加载页面，此方法可以加载页面中全部内容
            var content = '<iframe scrolling="auto" frameborder="0"  src="'
                + url + '" style="width:100%;height:100%;"></iframe>';
            jq("#tab").tabs('add', {
                title : title,
                content : content,
                closable : true
            });
        }
    }
</script>

<div class="easyui-layout" data-options="fit:true">
    //头部
    <div data-options="region:'north'" style="height: 100px" align="center">
        <img src="image/logo.jpg" style="width: 30%;height: 100%;">
    </div>
    //底部
    <div data-options="region:'south',split:true" style="height: 50px;"></div>
    //左侧菜单栏
    <div data-options="region:'west',split:true" title="菜单栏"
         style="width: 180px;">
        <div class="easyui-accordion" data-options="fit:true">
            <div title="菜单树" style="padding: 10px;">
                <ul class="easyui-tree">
                    <li><span>商品管理</span>
                        <ul>
                            <li><span>商品信息</span>
                                <ul>
                                    <li><a href="javascript:void(0);" onclick="addTab('手机列表','listphone.jsp')">手机</a></li>
                                    <li><a href="javascript:void(0);" onclick="addTab('电脑列表','listcomputer.jsp')">电脑</a></li>
                                    <li><a href="javascript:void(0);" onclick="addTab('衣物列表','listclothing.jsp')">衣物</a></li>
                                </ul></li>
                            <li><span>商品图表</span>
                                <ul>
                                    <li><a href="javascript:void(0);" onclick="getcharts('商品图表','charts.jsp')">查看图表</a></li>
                                </ul></li>
                        </ul></li>
                </ul>
            </div>
        </div>
    </div>
    //右侧正文
    <div data-options="region:'center',title:'首页'">
        <div id="tab" class="easyui-tabs" data-options="fit:true">
            <div title="欢迎页面" style="padding: 10px">
                <img src="image/home.jpg" style="width: 100%;height: 100%;">
            </div>
        </div>
    </div>
</div>
</body>
</html>