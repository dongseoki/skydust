<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page import="java.util.*" %>
<%
    List<String> list = new ArrayList<>();
for(int i=0;i<=23;i++) {
	String dronevalues = (String)request.getAttribute(""+i);
	list.add(dronevalues);
}
    
    List<Float> list_pm2 = new ArrayList<>(); 
    List<Float> list_pm10 = new ArrayList<>(); 
    for(int i=0;i<=23;i++){
    	String pmstr =list.get(i);
    	int s_pm2 = pmstr.indexOf("pm2"); // start index of pm2.
    	int s_pm10 = pmstr.indexOf(", pm10");
		int e_pm10 = pmstr.indexOf("]");
		float pm2= Float.parseFloat(pmstr.substring(s_pm2+4, s_pm10));
		float pm10= Float.parseFloat(pmstr.substring(s_pm10+7, e_pm10));
		list_pm2.add(pm2);
		list_pm10.add(pm10);
    }
    int a=10;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<!-- jQuery -->
    <script src="https://code.jquery.com/jquery.min.js"></script>
    <!-- google charts -->
       <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
 
     <font size=5><center>����� ���α� �̼����� �� ���� �׷���</center></font><br>
 	<div style="text-align:right; width: 1100px;">
    	<font size=1>
    	<font color=blue>Drnpm10Value</font>, <font color=red>Drnpm25Value</font>: �������� �̼����� ������ ������ ��ġ, <font color=orange>pm10Value</font>, <font color=green>pm25Value</font> : AirKorea���� ������ �̼����� ��ġ
    	</font>
    </div>
    <div id="Line_Controls_Chart">
      <!-- ���� ��Ʈ ������ ���� -->
          <div id="lineChartArea" style="padding:0px 20px 0px 0px;"></div>
      <!-- ��Ʈ�ѹٸ� ������ ���� -->
          <div id="controlsArea" style="padding:0px 20px 0px 0px;"></div>
        </div>
 
  </body>
 
  <script>

  
  var arr_pm2 = new Array();
  var arr_pm10 = new Array();
  <%for(int i=0;i<24;i++){%>
  arr_pm2[<%=i%>]=<%=list_pm2.get(i)%>;
  arr_pm10[<%=i%>]=<%=list_pm10.get(i)%>;
  <%}%>
  
  
  
  // data �׸���
  var loadDt = new Date();
  
  var chartDrowFun = {
 
    chartDrow : function(){
        var chartData = '';
 
        //��¥���� �����ϰ� �����ø� �� �κ� �����ϼ���.
        var chartDateformat     = 'yyyy��MM��dd��';
        //������Ʈ�� ���� ��
        var chartLineCount    = 10;
        //��Ʈ�ѷ� �� ��Ʈ�� ���� ��
        var controlLineCount    = 10;
 
        function drawDashboard() {
 
          var data = new google.visualization.DataTable();
          //�׷����� ǥ���� �÷� �߰�
          data.addColumn('datetime' , '��¥');
          data.addColumn('number', 'Drnpm2.5Value');
          data.addColumn('number', 'Drnpm10Value');
          //data.addColumn('number', 'pm10Value');
          //data.addColumn('number', 'pm25Value');
 
          //�׷����� ǥ���� ������
          var dataRow = [];
 
          for(var i = 1; i <= 24; i++){ //���� ������ ����
        	var asdf =1;
            var pm2   = arr_pm2[i-1];
            var pm10  = arr_pm10[i-1];
            var v = new Date(Date.parse(loadDt) - (24+1-i)*1000*60*60); 
            dataRow = [new Date(v.getFullYear(), v.getMonth(), v.getDate() , v.getHours()),pm2, pm10];
            
            data.addRow(dataRow);
          }
 
 
            var chart = new google.visualization.ChartWrapper({
              chartType   : 'LineChart',
              containerId : 'lineChartArea', //���� ��Ʈ ������ ����
              options     : {
                              isStacked   : 'percent',
                              focusTarget : 'category',
                              height          : 500,
                              width              : '100%',
                              legend          : { position: "top", textStyle: {fontSize: 13}},
                              pointSize        : 5,
                              tooltip          : {textStyle : {fontSize:12}, showColorCode : true,trigger: 'both'},
                              hAxis              : {format: chartDateformat, gridlines:{count:chartLineCount,units: {
                                                                  years : {format: ['yyyy��']},
                                                                  months: {format: ['MM��']},
                                                                  days  : {format: ['dd��']},
                                                                  hours : {format: ['HH��']}}
                                                                },textStyle: {fontSize:12}},
                vAxis              : {minValue: 100,viewWindow:{min:0},gridlines:{count:-1},textStyle:{fontSize:12}},
                animation        : {startup: true,duration: 1000,easing: 'in' },
                annotations    : {pattern: chartDateformat,
                                textStyle: {
                                fontSize: 15,
                                bold: true,
                                italic: true,
                                color: '#871b47',
                                auraColor: '#d799ae',
                                opacity: 0.8,
                                pattern: chartDateformat
                              }
                            }
              }
            });
 
            var control = new google.visualization.ControlWrapper({
              controlType: 'ChartRangeFilter',
              containerId: 'controlsArea',  //control bar�� ������ ����
              options: {
                  ui:{
                        chartType: 'LineChart',
                        chartOptions: {
                        chartArea: {'width': '60%','height' : 80},
                          hAxis: {'baselineColor': 'none', format: chartDateformat, textStyle: {fontSize:12},
                            gridlines:{count:controlLineCount,units: {
                                  years : {format: ['yyyy��']},
                                  months: {format: ['MM��']},
                                  days  : {format: ['dd��']},
                                  hours : {format: ['HH��']}}
                            }}
                        }
                  },
                    filterColumnIndex: 0
                }
            });
 
            var date_formatter = new google.visualization.DateFormat({ pattern: chartDateformat});
            date_formatter.format(data, 0);
 
            var dashboard = new google.visualization.Dashboard(document.getElementById('Line_Controls_Chart'));
            window.addEventListener('resize', function() { dashboard.draw(data); }, false); //ȭ�� ũ�⿡ ���� �׷��� ũ�� ����
            dashboard.bind([control], [chart]);
            dashboard.draw(data);
 
        }
          google.charts.setOnLoadCallback(drawDashboard);
 
      }
    }
 
$(document).ready(function(){
  google.charts.load('current', {'packages':['line','controls']});
  chartDrowFun.chartDrow(); //chartDrow() ����
});
  </script>
</html>