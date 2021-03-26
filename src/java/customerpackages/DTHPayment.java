package customerpackages;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
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
@WebServlet(name = "DTHPayment", urlPatterns = {"/DTHPayment"})
public class DTHPayment extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long cnum = Long.parseLong(request.getParameter("cnum"));
        Long pnum = Long.parseLong(request.getParameter("pnum"));
        String opr = request.getParameter("opr");
        Double amt = Double.parseDouble(request.getParameter("amt"));
        try {
            Long aid = Long.parseLong(CookieDetail.getvalue(request,"aid"));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String tdate = sdf.format(new Date());
            Connection conn = ConnectionProvider.getconn();
            PreparedStatement pstat = conn.prepareStatement("update accountdet set balance = balance - ? where aid = " + aid);
            pstat.setDouble(1,amt);
            int val = pstat.executeUpdate();
            if(val>0)
            {
                Statement stat3 = conn.createStatement();
                stat3.executeUpdate("update bankdet set value = value + " + amt + " where name = 'debit'");
                PreparedStatement pstat2 = conn.prepareStatement("insert into transactiondet(aid,msg,dr,date) values (?,?,?,?)");
                pstat2.setLong(1,aid);
                pstat2.setString(2,"DTH Recharge Customer ID - " + cnum + " P/No - " + pnum + " " + opr + " using Netbanking");
                pstat2.setDouble(3,amt);
                pstat2.setString(4,tdate);
                pstat2.executeUpdate();
                response.sendRedirect("dthPayment.jsp?msg=success");
            }
            else
            {
                response.sendRedirect("dthPayment.jsp?msg=error");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UpdateCustomer.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("dthPayment.jsp?msg=error");
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
