<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://glast-ground.slac.stanford.edu/pipeline" prefix="pl" %>

<table class="pageHeader">
   <tr>
      <td valign="top" rowspan="2">
         <a href="index.jsp"><img src="http://glast-ground.slac.stanford.edu/Commons/logoServlet.jsp?title=Pipeline+II"/></a>
      </td>
      <td align="right" valign="top">
         <a href="releasenotes.jsp">Version 2.0.3</a>
         |
         Jira <a href="http://jira.slac.stanford.edu/browse/PFE">(Front-End)</a> <a href="http://jira.slac.stanford.edu/browse/PII">(Server)</a>
         |
         <a href="http://confluence.slac.stanford.edu/display/ds/Pipeline+II+User%27s+Guide">Help</a>
      </td>
   </tr>
   <tr>
      <td align="right" valign="bottom">
         <p><jsp:useBean id="now" class="java.util.Date" />
         Page updated: <fmt:formatDate value="${now}" pattern="MM/dd/yyyy HH:mm:ss"/> </p>
         <c:choose>
            <c:when test="${empty userName}">
               <p><a href="?login=true${optionString}">Login</a></p>
            </c:when>

            <c:otherwise>
               <p>User: ${userName}&nbsp;.&nbsp;<a href="?login=false">Logout</a></p>
            </c:otherwise>
         </c:choose>
         <p>Mode: <b><c:out value="${mode}" default="Prod"/></b> Switch to: [ <a href="index.jsp?mode=prod">Prod</a> | <a href="index.jsp?mode=dev">Dev</a> | <a href="index.jsp?mode=test">Test</a> ]</p>
         <p><a href="index.jsp">Task List</a>&nbsp;.&nbsp;<a href="logViewer.jsp">Message Viewer</a>&nbsp;.&nbsp;<a href="JobProcessingStats.jsp">Usage Plots</a>&nbsp;.&nbsp;<a href="admin.jsp?login=true">Pipeline Admin</a></p>
      </td>
   </tr>
</table>

<c:if test="${!empty task}">
   <div class="breadCrumb">
      <a href="index.jsp">summary</a>
      / ${pl:linkToTasks(taskNamePath,taskPath," / ","task.jsp?task=")}
      <c:if test="${!empty processName}">/ <a href="process.jsp?process=${process}">${processName}</a> </c:if>
   </div>
</c:if>