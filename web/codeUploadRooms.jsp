<%@page import="org.apache.commons.lang3.RandomStringUtils"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.util.ArrayList"%>
<%@page session="true" %>
<%@page import="java.sql.*"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Date"%>
<%
    try {
        //session tracking
        HttpSession hs = request.getSession(true);
        String username = hs.getAttribute("x").toString();
        String contentType = request.getContentType();
        
        if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
            
            InputStream filecontent = null;
            String hotelname = "", categoryname = "", totalnoofrooms = "", amount = "", saveFile = "";
                         
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            for (FileItem item : items) {
            if (item.isFormField()) {
                // Process regular form field (input type="text|radio|checkbox|etc", select, etc).
                String fieldname = item.getFieldName();
                String fieldvalue = item.getString();
                
                 if(fieldname.equals("hotelname")){
                     hotelname = fieldvalue; 
                  }
                 
                if(fieldname.equals("categoryname")){
                     categoryname = fieldvalue; 
                }
                
                if(fieldname.equals("totalnoofrooms")){
                     totalnoofrooms = fieldvalue; 
                  }
                
                if(fieldname.equals("amount")){
                     amount = fieldvalue; 
                  }                
                               
            } else {
                // Process form file field (input type="file").
                    String fieldname = item.getFieldName();
                    String filename = FilenameUtils.getName(item.getName());
                    filecontent = item.getInputStream();
                    String contentTypes = item.getContentType();
                    boolean isInMemory = item.isInMemory();
                    long sizeInBytes = item.getSize();
                    byte[] data = item.get();     
                    String path = "images/" + session.getId() +filename;
                    //saveFile = this.getServletContext().getRealPath(path);  
                    saveFile = "C:/Project_Softwares/" + path;
                    FileOutputStream fos = new FileOutputStream(saveFile);
                    int data1 = 0;
                    while ((data1 = filecontent.read()) != -1) {
                        fos.write(data1);
                    }
                    fos.close();
                    filecontent.close();
            }
           
            }
              
            System.out.println(saveFile);
            
            File f = new File(saveFile);
            FileInputStream fis = new FileInputStream(f);    
           
            String secretkey = RandomStringUtils.random(2, false, true);;
            
            //upload into temp
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mycityportal", "root", "");
            String sql = " insert into roomdetails(ItemId, Category_Id, Total_Rooms, Amount, RoomPhoto, CreatedDate) "
                    + " VALUES (?, ?, ?, ? , ?, ?)";
            PreparedStatement psmnt = connection.prepareStatement(sql);
            psmnt.setString(1, hotelname);           
            psmnt.setString(2, categoryname);
            psmnt.setString(3, totalnoofrooms);
            psmnt.setString(4, amount);                 
            psmnt.setBinaryStream(5, (InputStream) fis, (int) (f.length())); 
            psmnt.setDate(6, getCurrentDate());                                                                         
            psmnt.executeUpdate();
            
            %>
            <jsp:forward page="UploadRooms.jsp">
                 <jsp:param name="msg" value="uploaded Sucessfully!"/>
            </jsp:forward>
            <%
        }
        else
        {
            %>
            <jsp:forward page="UploadRooms.jsp">
                 <jsp:param name="msg" value="No File Selected"/>
            </jsp:forward>
            <%
        }               
    } 
    catch (Exception e) 
    {
            e.printStackTrace();
            
            %>

                <jsp:forward page="UploadRooms.jsp">
                    
                    <jsp:param name="msg" value="No File Selected"/>
                    
                </jsp:forward>
            
            <%
                    System.out.println("No File Selected");
     }
            %>

<%!

private static java.sql.Date getCurrentDate() {
    java.util.Date today = new java.util.Date();
    return new java.sql.Date(today.getTime());
}
%>