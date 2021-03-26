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
        <title>Passbook</title>
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
            table, th, td {
                border: 1px solid black;
                border-collapse: collapse;
                width: 80%;
              }
              th, td {
                padding: 15px;
                font-size: 13px;
                font-family: verdana;
                width:50%;
              }
        </style>
        <link rel='stylesheet' href='tabledesign.css'>
    </head>
    <body style="font-family: verdana; font-size: 10pt;">
        <%@include file="Header.jsp" %>
        <center>
            <h3 style="color: black; margin-left: 25px;">Passbook</h3>
            <br>
            <%
                Long aid = Long.parseLong(CookieDetail.getvalue(request,"aid"));
                session.setAttribute("aid",aid);
                    Connection conn = ConnectionProvider.getconn();
                    Statement stat = conn.createStatement();
                    ResultSet rs = stat.executeQuery("select * from accountdet where aid = " + aid + "and status='Active'");
                    if(rs.next())
                    {
            %>
                <table class="styled-table" cellpadding="5" style="font-family: verdana; font-size: 10pt;">
                    <tr>
                        <th>Account Number</th>
                        <td><%= rs.getLong("aid") %></td>
                    </tr>
                    <tr>
                        <th>Customer Name</th>
                        <td><%= rs.getString("name") %></td>
                    </tr>
                    <tr>
                        <th>Account Type</th>
                        <td><%= rs.getString("atype") %></td>
                    </tr>
                    <tr>
                        <th>Balance Available</th>
                        <td><%= rs.getDouble("balance") %></td>
                    </tr>
                </table>
                    <br><br>
                <table class="styled-table" cellpadding="5" style="font-family: verdana; font-size: 10pt;">
                    <tr>
                        <th>Transaction Date</th>
                        <th>Particulars</th>
                        <th>Dr Amount</th>
                        <th>Cr Amount</th>
                    </tr>
                    <%
                        Statement gstat = conn.createStatement();
                        ResultSet grs = gstat.executeQuery("select * from transactiondet where aid = " + aid + " order by tid desc");
                        while(grs.next())
                        {
                    %>
                    <tr>
                        <td><%= grs.getString("date") %></td>
                        <td><%= grs.getString("msg") %></td>
                        <%
                            if(grs.getDouble("dr") == 0.0)
                            {
                        %>
                        <td></td>
                        <%
                            }
                            else
                            {
                        %>
                        <td><%= grs.getDouble("dr") %></td>
                        <%
                            }
                        %>
                        <%
                            if(grs.getDouble("cr") == 0.0)
                            {
                        %>
                        <td></td>
                        <%
                            }
                            else
                            {
                        %>
                        <td><%= grs.getDouble("cr") %></td>
                        <%
                            }
                        %>
                    </tr>
                    <%
                        }
                    %>
                </table>
                <br><br>
                <a href="exporttoexcel.jsp" style=" text-align: right;">Export to Excel</a>
                <br><br>
            <%
                    }
                    else
                    {          
            %>
            <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightsalmon;color: red; padding-top: 5px; ">
                <h4 style="margin-top: 3px;">Invalid Account Number or Account is deactivated</h4>
            </div>
            <%
                    }
            %>
        </center>
    </body>
</html>