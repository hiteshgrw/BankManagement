<!DOCTYPE html>
<html>
    <head>
        <title>Home Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                background-image: url("home_bg.jpg");
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: cover;
            }
            .card {
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
                max-height: 250px;
                max-width: 250px;
                margin: auto;
                text-align: center;
                font-family: arial;
            }
            .card:hover {
                box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
            }

            button {
                border: none;
                outline: 0;
                display: inline-block;
                padding: 8px;
                color: white;
                background-color: #000;
                text-align: center;
                cursor: pointer;
                width: 100%;
                font-size: 18px;
            }

            .button span {
                cursor: pointer;
                display: inline-block;
                position: relative;
                transition: 0.5s;
            }

            .button span:after {
                content: '\00bb';
                position: absolute;
                opacity: 0;
                top: 0;
                right: -20px;
                transition: 0.5s;
            }

            .button:hover span {
                padding-right: 25px;
            }

            .button:hover span:after {
                opacity: 1;
                right: 0;
            }
        </style>
    </head>

    <body>
    <center>
        <h1>Welcome to World Bank!</h1>
        <hr>
        <table style="width: 100%; height: 250px">
            <tr>
                <td>
                    <div class="card">
                        <img src="bank.jpg" alt="John" style="width:100%">
                        <form action="AdminLogin.jsp" method="POST">
                            <button class="button"><span>Bank</span></button>
                        </form>
                    </div>
                </td>
                <td>
                    <div class="card">
                        <img src="customer_home.png" alt="John" style="width:100%">
                        <form action="CustomerRegistration" method="POST">
                            <button class="button"><span>Customer</span></button>
                        </form>
                    </div>
                </td>
                <td>
                    <div class="card">
                        <img src="netBanking.jpg" alt="John" style="width:100%">
                        <form action="customerLogin.jsp" method="POST">
                            <button class="button"><span>Net Banking</span></button>
                        </form>
                    </div>
                </td>
            </tr>
        </table>
    </center>
</body>
</html>
