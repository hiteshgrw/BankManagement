package mainpackage;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import prepackage.ConnectionProvider;
import prepackage.SendEmail;
import prepackage.SendMessage;
@WebServlet(name = "OpenAccount", urlPatterns = {"/OpenAccount"})
public class OpenAccount extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ArrayList<String> namelist = new ArrayList();
            ArrayList<Integer> idlist = new ArrayList();
            namelist = (ArrayList) request.getSession().getAttribute("namelist");
            idlist = (ArrayList) request.getSession().getAttribute("idlist");
            String customer = request.getParameter("customer");
            String atype = request.getParameter("atype");
            Double amount = Double.parseDouble(request.getParameter("amount"));
            Connection conn = ConnectionProvider.getconn();
            Statement stat = conn.createStatement();
            int val = stat.executeUpdate("update customerdet set status = 'A' where cid = " + idlist.get(namelist.indexOf(customer)));
            if(val > 0)
            {
                Statement stat2 = conn.createStatement();
                ResultSet rs = stat2.executeQuery("select * from customerdet where cid = " + idlist.get(namelist.indexOf(customer)));
                if(rs.next())
                {
                    PreparedStatement pstat = conn.prepareCall("insert into accountdet(cid,name,atype,emailid,balance,status) values(?,?,?,?,?,'Active')");
                    pstat.setInt(1,rs.getInt("cid"));
                    pstat.setString(2,rs.getString("name"));
                    pstat.setString(3,atype);
                    pstat.setString(4,rs.getString("emailid"));
                    pstat.setDouble(5,amount);
                    int nval = pstat.executeUpdate();
                    if(nval > 0)
                    {
                        Statement stat3 = conn.createStatement();
                        stat3.executeUpdate("update bankdet set value = value + " + amount + " where name = 'credit'");
                        Statement stat4 = conn.createStatement();
                        ResultSet rs2 = stat4.executeQuery("select aid from accountdet where cid = " + rs.getInt("cid"));
                        rs2.next();
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        PreparedStatement pstat2 = conn.prepareStatement("insert into transactiondet(aid,msg,cr,date) values(?,?,?,?)");
                        pstat2.setLong(1,rs2.getLong(1));
                        pstat2.setString(2,"Account Opened");
                        pstat2.setDouble(3,amount);
                        pstat2.setString(4,sdf.format(new Date()));
                        pstat2.executeUpdate();
                        PreparedStatement pstat3 = conn.prepareStatement("insert into adminuser (username,password,role) values (?,?,?)");
                        pstat3.setString(1,rs.getString("emailid"));
                        pstat3.setString(2,"NewUser@123");
                        pstat3.setString(3,"Customer");
                        pstat3.executeUpdate();
                        SendEmail.sendemail("Dear User, \n\n\n You account has been opened successfully. Your Login credentials are - \n\n Username - " + rs.getString("emailid") + " \n\n Password - NewUser@123 \n\n Please do not share your password with anyone else. \n\n\n Regards, \n\n World's Bank","Account Opended Successfully",rs.getString("emailid"));
                        response.sendRedirect("openAccount.jsp?msg=success");
                    }
                    else
                    {
                        response.sendRedirect("openAccount.jsp?msg=error");
                    }
                }
                else
                {
                    response.sendRedirect("openAccount.jsp?msg=error");
                }
            }
            else
            {
                response.sendRedirect("openAccount.jsp?msg=error");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(OpenAccount.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("AdminDashboard.jsp");
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
