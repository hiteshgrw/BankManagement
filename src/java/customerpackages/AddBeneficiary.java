package customerpackages;
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
import prepackage.CookieDetail;
@WebServlet(name = "AddBeneficiary", urlPatterns = {"/AddBeneficiary"})
public class AddBeneficiary extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String bname = request.getParameter("bname");
            String bifsc = request.getParameter("bifsc");
            Long ano = Long.parseLong(request.getParameter("ano"));
            Double maxlimit = Double.parseDouble(request.getParameter("maxlimit"));
            Long aid = Long.parseLong(CookieDetail.getvalue(request,"aid"));
            Connection conn = ConnectionProvider.getconn();
            PreparedStatement pstat = conn.prepareStatement("insert into btable (aid,name,bname,bifsc,ano,maxlimit) values (?,?,?,?,?,?)");
            pstat.setLong(1,aid);
            pstat.setString(2,name);
            pstat.setString(3,bname);
            pstat.setString(4,bifsc);
            pstat.setLong(5,ano);
            pstat.setDouble(6,maxlimit);
            int val = pstat.executeUpdate();
            if(val > 0)
            {
                response.sendRedirect("addBeneficiary.jsp?msg=success");
            }
            else
            {
                response.sendRedirect("addBeneficiary.jsp?msg=error");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(AddBeneficiary.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("addBeneficiary.jsp?msg=error");
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
