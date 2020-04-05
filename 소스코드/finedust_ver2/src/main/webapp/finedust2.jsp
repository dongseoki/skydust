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
 
     <font size=5><center>서울시 종로구 미세먼지 농도 측정 그래프</center></font><br>
 	<div style="text-align:right; width: 1100px;">
    	<font size=1>
    	<font color=blue>Drnpm10Value</font>, <font color=red>Drnpm25Value</font>: 쿼드콥터 미세먼지 센서로 측정된 수치, <font color=orange>pm10Value</font>, <font color=green>pm25Value</font> : AirKorea에서 제공된 미세먼지 수치
    	</font>
    </div>
    <div id="Line_Controls_Chart">
      <!-- 라인 차트 생성할 영역 -->
          <div id="lineChartArea" style="padding:0px 20px 0px 0px;"></div>
      <!-- 컨트롤바를 생성할 영역 -->
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
  
  
  
  // data 그리기
  var loadDt = new Date();
  
  var chartDrowFun = {
 
    chartDrow : function(){
        var chartData = '';
 
        //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
        var chartDateformat     = 'yyyy년MM월dd일';
        //라인차트의 라인 수
        var chartLineCount    = 10;
        //컨트롤러 바 차트의 라인 수
        var controlLineCount    = 10;
 
        function drawDashboard() {
 
          var data = new google.visualization.DataTable();
          //그래프에 표시할 컬럼 추가
          data.addColumn('datetime' , '날짜');
          data.addColumn('number', 'Drnpm2.5Value');
          data.addColumn('number', 'Drnpm10Value');
          //data.addColumn('number', 'pm10Value');
          //data.addColumn('number', 'pm25Value');
 
          //그래프에 표시할 데이터
          var dataRow = [];
 
          for(var i = 1; i <= 24; i++){ //랜덤 데이터 생성
        	var asdf =1;
            var pm2   = arr_pm2[i-1];
            var pm10  = arr_pm10[i-1];
            var v = new Date(Date.parse(loadDt) - (24+1-i)*1000*60*60); 
            dataRow = [new Date(v.getFullYear(), v.getMonth(), v.getDate() , v.getHours()),pm2, pm10];
            
            data.addRow(dataRow);
          }
 
 
            var chart = new google.visualization.ChartWrapper({
              chartType   : 'LineChart',
              containerId : 'lineChartArea', //라인 차트 생성할 영역
              options     : {
                              isStacked   : 'percent',
                              focusTarget : 'category',
                              height          : 500,
                              width              : '100%',
                              legend          : { position: "top", textStyle: {fontSize: 13}},
                              pointSize        : 5,
                              tooltip          : {textStyle : {fontSize:12}, showColorCode : true,trigger: 'both'},
                              hAxis              : {format: chartDateformat, gridlines:{count:chartLineCount,units: {
                                                                  years : {format: ['yyyy년']},
                                                                  months: {format: ['MM월']},
                                                                  days  : {format: ['dd일']},
                                                                  hours : {format: ['HH시']}}
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
              containerId: 'controlsArea',  //control bar를 생성할 영역
              options: {
                  ui:{
                        chartType: 'LineChart',
                        chartOptions: {
                        chartArea: {'width': '60%','height' : 80},
                          hAxis: {'baselineColor': 'none', format: chartDateformat, textStyle: {fontSize:12},
                            gridlines:{count:controlLineCount,units: {
                                  years : {format: ['yyyy년']},
                                  months: {format: ['MM월']},
                                  days  : {format: ['dd일']},
                                  hours : {format: ['HH시']}}
                            }}
                        }
                  },
                    filterColumnIndex: 0
                }
            });
 
            var date_formatter = new google.visualization.DateFormat({ pattern: chartDateformat});
            date_formatter.format(data, 0);
 
            var dashboard = new google.visualization.Dashboard(document.getElementById('Line_Controls_Chart'));
            window.addEventListener('resize', function() { dashboard.draw(data); }, false); //화면 크기에 따라 그래프 크기 변경
            dashboard.bind([control], [chart]);
            dashboard.draw(data);
 
        }
          google.charts.setOnLoadCallback(drawDashboard);
 
      }
    }
 
$(document).ready(function(){
  google.charts.load('current', {'packages':['line','controls']});
  chartDrowFun.chartDrow(); //chartDrow() 실행
});
  </script>
</html>