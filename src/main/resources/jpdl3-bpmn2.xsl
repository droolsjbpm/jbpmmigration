<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:jpdl="urn:jbpm.org:jpdl-3.2" xmlns="http://www.omg.org/spec/BPMN/20100524/MODEL">

<xsl:output method="xml"/>

    <xsl:template match="/">
    	<definitions xmlns="http://www.omg.org/spec/BPMN/20100524/MODEL"
    		xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI"
            xmlns:dc="http://www.omg.org/spec/DD/20100524/DC" 
            xmlns:di="http://www.omg.org/spec/DD/20100524/DI" 
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            targetNamespace="http://www.jbpm.org/">
	    	<xsl:attribute name="id">
	      		<xsl:value-of select="jpdl:process-definition/@name"/>
      		</xsl:attribute>
            <xsl:attribute name="name">
                <xsl:value-of select="jpdl:process-definition/@name" />
            </xsl:attribute>
	     	<xsl:apply-templates select="jpdl:process-definition"/>
		</definitions>
	</xsl:template>
    
	<xsl:template match="jpdl:process-definition">
	    <process>
	    	<xsl:attribute name="id">
	      		<xsl:value-of select="@name"/><xsl:text>Process</xsl:text>
      		</xsl:attribute>
	      	<xsl:attribute name="name">
	      		<xsl:value-of select="@name"/>
      		</xsl:attribute>

      	<xsl:apply-templates/>
	    </process>

	</xsl:template>
	
    <xsl:template match="jpdl:start-state">
        <startEvent>
            <xsl:attribute name="name">
                <xsl:value-of select="@name" />
            </xsl:attribute>
            <xsl:attribute name="id">
                <xsl:value-of select="@name" />
            </xsl:attribute>
        </startEvent>

		<xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="jpdl:end-state">
        <endEvent>
            <xsl:attribute name="name">
                <xsl:value-of select="@name" />
            </xsl:attribute>
            <xsl:attribute name="id">
                <xsl:value-of select="@name" />
            </xsl:attribute>
        </endEvent>
    </xsl:template>

    <xsl:template match="jpdl:node">
        <scriptTask>
            <xsl:attribute name="name">
                <xsl:value-of select="@name" />
            </xsl:attribute>
            <xsl:attribute name="id">
                <xsl:value-of select="@name" />
            </xsl:attribute>
        </scriptTask>

		<xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="jpdl:state">
		<serviceTask>
			<xsl:attribute name="name">
				<xsl:value-of select="@name" />
			</xsl:attribute>
			<xsl:attribute name="id">
                <xsl:value-of select="@name" />
            </xsl:attribute>
		</serviceTask>

		<xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="jpdl:decision">
		<complexGateway>
			<xsl:attribute name="name">
				<xsl:value-of select="@name" />
			</xsl:attribute>
			<xsl:attribute name="id">
                <xsl:value-of select="@name" />
            </xsl:attribute>
		</complexGateway>

		<xsl:for-each select="jpdl:transition">
	        <sequenceFlow>
	        	<xsl:attribute name="id">
	        		<xsl:text>flow_</xsl:text>
	        		<xsl:value-of select="../@name" />
	        		<xsl:value-of select='position()' />
	        	</xsl:attribute>
	            <xsl:attribute name="sourceRef">
	                <xsl:value-of select="../@name" />
	            </xsl:attribute>
	            <xsl:attribute name="targetRef">
	                <xsl:value-of select="@to" />
	            </xsl:attribute>
	        </sequenceFlow>
  		</xsl:for-each>

    </xsl:template>


    <xsl:template match="jpdl:transition">
        <sequenceFlow>
        	<xsl:attribute name="id">
        		<xsl:text>flow_</xsl:text>
        		<xsl:value-of select="../@name" />
        	</xsl:attribute>
            <xsl:attribute name="sourceRef">
                <xsl:value-of select="../@name" />
            </xsl:attribute>
            <xsl:attribute name="targetRef">
                <xsl:value-of select="@to" />
            </xsl:attribute>
        </sequenceFlow>
    </xsl:template>

     <!-- Strip the white space from the result. -->
    <xsl:template match="text()">
        <xsl:value-of select="normalize-space()" />
    </xsl:template>
 
</xsl:stylesheet>