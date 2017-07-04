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
    <title>一食堂B出入口</title>
    <!--easyUI插件导入-->
    <link rel="stylesheet" type="text/css" href="css/easyui.css">
    <link rel="stylesheet" type="text/css" href="css/icon.css">
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
    <!--highcharts插件导入-->

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="js/jquery-1.8.3.min.js" type="text/javascript"></script>
        <script src="js/highcharts-zh_CN.js" type="text/javascript"></script>
        <script src="js/highcharts-3d.js" type="text/javascript"></script>
        <script src="js/exporting.js" type="text/javascript"></script>
        <script src="js/highcharts.js" type="text/javascript"></script>

</head>
<body>


<script type="text/javascript">
    $(function () {
        $('#container').highcharts({
            chart: {
                type: 'column',
                margin: 75,
                options3d: {
                    enabled: true,
                    alpha: 10,
                    beta: 25,
                    depth: 70
                }
            },
            title: {
                text: '一食堂B出入口人口流量信息展示'
            },
            subtitle: {
                text: ''
            },
            plotOptions: {
                column: {
                    depth: 25
                }
            },
            xAxis: {
                categories: ['10:30', '11:00', '12:00', '12:30', '13:00', '14:00', '14:30', '15:00', '15:30','16:00']
            },
            yAxis: {
                title: {
                    text: null
                }
            },
            series: [{
                name: '数量',
                data: [1, 1, 1, 2, 3, 0, 0, 0, 0, 0]
            }]
        });
    });
</script>
<div id="container" style="margin: 0 auto" >
</div>
</body>
</html>
