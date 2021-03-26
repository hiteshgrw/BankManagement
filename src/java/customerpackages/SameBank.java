package customerpackages;
import java.io.IOException;
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
import mainpackage.UpdateCustomer;
import prepackage.ConnectionProvider;
import prepackage.CookieDetail;
@WebServlet(name = "SameBank", urlPatterns = {"/SameBank"})
public class SameBank extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long oaid = Long.parseLong(CookieDetail.getvalue(request,"aid"));
            Long aid = Long.parseLong(request.getParameter("aid"));
            Double amt = Double.parseDouble(request.getParameter("amount"));
            String tdate = request.getParameter("date");
            Connection conn = ConnectionProvider.getconn();
            PreparedStatement pstat = conn.prepareStatement("update accountdet set balance = balance - ? where aid = " + oaid);
            pstat.setDouble(1,amt);
            int val = pstat.executeUpdate();
            PreparedStatement npstat = conn.prepareStatement("update accountdet set balance = balance + ? where aid = " + aid);
            npstat.setDouble(1,amt);
            int val2 = npstat.executeUpdate();
            if(val>0 && val2>0)
            {
                PreparedStatement pstat2 = conn.prepareStatement("insert into transactiondet(aid,msg,dr,date) values (?,?,?,?)");
                pstat2.setLong(1,oaid);
                pstat2.setString(2,"Rs " + amt + " debited to A/c No - " + aid + " through Net Banking");
                pstat2.setDouble(3,amt);
                pstat2.setString(4,tdate);
                pstat2.executeUpdate();
                PreparedStatement pstat3 = conn.prepareStatement("insert into transactiondet(aid,msg,cr,date) values (?,?,?,?)");
                pstat3.setLong(1,aid);
                pstat3.setString(2,"Rs " + amt + " credited from A/c No - " + oaid);
                pstat3.setDouble(3,amt);
                pstat3.setString(4,tdate);
                pstat3.executeUpdate();
                response.sendRedirect("sameBank.jsp?msg=success");
            }
            else
            {
                response.sendRedirect("sameBank.jsp?msg=error");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UpdateCustomer.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("sameBank.jsp?msg=error");
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
