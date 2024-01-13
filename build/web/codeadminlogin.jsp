<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.File"%>
<%@page import="java.io.Writer"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.sql.*" %>
<%@page  session="true" %>
<%
try
{
    Log objLog  = objLog = new Log();
    
    //getting value from 
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    //session 
    session.setAttribute("x", username);
   
    int count = 0;
    
    ResultSet rs = null;
    
    //jdbc coding
    try
    {             
        if( ((username!=null) && (!username.trim().equals(""))) && ((password!=null) && (!password.trim().equals(""))))
        {
            String sql = "SELECT * FROM admindetails "
                    + " WHERE Username = '"+username+"' and Password = '"+password+"'";

            Log.logger.info("sql:"+sql);	  
            
            //CALLING DATABASE Class           
            rs = DatabaseFile.getInstance().codeselect(sql);

            while(rs.next())
            {
                count = rs.getInt(1);
                
                Log.logger.info("count:"+count);	    
              
                //page redirection
                 %>
                 <jsp:forward page="Services.jsp"></jsp:forward>
                 <%
            }    
                                                    
                 %>
                     <jsp:forward page="adminlogin.jsp">
                         <jsp:param name="msg" value="Incorrect Username or Password"/>
                     </jsp:forward>
                 <%           
        }
        else
        {
             //page redirection
                 %>
                 <jsp:forward page="adminlogin.jsp">
                     <jsp:param name="msg" value="Please Fill Username or Password"/>
                 </jsp:forward>
                 <%
        }
    }
    catch(Exception e)
    {
          e.printStackTrace();             
	  Log.logger.error("Error:", e);                				
    }
    finally
    {
        if(rs != null)
        {
            DatabaseFile.getInstance().closeAllConnection(rs);
        }
    }
    
}
catch(Exception e)
{
    e.printStackTrace();
}
%>
