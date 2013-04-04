package org.srs.pipeline.web.taglib.admin;

import java.sql.Connection;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import org.srs.pipeline.client.PipelineClient;
import org.srs.pipeline.web.util.*;
import org.srs.pipeline.web.util.ConnectionManager;
/**
 * A tag for uploading xml files to the pipeline database
 * @author tonyj
 */
public class CreateStream extends SimpleTagSupport
{
   private String task;
   private String args;
   private int stream; // Note:  This is actually the Stream ID
   private String var;
   
   public void doTag() throws JspException
   {
      try
      {
         Connection conn = ConnectionManager.getConnection((PageContext) getJspContext(), null);
         try
         {
            PipelineClient client = new PipelineClient(conn);
            int streamNumber = client.createStream(task,stream,args);
            if (var != null) getJspContext().setAttribute(var,streamNumber);
         }
         finally
         {
            conn.close();
         }
      }
      catch (Exception x)
      {
         throw new JspException("Create stream failed",x);
      }
   }
   public void setTask(String task)
   {
      this.task = task;
   }
   public void setStream(int stream) // Note:  Actually the Stream ID
   {
      this.stream = stream;
   }
   public void setArgs(String args)
   {
      this.args = args;
   }
   public void setVar(String var)
   {
      this.var = var;
   }
}
