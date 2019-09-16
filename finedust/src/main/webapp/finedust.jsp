<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page import="java.util.*" %>
<%
    List<String> list = new ArrayList<>();
for(int i=0;i<=9;i++) {
	String dronevalues = (String)request.getAttribute("0"+i);
	list.add(dronevalues);
}
for(int i=10;i<=23;i++) {
	String dronevalues = (String)request.getAttribute(""+i);
	list.add(dronevalues);
}
    request.setAttribute("list", list);
    
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
</head>
<body>
<c:forEach items="${list}" var="item">
${item } <br>
</c:forEach>
<%= a%>
<%= list.get(10)%>
<% int j=0; %>
<script>
var arr = new Array();
arr[	0	] = <%= list_pm2.get(	0	)%>;
arr[	1	] = <%= list_pm2.get(	1	)%>;
arr[	2	] = <%= list_pm2.get(	2	)%>;
arr[	3	] = <%= list_pm2.get(	3	)%>;
arr[	4	] = <%= list_pm2.get(	4	)%>;
arr[	5	] = <%= list_pm2.get(	5	)%>;
arr[	6	] = <%= list_pm2.get(	6	)%>;
arr[	7	] = <%= list_pm2.get(	7	)%>;
arr[	8	] = <%= list_pm2.get(	8	)%>;
arr[	9	] = <%= list_pm2.get(	9	)%>;
arr[	10	] = <%= list_pm2.get(	10	)%>;
arr[	11	] = <%= list_pm2.get(	11	)%>;
arr[	12	] = <%= list_pm2.get(	12	)%>;
arr[	13	] = <%= list_pm2.get(	13	)%>;
arr[	14	] = <%= list_pm2.get(	14	)%>;
arr[	15	] = <%= list_pm2.get(	15	)%>;
arr[	16	] = <%= list_pm2.get(	16	)%>;
arr[	17	] = <%= list_pm2.get(	17	)%>;
arr[	18	] = <%= list_pm2.get(	18	)%>;
arr[	19	] = <%= list_pm2.get(	19	)%>;
arr[	20	] = <%= list_pm2.get(	20	)%>;
arr[	21	] = <%= list_pm2.get(	21	)%>;
arr[	22	] = <%= list_pm2.get(	22	)%>;
arr[	23	] = <%= list_pm2.get(	23	)%>;

var arr2 = new Array();
arr2[	0	] = <%= list_pm10.get(	0	)%>;
arr2[	1	] = <%= list_pm10.get(	1	)%>;
arr2[	2	] = <%= list_pm10.get(	2	)%>;
arr2[	3	] = <%= list_pm10.get(	3	)%>;
arr2[	4	] = <%= list_pm10.get(	4	)%>;
arr2[	5	] = <%= list_pm10.get(	5	)%>;
arr2[	6	] = <%= list_pm10.get(	6	)%>;
arr2[	7	] = <%= list_pm10.get(	7	)%>;
arr2[	8	] = <%= list_pm10.get(	8	)%>;
arr2[	9	] = <%= list_pm10.get(	9	)%>;
arr2[	10	] = <%= list_pm10.get(	10	)%>;
arr2[	11	] = <%= list_pm10.get(	11	)%>;
arr2[	12	] = <%= list_pm10.get(	12	)%>;
arr2[	13	] = <%= list_pm10.get(	13	)%>;
arr2[	14	] = <%= list_pm10.get(	14	)%>;
arr2[	15	] = <%= list_pm10.get(	15	)%>;
arr2[	16	] = <%= list_pm10.get(	16	)%>;
arr2[	17	] = <%= list_pm10.get(	17	)%>;
arr2[	18	] = <%= list_pm10.get(	18	)%>;
arr2[	19	] = <%= list_pm10.get(	19	)%>;
arr2[	20	] = <%= list_pm10.get(	20	)%>;
arr2[	21	] = <%= list_pm10.get(	21	)%>;
arr2[	22	] = <%= list_pm10.get(	22	)%>;
arr2[	23	] = <%= list_pm10.get(	23	)%>;


var h = <%= a%>
for (var i = 0; i < 24; i++) {
    h++;
    console.log(h);
    console.log(arr[i]);
  }

</script>
</body>
</html>