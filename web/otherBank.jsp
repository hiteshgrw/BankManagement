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
        <title>Transfer</title>
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
    </head>
    <body style="font-family: verdana; font-size: 10pt;">
        <%@include file="Header.jsp" %>
        <center>
            <h3 style="color: black; margin-left: 25px;">Transfer</h3>
            <br>
            <%
                Connection conn = ConnectionProvider.getconn();
                Statement getst = conn.createStatement();
                Long oaid = Long.parseLong(CookieDetail.getvalue(request,"aid"));
                ResultSet getrs = getst.executeQuery("select * from btable where aid = " + oaid);
                ArrayList<String> selectst = new ArrayList();
                ArrayList<Long> anolist = new ArrayList();
                selectst.clear();
                anolist.clear();
                while(getrs.next())
                {
                    selectst.add(getrs.getString("name") + " - " + getrs.getLong("ano"));
                    anolist.add(getrs.getLong("ano"));
                }
                String clk = request.getParameter("clk");
                String aid;
                session.setAttribute("selectst",selectst);
                session.setAttribute("anolist",anolist);
            %>
            <form action="otherBank.jsp" method="POST">
                <input name="clk" id="clk" value="okay" type="hidden"/>
                <%
                    if(clk!=null)
                    {
                        aid = request.getParameter("aid");
                %>
                <select name="aid" id="aid" required="required" style="width:60%;">
                    <%
                        for(String s : selectst)
                        {
                            if(s.equals(aid))
                            {
                    %>
                    <option selected="selected"><%= s %></option>
                    <%
                            }
                            else
                            {
                    %>
                    <option><%= s %></option>
                    <%
                            }
                        }
                    %>
                </select>
                <%
                    }
                    else
                    {
                %>
                <select name="aid" id="aid" required="required" style="width:60%;">
                    <%
                        for(String s : selectst)
                        {
                    %>
                    <option><%= s %></option>
                    <%
                        }
                    %>
                </select>
                <%
                    }
                %>
                <input name="submit" type="submit" value="Search" style="width:10%;"/>
            </form>
            <%
                if(clk != null)
                {
                    aid = request.getParameter("aid");
                    Long anum = anolist.get(selectst.indexOf(aid));
                    Statement stat = conn.createStatement();
                    ResultSet rs = stat.executeQuery("select * from btable where aid = " + oaid + "and ano=" + anum);
                    if(rs.next())
                    {
            %>
            <form action="OtherBank" method="POST">
                <input name="anum" id="anum" value="<%= anum %>" type="hidden"/>
                <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightgreen;color: green; padding-top: 5px; ">
                    <h4 style="margin-top: 3px;">Account Number Found</h4>
                </div>
                <table>
                    <tr>
                        <th>Account Number</th>
                        <td><%= rs.getLong("ano") %></td>
                    </tr>
                    <tr>
                        <th>Customer Name</th>
                        <td><%= rs.getString("name") %></td>
                    </tr>
                    <tr>
                        <th>Customer Bank Name</th>
                        <td><%= rs.getString("bname") %></td>
                    </tr>
                    <tr>
                        <th>Bank IFSC Code</th>
                        <td><%= rs.getString("bifsc") %></td>
                    </tr>
                </table>
                    <br><br>
                <table>
                    <tr>
                        <th>Transaction Date</th>
                        <th>Transfer Amount</th>
                    </tr>
                    <tr>
                        <td><center><input name="date" id="date" type="date" value="<%= new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>" required="required"/></center></td>
                        <td><center><input name="amount" id="amount" placeholder="Enter Transfer Amount" type="text" required="required"/></center></td>
                    </tr>
                </table>
                <input name="submit" type="submit" value="Transfer" style="width:10%;"/>
            </form>
            <%
                    }
                    else
                    {          
            %>
            <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightsalmon;color: red; padding-top: 5px; ">
                <h4 style="margin-top: 3px;">Invalid Account Number or Account is deactivated</h4>
            </div>
            <%
                    }
                }
                String msg = request.getParameter("msg");
                if(msg!=null)
                {
                    if(msg.equals("success"))
                    {
            %>
            <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightgreen;color: green; padding-top: 5px; ">
                <h4 style="margin-top: 3px;">Transfer Successful</h4>
            </div>
            <%
                    }
                    else if(msg.equals("error"))
                    {
            %>
            <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightsalmon;color: red; padding-top: 5px; ">
                <h4 style="margin-top: 3px;">Transfer Failed</h4>
            </div>
            <%
                    }
                    else if(msg.equals("maxlimit"))
                    {
            %>
            <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightsalmon;color: red; padding-top: 5px; ">
                <h4 style="margin-top: 3px;">The transfer amount exceeds the maximum limit</h4>
            </div>
            <%
                    }
                }
            %>
        </center>
    </body>
</html>