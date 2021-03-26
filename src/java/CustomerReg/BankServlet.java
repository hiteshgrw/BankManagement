package CustomerReg;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import prepackage.ConnectionProvider;
@WebServlet(name = "BankServlet", urlPatterns = {"/BankServlet"})
public class BankServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
        Connection conn = ConnectionProvider.getconn();      
        String name=request.getParameter("name");
        String address=request.getParameter("address");
        String email=request.getParameter("email");
        String dob=request.getParameter("dob");
        String gender=request.getParameter("gender");
        long cadhar=Long.parseLong(request.getParameter("adhar"));
        long phone=Long.parseLong(request.getParameter("phone"));
        int count;
        Statement stat1 = conn.createStatement();
        ResultSet rs = stat1.executeQuery("select count(adhar) from customerdet where customerdet.adhar="+cadhar);
        while(rs.next())
        {
            count=rs.getInt(1);
            System.out.println(count);
            if(count==0)
            {        
                PreparedStatement stmt=conn.prepareStatement("insert into customerdet(name,address,dob,adhar,phone,emailid,gender,status) VALUES (?,?,?,?,?,?,?,?)");
                stmt.setString(1, name);
                stmt.setString(2, address);
                stmt.setString(3, dob);
                stmt.setLong(4, cadhar);
                stmt.setLong(5, phone);
                stmt.setString(6, email);
                stmt.setString(7, gender);
                stmt.setString(8,"UP");
                int val=stmt.executeUpdate();
                if(val>0)
                    out.println("<h3 style=\"color: green; margin-left: 25px;\">Customer Registered Successfully</h3>");
                else
                    out.println("<h3 style=\"color: red; margin-left: 25px;\">Registration Failed</h3>");
                request.getRequestDispatcher("index.jsp").include(request, response);
            }
            else
            {
                out.println("<h3 style=\"color: red; margin-left: 25px;\">Customer Already Registered</h3>");
                request.getRequestDispatcher("index.jsp").include(request, response);
            }
        }
//        Statement stat2 = conn.createStatement();
//        ResultSet rs1 = stat2.executeQuery("select * from customerdet");
//        while(rs1.next())
//        {
//            String semail= rs1.getString(2);
//            String sname= rs1.getString(3);
//            String sdob= rs1.getString(4);
//            long sadhar=rs1.getLong(5);
//            long sphone=rs1.getLong(6);
//            String sgen= rs1.getString(7);
//            String saddress= rs1.getString(8);
//            System.out.println(sname+"\t\t"+saddress+"\t\t"+sdob+"\t\t"+sadhar+"\t\t"+semail);
//        }        
        }
        catch (ClassNotFoundException | NumberFormatException | SQLException e){
            e.printStackTrace();
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
