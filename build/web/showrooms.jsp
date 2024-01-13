<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Random"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title>My City Portal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="imagetoolbar" content="no" />
<link rel="stylesheet" href="styles/layout.css" type="text/css" />
<script src="scripts/jquery-1.5.js"></script>
<script src="scripts/jquery-ui-1.8.17.custom.min.js"></script>
<script type="text/javascript">
    $(function() {
            $("#datepicker1").datepicker({ dateFormat: "yy-mm-dd" }).val()
    });       
</script>
<%@page errorPage="ErrorPage.jsp"%>
</head>
<body id="top">
<div class="wrapper row1">
  <div id="header" class="clear">
    <div class="fl_left">
      <h1><a href="index.jsp">My City Information Application</a></h1>
      <p>My City Portal
          <span style="padding-left: 650px; color: red;"> Welcome : <%=session.getAttribute("x")%></span>  </p>
    </div>
    <div class="fl_right">
      <ul>
<!--        <li><a href="#">Home</a></li>
        <li><a href="#">Contact Us</a></li>
        <li><a href="#">A - Z Index</a></li>-->
<!--<li class="last"><a href="Admin.jsp">Admin Login</a></li>-->
<!--        <li class="last"><a href="#">Staff Login</a></li>-->
      </ul>
<!--      <form action="#" method="post" id="sitesearch">
        <fieldset>
          <strong>Search:</strong>
          <input type="text" value="Search Our Website&hellip;" onfocus="this.value=(this.value=='Search Our Website&hellip;')? '' : this.value ;" />
          <input type="image" src="images/search.gif" id="search" alt="Search" />
        </fieldset>
      </form>-->
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
          
                   <h1>Hotel Rooms List</h1>
                                        
                    <form action="codeshop.jsp" method="post">
                                                           
                        <%       
                            ResultSet rs = null;

                            try
                            {
                                    int g = 1;

                                     out.println("<table border='2px'  style='text-align: center;' width='100%'>");
                                     out.println("<tr>");
                                     out.println("<th>Select</th>");
                                     out.println("<th>Sno</th>");
                                     out.println("<th>Hotel Name</th>");
                                     out.println("<th>Category Name</th>");
                                     out.println("<th>Total No Of Rooms</th>");                                                                                                  
                                     out.println("<th>Price</th>"); 
                                     out.println("<th>Room Photo</th>");
                                     out.println("<th>Created Date</th>");                                   
                                     out.println("</tr>");

                                     //getting values from design page
                                    String index = request.getParameter("index");

                                    if((index!=null) && (!index.trim().equals("")))
                                    {               
                                           String sql = " SELECT rd.Room_Id, i.ItemName, c.Category_Name, rd.Total_Rooms, rd.Amount, rd.RoomPhoto, rd.CreatedDate "
                                               + " FROM roomdetails AS rd "
                                               + " LEFT JOIN categorydetails AS c ON c.Category_Id = rd.Category_Id "
                                               + " LEFT JOIN items AS i ON i.ItemId = rd.ItemId "
                                               + " WHERE i.ItemId = '"+index+"' "
                                               + " ORDER BY rd.CreatedDate DESC "
                                               + " LIMIT 10";

                                           rs = DatabaseFile.getInstance().codeselect(sql);

                                           while(rs.next())
                                           {
                                                out.println("<tr>"
                                                        + "<td><input type='checkbox' name='data' value="+rs.getString("Room_Id")+"></input></td>"  
                                                        + "<td>" + g++ + "</td>"
                                                        + "<td>" + rs.getString("ItemName") + "</td>"  
                                                        + "<td>" + rs.getString("Category_Name") + "</td>"        
                                                        + "<td>" + rs.getString("Total_Rooms") + "</td>"               
                                                        + "<td>" + rs.getString("Amount") + " Rupees Only %</td>"               
                                                        + "<td><img src='showimage1.jsp?imgid="+rs.getInt("Room_Id")+"' width='100' height='100'/></td>"                                             
                                                        + "<td>" + rs.getString("CreatedDate") + "</td>"                                                                                                                                                                                                                                                                                                                                                                                                                 
                                                        + "</tr>");
                                           }
                                    }

                                    if(g == 1)
                                    {
                                        out.println("<tr>"
                                                     + "<td>&nbsp;</td>"
                                                     + "<td>&nbsp;</td>"
                                                     + "<td>&nbsp;</td>" 
                                                     + "<td>&nbsp;</td>"
                                                     + "<td style='color: red;'> No Result Found! </td>"
                                                     + "<td>&nbsp;</td>"
                                                     + "<td>&nbsp;</td>"   
                                                     + "<td>&nbsp;</td>"
                                                     + "<td>&nbsp;</td>"
                                                     + "</tr>");
                                    }

                                    if(rs != null)
                                    {
                                         rs.close();
                                         rs = null;
                                    }

                                     out.println("</table>");
                            }
                            catch(Exception e)
                            {
                                  e.printStackTrace();                                         			
                            }
                            finally
                            {
                                if(rs != null)
                                {
                                    rs.close();
                                }
                            }    
                        %>
                        
                      <table align="center" border="0px" width="100px">
                           
                          <tr>
                              <td>&nbsp;</td><td><input type="hidden" name="itemid" id="itemid" value="<%=request.getParameter("index")%>" size="54px"/></td>
                          </tr>
                          
                          <tr>
                              <td>No of Rooms:</td><td><input type="text" name="rooms" size="54px" maxlength="6"/></td>
                          </tr>

                          <tr>
                              <td>Booking Date:</td><td><input type="text" name="datepicker1" id="datepicker1" size="54px"/></td>
                          </tr>
                          
                          <tr>
                              <td>&nbsp;</td>
                              <td><input type="submit" value="Submit"/><input type="reset" value="Reset"/></td>
                          </tr>

                      </table>

                  </form>
              
      <%
      //getting response
      
      out.println("<font color = 'red' >");
      
      try
      {
          if( (request.getParameter("msg") != null) && (!(request.getParameter("msg").trim().equals(""))) )
          {
              out.println(request.getParameter("msg"));
          }
      }
      catch(Exception e)
      {
          e.printStackTrace();
      }
      out.println("<font>");
      %>
      <!-- ####################################################################################################### -->
    </div>
  </div>
</div>
<!-- ####################################################################################################### 
<div class="wrapper row4">
  <div class="rnd">
    <div id="footer" class="clear">
       ####################################################################################################### 
      <div class="fl_left clear">
        <div class="fl_left center"><img src="images/demo/worldmap.gif" alt="" /><br />
          <a href="#">Find Us With Google Maps &raquo;</a></div>
        <address>
        Address Line 1<br />
        Address Line 2<br />
        Town/City<br />
        Postcode/Zip<br />
        <br />
        Tel: xxxx xxxx xxxxxx<br />
        Email: <a href="#">contact@domain.com</a>
        </address>
      </div>
      <div class="fl_right">
        <div id="social" class="clear">
          <p>Stay Up to Date With Whats Happening</p>
          <ul>
            <li><a style="background-position:0 0;" href="#">Twitter</a></li>
            <li><a style="background-position:-72px 0;" href="#">LinkedIn</a></li>
            <li><a style="background-position:-142px 0;" href="#">Facebook</a></li>
            <li><a style="background-position:-212px 0;" href="#">Flickr</a></li>
            <li><a style="background-position:-282px 0;" href="#">RSS</a></li>
          </ul>
        </div>
        <div id="newsletter">
          <form action="#" method="post">
            <fieldset>
              <legend>Subscribe To Our Newsletter:</legend>
              <input type="text" value="Enter Email Here&hellip;" onfocus="this.value=(this.value=='Enter Email Here&hellip;')? '' : this.value ;" />
              <input type="text" id="subscribe" value="Submit" />
            </fieldset>
          </form>
        </div>
      </div>
       ####################################################################################################### 
    </div>
  </div>
</div>
 ####################################################################################################### 
<div class="wrapper">
  <div id="copyright" class="clear">
    <p class="fl_left">Copyright &copy; 2011 - All Rights Reserved - <a href="#">Domain Name</a></p>
    <p class="fl_right">Template by <a href="http://www.os-templates.com/" title="Free Website Templates">OS Templates</a></p>
  </div>
</div>-->
</body>
</html>
