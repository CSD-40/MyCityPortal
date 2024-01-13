<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.sql.*"%>
<%
try
{
    Log objLog  = objLog = new Log();
    
    //getting values from design page
    String comment = request.getParameter("comment");
    String username = session.getAttribute("x").toString();
       
    if( ((comment!=null) && (!comment.trim().equals(""))) && ((username!=null) && (!username.trim().equals(""))))
    {         
            ResultSet rs = null;
            int count = 0;

            String sql = "SELECT C_ID "
                    + "FROM customer "
                    + "WHERE C_UNAME = '"+username+"' ";
            
            rs = DatabaseFile.getInstance().codeselect(sql);

            while(rs.next())
            {
                count = rs.getInt(1);                
                Log.logger.info("count:"+count);	 
            }

            if(rs != null)
            {
                DatabaseFile.getInstance().closeAllConnection(rs);
            }
                       
            //customer
            String sql1 = "INSERT INTO feedback(C_ID, COMMENT, RECORDEDDATE)"
                        + " VALUES('"+count+"', '"+comment+"', now())";

            DatabaseFile.getInstance().codeinsert(sql1);                
           
           %>
           <jsp:forward page="feedback.jsp">
                   <jsp:param name="msg" value="Feedback posted sucessfully!!!"></jsp:param>               
               </jsp:forward>
           <%       
    }
    else
    {
           %>
           <jsp:forward page="feedback.jsp">
               <jsp:param name="msg" value="Please Fill All Details"></jsp:param>
           </jsp:forward>
           <%
    }    
}
catch(Exception e)
{
    e.printStackTrace();
    Log.logger.error("Error:", e);    
} 
%>