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
            response.setHeader("Content-Disposition", "inline; filename="+"todaytransactionreport" + cdate + ".xls");
        %>
        <table class="styled-table" cellpadding="5" style="font-family: verdana; font-size: 10pt;">
                <thead>
                    <tr>
                        <th>Account Number</th>
                        <th>Particulars</th>
                        <th>Dr Amount</th>
                        <th>Cr Amount</th>
                    </tr>
                </thead>
                <%
                    Connection conn = ConnectionProvider.getconn();
                    Statement stat = conn.createStatement();
                    String date = (new SimpleDateFormat("yyyy-MM-dd")).format(new Date());
                    ResultSet rs = stat.executeQuery("select * from transactiondet where date = '" + date + "'");
                    while(rs.next()){
                %>
                <tr>
                    <td><%= rs.getLong("aid") %></td>
                    <td><%= rs.getString("msg") %></td>
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