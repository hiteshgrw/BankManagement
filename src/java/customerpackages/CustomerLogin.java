package customerpackages;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import prepackage.ConnectionProvider;
@WebServlet(name = "CustomerLogin", urlPatterns = {"/CustomerLogin"})
public class CustomerLogin extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                String uname = request.getParameter("Username");
                String upass = request.getParameter("Password");
                response.setContentType("text/html;charset=UTF-8");
                try (PrintWriter out = response.getWriter()) {
                Connection conn = ConnectionProvider.getconn();
                Statement stat = conn.createStatement();
                ResultSet rs = stat.executeQuery("select password,role from adminuser where username = '" + uname + "'");
                if(rs.next())
                {
                    if(rs.getString(1).equals(upass))
                    {
                        if(rs.getString(2).equals("Customer"))
                        {
                            Statement gstat = conn.createStatement();
                            ResultSet grs = gstat.executeQuery("select aid,cid from accountdet where emailid = '" + uname + "'");
                            if(grs.next())
                            {
                                Cookie nck1 = new Cookie("aid",String.valueOf(grs.getLong(1)));
                                nck1.setPath("/");
                                nck1.setMaxAge(1800);
                                response.addCookie(nck1);
                                Cookie nck2 = new Cookie("cid",String.valueOf(grs.getInt(2)));
                                nck2.setPath("/");
                                nck2.setMaxAge(1800);
                                response.addCookie(nck2);
                            }
                            Cookie ck = new Cookie("Username",uname);
                            ck.setPath("/");
                            ck.setMaxAge(1800);
                            response.addCookie(ck);
                            Cookie ck1 = new Cookie("Role",rs.getString(2));
                            ck1.setPath("/");
                            ck1.setMaxAge(1800);
                            response.addCookie(ck1);
                            response.sendRedirect("customerDashboard.jsp");
                        }
                        else
                        {
                            request.getRequestDispatcher("customerLogin.jsp?validation=errorperm").forward(request, response);
                        }
                    }
                    else
                    {
                        request.getRequestDispatcher("customerLogin.jsp?validation=errorpass").forward(request, response);
                    }
                }
                else
                {
                    request.getRequestDispatcher("customerLogin.jsp?validation=errorname").forward(request, response);
                }
            } catch (ClassNotFoundException | SQLException ex) {
                request.getRequestDispatcher("customerLogin.jsp?validation=error").forward(request, response);
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
