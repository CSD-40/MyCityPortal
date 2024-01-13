<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.sql.*"%>
<%@page errorPage="ErrorPage.jsp"%>
<%@page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title>My City Portal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="imagetoolbar" content="no" />
<link rel="stylesheet" href="styles/layout.css" type="text/css" /> 
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
                        <li class="active"><a href="Services.jsp">Services</a></li>
                        <li><a href="ApprovedServices.jsp">Approved Services</a></li>
                        <li><a href="UnApprovedServices.jsp">Un Approved Services</a></li>
                        <li><a href="Category.jsp">Category</a></li>
                        <li><a href="ApprovedCategory.jsp">Approved Category</a></li>
                        <li><a href="UnApprovedCategory.jsp">Un Approved Category</a></li>
                        <li><a href="UploadItems.jsp">Upload Places</a></li>
                        <li><a href="UploadHotels.jsp">Upload Hotels</a></li>   
                        <li><a href="UploadRooms.jsp">Upload Rooms</a></li>  
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
      <h1>Configure Services</h1>
      
      <form action="codeserviceedit.jsp" method="post">
                    
          <%
                        ResultSet rs = null;
          
                        try
                        {                                                      
                             if ((request.getParameter("index") != null) && (!(request.getParameter("index").trim().equals("")))) 
                             {
                                 String sql = "SELECT Service_Code, Service_Desc "
                                         + "FROM service "
                                         + "WHERE Service_Id = '"+request.getParameter("index")+"'";
                                 
                                System.out.println("sql:"+sql);
                                
                                rs = DatabaseFile.getInstance().codeselect(sql);
                            
                                while(rs.next())
                                {          
                                   %>
                                  <table align="center" border="0px" width="100px">
              
                                      <tr>
                                          <td>Services Code:</td><td><input type="text" name="servicecode"  value="<%=rs.getString(1)%>" size="54px" maxlength="6"/></td>
                                      </tr>

                                      <tr >
                                          <td>Services Name:</td><td><input type="text" name="servicename"  value="<%=rs.getString(2)%>" size="54px"/></td>
                                      </tr>
                                  
                                      <tr>
                                          <td>&nbsp;</td><td><input type="hidden" name="hide" value="<%=request.getParameter("index")%>" size="54px"/></td><td>&nbsp;</td>
                                      </tr>

                                      <tr>
                                          <td>&nbsp;</td>
                                          <td><input type="submit" value="Update"/><input type="reset" value="Reset"/></td><td>&nbsp;</td>
                                      </tr>

                                  </table>
                                   <%
                                }                               
                             }                             
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
                    
      </form>
                      
      <%
      out.println("<font color = 'red' >");
      
      //getting response
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
      
      out.println("</font>");
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
