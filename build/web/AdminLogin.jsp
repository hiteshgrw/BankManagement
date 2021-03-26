<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>World bank</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                background-image: url("rest_bg.jpg");
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: cover;
            }
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
    <body>
        <button class="button" onclick=history.go(-1);>Home</button>
        <h1 align="center">Admin Login</h1>
        <hr>
        <div style="width: 300px; height: 300px; margin: auto; margin-top: 150px;margin-left: 900px; padding: 10px; background-color: rgba(255,255,255,0.5)">
            <h3 style="text-align: center; color: purple; font-family: serif; font-size: 18px;">WORLD'S BANK</h3>
            <h4 style="text-align: center; color: purple; font-family: serif; font-size: 14px;">ADMIN LOGIN</h4><br>
            <form action="LoginServlet" method="POST" style="text-align: center">
                User ID<br>
                <input name="Username" type="text" placeholder="Enter Username" style="width: 250px;" required/><br><br>
                Password<br>
                <input name="Password" type="password" placeholder="Enter Password" style="width: 250px;" required/><br><br>
                <input type="submit" value="LOGIN" style="width: 250px;border-radius: 12px;background-color: white;color: coral;border: 2px solid #008CBA; height: 30px;"/>
            </form>
            <%
                String msg = request.getParameter("validation");
                if("errorname".equals(msg))
                {
            %>
            <h4 style="text-align: center; color: red;"> Invalid Username </h4>
            <%
                }
            else if("errorpass".equals(msg))
            {
            %>
            <h4 style="text-align: center; color: red;"> Invalid Password </h4>
            <%
                }
            else if("errorperm".equals(msg))
            {
            %>
            <h4 style="text-align: center; color: red;"> You don't have permission to log in further!! </h4>
            <%
                }
            else if("error".equals(msg))
            {
            %>
            <h4 style="text-align: center; color: red;"> Database Connection Error!! </h4>
            <%
            }
            %>
        </div>
    </body>
</html>
