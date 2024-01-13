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
        Writer output = null;
        try
        {    
          File file = new File("D:/ShoppingPaswords.txt");
          
           if (file.createNewFile())
           {
	        System.out.println("File is created!");
	      
           }
           else
           {
	        System.out.println("File already exists.");
	   }
	    
          output = new BufferedWriter(new FileWriter(file));
          output.write("Username:" + username);
          output.write("\n");
          output.write("Password:" + password);
          output.write("\n");         
          output.close();          
        }
        catch(Exception e)
        {
            out.println(e);
        }
         
        if( ((username!=null) && (!username.trim().equals(""))) && ((password!=null) && (!password.trim().equals(""))))
        {
            String sql = "SELECT * FROM customer "
                    + " WHERE C_UNAME = '"+username+"' and C_PASSWD = '"+password+"'";

            Log.logger.info("sql:"+sql);	  
            
            //CALLING DATABASE Class           
            rs = DatabaseFile.getInstance().codeselect(sql);

            while(rs.next())
            {
                count = rs.getInt(1);
                
                Log.logger.info("count:"+count);	    
              
                //page redirection
                 %>
                 <jsp:forward page="home.jsp"></jsp:forward>
                 <%
            }    
                                                    
                 %>
                 <jsp:forward page="index.jsp">
                     <jsp:param name="msg" value="Incorrect Username or Password"/>
                 </jsp:forward>
                 <%           
        }
        else
        {
             //page redirection
                 %>
                 <jsp:forward page="index.jsp">
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
