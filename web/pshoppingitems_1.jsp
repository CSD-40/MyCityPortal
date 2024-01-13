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
                        <li class="active"><a href="pshoppingitems.jsp">Shopping Items</a></li>
                        <li><a href="pshoppingcart.jsp">Shopping Cart</a></li>
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
                  
                  <h1>Search Items</h1>
       
                  <form action="pshoppingitems_1.jsp" method="get">

                      <table align="center" border="0px" width="100px">

                          <tr style="color: red;">
                              <td style="text-align: center;"><input type="text" name="search" size="35px"/><input type="submit" value="Search"/></td>
                          </tr>

                      </table>

                  </form>
                 
                  <%
                        Log objLog  = objLog = new Log();
                        ResultSet rs =  null;
                   
                        try
                        {
                                 int g = 1;
                             
                                  String sql = " SELECT i.ItemId, i.ItemName, s.Service_Desc, i.ShippingType, i.ItemAmount, i.ItemPhoto, i.ItemLocation, i.ItemPincode, i.ItemLatitude, i.ItemLongitude, i.CreatedDate "
                                         + " FROM items as i"
                                         + " LEFT JOIN service AS s ON s.Service_Id = i.Service_Id ";
                                                                   
                                 if((request.getParameter("search") != null) && (!(request.getParameter("search").trim().equals(""))) )
                                 {
                                     String mainSearch = "";
                                     String subsearch = "";
                                     
                                     if(request.getParameter("search").contains("OR") || request.getParameter("search").contains("or"))
                                     {
                                         mainSearch = request.getParameter("search").substring(0, request.getParameter("search").indexOf("or"));
                                      
                                        subsearch = request.getParameter("search").substring(request.getParameter("search").indexOf("or"));
                                        
                                        sql += "WHERE i.ItemName = '"+mainSearch.trim()+"' " + subsearch;
                                     }                                    
                                     else
                                     {
                                         mainSearch = request.getParameter("search");
                                         
                                         sql += "WHERE i.ItemName = '"+mainSearch.trim()+"' ";
                                     }                                     
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
                                     
                                      out.println("<td style='text-align: center; font-weight: bold; color: red;'>"
                                              + "<a href='codeshop_1.jsp?index="+ rs.getInt("ItemId") +"''><img src='showimage.jsp?imgid="+rs.getInt("ItemId")+"' width='100' height='100'/></a>"
                                              + "<br/>"+ rs.getString("ItemName")+
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
