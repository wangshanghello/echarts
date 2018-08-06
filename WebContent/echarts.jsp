<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script type="text/javascript" src="echarts/echarts.js"></script>
		<script type="text/javascript" src="echarts/jquery-3.2.1.js"></script>
<%
	String path = request.getContextPath();
%>
</head>
<body>
		<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
		<div id="main" style="width: 600px;height:400px;"></div>
		<script type="text/javascript">
		var xx=[];
		var yy="";
		var ss=[];
			$(document).ready(function(){
				$.post('<%=path%>/echarts', function(data) {
							var xxyy = eval(data);
							for (var i = 0; i < xxyy.length; i++) {
								xx.push(xxyy[i].claz_name);
								ss.push(xxyy[i].claz_num);
							}

							// 基于准备好的dom，初始化echarts实例
							var myChart = echarts.init(document
									.getElementById('main'));
							// 指定图表的配置项和数据

							var option = {

								//提示框组件,鼠标移动上去显示的提示内容
								tooltip : {
									trigger : 'item',
									formatter : "{a} <br/>{b}: {c} ({d}%)"//模板变量有 {a}、{b}、{c}、{d}，分别表示系列名，数据名，数据值，百分比。
								},
								//图例
								legend : {
									//图例垂直排列
									orient : 'vertical',
									x : 'left',
									//data中的名字要与series-data中的列名对应，方可点击操控
									data : xx
								},

								series : [ {
									name : '访问来源',
									type : 'pie',
									//饼状图
									// radius: ['50%', '70%'],
									avoidLabelOverlap : false,
									//标签
									label : {
										normal : {
											show : true,
											position : 'inside',
											formatter : '{d}%',//模板变量有 {a}、{b}、{c}、{d}，分别表示系列名，数据名，数据值，百分比。{d}数据会根据value值计算百分比

											textStyle : {
												align : 'center',
												baseline : 'middle',
												fontFamily : '微软雅黑',
												fontSize : 15,
												fontWeight : 'bolder'
											}
										},
									},

									data : function() {
										var res = [];
										for (var i = 0; i < xx.length; i++) {
											res.push({
												value : ss[i],
												name : xx[i]
											});
										}
										alert(res.toString())
										return res;
									}()
								} ]
							};
							// 使用刚指定的配置项和数据显示图表。
							myChart.setOption(option);
						})
					});
		</script>
</body>
</html>