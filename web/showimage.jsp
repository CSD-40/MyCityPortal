<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@ page import="java.sql.*,java.io.*,java.util.*" %> 
<%
Log objLog  = objLog = new Log();

ResultSet rs = null;

if(request.getParameter("imgid")!=null && request.getParameter("imgid")!="")
{   
	int id =  Integer.parseInt(request.getParameter("imgid"));
	String filename = "image"+id+".jpg";
               
	try
        {      				                
                String sql = " SELECT ItemPhoto "
                             + " FROM items "
                             + " WHERE ItemId = '"+id+"'";
                
                rs = DatabaseFile.getInstance().codeselect(sql);
                
                String imgLen = ""; 
                
		if(rs.next())
                {
                    imgLen = rs.getString(1);
	   	}  
                
                rs.close();
                
		rs = DatabaseFile.getInstance().codeselect(sql);
                
		if(rs.next())
                {
			int len = imgLen.length();
			byte [] rb = new byte[len];
                        
			InputStream readImg = rs.getBinaryStream(1);
                        
			int index = readImg.read(rb, 0, len);  
                        		
			response.reset();
			response.setContentType("image/jpg");
			response.setHeader("Content-disposition","attachment; filename=" +filename);
			response.getOutputStream().write(rb,0,len); 
			response.getOutputStream().flush();        
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
}
%>
