<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://aida.freehep.org/jsp20" prefix="aida"%>
<%@taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@taglib uri="http://glast-ground.slac.stanford.edu/pipeline" prefix="pl" %>
<%@taglib prefix="time" uri="http://srs.slac.stanford.edu/time" %>
<%@ page import="hep.aida.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Data Processing delay</title>    
    </head>
    <body>

<c:set var="debug" value="0"/>

<jsp:useBean id="startTimeBean" class="java.util.Date" />
<jsp:useBean id="endTimeBean" class="java.util.Date" />

<c:set var="startTime" value="${param.startTime}"/>
<c:set var="endTime" value="${param.endTime}"/>
<c:set var="dphours" value="${param.dphours}"/>

<c:if test="${debug == 1}">
    <c:forEach var="p" items="${param}">
        <h3>${p.key} = ${p.value}</h3>
    </c:forEach>
</c:if>

<%-- if no preferences set then no time constraint should be set on the query --%>
<c:if test="${empty firstTimeDPS}">
    <c:set var="dphours" value="${preferences.defaultDPhours}"/>
    <c:set var="sessionDPhours" value="${dphours > 0 ? dphours : ''}" scope="session"/>
    <c:set var="firstTimeDPS" value="notEmpty" scope="session"/>
    <c:set var="selectDPhours" value="${dphours > 0 ? 'true' : 'false'}"/>
    <c:set var="sessionDPstartTime" value="-1" scope="session"/>
    <c:set var="sessionDPendTime" value="-1" scope="session"/>
</c:if>

<c:if test="${param.filter=='Default'}">
    <c:set var="dphours" value="${preferences.defaultDPhours > 0 ? preferences.defaultDPhours : ''}"/>
    <c:set var="sessionDPhours" value="${dphours}" scope = "session"/>
    <c:set var="selectDPhours" value="${dphours > 0 ? 'true' : 'false'}"/>
    <c:set var="startTime" value='-1' />
    <c:set var="endTime" value='-1' />
    <c:set var="sessionDPstartTime" value="-1" scope="session" />
    <c:set var="sessionDPendTime" value="-1" scope="session" />
</c:if>

<c:if test="${param.filter == 'Filter'}">

    <c:set var="selectDPstartTime" value="${!empty startTime && startTime != -1 && startTime != sessionDPstartTime}" scope="session"/>
    <c:set var="selectDPendTime" value="${!empty endTime && endTime != -1 && endTime != sessionDPendTime}" scope="session"/>
    <c:set var="selectDPhours" value="${!empty dphours && dphours != -1 && !selectDPstartTime && !selectDPendTime}"/>
    <c:set var="selectDPstartNone" value="${empty dphours && param.startTime == '-1'}"/>
    <c:set var="selectDPendNone" value="${empty dphours && param.endTime == '-1'}" />

    <c:choose>
        <c:when test="${selectDPstartTime || selectDPendTime}">
            <c:set var="sessionDPhours" value="" scope="session"/>

            <c:if test="${selectDPstartTime}">
                <c:set var="sessionDPstartTime" value="${startTime}" scope="session"/>
            </c:if>
            <c:if test="${selectDPendTime}">
                <c:set var="sessionDPendTime" value="${endTime}" scope="session"/>
            </c:if>
        </c:when>
        <c:when test="${selectDPhours}">
            <c:set var="sessionDPstartTime" value="" scope="session" />
            <c:set var="sessionDPendTime" value="" scope="session" />
            <c:set var="sessionDPhours" value="${dphours}" scope="session" />
        </c:when>
    </c:choose>

    <c:choose>
        <c:when test="${selectDPstartNone == 'true'}">
            <c:set var="sessionDPstartTime" value="-1" scope="session" />
        </c:when>
        <c:when test="${selectDPendNone == 'true'}">
            <c:set var="sessionDPendTime" value="-1" scope="session" />
        </c:when>
    </c:choose>
</c:if>

<form name="DateForm">        
    <table class="filtertable">
        <tr>
            <td><strong>Start</strong> <time:dateTimePicker size="20" name="startTime" shownone="true" showtime="false" format="%b/%e/%y" value="${sessionDPstartTime}"  timezone="PST8PDT"/></td>
            <td><strong>End</strong> <time:dateTimePicker size="20" name="endTime" shownone="true" showtime="false" format="%b/%e/%y" value="${sessionDPendTime}" timezone="PST8PDT"/> </td>
            <td><strong>Hours</strong><br>
            <input type="text" value="${sessionDPhours}" name="dphours" size="5"</input>
            </td>
        </tr>
        <tr>
            <td> <input type="submit" value="Filter" name="filter"><input type="submit" value="Default" name="filter"></td>
        </tr>
    </table>
</form>
    
            <c:if test="${empty dataShownAs}">
                <c:set var="dataShownAs" value="plot" scope="session"/>
            </c:if>
            <c:if test="${!empty param.dataShownAs}">
                <c:set var="dataShownAs" value="${param.dataShownAs}" scope="session"/>
            </c:if>
            Show data as: 
            <c:choose>
                <c:when test="${dataShownAs == 'plot'}"><b>Plot</b> | <a href="?dataShownAs=table">Table</a></c:when>
                <c:otherwise><a href="?dataShownAs=plot">Plot</a> | <b>Table</b></c:otherwise>
            </c:choose>
                <br>
<c:if test="${debug == 0}">
    <sql:query var="data">
            select (GLAST_UTIL.GetDeltaSeconds(dv.registered-to_date('01-JAN-01'))-f.treceive+978307200)/3600+
            (case when 
               (dv.registered>'03-NOV-19 02:00' and dv.registered<'8-MAR-20 02:00') or
               (dv.registered>'04-NOV-18 02:00' and dv.registered<'10-MAR-19 02:00') or
               (dv.registered>'05-NOV-17 02:00' and dv.registered<'11-MAR-18 02:00') or
               (dv.registered>'06-NOV-16 02:00' and dv.registered<'12-MAR-17 02:00') or
               (dv.registered>'01-NOV-15 02:00' and dv.registered<'13-MAR-16 02:00') or
               (dv.registered>'02-NOV-14 02:00' and dv.registered<'08-MAR-15 02:00') or
               (dv.registered>'03-NOV-13 02:00' and dv.registered<'09-MAR-14 02:00') or
               (dv.registered>'04-NOV-12 02:00' and dv.registered<'10-MAR-13 02:00') or
               (dv.registered>'06-NOV-11 02:00' and dv.registered<'11-MAR-12 02:00') or
               (dv.registered>'07-NOV-10 02:00' and dv.registered<'13-MAR-11 02:00') or
               (dv.registered>'01-NOV-09 02:00' and dv.registered<'14-MAR-10 02:00') or 
               (dv.registered>'02-NOV-08 02:00' and dv.registered<'08-MAR-09 02:00') then 8 else 7 end) 
                                                    as SLAC,
            (f.treceive-978307200-n.metavalue)/3600 as NASA,
            n.metavalue as runStart
            from verdataset d
            join datasetversion dv on (d.latestversion=dv.datasetversion)
            join verdatasetmetanumber n on (n.datasetversion=dv.datasetversion and n.metaname='nMetStop')
            join verdatasetlocation l on (dv.masterlocation= l.datasetlocation)
            join isoc_flight.fcopy_incoming f on (
            f.downlink_id=(
            select max (downlink_id)
            from isoc_flight.glastops_downlink_acqsummary a
            where a.startedat= l.runmin and a.scid = 77
            )
            )
            where datasetgroup=39684247 and n.metaValue>239907864.08432
        <c:if test="${sessionDPstartTime > 0  && empty sessionDPhours  }">
            and dv.registered>?
            <jsp:setProperty name="startTimeBean" property="time" value="${sessionDPstartTime}" />
            <sql:dateParam value="${startTimeBean}"/>
        </c:if>
        <c:if test="${sessionDPendTime > 0 && empty sessionDPhours}">
            and dv.registered<?
            <jsp:setProperty name="endTimeBean" property="time" value="${sessionDPendTime}" />
            <sql:dateParam value="${endTimeBean}"/>
        </c:if>
        <c:if test="${sessionDPhours > 0}">
            and dv.registered > ? and dv.registered < ?
            <jsp:setProperty name="startTimeBean" property="time" value="${endTimeBean.time-sessionDPhours*60*60*1000}"/>
            <sql:dateParam value="${startTimeBean}" type="timestamp"/>
            <jsp:setProperty name="endTimeBean" property="time" value="${endTimeBean.time}"/>
            <sql:dateParam value="${endTimeBean}" type="timestamp"/>
        </c:if>
            order by runStart desc
    </sql:query>

    ${aida:clearPlotRegistry(pageContext.session)}

    <c:if test="${data.rowCount < 1}">
        <h3>No Data Found</h3>
    </c:if>

        <c:if test="${data.rowCount > 0}">
            
            <c:choose>
                <c:when test="${dataShownAs == 'plot'}">
        <aida:plotter height="400" width="1000" nx="2">
            <aida:tuple var="tuple" query="${data}"/>    
            <aida:tupleProjection var="lslac" tuple="${tuple}" xprojection="log10(SLAC)" xbins="96" xmin="-2" xmax="3" name="SLAC"/>
            <aida:tupleProjection var="lnasa" tuple="${tuple}" xprojection="log10(NASA)" xbins="96" xmin="-2" xmax="3" name="NASA"/>
            <aida:tupleProjection var="ltotal" tuple="${tuple}" xprojection="log10(SLAC+NASA)" xbins="96" xmin="-2" xmax="3" name="Total"/>
            <aida:tupleProjection var="slac" tuple="${tuple}" xprojection="SLAC" xbins="96" xmin="0" xmax="48" name="SLAC"/>
            <aida:tupleProjection var="nasa" tuple="${tuple}" xprojection="NASA" xbins="96" xmin="0" xmax="48" name="NASA"/>
            <aida:tupleProjection var="total" tuple="${tuple}" xprojection="SLAC+NASA" xbins="96" xmin="0" xmax="48" name="Total"/>
            
            <aida:region title= "Data processing elapsed time per run" >            
                <aida:style>
                    <aida:style type="data">
                        <aida:style type="errorBar">
                            <aida:attribute name="isVisible" value="false"/>
                        </aida:style>
                    </aida:style>
                    <aida:style type="xAxis">
                        <aida:attribute name="label" value="Hours"/>
                    </aida:style>
                </aida:style>               
                <aida:plot var="${slac}">
                    <aida:style>
                        <aida:style type="fill">
                            <aida:attribute name="color" value="red"/>
                            <aida:attribute name="opacity" value="0.5"/>
                        </aida:style>
                    </aida:style>
                </aida:plot>
                <aida:plot var="${nasa}">
                    <aida:style>
                        <aida:style type="fill">
                            <aida:attribute name="color" value="blue"/>
                            <aida:attribute name="opacity" value="0.5"/>
                        </aida:style>
                    </aida:style>
                </aida:plot>
                <aida:plot var="${total}">
                    <aida:style>
                        <aida:style type="fill">
                            <aida:attribute name="color" value="green"/>
                            <aida:attribute name="opacity" value="0.5"/>
                        </aida:style>
                    </aida:style>
                </aida:plot>
            </aida:region>
            <aida:region title= "Data processing elapsed time per run" >            
                <aida:style>
                    <aida:style type="data">
                        <aida:style type="errorBar">
                            <aida:attribute name="isVisible" value="false"/>
                        </aida:style>
                    </aida:style>
                    <aida:style type="xAxis">
                        <aida:attribute name="label" value="log10(Hours)"/>
                    </aida:style>
                </aida:style>               
                <aida:plot var="${lslac}">
                    <aida:style>
                        <aida:style type="fill">
                            <aida:attribute name="color" value="red"/>
                            <aida:attribute name="opacity" value="0.5"/>
                        </aida:style>
                    </aida:style>
                </aida:plot>
                <aida:plot var="${lnasa}">
                    <aida:style>
                        <aida:style type="fill">
                            <aida:attribute name="color" value="blue"/>
                            <aida:attribute name="opacity" value="0.5"/>
                        </aida:style>
                    </aida:style>
                </aida:plot>
                <aida:plot var="${ltotal}">
                    <aida:style>
                        <aida:style type="fill">
                            <aida:attribute name="color" value="green"/>
                            <aida:attribute name="opacity" value="0.5"/>
                        </aida:style>
                    </aida:style>
                </aida:plot>
            </aida:region>
        </aida:plotter>    
    
        <%-- make an average delay per day plot --%>
        <%
        IAnalysisFactory af = IAnalysisFactory.create();
        ITree tree = af.createTreeFactory().create();
        IHistogramFactory hf = af.createHistogramFactory(tree);
        ICloud2D cSLAC = hf.createCloud2D("SLAC");
        ICloud2D cNASA = hf.createCloud2D("NASA");
        ICloud2D cTotal = hf.createCloud2D("Total");
        ITuple tuple = (ITuple) pageContext.getAttribute("tuple");
        tuple.start();
        ITupleColumn.D runStart = (ITupleColumn.D) tuple.column("RUNSTART");
        ITupleColumn.D SLAC = (ITupleColumn.D) tuple.column("SLAC");
        ITupleColumn.D NASA = (ITupleColumn.D) tuple.column("NASA");
        while (tuple.next()) {
            cSLAC.fill(runStart.value(),Math.log10(SLAC.value()));
            cNASA.fill(runStart.value(),Math.log10(NASA.value()));
            cTotal.fill(runStart.value(),Math.log10(SLAC.value()+NASA.value()));
        }
        pageContext.setAttribute("cSLAC",cSLAC);
        pageContext.setAttribute("cNASA",cNASA);
        pageContext.setAttribute("cTotal",cTotal);
        %>
        <aida:plotter height="400" width="1000">  
            <aida:region title= "Data processing elapsed time per run vs MET" > 
                <aida:style>
                    <aida:style type="yAxis">
                        <aida:attribute name="label" value="log10(Hours)"/>
                    </aida:style>
                    <aida:style type="xAxis">
                        <aida:attribute name="label" value="MET"/>
                    </aida:style>
                </aida:style>
                <aida:plot var="${cSLAC}">
                    <aida:style>
                        <aida:style type="marker">
                            <aida:attribute name="size" value="2"/>
                            <aida:attribute name="color" value="red"/>
                            <aida:attribute name="shape" value="box"/>
                            <aida:attribute name="opacity" value="0.5"/>
                        </aida:style>
                    </aida:style>
                </aida:plot>
                <aida:plot var="${cNASA}">
                    <aida:style>
                        <aida:style type="marker">
                            <aida:attribute name="size" value="2"/>
                            <aida:attribute name="color" value="blue"/>
                            <aida:attribute name="shape" value="box"/>
                            <aida:attribute name="opacity" value="0.5"/>
                        </aida:style>
                    </aida:style>
                </aida:plot>
                <aida:plot var="${cTotal}">
                    <aida:style>
                        <aida:style type="marker">
                            <aida:attribute name="size" value="2"/>
                            <aida:attribute name="color" value="green"/>
                            <aida:attribute name="shape" value="box"/>
                            <aida:attribute name="opacity" value="0.5"/>
                        </aida:style>
                    </aida:style>
                </aida:plot>
            </aida:region>
        </aida:plotter>
                    
                </c:when>
                <c:otherwise>
                        <table>
    <tr>
    <td>Run Start</td>
    <td>SLAC</td>
    <td>NASA</td>
    </tr>
    <c:forEach var="p" items="${data.rows}">
    <tr>
    <td>${p.runStart}</td>
    <td>${p.SLAC}</td>
    <td>${p.NASA}</td>
    </tr>
    </c:forEach>
    </table>


                </c:otherwise>
            </c:choose>
            
            
            
</c:if>

        <h2>Notes</h2>
        <ul>
        <li>NASA = Hours elapsed between end of data taking for run and ALL data for that run arriving at SLAC.
        <li>SLAC = Hours elapsed between ALL data for that run arriving at SLAC and data being registered in data catalog.
        <li>Y axis of scatter plot and X axis of second histogram show log10(hours) so that both body of distribution and tails can be seen.
        <table>
            <tr><th>Log10(Hours)</th><th>Time</th></tr>
            <tr><td>-1</td><td>6 minutes</td></tr>
            <tr><td>-0.5</td><td>20 minutes</td></tr>
            <tr><td>0</td><td>1 hour</td></tr>
            <tr><td>0.5</td><td>3 hours</td></tr>
            <tr><td>1</td><td>10 hours</td></tr>
            <tr><td>1.5</td><td>30 hours</td></tr>
            <tr><td>2</td><td>4 days</td></tr>
            <tr><td>2.5</td><td>13 days</td></tr>
        </table>   

  </c:if>
    </body>
</html>
