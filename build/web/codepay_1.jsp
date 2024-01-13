<%@page import="java.util.StringTokenizer"%>
<%@page import="java.sql.*"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page session="true" %>
<%
    try 
    {
        //session
        HttpSession hs = request.getSession(true);
       
        //argument
        String username =  hs.getAttribute("x").toString();
        String orderid = request.getParameter("index");
         
        if(((username != null) && (!username.trim().equals(""))) 
                && ((orderid != null) && (!orderid.trim().equals("")))) 
        {                       
            StringTokenizer st =  new StringTokenizer(orderid, "-");
                                    
            while(st.hasMoreTokens())
            {                                                        
                    String sql = "UPDATE orders "
                            + "SET O_STATUS = 'N' "
                            + "WHERE O_ID = '"+ st.nextToken() +"' ";
                    
                    DatabaseFile.getInstance().codeupdate(sql);
            }
                    
                        
                     %>
                     <jsp:forward page="pay_1.jsp">
                             <jsp:param name="msg" value=""/>
                         </jsp:forward>
                     <%                          
        } 
        else 
        {
                     %>
                     <jsp:forward page="pay_1.jsp">
                             <jsp:param name="msg" value="Not Payed Successfully!"/>
                         </jsp:forward>
                     <%    
        }
    } 
    catch (Exception e) 
    {
        e.printStackTrace();
        Log.logger.error("Error:", e); 
    }

%>