<%@page import="prepackage.CookieDetail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Beneficiary</title>
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
        <h2 style="color: black; margin-left: 25px; text-align: center;">ADD BENEFICIARY</h2> <br><br>
    <center>
        <%
            String msg = request.getParameter("msg");
            if(msg!=null)
            {
                if(msg.equals("success"))
                {
        %>
        <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightgreen;color: green; padding-top: 5px; ">
            <h4 style="margin-top: 3px;">Beneficiary Added Successfully</h4>
        </div>
        <%
                }
                else if(msg.equals("error"))
                {
        %>
        <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightsalmon;color: red; padding-top: 5px; ">
            <h4 style="margin-top: 3px;">Beneficiary Addition Failed</h4>
        </div>
        <%
                }
            }
        %>
        <form action="AddBeneficiary" method="POST">
                <table>
                    <tr>
                        <td><center><input name="name" id="name" placeholder="Beneficiary Name" type="text" required="required"/></center></td>
                    </tr>
                    <tr>
                        <td><center><input name="bname" id="bname" placeholder="Bank Name" type="text" required="required"/></center></td>
                    </tr>
                    <tr>
                        <td><center><input name="bifsc" id="bifsc" placeholder="Bank IFSC Code" type="text" required="required"/></center></td>
                    </tr>
                    <tr>
                        <td><center><input name="ano" id="ano" placeholder="Account Number" type="text" required="required"/></center></td>
                    </tr>
                    <tr>
                        <td><center><input name="maxlimit" id="maxlimit" placeholder="Maximum Limit" type="text" required="required"/></center></td>
                    </tr>
                </table>
                <input name="submit" type="submit" value="Add Beneficiary" style="width:10%;"/>
            </form>
    </center>
    </body>
</html>
