<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="prepackage.ConnectionProvider"%>
<%@page contentType="text/html" %>
<html>
    <head>
        <title>Beneficiary Details</title>
        <style>
            input[type=text], select {
                padding: 12px 20px;
                margin: 8px 0;
                display: inline-block;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }
            input[type=date], select {
                padding: 12px 20px;
                margin: 8px 0;
                display: inline-block;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }
            input[type=submit] {
                background-color: #4CAF50;
                color: white;
                padding: 14px 20px;
                margin: 8px 0;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            input[type=submit]:hover {
                background-color: #45a049;
            }
        </style>
        <link rel='stylesheet' href='tabledesign.css'>
    </head>
    <body style="font-family: verdana; font-size: 10pt;">
        <%@include file="Header.jsp" %>
        <center>
            <h3 style="color: black; margin-left: 25px;">Beneficiary Details</h3>
            <br>
            <%
                Long aid = Long.parseLong(CookieDetail.getvalue(request,"aid"));
            %>
                <table class="styled-table" cellpadding="5" style="font-family: verdana; font-size: 10pt; width: 95%;">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Bank Name</th>
                            <th>Bank IFSC Code</th>
                            <th>Account Number</th>
                            <th>Max Limit</th>
                        </tr>
                    </thead>
                    <%
                        Connection conn = ConnectionProvider.getconn();
                        Statement gstat = conn.createStatement();
                        ResultSet grs = gstat.executeQuery("select * from btable where aid = " + aid);
                        while(grs.next())
                        {
                    %>
                    <tr>
                        <td><%= grs.getString("name") %></td>
                        <td><%= grs.getString("bname") %></td>
                        <td><%= grs.getString("bifsc") %></td>
                        <td><%= grs.getLong("ano") %></td>
                        <td><%= grs.getDouble("maxlimit") %></td>
                    </tr>
                        <%
                            }
                        %>
                </table>
                <br><br>
        </center>
    </body>
</html>