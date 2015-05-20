<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:fn="bbc.local"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output indent="yes" method="xml"/>
    
    <xsl:variable name="lookup">
        <value code="H" name="Home"/>
        <value code="A" name="Away"/>
    </xsl:variable>
    
    <xsl:template match="/footballResults">
        <atom:feed>
            <xsl:call-template name="metadata"/>
            
            <xsl:apply-templates select="footballResult"/>
            
        </atom:feed>
    </xsl:template>
    
    <xsl:template match="footballResult">
        <xsl:variable name="currentMatch" select="." as="element()"/>
        <xsl:variable name="home" select="fn:getTeam('H')" as="xs:string"/>
        <xsl:variable name="away" select="fn:getTeam('A')" as="xs:string"/>
        
        <atom:entry>
            <atom:id>tag:bbc.co.uk,/syndication-manager/football/1</atom:id>
            <atom:category term="Sport"/>
            <atom:category term="Football"/>
            <atom:title>
                <xsl:value-of select="$home"/>
                <xsl:text> v </xsl:text>
                <xsl:value-of select="$away"/>
            </atom:title>
            <atom:updated>
                <xsl:value-of select="$currentMatch/@updateTime"/>
            </atom:updated>
            <atom:summary>
                <xsl:value-of select="concat($home, ' v ', $away, ' Results')"/>
            </atom:summary>
            <atom:author>
                <atom:name>Syndication Manager</atom:name>
            </atom:author>
            <atom:content type="xhtml">
                <div>
                    <table typeof="matchDetails">
                        <tr>
                            <td property="comment">The date of the match</td>
                            <td property="startDate">
                                <xsl:value-of select="$currentMatch/@date"/>
                            </td>
                        </tr>
                        <tr>
                            <td property="comment">The ground where the match was played.</td>
                            <td property="location">
                                <xsl:value-of select="$currentMatch/@location"/>
                            </td>
                        </tr>
                    </table>
                    <div property="match">
                        <table vocab="http://www.bbc.co.uk/2012/syndication-manager/" typeof="matchResult">
                            <xsl:apply-templates select="team"/>
                        </table>
                    </div>
                </div>
            </atom:content>
        </atom:entry>
    </xsl:template>
    
    <xsl:template match="team">
        <xsl:variable name="homeOrAwayText" select="$lookup/value[@code=current()/@side]/@name"/>
        
        <tr property="side{position()}">
            <td property="name">
                <xsl:value-of select="@name"/>
            </td>
            <td property="goals">
                <xsl:value-of select="@goalsScored"/>
            </td>
            <td property="summary">
                <xsl:value-of select="summary/text()"/>
            </td>
            <td property="homeOrAway">
                <xsl:value-of select="$homeOrAwayText"/>
            </td>
        </tr>
        
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
    
    <xsl:function name="fn:getTeam" as="xs:string">
        <!-- H or A -->
        <xsl:param name="side"/>
        
        <xsl:choose>
            <xsl:when test="$side='H'">
                <xsl:text>Home</xsl:text>
            </xsl:when>
            <xsl:when test="$side='A'">
                <xsl:text>Away</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Not Found</xsl:text>
                <xsl:message>Term not found</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
</xsl:stylesheet>