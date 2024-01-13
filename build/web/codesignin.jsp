<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="java.sql.*"%>
<%
try
{
    Log objLog  = objLog = new Log();
    
    //getting values from design page
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String phoneno = request.getParameter("phone");   
    String email = request.getParameter("email");
    String dob = request.getParameter("datepicker");
    String street1 = request.getParameter("street1");  
    String street2 = request.getParameter("street2");
    String city = request.getParameter("city");
    String state = request.getParameter("state");  
    String zipcode = request.getParameter("zipcode");
    String country = request.getParameter("country");
    String about = request.getParameter("about");                     
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    if( ((fname!=null) && (!fname.trim().equals(""))) && ((lname!=null) && (!lname.trim().equals(""))) 
            && ((phoneno!=null) && (!phoneno.trim().equals(""))) && ((email!=null) && (!email.trim().equals(""))) 
            && ((dob!=null) && (!dob.trim().equals(""))) && ((street1!=null) && (!street1.trim().equals("")))
            && ((city!=null) && (!city.trim().equals("")))
            && ((state!=null) && (!state.trim().equals(""))) && ((zipcode!=null) && (!zipcode.trim().equals("")))
            && ((country!=null) && (!country.trim().equals(""))) && ((about!=null) && (!about.trim().equals("")))
            && ((username!=null) && (!username.trim().equals(""))) && ((password!=null) && (!password.trim().equals(""))))
    {        
        //type casting
        Long mobile = Long.parseLong(phoneno);
       
        //jdbc connection
        try
        {
            ResultSet rs = null;
            int count = 0;

            String sql = "SELECT COUNT(*) as c "
                    + "FROM customer "
                    + "WHERE C_UNAME = '"+username+"' "
                    + "AND C_PASSWD = '"+password+"' ";
            
            rs = DatabaseFile.getInstance().codeselect(sql);

            while(rs.next())
            {
                count = rs.getInt(1);                
                Log.logger.info("count:"+count);	 
            }

            if(rs != null)
            {
                DatabaseFile.getInstance().closeAllConnection(rs);
            }
            
            if(count > 0)
            {
               %>
               <jsp:forward page="Signin.jsp">
                   <jsp:param name="msg" value="Username or Password already exits"></jsp:param>
               </jsp:forward>
               <%
            }

            if(count == 0)
            {
                //customer
                String sql1 = "INSERT INTO customer(C_UNAME, C_PASSWD, C_FNAME, C_LNAME, C_PHONE, C_EMAIL, C_LOGIN, C_EXPIRATION, C_DISCOUNT, C_BALANCE, C_BIRTHDATE, C_DATA)"
                    + " VALUES('"+username+"', '"+password+"', '"+fname+"', '"+lname+"', '"+phoneno+"', '"+email+"', now(), NOW( ) + INTERVAL 1 YEAR, '10', '10000', '"+dob+"', '"+about+"')";

                DatabaseFile.getInstance().codeinsert(sql1);
                
                String sql2 = "SELECT C_ID "
                    + "FROM customer "
                    + "WHERE C_UNAME = '"+username+"' "
                    + "AND C_PASSWD = '"+password+"' ";
            
                int cid = 0;
                
                rs = DatabaseFile.getInstance().codeselect(sql2);

                while(rs.next())
                {
                    cid = rs.getInt(1);                
                    Log.logger.info("cid:"+cid);	 
                }

               if(rs != null)
               {
                    DatabaseFile.getInstance().closeAllConnection(rs);
               }
            
                //address
                String sql3 = "INSERT INTO address(ADDR_STREET1, ADDR_STREET2, ADDR_CITY, ADDR_STATE, ADDR_ZIP, ADDR_CO_ID)"
                    + " VALUES('"+street1+"', '"+street2+"', '"+city+"', '"+state+"', '"+zipcode+"', '"+country+"')";

                DatabaseFile.getInstance().codeinsert(sql3);    

                //update
                String sql4 = "UPDATE customer "
                        + "SET C_ADDR_ID = '"+cid+"' "
                        + "WHERE C_UNAME = '"+username+"' "
                        + "AND C_PASSWD = '"+password+"' ";

                DatabaseFile.getInstance().codeupdate(sql4); 
            }
           %>
           <jsp:forward page="index.jsp">
                   <jsp:param name="msg" value="You can login, your account is active."></jsp:param>               
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
           <jsp:forward page="Signin.jsp">
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