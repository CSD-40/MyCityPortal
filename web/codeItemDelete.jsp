<%@page import="com.apps.Database.DatabaseFile"%>
<%@page session="true" %>

<%
    try 
    {
        //session
        HttpSession hs = request.getSession(true);
       
        //argument
        String username =  hs.getAttribute("x").toString();
        int RequestId = Integer.parseInt(request.getParameter("index"));       
            
        if (((username != null) && (!username.trim().equals(""))) && (RequestId != 0)) 
        {           
            String sql = "DELETE "
                    + " FROM items "
                    + " WHERE ItemId = '" + RequestId + "'";

            DatabaseFile.getInstance().codedelete(sql);
            
                     %>
                     <jsp:forward page="UploadItems.jsp">
                             <jsp:param name="msg" value="Deleted Successfully!"/>
                         </jsp:forward>
                     <%                          
        } 
        else 
        {
                     %>
                     <jsp:forward page="UploadItems.jsp">
                             <jsp:param name="msg" value="Not Deleted Successfully!"/>
                         </jsp:forward>
                     <%    
        }
    } 
    catch (Exception e) 
    {
        e.printStackTrace();       
    }

%>