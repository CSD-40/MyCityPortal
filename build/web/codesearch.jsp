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
                        <li class="active"><a href="shoppingitems.jsp">Shopping Items</a></li>
                        <li><a href="shoppingcart.jsp">Shopping Cart</a></li>
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
                  
                  <h1>Search Items</h1>
       
                  <form action="codesearch.jsp" method="post">

                      <table align="center" border="0px" width="100px">

                          <tr style="color: red;">
                              <td style="text-align: center;"><input type="text" name="search" size="35px"/><input type="submit" value="Search"/></td>
                          </tr>

                      </table>

                  </form>
                  
                  <%
                  //getting response

                  out.println("<font color = 'red' >");

                  try
                  {
                      if( (request.getParameter("search") != null) && (!(request.getParameter("search").trim().equals(""))) )
                      {
                          out.println("Search for your keyword " + request.getParameter("msg"));
                      }
                  }
                  catch(Exception e)
                  {
                      e.printStackTrace();
                  }

                  out.println("<font>");
                  %>   
                  
                  <br/>
                  <br/>
                  
                  <h1>Listed Items</h1>
                      
                   <%
                        Log objLog  = objLog = new Log();
                        ResultSet rs =  null;
                   
                        try
                        {
                                 int g = 1;
                             
                                 String sql = "SELECT i.I_ID, i.I_TITLE, a.A_FNAME, a.A_LNAME, i.I_PUB_DATE, i.I_PUBLISHER, i.I_SRP, i.I_COST, i.I_STOCK, i.I_PAGE, i.I_DIMENSIONS "
                                         + "FROM item as i "
                                         + "Left join author as a on a.A_ID = i.I_A_ID ";

                                 rs =  DatabaseFile.getInstance().codeselect(sql);
                            
                                 int h = 0;
                                 
                                 while(rs.next())
                                 {
                                     if(h == 0)
                                     {
                                        out.println("<table border='2px' align='center'>");
                                        out.println("<tr>");
                                     }
                                     
                                      out.println("<td style='text-align: center; font-weight: bold; color: red;'>"
                                              + "<a href='codeshop.jsp?index="+ rs.getInt("I_ID") +"''><img src='image.jsp?imgid="+rs.getInt("I_ID")+"' width='100' height='100'/></a>"
                                              + "<br/>"+ rs.getString("I_TITLE")+
                                              "<br/>ITEM#" + (g++) +"</td>");    
  
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
                                                + "<td style='color: red;'> Not Result Found! </td>"                                                   
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
