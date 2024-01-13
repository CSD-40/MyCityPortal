<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.sql.*"%>
<%
try
{
    Log objLog  = objLog = new Log();    
    ResultSet rs = null;
         
    //getting values from design page
    String rooms = request.getParameter("rooms");
    String datepicker1 = request.getParameter("datepicker1");
    String data[] = request.getParameterValues("data");
    String index = request.getParameter("itemid");
    
    Log.logger.info("rooms:"+rooms);
    Log.logger.info("datepicker1:"+datepicker1);
    Log.logger.info("data:"+data);
    Log.logger.info("index:"+index);
   
    if(((rooms!=null) && (!rooms.trim().equals(""))) && ((datepicker1!=null) && (!datepicker1.trim().equals("")))
            && ((data!=null)) && ((index!=null) && (!index.trim().equals(""))))
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
            
            for(String roomid : data)
            {
                String sql = " SELECT rd.Room_Id, i.ItemName, c.Category_Name, rd.Total_Rooms, rd.Amount, rd.RoomPhoto, rd.CreatedDate "
                        + " FROM roomdetails AS rd "
                        + " LEFT JOIN categorydetails AS c ON c.Category_Id = rd.Category_Id "
                        + " LEFT JOIN items AS i ON i.ItemId = rd.ItemId "
                        + " WHERE i.ItemId = '"+index+"' "
                        + " AND rd.Room_Id = '"+roomid+"' "
                        + " ORDER BY rd.CreatedDate DESC ";
            
                rs = DatabaseFile.getInstance().codeselect(sql);

                while(rs.next())
                {
                    int totalamount = (Integer.parseInt(rooms) * rs.getInt("Amount"));
                            
                    //orders
                    String sql1 = "INSERT INTO orders(O_C_ID, O_DATE, O_SUB_TOTAL, O_TAX, O_TOTAL, O_SHIP_TYPE, O_SHIP_DATE, O_BILL_ADDR_ID, O_SHIP_ADDR_ID, O_STATUS)"
                        + " VALUES('"+cid+"', now(), '"+rs.getInt("Amount")+"', '0', '"+ totalamount +"', '"+rooms+"',  '"+datepicker1+"', '"+roomid+"', '"+cid+"', 'Y')";

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
            }

            rs.close();
             
           %>
           <jsp:forward page="shoppingcart.jsp">
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