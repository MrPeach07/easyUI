<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/1
  Time: 12:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    //添加新的tab选项卡，内容是图表（柱形图）
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
  <div data-options="region:'north'" style="height:100px">
    <img src="img/logo.png" style="height: 100%;width: 150px; margin-left: 100px;" >
    <div style="font-size: 30px; float: right; align-content: center;" >西南石油大学各区域人口流量信息查询</div>
  </div>
  <div data-options="region:'south',split:true" style="height:50px;"></div>
  <div data-options="region:'west',split:true" title="菜单" style="width:180px;">
    <div class="easyui-accordion" style="width:500px;height:300px;">
      <div title="食堂人口流量查询" data-options="iconCls:'icon-search'" style="padding:10px;">
        <ul class="easyui-tree">
          <li>
            <span>一食堂出入口</span>
            <ul>
              <li><a href="javascript:void(0);" onclick="getcharts('一食堂A入口人口流量信息','first_cantee_a_entrance.jsp')">A入口</a></li>
              <li><a href="javascript:void(0);" onclick="getcharts('一食堂B入口人口流量信息','first_cantee_b_entrance.jsp')">B入口</a></li>
              <li><a href="javascript:void(0);" onclick="getcharts('一食堂C入口人口流量信息','first_cantee_c_entrance.jsp')">C入口</a></li>
            </ul>
          </li>
          <li>
            <span>二食堂出入口</span>
            <ul>
              <li><a href="javascript:void(0);" onclick="getcharts('一食堂A入口人口流量信息','second_cantee_a_entrance.jsp')">A入口</a></li>
              <li><a href="javascript:void(0);" onclick="getcharts('二食堂B入口人口流量信息','second_cantee_b_entrance.jsp')">B入口</a></li>
              <li><a href="javascript:void(0);" onclick="getcharts('二食堂C入口人口流量信息','second_cantee_c_entrance.jsp')">C入口</a></li>
            </ul>
          </li>
          <li>
            <span>校园各区域人口流量统计</span>
            <ul>
              <li><a href="javascript:void(0);" onclick="addTab('区域人口流量统计','map_info.jsp')">区域人口流量统计展示</a></li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </div>
  <div data-options="region:'center',title:'首页'">
    <div id="tab" class="easyui-tabs" data-options="fit:true">
      <div title="欢迎页面" data-options="iconCls:'icon-help',closable:true" style="padding:10px">
        首页
      </div>
    </div>
  </div>
</div>
</body>
</html>
