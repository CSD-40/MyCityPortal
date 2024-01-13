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
    String categorycode = request.getParameter("categorycode");
    String categoryname = request.getParameter("categoryname");
    String categorydesc = request.getParameter("categorydesc");
  
    if( ((categorycode!=null) && (!categorycode.trim().equals(""))) 
            && ((categoryname!=null) && (!categoryname.trim().equals("")))
            && ((categorydesc!=null) && (!categorydesc.trim().equals(""))))
    {                
        //jdbc connection
        try
        {               
            String sql = "INSERT INTO categorydetails(Category_Code, Category_Name, Category_Desc, Status, CreatedDate)"
                    + " VALUES('"+categorycode+"', '"+categoryname+"',  '"+categorydesc+"', 'Un Approved', now())";

           DatabaseFile.getInstance().codeinsert(sql);                      
           
           %>
           <jsp:forward page="Category.jsp">
                   <jsp:param name="msg" value="Category Created Sucessfully!"></jsp:param>               
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
           <jsp:forward page="Category.jsp">
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