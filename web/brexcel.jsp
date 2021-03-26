<%@page import="java.util.Date"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="prepackage.ConnectionProvider"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Export to Excel</title>
        <style>
        table, th, td {
          border: 1px solid black;
        }
        </style>
    </head>
    <body>
        <%
            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat sdf = new SimpleDateFormat("ddMMyyyyHHmmss");
            String cdate = sdf.format(new java.util.Date());
            response.setHeader("Content-Disposition", "inline; filename="+"banktransactionreport" + cdate + ".xls");
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
                    String fromd = (String) session.getAttribute("fromd");
                    String tod = (String) session.getAttribute("tod");
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
    </body>
</html>