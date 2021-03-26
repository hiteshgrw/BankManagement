<%@page import="prepackage.CookieDetail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mobile Recharge</title>
        <style>
            input[type=text], select {
                padding: 12px 20px;
                display: inline-block;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                width: 95%;
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
                width: 40%;
            }
            th, td {
                font-size: 13px;
                font-family: verdana;
            }
        </style>
    </head>
    <body>
        <%@include file="Header.jsp" %>
        <h2 style="color: black; margin-left: 25px; text-align: center;">MOBILE RECHARGE</h2> <br><br>
    <center>
        <%            String msg = request.getParameter("msg");
            if (msg != null) {
                if (msg.equals("success")) {
        %>
        <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightgreen;color: green; padding-top: 5px; ">
            <h4 style="margin-top: 3px;">Recharge Successful</h4>
        </div>
        <%
        } else if (msg.equals("error")) {
        %>
        <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightsalmon;color: red; padding-top: 5px; ">
            <h4 style="margin-top: 3px;">Mobile Recharge Failed</h4>
        </div>
        <%
                }
            }
        %>
        <div style="width: 100%; margin: auto; padding: 10px; background-color: rgba(255,255,255,0.5)">
            <form action="MobileRecharge" method="POST">
                <table>
                    <tr>
                        <td><h4>Enter Mobile Number</h4></td>
                    </tr>
                    <tr>
                        <td><center><input name="mnum" id="mnum" placeholder="Enter Mobile Number" type="text" required="required"/></center></td>
                    </tr>
                    <tr>
                        <td><h4>Enter Operator</h4></td>
                    </tr>
                    <tr>
                        <td><center><input name="opr" id="opr" placeholder="Enter Operator" type="text" required="required"/></center></td>
                    </tr>
                    <tr>
                        <td><h4>Enter Amount</h4></td>
                    </tr>
                    <tr>
                        <td><center><input name="amt" id="amt" placeholder="Enter Amount" type="text" required="required"/></center></td>
                    </tr>
                </table>
                <input name="submit" type="submit" value="Recharge Now" style="width:10%;"/>
            </form>
        </div>
    </center>
</body>
</html>
