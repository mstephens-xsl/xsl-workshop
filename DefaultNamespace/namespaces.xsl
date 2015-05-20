<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:fn="bbc.local"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output indent="yes" method="xml"/>
    
    <xsl:template match="/footballResults">
        <atom:feed>
            <xsl:call-template name="metadata"/>
        </atom:feed>
    </xsl:template>
    
    <xsl:template name="metadata">
        <atom:title>Syndication Manager</atom:title>
        <atom:subtitle>Generated at <xsl:value-of select="current-date()"/></atom:subtitle>
        <atom:link href="http://www.bbc.co.uk/syndication-manager/" rel="self"/>
        <atom:link href="http://www.bbc.co.uk/syndication-manager/"/>
        <atom:id>tag:bbc.co.uk,<xsl:value-of select="generate-id()"
        />:/syndication-manager/</atom:id>
        <atom:updated>
            <xsl:value-of select="current-dateTime()"/>
        </atom:updated>
        <atom:author>
            <atom:name>Syndication Manager</atom:name>
            <atom:email>syndication-manager@bbc.co.uk</atom:email>
        </atom:author>
    </xsl:template>
    
    <xsl:template match="text()"/>
</xsl:stylesheet>