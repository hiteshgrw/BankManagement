<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="prepackage.ConnectionProvider"%>
<%@page contentType="text/html" %>
<html>
    <head>
        <title>Today's Transaction</title>
        <link rel='stylesheet' href='tabledesign.css'>
    </head>
    <body style="font-family: verdana; font-size: 10pt;">
        <%@include file="Header.jsp" %>
        <center>
            <h3 style="color: black; margin-left: 25px;">Today's Transaction</h3>
            <table class="styled-table" cellpadding="5" style="font-family: verdana; font-size: 10pt;">
                <thead>
                    <tr>
                        <th>Account Number</th>
                        <th>Particulars</th>
                        <th>Dr Amount</th>
                        <th>Cr Amount</th>
                    </tr>
                </thead>
                <%
                    Connection conn = ConnectionProvider.getconn();
                    Statement stat = conn.createStatement();
                    String date = (new SimpleDateFormat("yyyy-MM-dd")).format(new Date());
                    ResultSet rs = stat.executeQuery("select * from transactiondet where date = '" + date + "'");
                    while(rs.next()){
                %>
                <tr>
                    <td><%= rs.getLong("aid") %></td>
                    <td><%= rs.getString("msg") %></td>
                    <%
                            if(rs.getDouble("dr") == 0.0)
                            {
                        %>
                        <td></td>
                        <%
                            }
                            else
                            {
                        %>
                        <td><%= rs.getDouble("dr") %></td>
                        <%
                            }
                        %>
                        <%
                            if(rs.getDouble("cr") == 0.0)
                            {
                        %>
                        <td></td>
                        <%
                            }
                            else
                            {
                        %>
                        <td><%= rs.getDouble("cr") %></td>
                        <%
                            }
                        %>
                </tr>
                <%
                    }
                %>
            </table>
            <br><br>
            <a href="todayexcel.jsp" style=" text-align: right;">Export to Excel</a>
            <br><br>
        </center>
    </body>
</html>