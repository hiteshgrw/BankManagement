<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="prepackage.ConnectionProvider"%>
<%@page contentType="text/html" %>
<html>
    <head>
        <title>Update Information</title>
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
                width:20%;
            }
        </style>
    </head>
    <body style="font-family: verdana; font-size: 10pt;">
        <%@include file="Header.jsp" %>
    <center>
        <h3 style="color: black; margin-left: 25px;">Update Customer Information</h3>
        <br>
        <%                String clk = request.getParameter("clk");
            Long aid;
        %>
        <form action="updateCustomer.jsp" method="POST">
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
                ResultSet rs = stat.executeQuery("select * from accountdet where aid = " + aid);
                Statement stat2;
                ResultSet rs2;
                if (rs.next()) {
                    stat2 = conn.createStatement();
                    rs2 = stat2.executeQuery("select * from customerdet where cid = " + rs.getInt("cid"));
                    if (rs2.next()) {
        %>
        <form action="UpdateCustomer" method="POST">
            <input name="cid" id="cid" value="<%= rs.getInt("cid")%>" type="hidden"/>
            <input name="aid" id="aid" value="<%= rs.getLong("aid")%>" type="hidden"/>
            <table>
                <tr>
                    <th>Account Number</th>
                    <td><%= rs.getLong("aid")%></td>
                    <th>Account Type</th>
                    <td><%= rs.getString("atype")%></td>
                </tr>
                <tr>
                    <th>Balance Available</th>
                    <td><%= rs.getDouble("balance")%></td>
                    <th>Account Status</th>
                    <td><%= rs.getString("status")%></td>
                </tr>
                <tr>
                    <th>Customer Name</th>
                    <td><input name="name" id="name" placeholder="Enter Customer Name" type="text" required="required" value="<%= rs2.getString("name")%>" style=" width: 90%"/></td>
                    <th>Customer Address</th>
                    <td><input name="address" id="address" placeholder="Enter Customer Address" type="text" required="required" value="<%= rs2.getString("address")%>" style=" width: 90%"/></td>
                </tr>
                <tr>
                    <th>Gender</th>
                    <td><input name="gender" id="gender" placeholder="Enter Gender" type="text" required="required" value="<%= rs2.getString("gender")%>" style=" width: 90%"/></td>
                    <th>Phone Number</th>
                    <td><input name="phone" id="phone" placeholder="Enter Phone Number" type="text" required="required" value="<%= rs2.getString("phone")%>" style=" width: 90%"/></td>
                </tr>
                <tr>
                    <th>Adhar ID</th>
                    <td><input name="adhar" id="adhar" placeholder="Enter Adhar Number" type="text" required="required" value="<%= rs2.getString("adhar")%>" style=" width: 90%"/></td>
                    <th>Email ID</th>
                    <td><%= rs.getString("emailid")%></td>
                </tr>
            </table>
            <input name="submit" type="submit" value="Update Information" style="width:10%;"/>
        </form>
        <%
            }
        } else {
        %>
        <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightsalmon;color: red; padding-top: 5px; ">
            <h4 style="margin-top: 3px;">Invalid Account Number</h4>
        </div>
        <%
                }
            }
            String msg = request.getParameter("msg");
            if (msg != null) {
                if (msg.equals("success")) {
        %>
        <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightgreen;color: green; padding-top: 5px; ">
            <h4 style="margin-top: 3px;">Information Updated Successfully</h4>
        </div>
        <%
        } else if (msg.equals("error")) {
        %>
        <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightsalmon;color: red; padding-top: 5px; ">
            <h4 style="margin-top: 3px;">Information Update Failed</h4>
        </div>
        <%
                }
            }
        %>
    </center>
</body>
</html>