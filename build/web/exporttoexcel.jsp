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
            Long aid = (Long) session.getAttribute("aid");
            Connection conn = ConnectionProvider.getconn();
            Statement gstat = conn.createStatement();
            ResultSet grs = gstat.executeQuery("select * from transactiondet where aid = " + aid + " order by date");
        %>
        <%
                    Statement stat = conn.createStatement();
                    ResultSet rs = stat.executeQuery("select * from accountdet where aid = " + aid + "and status='Active'");
                    response.setContentType("application/vnd.ms-excel");
                    SimpleDateFormat sdf = new SimpleDateFormat("ddMMyyyyHHmmss");
                    String cdate = sdf.format(new java.util.Date());
                    response.setHeader("Content-Disposition", "inline; filename="+ aid + " accountreport" + cdate + ".xls");
                    if(rs.next())
                    {
            %>
                <table cellpadding="5" style="font-family: verdana; font-size: 10pt; border: 2px solid black;">
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
        <table cellpadding="5" style="font-family: verdana; font-size: 10pt; border: 2px solid black;">
            <tr>
                <th>Transaction Date</th>
                <th>Particulars</th>
                <th>Dr Amount</th>
                <th>Cr Amount</th>
            </tr>
            <%
                    while(grs.next()){
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
                }
            %>
        </table>
    </body>
</html>