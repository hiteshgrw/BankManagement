package CustomerReg;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CustomerRegistration", urlPatterns = {"/CustomerRegistration"})
public class CustomerRegistration extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>\n"
                    + "        <title>Registration Form</title>\n"
                    + "        <meta charset=\"UTF-8\">\n"
                    + "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                    + "        <style>\n"
                    + "            body {\n"
                    + "                background-image: url(\"rest_bg.jpg\");\n"
                    + "                background-repeat: no-repeat;\n"
                    + "                background-attachment: fixed;\n"
                    + "                background-size: cover;\n"
                    + "            }"
                    + "            input[type=submit] \n"
                    + "            {\n"
                    + "                background-color: #4CAF50;\n"
                    + "                color: white;\n"
                    + "                padding: 12px 75px;\n"
                    + "                border: none;\n"
                    + "                border-radius: 4px;\n"
                    + "                cursor: pointer;\n"
                    + "                float: center;\n"
                    + "            }\n"
                    + "            .button \n"
                    + "            {\n"
                    + "                background-color: #4CAF50;\n"
                    + "                border: none;\n"
                    + "                color: white;\n"
                    + "                padding: 6px 15px;\n"
                    + "                text-align: center;\n"
                    + "                text-decoration: none;\n"
                    + "                font-size: 14px;\n"
                    + "                margin: 4px 2px;\n"
                    + "                cursor: pointer;\n"
                    + "                border-radius: 4px;\n"
                    + "                float: right;            \n"
                    + "            }   \n"
                    + "            img {\n"
                    + "                border-radius: 50%;\n"
                    + "            }\n"
                    + "        </style>\n"
                    + "    </head>\n"
                    + "    <body style=\"font-family: verdana; font-size: 12px\">  \n"
                    + "        <button class=\"button\" onclick=history.go(-1);>Home</button>        \n"
                    + "        <h1 align=\"center\">Customer Registration Form</h1><hr>\n"
                    + "         <div style=\"width: 300px; margin: auto; padding: 10px; background-color: rgba(255,255,255,0.5)\">\n"
                    + "        <form action=\"BankServlet\" style=\"text-align: left;\" method=\"POST\">\n"
                    + "\n"
                    + "            <center>\n"
                    + "                <table>\n"
                    + "                    <tr>\n"
                    + "                    <img src=\"customer.png\" alt=\"\" width=\"100\" height=\"100\">\n"
                    + "                    </tr>\n"
                    + "                    <tr>\n"
                    + "                        <td colspan=\"2\"><br><br><br><input name=\"name\" type=\"text\" required=\"required\" placeholder=\"Customer Name\" style=\"width:250px\"><br><br><br></td>\n"
                    + "                    </tr>\n"
                    + "                    <tr>\n"
                    + "                        <td colspan=\"2\"><input name=\"address\" type=\"text\" required=\"required\" placeholder=\"Customer Address\" style=\"width:250px\"><br><br><br></td>\n"
                    + "                    </tr>\n"
                    + "                    <tr>\n"
                    + "                        <td>Date of Birth</td>\n"
                    + "                    </tr>\n"
                    + "                    <tr>\n"
                    + "                        <td><input name=\"dob\" type=\"date\" required=\"required\" style=\"width:250px\"><br><br><br></td>\n"
                    + "                    </tr>\n"
                    + "                    <tr>\n"
                    + "                        <td colspan=\"2\"><input name=\"adhar\" type=\"tel\" required=\"required\" placeholder=\"Adhar Number\" pattern=\"[0-9]{12}\" style=\"width:250px\"><br><br><br></td>\n"
                    + "                    </tr>\n"
                    + "                    <tr>\n"
                    + "                        <td colspan=\"2\"><input name=\"phone\" type=\"tel\" required=\"required\" placeholder=\"Phone Number\" pattern=\"[0-9]{10}\" style=\"width:250px\"><br><br><br></td>\n"
                    + "                    </tr>\n"
                    + "                    <tr>\n"
                    + "                        <td colspan=\"2\"><input name=\"email\" type=\"email\" required=\"required\" placeholder=\"Email Address\" style=\"width:250px\"><br><br><br></td>\n"
                    + "                    </tr>\n"
                    + "                    <tr>\n"
                    + "                        <td colspan=\"2\">\n"
                    + "                            <input list=\"Gender\" name=\"gender\" required=\"required\" placeholder=\"--Select Gender--\" style=\"width:250px\"><br><br><br><br><br><br>\n"
                    + "                            <datalist id=\"Gender\">\n"
                    + "                                <option value=\" Male\">\n"
                    + "                                <option value=\" Female\">\n"
                    + "                            </datalist>\n"
                    + "                        </td>\n"
                    + "                    </tr>               \n"
                    + "                    <tr>\n"
                    + "                        <td colspan=\"2\"><input type=\"submit\" value=\"Register Customer\" size=\"60\"></td>\n"
                    + "                    </tr>\n"
                    + "                </table>\n"
                    + "            </center>\n"
                    + "        </form>  \n"
                    + "     </div>\n"
                    + "    </body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
