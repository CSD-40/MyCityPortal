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
                        <li><a href="home.jsp">Home</a></li>
                        <li><a href="pshoppingitems.jsp">Shopping Items</a></li>
                        <li><a href="pshoppingcart.jsp">Shopping Cart</a></li>
                        <li class="active"><a href="pfeedback.jsp">Feedback</a></li>
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
                  
                  <h1>Feed Back</h1>
       
                  <form action="codefeedback_1.jsp" method="get">

                      <table align="center" border="0px" width="100px">

                          <tr style="color: red;">
                             <td>Comments:</td>
                              <td>
                                   <textarea cols="50" rows="5" name="comment"></textarea>                                                                 
                              </td>
                          </tr>
                          <tr style="color: red;">
                              <td>&nbsp;</td> 
                              <td >                                               
                                <input type="submit" value="Comment"/>
                              </td>
                          </tr>

                      </table>

                  </form>
                                    
                  <br/>
                 
                  <h1>Customers FeedBack's</h1>
                      
                   <%
                        Log objLog  = objLog = new Log();
                        ResultSet rs =  null;
                   
                        try
                        {
                                 int g = 1;
                             
                                 String sql = "SELECT C_FNAME, C_LNAME, COMMENT, RECORDEDDATE "
                                         + "FROM feedback AS f "
                                         + "LEFT JOIN customer AS c on c.C_ID = f.C_ID ";
                                 
                                 rs =  DatabaseFile.getInstance().codeselect(sql);
                                
                                 out.println("<table border='2px'  style='text-align: center;' width='100%'>");
                                 out.println("<tr>");                               
                                 out.println("<th>Sno</th>");
                                 out.println("<th>Name</th>");
                                 out.println("<th>Comment</th>");                                                                
                                 out.println("<th>Date</th>");                                                                                                                                                                                                                                                                                                                                                                                                                           
                                 out.println("</tr>");                            
                                         
                                 while(rs.next())
                                {
                                     out.println("<tr>"                                           
                                             + "<td>" + g + "</td>"                                            
                                             + "<td>" + rs.getString(1) + " " + rs.getString(2) + "</td>"                                              
                                             + "<td>" + rs.getString(3) + "</td>"                                                                                                                                   
                                             + "<td>" + rs.getDate(4) + "</td>"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
                                             + "</tr>");
                                    g++;
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
