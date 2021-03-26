package prepackage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
public class CookieDetail {
    public static String getvalue(HttpServletRequest request,String key)
    {
        Cookie[] cks = request.getCookies();
        for(Cookie ck:cks)
        {
            if(ck.getName().equals(key))
                return ck.getValue();
        }
        return "";
    }
}
