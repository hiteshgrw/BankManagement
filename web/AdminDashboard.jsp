<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="prepackage.ConnectionProvider"%>
<%@page import="prepackage.CookieDetail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
    </head>
    <body>
        <%
            String role = CookieDetail.getvalue(request,"Role");
            if(role.equals("admin"))
            {
                int noac;
                double deb,cred;
                Connection conn = ConnectionProvider.getconn();
                Statement stat = conn.createStatement();
                ResultSet rs = stat.executeQuery("SELECT COUNT(aid) from accountdet where status = 'Active'");
                if(rs.next())
                {
                    noac = rs.getInt(1);
                }
                else
                {
                    noac = -1;
                }
                rs = stat.executeQuery("SELECT value from bankdet where name = 'debit'");
                if(rs.next())
                {
                    deb = rs.getDouble(1);
                }
                else
                {
                    deb = -1.0;
                }
                rs = stat.executeQuery("SELECT value from bankdet where name = 'credit'");
                if(rs.next())
                {
                    cred = rs.getDouble(1);
                }
                else
                {
                    cred = -1.0;
                }
        %>
        <%@include file="Header.jsp" %>
        <h2 style="color: black; margin-left: 25px; text-align: center;">WELCOME TO DASHBOARD</h2> <br><br>
        <div style="padding: 15px; font-family: verdana; font-size: 16px">
            <div style="width: 20%; height: 100px; background-color: blue;text-align: right; float: left; margin: 10px; padding: 15px; border-radius: 25px;">
                <h4 style="color: white;">ACTIVE ACCOUNTS</h4>
                <h4 style="color: white;"><%= noac %></h4>
            </div>
            <div style="width: 20%; height: 100px; background-color: red;text-align: right; float: left; margin: 10px; padding: 15px; border-radius: 25px;">
                <h4 style="color: white;">NET DEBIT</h4>
                <h4 style="color: white;"><%= deb %></h4>
            </div>
            <div style="width: 20%; height: 100px; background-color: green;text-align: right; float: left; margin: 10px; padding: 15px; border-radius: 25px;">
                <h4 style="color: white;">NET CREDIT</h4>
                <h4 style="color: white;"><%= cred %></h4>
            </div>
            <div style="width: 20%; height: 100px; background-color: lightskyblue;text-align: right; float: left; margin: 10px; padding: 15px; border-radius: 25px;">
                <h4 style="color: white;">CASH IN HAND</h4>
                <h4 style="color: white;"><%= (cred - deb) %></h4>
            </div>
        </div>
            <%    
                }
                else
                {
                    response.sendRedirect("AdminLogin.jsp");
                }
            %>
    </body>
</html>
