<%@page import="prepackage.CookieDetail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
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
                width: 80%;
              }
              th, td {
                padding: 15px;
                font-size: 13px;
                font-family: verdana;
                width:100%;
              }
        </style>
    </head>
    <body>
        <%
            String name = CookieDetail.getvalue(request,"Username");
        %>
        <%@include file="Header.jsp" %>
        <h2 style="color: black; margin-left: 25px; text-align: center;">CHANGE PASSWORD</h2> <br><br>
    <center>
        <%
            String msg = request.getParameter("msg");
            if(msg!=null)
            {
                if(msg.equals("old"))
                {
        %>
        <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightsalmon;color: red; padding-top: 5px; ">
            <h4 style="margin-top: 3px;">Incorrect Current Password</h4>
        </div>
        <%
                }
                else if(msg.equals("new"))
                {
        %>
        <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightsalmon;color: red; padding-top: 5px; ">
            <h4 style="margin-top: 3px;">New and Confirm Password does not match</h4>
        </div>
        <%
                }
            }
        %>
        <div style="width: 300px; margin: auto; padding: 10px; background-color: rgba(255,255,255,0.5)">
        <form action="changepassword" method="POST">
                <input name="emailid" id="emailid" value="<%= name %>" type="hidden"/>
                <table>
                    <tr>
                        <td><center><input name="cpass" id="cpass" placeholder="Enter Current Password" type="password" required="required"/></center></td>
                    </tr>
                    <tr>
                        <td><center><input name="npass" id="npass" placeholder="Enter New Password" type="password" required="required"/></center></td>
                    </tr>
                    <tr>
                        <td><center><input name="cnpass" id="cnpass" placeholder="Confirm New Password" type="password" required="required"/></center></td>
                    </tr>
                </table>
                <input name="submit" type="submit" value="Change Password" style="width:200px;"/>
            </form>
        </div>
    </center>
    </body>
</html>
