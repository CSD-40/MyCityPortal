<%@page import="com.apps.Logcreation.Log"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.sql.*"%>

<%

try
{
     Log objLog  = objLog = new Log();
     
     //session
     HttpSession hs = request.getSession(true);
       
    //argument
    String username =  hs.getAttribute("x").toString();
        
    //getting values from design page
    String servicecode = request.getParameter("servicecode");
    String servicename = request.getParameter("servicename");
  
    if( ((servicecode!=null) && (!servicecode.trim().equals(""))) && ((servicename!=null) && (!servicename.trim().equals(""))))
    {                
        //jdbc connection
        try
        {               
            String sql = "INSERT INTO service(Service_Code, Service_Desc, Status, CreatedDate)"
                    + " VALUES('"+servicecode+"', '"+servicename+"', 'Un Approved', now())";

           DatabaseFile.getInstance().codeinsert(sql);                      
           
           %>
           <jsp:forward page="Services.jsp">
                   <jsp:param name="msg" value="Service Created Sucessfully!"></jsp:param>               
               </jsp:forward>
           <%

        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    else
    {
           %>
           <jsp:forward page="Services.jsp">
               <jsp:param name="msg" value="Please Fill All Details"></jsp:param>
           </jsp:forward>
           <%
    }
    
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
    
%>