<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/1
  Time: 13:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>一食堂C出入口</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="js/jquery-3.0.0.js"></script>
    <script type="text/javascript" src="js/highcharts.js"></script>
    <!--easyUI插件导入-->
    <!--<link rel="stylesheet" type="text/css" href="css/easyui.css">
    <link rel="stylesheet" type="text/css" href="css/icon.css">
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.easyui.min.js"></script>-->
    <!--highcharts插件导入-->



</head>
<body>


<script type="text/javascript">
    $(function() {
        var x = [];//X轴
        var y = [];//Y轴
        var xtext = [];//X轴TEXT
        var color = ["gray","tan","red","blue","yellow","green","black","purple","skyblue"];
        /*var ytext = [];//Y轴TEXT*/
        $.ajax({
            type:'get',
            url:'CanteeServlet', //请求数据的地址
            //dataType:'json', //后台传值指定格式
            //data:{pname:"pname",pnum:"pnum"},//发送到服务器的数据格式
            success:function(json){
                //解析json数据
                var j = eval("("+json+")");
                //遍历json
                for(var key in j){
                    xtext.push(j[key].Time);//给X轴TEXT赋值
                    /*ytext.push(j[key].people_coint);*///给Y轴值的数组赋值
                    j[key].y = j[key].people_count; //给Y轴赋值
                    j[key].color= color[key];
                }
                chart.series[0].setData(j);//数据填充到highcharts上面
            },
            error:function(){
                alert("请求失败！！！");

            }
        });


        //创建图表
        var chart = new Highcharts.Chart({
            chart : {
                renderTo : 'container', //图表放置div位置
                type:'column' //图表类型（柱形图）
            },

            title:{
                text:'实时人口流量信息柱状图' //图表的标题
            },

            xAxis:{
                /* title:{
                 text:'时间' //X轴的名称
                 }, */
                categories:xtext //X轴的种类
            },

            yAxis:{
                title:{
                    text:'人口流量' //Y轴的名称
                }
            },

            series : [ {
                name:"人口流量"
            } ]
        });
        /*$(document).ready(function() {
         //每隔3秒自动调用方法，实现图表的实时更新
         window.setInterval(getForm,3000);

         });  */
    });
</script>
<div id="container" style="margin: 0 auto" >
</div>
</body>
</html>
