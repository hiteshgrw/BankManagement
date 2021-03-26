package mainpackage;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import prepackage.ConnectionProvider;
@WebServlet(name = "UpdateCustomer", urlPatterns = {"/UpdateCustomer"})
public class UpdateCustomer extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int cid = Integer.parseInt(request.getParameter("cid"));
            Long aid = Long.parseLong(request.getParameter("aid"));
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            Long phone = Long.parseLong(request.getParameter("phone"));
            Long adhar = Long.parseLong(request.getParameter("adhar"));
            Connection conn = ConnectionProvider.getconn();
            PreparedStatement pstat = conn.prepareStatement("update accountdet set name = ? where aid = " + aid);
            pstat.setString(1,name);
            int val = pstat.executeUpdate();
            PreparedStatement pstat2 = conn.prepareStatement("update customerdet set name = ?,address = ?,gender = ?,phone = ?,adhar = ? where cid = " + cid);
            pstat2.setString(1,name);
            pstat2.setString(2,address);
            pstat2.setString(3,gender);
            pstat2.setLong(4,phone);
            pstat2.setLong(5,adhar);
            int val2 = pstat2.executeUpdate();
            if(val>0 && val2 > 0)
            {
                response.sendRedirect("updateCustomer.jsp?msg=success");
            }
            else
            {
                response.sendRedirect("updateCustomer.jsp?msg=error");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UpdateCustomer.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("updateCustomer.jsp?msg=error");
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
