<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="prepackage.ConnectionProvider"%>
<%@page contentType="text/html" %>
<html>
    <head>
        <title>Reactivate Account</title>
        <style>
            input[type=text], select {
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
            th {
                background-color: #ffae42;
            }
            td {
                background-color: #f2f2f2;
            }
            th, td {
                padding: 15px;
                font-size: 13px;
                font-family: verdana;
                width:50%;
            }
        </style>
    </head>
    <body style="font-family: verdana; font-size: 10pt;">
        <%@include file="Header.jsp" %>
    <center>
        <h3 style="color: black; margin-left: 25px;">Reactivate Account</h3>
        <br>
        <%                String clk = request.getParameter("clk");
            Long aid;
        %>
        <form action="reactivateAccount.jsp" method="POST">
            <input name="clk" id="clk" value="okay" type="hidden"/>
            <%
                if (clk != null) {
                    aid = Long.parseLong(request.getParameter("aid"));
            %>
            <input name="aid" id="aid" placeholder="Enter Account Number to search" type="text" required="required" style="width:60%;" value="<%= aid%>"/>
            <%
            } else {
            %>
            <input name="aid" id="aid" placeholder="Enter Account Number to search" type="text" required="required" style="width:60%;"/>
            <%
                }
            %>
            <input name="submit" type="submit" value="Search" style="width:10%;"/>
        </form>
        <%
            if (clk != null) {
                aid = Long.parseLong(request.getParameter("aid"));
                Connection conn = ConnectionProvider.getconn();
                Statement stat = conn.createStatement();
                ResultSet rs = stat.executeQuery("select * from accountdet where aid = " + aid + "and status='Deactivated'");
                if (rs.next()) {
        %>
        <form action="ReactivateAccount" method="POST">
            <input name="aid" id="aid" value="<%= rs.getLong("aid")%>" type="hidden"/>
            <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightgreen;color: green; padding-top: 5px; ">
                <h4 style="margin-top: 3px;">Account Number Found</h4>
            </div>
            <table>
                <tr>
                    <th>Account Number</th>
                    <td><%= rs.getLong("aid")%></td>
                </tr>
                <tr>
                    <th>Customer Name</th>
                    <td><%= rs.getString("name")%></td>
                </tr>
                <tr>
                    <th>Account Type</th>
                    <td><%= rs.getString("atype")%></td>
                </tr>
                <tr>
                    <th>Balance Available</th>
                    <td><%= rs.getDouble("balance")%></td>
                </tr>
            </table>
            <input name="submit" type="submit" value="Reactivate Account" style="width:10%;"/>
        </form>
        <%
        } else {
        %>
        <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightsalmon;color: red; padding-top: 5px; ">
            <h4 style="margin-top: 3px;">Invalid Account Number or Account is already active</h4>
        </div>
        <%
                }
            }
            String msg = request.getParameter("msg");
            if (msg != null) {
                if (msg.equals("success")) {
        %>
        <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightgreen;color: green; padding-top: 5px; ">
            <h4 style="margin-top: 3px;">Account Reactivated Successfully</h4>
        </div>
        <%
        } else if (msg.equals("error")) {
        %>
        <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightsalmon;color: red; padding-top: 5px; ">
            <h4 style="margin-top: 3px;">Account Reactivation Failed</h4>
        </div>
        <%
                }
            }
        %>
    </center>
</body>
</html>