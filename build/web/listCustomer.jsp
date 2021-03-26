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
            <h3 style="color: black; margin-left: 25px;">ALL CUSTOMER</h3>
            <table class="styled-table" cellpadding="5" style="font-family: verdana; font-size: 10pt;">
                <thead>
                    <tr>
                        <th>Customer ID</th>
                        <th>Customer Name</th>
                        <th>Address</th>
                        <th>Gender</th>
                        <th>Adhar ID</th>
                        <th>Phone Number</th>
                        <th>Email Address</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    while(rs.next()){
                %>
                
                <tr>
                    <td><%= rs.getInt("cid") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("address") %></td>
                    <td><%= rs.getString("gender") %></td>
                    <td><%= rs.getLong("adhar") %></td>
                    <td><%= rs.getLong("phone") %></td>
                    <td><%= rs.getString("emailid") %></td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </center>
    </body>
</html>