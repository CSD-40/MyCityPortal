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
        <link href="styles/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <script src="scripts/jquery-1.5.js"></script>
        <script src="scripts/jquery-ui-1.8.17.custom.min.js"></script>
         <script type="text/javascript">
               $(function() {
                       $("#datepicker").datepicker({ dateFormat: "yy-mm-dd" }).val()
               });
         </script>
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
                        <li><a href="home.jsp">Home</a></li>
                        <li><a href="pshoppingitems.jsp">Shopping Items</a></li>
                        <li class="active"><a href="pshoppingcart.jsp">Shopping Cart</a></li>
                        <li><a href="pfeedback.jsp">Feedback</a></li>
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
                 
                  <h1>View Shopping Cart</h1>
                      
                   <%
                        Log objLog  = objLog = new Log();
                        ResultSet rs =  null;
                   
                        try
                        {
                                 int cid = 0;
                                 int g = 1;
                                 int total = 0; 
                                 StringBuffer orderid =  new StringBuffer();
                                 
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
                                
                                 out.println("<table border='2px' align='center'>");
                                 out.println("<tr>");
                                 out.println("<th>SNO</th>");
                                 out.println("<th>PRODUCT</th>");
                                 out.println("<th>TITLE</th>");                
                                 out.println("<th>SUB TOTAL</th>");                                  
                                 out.println("<th>TAX</th>");                                 
                                 out.println("<th>TOTAL</th>");                                                                                                                             
                                 out.println("<th>SHIP TYPE</th>");
                                 out.println("<th>DELETE</th>");                                                                                                                                                             
                                 out.println("</tr>");

                                 String sql = "SELECT i.I_ID, i.I_TITLE, o.O_SUB_TOTAL, o.O_TOTAL, o.O_TAX, o.O_SHIP_TYPE, o.O_ID, ol.OL_ID "
                                         + "FROM order_line as ol "
                                         + "LEFT JOIN orders as o on o.O_ID = ol.OL_O_ID "
                                         + "LEFT JOIN item as i on i.I_ID = ol.OL_I_ID "
                                         + "WHERE o.O_C_ID = '"+cid+"' "
                                         + "AND O_STATUS NOT IN ('N') ";

                                 rs =  DatabaseFile.getInstance().codeselect(sql);
                            
                                 while(rs.next())
                                 {
                                     total += rs.getInt("O_TOTAL");
                                     orderid.append(rs.getInt("O_ID")+"-");
                                     
                                     out.println("<tr><td>" + g++ 
                                             + "</td><td><a href='codeshop_1.jsp?index="+ rs.getInt("I_ID") +"''><img src='image.jsp?imgid="+rs.getInt("I_ID")+"' width='100' height='100'/>" 
                                             + "</td><td>" + rs.getString("I_TITLE") 
                                             + "</td><td>" + rs.getString("O_SUB_TOTAL")
                                             + "</td><td>" + rs.getString("O_TAX")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
                                             + "</td><td>" + rs.getString("O_TOTAL")
                                             + "</td><td>" + rs.getString("O_SHIP_TYPE")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                             + "<td style='text-align:center;'><a href='codeshoppingDelete_1.jsp?index="+ rs.getInt("O_ID") +"&index1="+ rs.getInt("OL_ID")+"'><img src='images/Delete.png'></img></a></td>"                                                                                                                                                                                                                            
                                             + "</td></tr>");
                                 }
                                
                                 if(g == 1)
                                 {
                                      out.println("<tr>"
                                                + "<td> &nbsp; </td>"    
                                                + "<td> &nbsp; </td>"
                                                + "<td> &nbsp; </td>"                                                                                                        
                                                + "<td style='color: red;'> Not Result Found! </td>"    
                                                + "<td> &nbsp; </td>"    
                                                + "<td> &nbsp; </td>" 
                                                + "<td> &nbsp; </td>"
                                                + "<td> &nbsp; </td>"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
                                                + "</tr>");
                                 }
                                 
                                 if(g != 1)
                                 {
                                  out.println("<tr>"
                                                + "<td> &nbsp; </td>"  
                                                + "<td> &nbsp; </td>"                                                       
                                                + "<td> &nbsp; </td>"                                                                                                   
                                                + "<td> &nbsp; </td>"    
                                                + "<td> &nbsp; </td>" 
                                                + "<td style='color: red;'> GRAND TOTAL: "+total+"</td>"   
                                                + "<td style='text-align:center;'><a href='codepay_1.jsp?index="+ orderid +"'>PAY</a></td>"                                                                                                                                                                                                                             
                                                + "<td> &nbsp; </td>"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
                                                + "</tr>");
                                  }
                                  
                                 out.println("</table>");
                                 
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
