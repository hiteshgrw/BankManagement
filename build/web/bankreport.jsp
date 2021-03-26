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
        <title>Bank Report</title>
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
            <h3 style="color: black; margin-left: 25px;">Bank Report</h3>
            <br>
            <%
                String clk = request.getParameter("clk");
            %>
            <form action="bankreport.jsp" method="POST">
                <input name="clk" id="clk" value="okay" type="hidden"/>
                <input name="from" id="from" placeholder="--yyyy-MM-dd--" type="date" required="required" style="width:30%;" value="<%= new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>"/>
                <input name="to" id="to" placeholder="--yyyy-MM-dd--" type="date" required="required" style="width:30%;" value="<%= new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>"/>
                <input name="submit" type="submit" value="Show Me" style="width:10%;"/>
            </form>
            <%
                if(clk != null)
                {
            %>
            <table class="styled-table" cellpadding="5" style="font-family: verdana; font-size: 10pt;">
                    <thead>
                        <tr>
                            <th>Account Number</th>
                            <th>Particulars</th>
                            <th>Transaction Date</th>
                            <th>Dr Amount</th>
                            <th>Cr Amount</th>
                        </tr>
                    </thead>
            <%
                    String fromd = request.getParameter("from");
                    String tod = request.getParameter("to");
                    session.setAttribute("fromd",fromd);
                    session.setAttribute("tod",tod);
                    Connection conn = ConnectionProvider.getconn();
                    Statement stat = conn.createStatement();
                    ResultSet rs = stat.executeQuery("select * from transactiondet where date >= '" + fromd + "' and date <= '" + tod + "'");
                    while(rs.next())
                    {
            %>
                    <tr>
                        <td><%= rs.getLong("aid") %></td>
                        <td><%= rs.getString("msg") %></td>
                        <td><%= rs.getString("date") %></td>
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
                <a href="brexcel.jsp" style=" text-align: right;">Export to Excel</a>
                <br><br>
            <%
                    }
            %>
        </center>
    </body>
</html>