<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="prepackage.ConnectionProvider"%>
<%@page contentType="text/html" %>
<html>
    <head>
        <title>Open Account</title>
    </head>
    <body style="font-family: verdana; font-size: 10pt;">
        <%@include file="Header.jsp" %>
        <%
            ArrayList<String> namelist = new ArrayList();
            ArrayList<Integer> idlist = new ArrayList();
            Connection conn = ConnectionProvider.getconn();
            Statement stat = conn.createStatement();
            ResultSet rs = stat.executeQuery("select cid,name from customerdet where status = 'UP'");
            namelist.clear();
            idlist.clear();
            while(rs.next())
            {
                namelist.add(rs.getInt(1) + " - " + rs.getString(2));
                idlist.add(rs.getInt(1));
            }
            session.setAttribute("namelist", namelist);
            session.setAttribute("idlist",idlist);
        %>
        <center>
            <h3 style="color: black; margin-left: 25px;">OPEN CUSTOMER ACCOUNT</h3>
            <%
                String msg = request.getParameter("msg");
                if(msg != null)
                {
                    if(msg.equals("success"))
                {
            %>
            <div style="width: 300px; height: 25px;background-color: lightgreen; text-align: center;">
                <h5 style="color: green;font-family: verdana;font-size: 13px; margin: 10px; margin-top: 10px;">Account Opened Successfully</h5>
            </div>
            <%
                }
                else if(msg.equals("error"))
                {
            %>
            <div style="width: 300px; height: 25px;background-color: lightsalmon; text-align: center;">
                <h5 style="color: red;font-family: verdana;font-size: 13px; margin: 10px; margin-top: 10px;">Account Opened Successfully</h5>
            </div>
            <%
                }
                }
            %>
            <br>
            <br>
            <div style="width: 300px; height: 270px;padding: 10px; background-color: white;">
                <form action="OpenAccount" method="POST" style="text-align: center; padding: 5px;">
                    Select Customer<br><br>
                    <select name="customer" required="required" style="width: 250px;">
                        <option selected="selected" disabled> --- Select Customer --- </option>
                        <%
                            for(String s:namelist)
                            {
                        %>
                        <option><%= s %></option>
                        <%
                            }
                        %>
                    </select>
                    <br><br>Select Account Type<br><br>
                    <select name="atype" required="required" style="width: 250px;">
                        <option selected="selected" disabled> --- Select Account Type --- </option>
                        <option>Saving Bank Account</option>
                        <option>Current Bank Account</option>
                    </select>
                    <br><br>Opening Amount<br><br>
                    <input name="amount" type="text" placeholder="Opening Amount" style="width: 250px;" required/><br><br>
                    <input type="submit" value="Open Account" style="width: 250px;border-radius: 12px;background-color: blue;color: white;height: 30px;"/>
                </form>
            </div>
        </center>
    </body>
</html>