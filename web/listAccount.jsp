<%@page contentType="text/html" %>
<jsp:useBean id="rs" scope="request" type="java.sql.ResultSet" />
<html>
    <head>
        <title>Show All Customers</title>
        <link rel='stylesheet' href='tabledesign.css'>
    </head>
    <body style="font-family: verdana; font-size: 10pt;">
        <%@include file="Header.jsp" %>
        <center>
            <h3 style="color: black; margin-left: 25px;">ALL ACCOUNTS</h3>
            <table class="styled-table" cellpadding="5" style="font-family: verdana; font-size: 10pt;">
                <thead>
                    <tr>
                        <th>Customer ID</th>
                        <th>Customer Name</th>
                        <th>Account Number</th>
                        <th>Account Type</th>
                        <th>Available Balance</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <%
                    while(rs.next()){
                %>
                <tr>
                    <td><%= rs.getInt("cid") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getLong("aid") %></td>
                    <td><%= rs.getString("atype") %></td>
                    <td><%= rs.getDouble("balance") %></td>
                    <td><%= rs.getString("status") %></td>
                </tr>
                <%
                    }
                %>
            </table>
        </center>
    </body>
</html>