<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
    <head profile="http://gmpg.org/xfn/11">
        <title>My City Portal</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="imagetoolbar" content="no" />
        <link rel="stylesheet" href="styles/layout.css" type="text/css" />
        <%@page errorPage="ErrorPage.jsp"%>
        <%@page session="true" %>        
    </head>
    <body id="top">
        <div class="wrapper row1">
            <div id="header" class="clear">
                <div class="fl_left">
                    <h1><a href="index.jsp">My City Information Application</a></h1>
                    <p>My City Portal
                        <span style="padding-left: 650px; color: red;"> Welcome : <%=session.getAttribute("x")%></span>
                    </p>
                </div>
                <div class="fl_right">
                    
                </div>
            </div>
        </div>
        <!-- ####################################################################################################### -->
        <div class="wrapper row2">
            <div class="rnd">
                <!-- ###### -->
                <div id="topnav">
                    <ul>                       
                        <li><a href="shoppingitems.jsp">Search Places</a></li>
                        <li class="active"><a href="loctionitems.jsp">Search Places By Location</a></li>
                        <li><a href="shoppingcart.jsp">Shopping Cart</a></li>
                        <li><a href="bookinghistory.jsp">Booking History</a></li>
                        <li><a href="feedback.jsp">Feedback</a></li>
                        <li class="last"><a href="Signout.jsp">Sign Out</a></li>
                    </ul>
                </div>
                <!-- ###### -->
            </div>
        </div>
        <!-- ####################################################################################################### -->
        <div class="wrapper row3">
            <div class="rnd">
                <div id="container" class="clear">
                  <!-- ####################################################################################################### -->
                  
                  <h1>Search Places By Location</h1>
       
                  <form action="locationitems_1.jsp" method="get">

                      <table align="center" border="0px" width="100px">

                          <tr>
                              <td>Location:</td><td><input type="text" name="location" size="54px"/></td>
                          </tr>
                          
                          <tr>
                              <td>&nbsp;</td><td style="color: red;">(or)</td>
                          </tr>
                          
                          <tr>
                              <td>Pincode:</td><td><input type="text" name="pincode" size="54px"/></td>
                          </tr>
                          
                          <tr>
                              <td>&nbsp;</td>
                              <td><input type="submit" value="Submit"/><input type="reset" value="Reset"/></td>
                          </tr>

                      </table>

                  </form>
                  
                  <%
                  //getting response

                  out.println("<p style='text-align: center;'><font color = 'red'>");

                  try
                  {
                      if((request.getParameter("location") != null) && (!(request.getParameter("location").trim().equals(""))) )
                      {
                          out.println("Search for your keyword " + request.getParameter("location"));
                      }
                      
                      if((request.getParameter("pincode") != null) && (!(request.getParameter("pincode").trim().equals(""))) )
                      {
                          out.println("Search for your keyword " + request.getParameter("pincode"));
                      }
                  }
                  catch(Exception e)
                  {
                      e.printStackTrace();
                  }

                  out.println("<font></p>");
                  
                  %>   
                  
                  <br/>
                 
                   <%
                        Log objLog  = objLog = new Log();
                        ResultSet rs =  null;
                   
                        try
                        {                                                                                                                                   
                                        %>
                                        
                                        <h1>Listed Places From Our Services</h1>
                                        
                                        <%
                      
                                         int g = 1;
                                           
                                         String sql = " SELECT i.ItemId, i.ItemName, s.Service_Desc, i.ShippingType, i.ItemAmount, i.ItemPhoto, i.ItemLocation, i.ItemPincode, i.ItemLatitude, i.ItemLongitude, i.CreatedDate "
                                                 + " FROM items as i"
                                                 + " LEFT JOIN service AS s ON s.Service_Id = i.Service_Id ";      

                                         if((request.getParameter("location") != null) && (!(request.getParameter("location").trim().equals(""))))
                                         {
                                             sql += " WHERE i.ItemLocation LIKE '%"+request.getParameter("location").trim()+"%' ";
                                         }
                                         
                                         if((request.getParameter("pincode") != null) && (!(request.getParameter("pincode").trim().equals(""))))
                                         {
                                             sql += " WHERE i.ItemPincode LIKE '%"+request.getParameter("pincode").trim()+"%' ";
                                         }

                                         System.out.println("sql:" + sql);

                                         rs =  DatabaseFile.getInstance().codeselect(sql);

                                         int h = 0;

                                         while(rs.next())
                                         {
                                             if(h == 0)
                                             {
                                                out.println("<table border='2px' align='center'>");
                                                out.println("<tr>");
                                             }
                                             
                                             if(!rs.getString("Service_Desc").equalsIgnoreCase("Hotel"))
                                             {
                                                  out.println("<td style='text-align: center; font-weight: bold; color: red;'>"
                                                      + "<img src='showimage.jsp?imgid="+rs.getInt("ItemId")+"' width='100' height='100'/>"
                                                      + "<br/>"+ rs.getString("Service_Desc") + " : " + rs.getString("ItemName")+
                                                      "<br/>ITEM#" + (g++) +"</td>");    
                                             }
                                             else
                                             {
                                                  out.println("<td style='text-align: center; font-weight: bold; color: red;'>"
                                                      + "<a href='showrooms.jsp?index="+ rs.getInt("ItemId") +"''><img src='showimage.jsp?imgid="+rs.getInt("ItemId")+"' width='100' height='100'/></a>"
                                                      + "<br/>"+ rs.getString("Service_Desc") + " : " + rs.getString("ItemName")+
                                                      "<br/>ITEM#" + (g++) +"</td>");
                                             }
                                             
                                             if(h  == 5)
                                             {
                                                out.println("</table>");  
                                             }   

                                            h++;

                                            if(h == 5)
                                            {
                                                h = 0;
                                            }
                                         }

                                         if(g == 1)
                                         {
                                             out.println("<table border='2px' align='center'>");

                                              out.println("<tr>"
                                                        + "<td> &nbsp; </td>"                                                                                                                                               
                                                        + "<td style='color: red;'> No Result Found! </td>"                                                   
                                                        + "<td> &nbsp; </td>"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
                                                        + "</tr>");

                                              out.println("</table>");
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
                    
                        %>
                  </div>

                    <%
                        //getting response
                        try {
                            out.println("<font color = 'red'>");

                            if ((request.getParameter("msg") != null) && (!(request.getParameter("msg").trim().equals("")))) {
                                out.println(request.getParameter("msg"));
                            }

                            out.println("</font>");
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>                   
                </div>                
         </div>              
    </body>
</html>
