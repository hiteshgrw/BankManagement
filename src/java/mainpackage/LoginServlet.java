package mainpackage;
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
import prepackage.SendMessage;
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
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
                        if(rs.getString(2).equals("admin"))
                        {
                            Cookie ck = new Cookie("Username",uname);
                            ck.setPath("/");
                            ck.setMaxAge(1800);
                            response.addCookie(ck);
                            Cookie ck1 = new Cookie("Role",rs.getString(2));
                            ck1.setPath("/");
                            ck1.setMaxAge(1800);
                            response.addCookie(ck1);
                            response.sendRedirect("AdminDashboard.jsp");
                            
                        }
                        else
                        {
                            request.getRequestDispatcher("AdminLogin.jsp?validation=errorperm").forward(request, response);
                        }
                    }
                    else
                    {
                        request.getRequestDispatcher("AdminLogin.jsp?validation=errorpass").forward(request, response);
                    }
                }
                else
                {
                    request.getRequestDispatcher("AdminLogin.jsp?validation=errorname").forward(request, response);
                }
            } catch (ClassNotFoundException | SQLException ex) {
                request.getRequestDispatcher("AdminLogin.jsp?validation=error").forward(request, response);
            } 
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
