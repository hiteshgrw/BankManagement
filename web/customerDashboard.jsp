<%@page import="prepackage.CookieDetail"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="prepackage.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Panel</title>
        <link rel='stylesheet' href='tabledesign.css'>
    </head>
    <body>
        <%
            String role = CookieDetail.getvalue(request, "Role");
            String emailid = CookieDetail.getvalue(request, "Username");
            if (role.equals("Customer")) {
                Connection conn = ConnectionProvider.getconn();
                Statement stat = conn.createStatement();
                ResultSet rs = stat.executeQuery("select balance,name,aid from accountdet where emailid = '" + emailid + "'");
                if (rs.next()) {
        %>
        <%@include file="Header.jsp" %>
        <h2 style="color: black; margin-left: 25px; text-align: center;">WELCOME TO DASHBOARD</h2> <br><br>
        <h3 style="color: black; margin-left: 25px; text-align: left;">WELCOME <%= rs.getString(2)%></h3> <br>
        <h3 style="color: black; margin-right: 25px; text-align: right;">Current Available Balance :  <%= rs.getString(1)%></h3> <br>
        <h3 style="color: black; margin-left: 25px; text-align: center;">Last 10 Transactions </h3> <br><br><br>
        <%
            Long aid = rs.getLong(3);
        %>
    <center>
        <table class="styled-table" cellpadding="5" style="font-family: verdana; font-size: 10pt;width: 80%;">
            <thead>    
                <tr>
                    <th>Transaction Date</th>
                    <th>Particulars</th>
                    <th>Dr Amount</th>
                    <th>Cr Amount</th>
                </tr>
            </thead>
            <%
                Statement gstat = conn.createStatement();
                ResultSet grs = gstat.executeQuery("select * from transactiondet where aid = " + aid + " order by tid desc fetch first 10 row only");
                while (grs.next()) {
            %>
            <tr>
                <td><%= grs.getString("date")%></td>
                <td><%= grs.getString("msg")%></td>
                <%
                    if (grs.getDouble("dr") == 0.0) {
                %>
                <td></td>
                <%
                } else {
                %>
                <td><%= grs.getDouble("dr")%></td>
                <%
                    }
                %>
                <%
                    if (grs.getDouble("cr") == 0.0) {
                %>
                <td></td>
                <%
                } else {
                %>
                <td><%= grs.getDouble("cr")%></td>
                <%
                    }
                %>
            </tr>
            <%
                }
            %>
        </table>
    </center>
    <%
            } else {
                response.sendRedirect("Logout");
            }
        } else {
            response.sendRedirect("customerLogin.jsp");
        }
    %>
</body>
</html>