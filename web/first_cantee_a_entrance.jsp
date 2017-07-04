<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>柱形图</title>
    <script type="text/javascript" src="js/jquery-3.0.0.js"></script>
    <script type="text/javascript" src="js/highcharts.js"></script>
</head>
<body>
<script type="text/javascript">
    $(function() {
        var x = [];//X轴
        var y = [];//Y轴
        var xtext = [];//X轴TEXT
        var color = ["gray","tan","red","blue","yellow","green","black","purple","skyblue"];
        $.ajax({
            type:'get',
            url:'CanteeServlet', //请求数据的地址
            //dataType:'json', //后台传值指定格式
            //data:{people_count:"people_count"},//发送到服务器的数据格式
            success:function(json){
                //解析json数据
                var j = eval("("+json+")");
                for(var key in j){
                    j[key].y = j[key].pnum; //给Y轴赋值
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
                categories: ['10:30', '11:00', '12:00', '12:30', '13:00', '14:00', '14:30', '15:00', '15:30','16:00',
                    '16:30', '17:00', '17:30', '18:00','18:30','19:00','19:30']//X轴的种类
            },

            yAxis:{
                title:{
                    text:'数量' //Y轴的名称
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