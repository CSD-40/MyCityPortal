<%@page import="com.apps.Database.DatabaseFile"%>
<%@page session="true" %>
<%
    try 
    {
        //session
        HttpSession hs = request.getSession(true);
       
        //argument
        String username =  hs.getAttribute("x").toString();
        
        //getting values from design page
        String servicecode = request.getParameter("servicecode");        
        String servicename = request.getParameter("servicename");
        String id = request.getParameter("hide");
                         
        if(((servicecode!=null) && (!servicecode.trim().equals(""))) && ((servicename!=null) && (!servicename.trim().equals("")))
                && ((id!=null) && (!id.trim().equals(""))))
        {     
            String sql = "UPDATE service "
                    + " SET Service_Code = '"+servicecode+"', "                  
                    + " Service_Desc = '"+servicename+"' "              
                    + " WHERE Service_Id = '" + id + "' ";
                               
            DatabaseFile.getInstance().codeupdate(sql);
                        
                     %>
                     <jsp:forward page="Services.jsp">
                             <jsp:param name="msg" value="Record modified Successfully!"/>
                         </jsp:forward>
                     <%                          
        } 
        else 
        {
                     %>
                     <jsp:forward page="Services.jsp">
                             <jsp:param name="msg" value="Record Not Modified Successfully!"/>
                         </jsp:forward>
                     <%    
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

%>