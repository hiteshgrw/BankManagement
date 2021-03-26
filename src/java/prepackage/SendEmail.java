package prepackage;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmail {
    public static boolean sendemail(String emsg,String esub,String eto)
    {
        String emailhost,emailport,emailid,emailpass;
        Session sess;
        emailhost = "smtp.gmail.com";
        emailport = "465";
        emailid = "hitagarwal21@gmail.com";
        emailpass = "Hitesh@2000";
        Properties prop = System.getProperties();        
        prop.put("mail.smtp.host",emailhost);
        prop.put("mail.smtp.port",emailport);
        prop.put("mail.smtp.ssl.enable",true);
        prop.put("mail.smtp.auth",true); 
        sess = Session.getInstance(prop,new javax.mail.Authenticator(){
            @Override
            protected javax.mail.PasswordAuthentication getPasswordAuthentication()
            {
                return new javax.mail.PasswordAuthentication(emailid,emailpass);                
            }
        });
        MimeMessage mmsg = new MimeMessage(sess);
        try
        {
            mmsg.setFrom(new InternetAddress(emailid));
            mmsg.addRecipient(Message.RecipientType.TO, new InternetAddress(eto));
            mmsg.setSubject(esub);
            mmsg.setText(emsg);
            Transport.send(mmsg);
            return true;
        }catch(MessagingException e)
        {
            e.printStackTrace();
            return false;
        }
    }
}
