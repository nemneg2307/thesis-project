<%--
  Created by IntelliJ IDEA.
  User: nexy2
  Date: 26-Apr-21
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %>***
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>

<script>
    function printDate()
    {
        let date_time = "";

        const days = new Array("SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT");
        const months = new Array("JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC");

        let current_time = new Date();

        date_time += "CURRENT DATE - TIME : " + days[current_time.getDay()] + ", " + current_time.getDate() + " " + months[current_time.getMonth()] + " " + current_time.getFullYear() + " " + current_time.getHours() +":" + current_time.getMinutes() + ":" + current_time.getSeconds();
        document.getElementById("todaysDate").innerHTML = date_time;
    }

    setInterval(printDate, 1000);
</script>
<div id="todaysDate"></div>

</body>
</html>
