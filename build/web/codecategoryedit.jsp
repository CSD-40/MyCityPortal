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
        String categorycode = request.getParameter("categorycode");        
        String categoryname = request.getParameter("categoryname");
        String categorydesc = request.getParameter("categorydesc");
        String id = request.getParameter("hide");
                         
        if(((categorycode!=null) && (!categorycode.trim().equals(""))) && ((categoryname!=null) && (!categoryname.trim().equals("")))
                && ((categorydesc!=null) && (!categorydesc.trim().equals(""))) && ((id!=null) && (!id.trim().equals(""))))
        {     
            String sql = "UPDATE categorydetails "
                    + " SET Category_Code = '"+categorycode+"', "                  
                    + " Category_Name = '"+categoryname+"', "         
                    + " Category_Desc = '"+categorydesc+"' "         
                    + " WHERE Category_Id = '" + id + "' ";
                               
            DatabaseFile.getInstance().codeupdate(sql);
                        
                     %>
                     <jsp:forward page="Category.jsp">
                             <jsp:param name="msg" value="Record modified Successfully!"/>
                         </jsp:forward>
                     <%                          
        } 
        else 
        {
                     %>
                     <jsp:forward page="Category.jsp">
                             <jsp:param name="msg" value="Record Not Modified Successfully!"/>
                         </jsp:forward>
                     <%    
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

%>