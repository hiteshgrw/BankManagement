<%@page import="prepackage.CookieDetail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header</title>
        <link rel='stylesheet' href='dashboardstyle.css'>
        <style>
            body {
                background-image: url("rest_bg.jpg");
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: cover;
            }
        </style>
    </head>
    <%
        String urole = CookieDetail.getvalue(request, "Role");
    %>
    <body>
        <nav class="nav-area">
            <ul>
                <%
                    if ("admin".equals(urole)) {
                %>
                <li><a href='AdminDashboard.jsp'>Home</a></li>
                <li><a href='#'>Customers</a>
                    <ul>
                        <li><a href='addCustomer.jsp'>New Customer</a></li>
                        <li><a href='ListCustomer'>List All</a></li>
                    </ul>
                </li>
                <li><a href='#'>Accounts</a>
                    <ul>
                        <li><a href='ListAccount'>List All</a></li>
                        <li><a href='openAccount.jsp'>Open Account</a></li>
                        <li><a href='updateCustomer.jsp'>Update Information</a></li>
                        <li><a href='closeAccount.jsp'>Close Account</a></li>
                        <li><a href='reactivateAccount.jsp'>Reactivate Account</a></li>
                    </ul>
                </li>
                <li><a href='#'>Transaction</a>
                    <ul>
                        <li><a href='deposit.jsp'>Deposit</a></li>
                        <li><a href='withdraw.jsp'>Withdraw</a></li>
                        <li><a href='balance.jsp'>Balance Enquiry</a></li>
                        <li><a href='checkdeposit.jsp'>Cheque Deposit</a></li>
                        <li><a href='checkwithdraw.jsp'>Cheque Withdraw</a></li>
                        <li><a href='passbook.jsp'>Passbook</a></li>
                    </ul>
                </li>
                <li><a href='#'>Reports</a>
                    <ul>
                        <li><a href='todaytrans.jsp'>Today's Transaction</a></li>
                        <li><a href='bankreport.jsp'>Bank Report</a></li>
                    </ul>
                </li>
                <%
                } else if ("Customer".equals(urole)) {
                %>
                <li><a href='customerDashboard.jsp'>Home</a></li>
                <li><a href='#'>Online Payments</a>
                    <ul>
                        <li><a href='mobileRecharge.jsp'>Mobile Recharge</a></li>
                        <li><a href='electricity.jsp'>Electricity Bill</a></li>
                        <li><a href='dthPayment.jsp'>DTH Recharge</a></li>
                    </ul>
                </li>
                <li><a href='#'>Online Transfer</a>
                    <ul>
                        <li><a href='sameBank.jsp'>Same Bank</a></li>
                        <li><a href='otherBank.jsp'>Other Bank</a></li>
                    </ul>
                </li>
                <li><a href='#'>Beneficiary</a>
                    <ul>
                        <li><a href='addBeneficiary.jsp'>Add Beneficiary</a></li>
                        <li><a href='viewbeneficiary.jsp'>View Beneficiary</a></li>
                    </ul>
                </li>
                <li><a href='cpassbook.jsp'>Passbook</a></li>
                    <%
                        } else {
                            response.sendRedirect("AdminLogin.jsp");
                        }
                    %>
                <li style="width: 500px;text-align: center;font-family: verdana;font-size: 25px;color: coral;padding-top: 10px;"> WORLD'S BANK</li>
                <li><a href='ChangePassword.jsp'>Change Password</a></li>
                <li><a href='Logout'>Logout</a></li>
            </ul>
        </nav>
    </body>
</html>
