<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.sql.*"%>
<%
try
{
    Log objLog  = objLog = new Log();    
    ResultSet rs = null;
         
    //getting values from design page
    String index = request.getParameter("index");
   
    if((index!=null) && (!index.trim().equals("")))
    {               
        //jdbc connection
        try
        {    
            int cid = 0; 
            int oid = 0; 
                       
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
             
            String sql = "SELECT i.I_ID, i.I_TITLE, a.A_FNAME, a.A_LNAME, i.I_PUB_DATE, i.I_PUBLISHER, i.I_SRP, i.I_COST, i.I_STOCK, i.I_PAGE, i.I_DIMENSIONS "
                         + "FROM item as i "
                         + "Left join author as a on a.A_ID = i.I_A_ID "
                         + "WHERE i.I_ID = '"+index+"'";
            
            rs = DatabaseFile.getInstance().codeselect(sql);

            while(rs.next())
            {
                //orders
                String sql1 = "INSERT INTO orders(O_C_ID, O_DATE, O_SUB_TOTAL, O_TAX, O_TOTAL, O_SHIP_TYPE, O_SHIP_DATE, O_BILL_ADDR_ID, O_SHIP_ADDR_ID, O_STATUS)"
                    + " VALUES('"+cid+"', now(), '"+rs.getInt("I_SRP")+"', '0', '"+rs.getInt("I_SRP")+"', 'Blue Dot',  NOW() + INTERVAL 4 DAY, '"+cid+"', '"+cid+"', 'Y')";

                Log.logger.info("sql1"+sql1);
                
                DatabaseFile.getInstance().codeinsert(sql1);	

                
                String sql4 = "SELECT O_ID "
                    + "FROM orders "
                    + "ORDER BY O_C_ID DESC LIMIT 1";
             
                 Log.logger.info("sql4:"+sql4);

                rs = DatabaseFile.getInstance().codeselect(sql4);

                while(rs.next())
                {
                    oid = rs.getInt("O_ID");

                    Log.logger.info("oid:"+oid);
                }

                //orders_line                
                String sql3 = "INSERT INTO order_line(OL_O_ID, OL_I_ID, OL_QTY, OL_DISCOUNT, OL_COMMENTS)"
                    + " VALUES('"+oid+"', '"+index+"', '1', '0', '-')";

                Log.logger.info("sql3"+sql3);
                
                DatabaseFile.getInstance().codeinsert(sql3);
            }

            rs.close();
             
           %>
           <jsp:forward page="pshoppingcart.jsp">
                   <jsp:param name="msg" value=""></jsp:param>               
               </jsp:forward>
           <%

        }
        catch(Exception e)
        {
            e.printStackTrace();
            Log.logger.error("Error:", e);    
        }
    }
    else
    {
           %>
           <jsp:forward page="shoppingitems.jsp">
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