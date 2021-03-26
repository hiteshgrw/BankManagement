<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Registration Form</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            input[type=submit]
            {
                background-color: #4CAF50;
                color: white;
                padding: 12px 75px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                float: center;
                }
            .button
            {
                background-color: #4CAF50;
                border: none;
                color: white;
                padding: 6px 15px;
                text-align: center;
                text-decoration: none;
                font-size: 14px;
                margin: 4px 2px;
                cursor: pointer;
                border-radius: 4px;
                float: right;
            }
            img {
                border-radius: 50%;
                }
        </style>
                        </head>
                        <body style="font-family: verdana; font-size: 12px">
                            <%@include file="Header.jsp" %>
                        <center>
                            <h2 style="color: black; margin-left: 25px; text-align: center;">ADD CUSTOMER</h2> <br><br>
                            <%
                                String msg = request.getParameter("msg");
                                if(msg!=null)
                                {
                                    if(msg.equals("success"))
                                    {
                            %>
                            <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightgreen;color: green; padding-top: 5px; ">
                                <h4 style="margin-top: 3px;">Customer Added Successfully</h4>
                            </div>
                            <%
                                    }
                                    else if(msg.equals("error"))
                                    {
                            %>
                            <div style="width:80%;text-align: center;height: 32px;font-size: 14px;font-family: verdana;background-color: lightsalmon;color: red; padding-top: 5px; ">
                                <h4 style="margin-top: 3px;">Customer Addition Failed</h4>
                            </div>
                            <%
                                    }
                                }
                            %>
                            <div style="width: 300px; margin: auto; padding: 10px; background-color: rgba(255,255,255,0.5)">
                            <center>
                            <form action="AddCustomer" method="POST">
                                <table>
                                        <tr>
                                        <img src="customer.png" alt="" width="100" height="100">
                                        </tr>
                                        <tr>
                                            <td colspan="2"><br><br><br><input name="name" type="text" required="required" placeholder="Customer Name" style="width:250px"><br><br><br></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><input name="address" type="text" required="required" placeholder="Customer Address" style="width:250px"><br><br><br></td>
                                        </tr>
                                        <tr>
                                            <td>Date of Birth</td>
                                        </tr>
                                        <tr>
                                            <td><input name="dob" type="date" required="required" style="width:250px"><br><br><br></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><input name="adhar" type="tel" required="required" placeholder="Adhar Number" pattern="[0-9]{12}" style="width:250px"><br><br><br></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><input name="phone" type="tel" required="required" placeholder="Phone Number" pattern="[0-9]{10}" style="width:250px"><br><br><br></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><input name="email" type="email" required="required" placeholder="Email Address" style="width:250px"><br><br><br></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <input list="Gender" name="gender" required="required" placeholder="--Select Gender--" style="width:250px"><br><br><br><br><br><br>
                                                <datalist id="Gender">
                                                    <option value=" Male">
                                                    <option value=" Female">
                                                </datalist>
                                            </td>
                                        </tr>               
                                        <tr>
                                            <td colspan="2"><input type="submit" value="Register Customer" size="60"></td>
                                        </tr>
                                    </table>
                                </form>
                            </center>
                            </div>
                            </center>
                        </body>
</html>
