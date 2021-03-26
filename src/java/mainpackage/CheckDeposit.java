package mainpackage;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
@WebServlet(name = "CheckDeposit", urlPatterns = {"/CheckDeposit"})
public class CheckDeposit extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long aid = Long.parseLong(request.getParameter("aid"));
            Double amt = Double.parseDouble(request.getParameter("amount"));
            String tdate = request.getParameter("date");
            String bname = request.getParameter("bankname");
            Long num = Long.parseLong(request.getParameter("number"));
            Connection conn = ConnectionProvider.getconn();
            PreparedStatement pstat = conn.prepareStatement("update accountdet set balance = balance + ? where aid = " + aid);
            pstat.setDouble(1,amt);
            int val = pstat.executeUpdate();
            if(val>0)
            {
                Statement stat3 = conn.createStatement();
                stat3.executeUpdate("update bankdet set value = value + " + amt + " where name = 'credit'");
                PreparedStatement pstat2 = conn.prepareStatement("insert into transactiondet(aid,msg,cr,date) values (?,?,?,?)");
                pstat2.setLong(1,aid);
                pstat2.setString(2,"Cheque Deposited with C No - " + num + " from " + bname);
                pstat2.setDouble(3,amt);
                pstat2.setString(4,tdate);
                pstat2.executeUpdate();
                response.sendRedirect("checkdeposit.jsp?msg=success");
            }
            else
            {
                response.sendRedirect("checkdeposit.jsp?msg=error");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UpdateCustomer.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("checkdeposit.jsp?msg=error");
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