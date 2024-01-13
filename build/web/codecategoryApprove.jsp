<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.sql.*"%>
<%@page session="true" %>
<%
    try 
    {
        //session
        HttpSession hs = request.getSession(true);

        //argument
        String username = hs.getAttribute("x").toString();
        int requestid = Integer.parseInt(request.getParameter("index"));
        String status = request.getParameter("index1");
       
        String page1 = "";

        if (((username != null) && (!username.trim().equals(""))) && (requestid != 0)) 
        {
            if (status.equals("Approved")) 
            {
                page1 = "ApprovedCategory.jsp";
                status = "Un Approved";
            } 
            else if (status.equals("Un Approved")) 
            {
                page1 = "UnApprovedCategory.jsp";
                status = "Approved";
            } 
            else 
            {
                
            }
           
            String sql = "UPDATE categorydetails "
                    + " SET Status = '" + status + "' "
                    + " WHERE Category_Id = '" + requestid + "' ";
            
            DatabaseFile.getInstance().codeupdate(sql);
                       
            %>
                <jsp:forward page="<%=page1%>">
                    <jsp:param name="msg" value="Update Successfully!"/>
                </jsp:forward>
            <%
        } 
        else 
        {
            %>
                <jsp:forward page="<%=page1%>">
                    <jsp:param name="msg" value="Update Successfully!"/>
                </jsp:forward>
            <%
        }
} 
catch (Exception e) 
{
   e.printStackTrace();
}

%>