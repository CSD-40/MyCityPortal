<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.sql.*"%>
<%@page errorPage="ErrorPage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title>My City Portal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="imagetoolbar" content="no" />
<link rel="stylesheet" href="styles/layout.css" type="text/css" />
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
      <p>My City Portal</p>
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
          <li class="active"><a href="index.jsp">Login</a></li> 
          <li><a href="adminlogin.jsp">Admin</a></li> 
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
      <h1 style="color: red;">Sign Up Form</h1>
      
      <form action="codesignin.jsp" method="post">
                    
          <table align="center" border="0px" width="100px">
              
              <tr style="color: red;">
                  <td>First Name</td><td><input type="text" name="fname" size="54px"/></td>
              </tr>
              
              <tr style="color: red;">
                  <td>Last Name</td><td><input type="text" name="lname" size="54px"/></td>
              </tr>
            
              <tr style="color: red;">
                  <td>Phone No:</td><td><input type="text" name="phone" size="54px"/></td>
              </tr>
              
              <tr style="color: red;">
                  <td>Email Id:</td><td><input type="text" name="email" size="54px"/></td>
              </tr>
              
              <tr style="color: red;">
                  <td>DOB:</td><td><input type="text" id="datepicker" name="datepicker" size="54px"/></td>
              </tr>
              
              <tr style="color: red;">
                  <td>Street 1:</td><td><input type="text" name="street1" size="54px"/></td>
              </tr>
              
              <tr style="color: red;">
                  <td>Street 2:</td><td><input type="text" name="street2" size="54px"/></td>
              </tr>
              
              <tr style="color: red;">
                  <td>City:</td><td><input type="text" name="city" size="54px"/></td>
              </tr>
              
              <tr style="color: red;">
                  <td>State:</td><td><input type="text" name="state" size="54px"/></td>
              </tr>
              
              <tr style="color: red;">
                  <td>Pincode:</td><td><input type="text" name="zipcode" size="54px"/></td>
              </tr>
              
              <tr style="color: red;">
                  <td>Country</td>
                  <td><select name="country" style="width:340px;">                         
                          <%
                          try
                          {
                              ResultSet rs = null;
                              
                              String sql = "SELECT CO_ID, CO_NAME FROM country";
                              
                              rs = DatabaseFile.getInstance().codeselect(sql);
                              
                              while(rs.next())
                              {
                                  %>
                                  <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                                  <%
                              }
                              rs.close();
                          }
                          catch(Exception e)
                          {
                          e.printStackTrace();    
                          }
                          %>
                      </select>
                  </td>
              </tr>
                      
              <tr style="color: red;">
                  <td>About You:</td><td><textarea cols="50" rows="6" name="about"></textarea></td>
              </tr>
              
              <tr style="color: red;">
                  <td>Username:</td><td><input type="text" name="username" size="54px"/></td>
              </tr>
              
              <tr style="color: red;">
                  <td>Password:</td><td><input type="password" name="password" size="54px"/></td>
              </tr>
              
              <tr>
                  <td>&nbsp;</td>
                  <td><input type="submit" value="Submit"/><input type="reset" value="Reset"/></td>
              </tr>
              
          </table>
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
