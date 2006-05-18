<%@page contentType="text/xml"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema targetNamespace="http://glast-ground.slac.stanford.edu/pipeline" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://glast-ground.slac.stanford.edu/pipeline" elementFormDefault="qualified" version="1.1">
   <xs:element name="pipeline">
      <xs:complexType>
         <xs:sequence>
            <xs:element name="name" type="TaskNameType"/>
            <xs:element name="type" type="TaskType"/>
            <xs:element name="notation" type="NotationType" minOccurs="0" maxOccurs="1"/>
            <xs:element name="dataset-base-path" type="BasePathType"/>
            <xs:element name="run-log-path" type="RunLogPathType"/>
            <xs:element ref="executable" maxOccurs="unbounded"/>
            <xs:element ref="batch-job-configuration" maxOccurs="unbounded"/>
            <xs:element ref="file" minOccurs="0" maxOccurs="unbounded"/>
            <xs:element ref="foreign-input-file" minOccurs="0" maxOccurs="unbounded"/>
            <xs:element ref="processing-step" maxOccurs="unbounded"/>
         </xs:sequence>
      </xs:complexType>
   </xs:element>
   <xs:simpleType name="TaskNameType">
      <xs:restriction base="xs:string">
         <xs:minLength value="1"/>
         <xs:maxLength value="30"/>
      </xs:restriction>
   </xs:simpleType>
   <xs:simpleType name="NotationType">
      <xs:restriction base="xs:string">
         <xs:minLength value="0"/>
         <xs:maxLength value="200"/>
      </xs:restriction>
   </xs:simpleType>
   <xs:simpleType name="TaskType">
      <xs:restriction base="xs:NMTOKEN">
         <sql:query var="data">select TASKTYPENAME from TASKTYPE</sql:query>
         <c:forEach var="row" items="${data.rows}">
            <xs:enumeration value="${row.TASKTYPENAME}"/>
         </c:forEach>   
      </xs:restriction>
   </xs:simpleType>
   <xs:simpleType name="BasePathType">
      <xs:restriction base="xs:string">
         <xs:minLength value="0"/>
         <xs:maxLength value="200"/>
      </xs:restriction>
   </xs:simpleType>
   <xs:simpleType name="RunLogPathType">
      <xs:restriction base="xs:string">
         <xs:minLength value="1"/>
         <xs:maxLength value="200"/>
      </xs:restriction>
   </xs:simpleType>
   <!-- Application -->
   <xs:element name="executable" nillable="false">
      <xs:complexType>
         <xs:simpleContent>
            <xs:extension base="ExecutablePathType">
               <xs:attribute name="name" type="ExecutableNameType" use="required"/>
               <xs:attribute name="version" type="ExecutableVersionType" use="required"/>
            </xs:extension>
         </xs:simpleContent>
      </xs:complexType>
   </xs:element>
   <xs:simpleType name="ExecutablePathType">
      <xs:restriction base="xs:string">
         <xs:minLength value="1"/>
         <xs:maxLength value="200"/>
      </xs:restriction>
   </xs:simpleType>
   <xs:simpleType name="ExecutableNameType">
      <xs:restriction base="xs:string">
         <xs:minLength value="1"/>
         <xs:maxLength value="20"/>
      </xs:restriction>
   </xs:simpleType>
   <xs:simpleType name="ExecutableVersionType">
      <xs:restriction base="xs:string">
         <xs:minLength value="1"/>
         <xs:maxLength value="20"/>
      </xs:restriction>
   </xs:simpleType>
	<!-- JobConfiguration-->
   <xs:element name="batch-job-configuration">
      <xs:complexType>
         <xs:sequence>
            <xs:element name="working-directory" type="WorkingDirectoryType"/>
            <xs:element name="log-file-path" type="LogFilePathType"/>
         </xs:sequence>
         <xs:attribute name="name" type="xs:string" use="required"/>
         <xs:attribute name="queue" type="BatchQueue" use="required"/>
         <xs:attribute name="group" type="BatchGroup" use="required"/>
      </xs:complexType>
   </xs:element>
   <xs:simpleType name="WorkingDirectoryType">
      <xs:restriction base="xs:string">
         <xs:minLength value="0"/>
         <xs:maxLength value="200"/>
      </xs:restriction>
   </xs:simpleType>
   <xs:simpleType name="LogFilePathType">
      <xs:restriction base="xs:string">
         <xs:minLength value="1"/>
         <xs:maxLength value="200"/>
      </xs:restriction>
   </xs:simpleType>
   <xs:simpleType name="BatchQueue">
      <xs:restriction base="xs:NMTOKEN">
         <sql:query var="data">select BATCHQUEUENAME from BATCHQUEUE</sql:query>
         <c:forEach var="row" items="${data.rows}">
            <xs:enumeration value="${row.BATCHQUEUENAME}"/>
         </c:forEach>  
      </xs:restriction>
   </xs:simpleType>
   <xs:simpleType name="BatchGroup">
      <xs:restriction base="xs:NMTOKEN">
         <sql:query var="data">select BATCHGROUPNAME from BATCHGROUP</sql:query>
         <c:forEach var="row" items="${data.rows}">
            <xs:enumeration value="${row.BATCHGROUPNAME}"/>
         </c:forEach> 
      </xs:restriction>
   </xs:simpleType>
   <!-- Dataset -->
   <xs:element name="file">
      <xs:complexType>
          <xs:sequence>
            <xs:element name="notation" type="NotationType" minOccurs="0" maxOccurs="1"/>
            <xs:element name="path" type="PathType"/>
         </xs:sequence>
         <xs:attribute name="name" type="DatasetNameType" use="required"/>
         <xs:attribute name="type" type="DatasetType" use="required"/>
         <xs:attribute name="file-type" type="DatasetFileType" use="required"/>
      </xs:complexType>
   </xs:element>
   <xs:simpleType name="PathType">
      <xs:restriction base="xs:string">
         <xs:minLength value="1"/>
         <xs:maxLength value="200"/>
      </xs:restriction>
   </xs:simpleType>
   <xs:element name="foreign-input-file">
      <xs:complexType>
         <xs:simpleContent>
            <xs:extension base="xs:string">
               <xs:attribute name="name" type="DatasetNameType" use="required"/>
               <xs:attribute name="pipeline" type="TaskNameType" use="required"/>
               <xs:attribute name="file" type="DatasetNameType" use="required"/>
            </xs:extension>
         </xs:simpleContent>
      </xs:complexType>
   </xs:element>
   <xs:simpleType name="DatasetNameType">
      <xs:restriction base="xs:string">
         <xs:minLength value="1"/>
         <xs:maxLength value="30"/>
      </xs:restriction>
   </xs:simpleType>
   <xs:simpleType name="DatasetType">
      <xs:restriction base="xs:NMTOKEN">
         <sql:query var="data">select DSTYPENAME from DSTYPE</sql:query>
         <c:forEach var="row" items="${data.rows}">
            <xs:enumeration value="${row.DSTYPENAME}"/>
         </c:forEach> 
      </xs:restriction>
   </xs:simpleType>
   <xs:simpleType name="DatasetFileType">
      <xs:restriction base="xs:NMTOKEN">
         <sql:query var="data">select DSFILETYPENAME from DSFILETYPE</sql:query>
         <c:forEach var="row" items="${data.rows}">
            <xs:enumeration value="${row.DSFILETYPENAME}"/>
         </c:forEach> 
      </xs:restriction>
   </xs:simpleType>
   <xs:element name="processing-step">
      <xs:complexType>
         <xs:sequence>
            <xs:element name="notation" type="NotationType" minOccurs="0" maxOccurs="1"/>
            <xs:element name="input-file" minOccurs="0" maxOccurs="unbounded">
               <xs:complexType>
                  <xs:sequence>
                     <xs:element name="notation" type="NotationType" minOccurs="0" maxOccurs="1"/>
                  </xs:sequence>
                  <xs:attribute name="name" type="xs:string" use="required"/>
               </xs:complexType>
            </xs:element>
            <xs:element name="output-file" minOccurs="0" maxOccurs="unbounded">
               <xs:complexType>
                  <xs:sequence>
                     <xs:element name="notation" type="NotationType" minOccurs="0" maxOccurs="1"/>
                  </xs:sequence>
                  <xs:attribute name="name" type="xs:string" use="required"/>
               </xs:complexType>
            </xs:element>
         </xs:sequence>
         <xs:attribute name="name" type="xs:string" use="required"/>
         <xs:attribute name="executable" type="xs:string" use="required"/>
         <xs:attribute name="batch-job-configuration" type="xs:string" use="required"/>
      </xs:complexType>
   </xs:element>
</xs:schema>
