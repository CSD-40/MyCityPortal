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
                    + " FROM roomdetails "
                    + " WHERE Room_Id = '" + RequestId + "'";

            DatabaseFile.getInstance().codedelete(sql);
            
                     %>
                         <jsp:forward page="UploadRooms.jsp">
                             <jsp:param name="msg" value="Deleted Successfully!"/>
                         </jsp:forward>
                     <%                          
        } 
        else 
        {
                     %>
                         <jsp:forward page="UploadRooms.jsp">
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