<%@page import="java.sql.*"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page session="true" %>
<%
    try 
    {
        //session
        HttpSession hs = request.getSession(true);
       
        ResultSet rs = null;
        
        //argument
        String username =  hs.getAttribute("x").toString();
        int orderid = Integer.parseInt(request.getParameter("index"));
        int orderlineid = Integer.parseInt(request.getParameter("index1"));                 
            
        if (((username != null) && (!username.trim().equals(""))) && (orderid != 0) && (orderlineid != 0)) 
        {           
            int cid = 0; 
                 
            String sql2 = "SELECT C_ID "
                    + "FROM customer "
                    + "WHERE C_UNAME = '"+session.getAttribute("x") +"'";
             
             Log.logger.info("sql2:"+sql2);
             
            rs = DatabaseFile.getInstance().codeselect(sql2);

            while(rs.next())
            {
                cid = rs.getInt("C_ID");
                
                Log.logger.info("cid:"+cid);
                
            }
            
            rs.close();
            
            String sql = "DELETE "
                    + " FROM orders "
                    + " WHERE O_ID = '" + orderid + "'";

            DatabaseFile.getInstance().codedelete(sql);
            
             String sql1 = "DELETE "
                    + " FROM order_line "
                    + " WHERE OL_ID = '" + orderlineid + "'";

            DatabaseFile.getInstance().codedelete(sql1);
            
                     %>
                     <jsp:forward page="pshoppingcart.jsp">
                             <jsp:param name="msg" value="Remove from the cart!"/>
                         </jsp:forward>
                     <%                          
        } 
        else 
        {
                     %>
                     <jsp:forward page="pshoppingcart.jsp">
                             <jsp:param name="msg" value="Not Deleted Successfully!"/>
                         </jsp:forward>
                     <%    
        }
    } 
    catch (Exception e) 
    {
        e.printStackTrace();
        Log.logger.error("Error:", e); 
    }

%>