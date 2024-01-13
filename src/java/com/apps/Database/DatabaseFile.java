/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apps.Database;

import com.apps.ResourceBundle.AppBundle;
import com.apps.Logcreation.Log;
import java.sql.*;

/**
 *
 * @author KIRUBAKARAN
 */
public class DatabaseFile 
{
    public static DatabaseFile objDatabaseFile = null;
    public static Connection con = null;
    public static Statement st = null;
    public static ResultSet rs = null;    
    
    public static DatabaseFile getInstance()
    {
        Log.logger.info("DatabaseFile-->getInstance()");
        
        if(objDatabaseFile == null)
        {
            objDatabaseFile = new DatabaseFile();
            
            Log.logger.info("DatabaseFile Instance Created");
        }
        
        return objDatabaseFile;
    }
    
    public static Connection getConnection()
    {       
       Log.logger.info("DatabaseFile-->getConnection()");
        
       try
        {            
            Class.forName(AppBundle.getInstance().loadpropertyfile("driver", "MyCityconfig"));
            
            con = DriverManager.getConnection(
                    AppBundle.getInstance().loadpropertyfile("dbpath", "MyCityconfig") + AppBundle.getInstance().loadpropertyfile("databaseName", "MyCityconfig"), 
                    AppBundle.getInstance().loadpropertyfile("username", "MyCityconfig"),
                    AppBundle.getInstance().loadpropertyfile("password", "MyCityconfig"));
            
            return con;
        }
        catch(Exception e)
        {
            e.printStackTrace();            
            Log.logger.error("Error:", e);
            Log.logger.warn("This is a warning message");
            Log.logger.trace("This message will not be logged since log level is set as DEBUG");
            
            con = null;
        } 
       
       Log.logger.info("DB Connection:" + con);
       
       return con;
    }
            
    //select code here
    public ResultSet codeselect(String sql)
    {     
        Log.logger.info("DatabaseFile-->codeselect()");
        
        try
        {          
            st  = getConnection().createStatement();
            
            rs  = st.executeQuery(sql);            
        }
        catch(Exception e)
        {
            e.printStackTrace();
            Log.logger.error("Error:", e);
            
            rs = null;
        }
                
        return rs;
    }
    
    //insert code here
    public void codeinsert(String sql)
    {      
        Log.logger.info("DatabaseFile-->codeinsert()");
        
        try
        {                      
            st = getConnection().createStatement();
            
            st.executeUpdate(sql);                         
        }
        catch(Exception e)
        {
            e.printStackTrace();
            Log.logger.error("Error:", e);
            Log.logger.warn("This is a warning message");
            Log.logger.trace("This message will not be logged since log level is set as DEBUG");
        }
        finally
        {
            try
            {
                closeStatement(st, con);
            }
            catch(Exception e)
            {
                e.printStackTrace();
                Log.logger.error("Error:", e);
                Log.logger.warn("This is a warning message");
                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
            }
        }
    }
    
    //update code here
    public void codeupdate(String sql)
    {
        Log.logger.info("DatabaseFile-->codeupdate()");
        
        try
        {         
            st = getConnection().createStatement();
            
            st.executeUpdate(sql);            
        }
        catch(Exception e)
        {
            e.printStackTrace();
            Log.logger.error("Error:", e);
            Log.logger.warn("This is a warning message");
            Log.logger.trace("This message will not be logged since log level is set as DEBUG");
        }
        finally
        {
            try
            {
                 closeStatement(st, con);
            }
            catch(Exception e)
            {
                e.printStackTrace();
                Log.logger.error("Error:", e);
                Log.logger.warn("This is a warning message");
                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
            }
        }
    }
    
    //delete code here
    public void codedelete(String sql)
    {   
        Log.logger.info("DatabaseFile-->codedelete()");
        
        try
        {
            st  = getConnection().createStatement();
            
            st.executeUpdate(sql);        
        }
        catch(Exception e)
        {
            e.printStackTrace();
            Log.logger.error("Error:", e);
            Log.logger.warn("This is a warning message");
            Log.logger.trace("This message will not be logged since log level is set as DEBUG");
        }
        finally
        {
            try
            {
                closeStatement(st, con);
            }
            catch(Exception e)
            {
                e.printStackTrace();
                Log.logger.error("Error:", e);
                Log.logger.warn("This is a warning message");
                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
            }
        }
    }
    
    public static void closeStatement(Statement st, Connection con)
    {
            Log.logger.info("DatabaseFile-->closeStatement()");
        
            try
            {
                if(st != null)
                {
                    st.close(); 
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
                Log.logger.error("Error:", e);
                Log.logger.warn("This is a warning message");
                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
            }    
            
             try
            {
                if(con != null)
                {
                    con.close(); 
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
                Log.logger.error("Error:", e);
                Log.logger.warn("This is a warning message");
                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
            }    
    }

    public void closeAllConnection(ResultSet rss) 
    {
        
            Log.logger.info("DatabaseFile-->closeStatement()");
        
            try
            {
                if(st != null)
                {
                    st.close(); 
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
                Log.logger.error("Error:", e);
                Log.logger.warn("This is a warning message");
                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
            }    
            
            try
            {
                if(rss != null)
                {
                    rss.close(); 
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
                Log.logger.error("Error:", e);
                Log.logger.warn("This is a warning message");
                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
            }   
            
            try
            {
                if(rs != null)
                {
                    rs.close(); 
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
                Log.logger.error("Error:", e);
                Log.logger.warn("This is a warning message");
                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
            }   
            
             try
            {
                if(con != null)
                {
                    con.close(); 
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
                Log.logger.error("Error:", e);
                Log.logger.warn("This is a warning message");
                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
            }    
    }
}
