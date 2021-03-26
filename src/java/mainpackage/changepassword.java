package mainpackage;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import prepackage.ConnectionProvider;
import prepackage.CookieDetail;
@WebServlet(name = "changepassword", urlPatterns = {"/changepassword"})
public class changepassword extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String oldp = request.getParameter("cpass");
            String newp = request.getParameter("npass");
            String cnewp = request.getParameter("cnpass");
            String id = request.getParameter("emailid");
            String role = CookieDetail.getvalue(request,"Role");
            Connection conn = ConnectionProvider.getconn();
            Statement stat = conn.createStatement();
            ResultSet rs = stat.executeQuery("select password from adminuser where username = '" + id + "'");
            if(rs.next())
            {
                if(rs.getString(1).equals(oldp))
                {
                    if(newp.equals(cnewp))
                    {
                        Statement stat2 = conn.createStatement();
                        stat2.executeUpdate("update adminuser set password  = '" + newp + "' where username = '" + id + "'");
                        if(role.equals("admin"))
                        {
                            response.sendRedirect("AdminDashboard.jsp");
                        }
                        else if(role.equals("Customer"))
                        {
                            response.sendRedirect("customerDashboard.jsp");
                        }
                    }
                    else
                    {
                        response.sendRedirect("ChangePassword.jsp?msg=new");
                    }
                }else{
                    response.sendRedirect("ChangePassword.jsp?msg=old");
                }
            }
            else
            {
                response.sendRedirect("Logout");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(changepassword.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("Logout");
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
