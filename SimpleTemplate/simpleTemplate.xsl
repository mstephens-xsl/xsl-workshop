<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:fn="bbc.local"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output indent="yes" method="xml"/>
    
    <xsl:template match="/footballResults">
        <atom:feed>
            
            <xsl:apply-templates select="footballResult"/>
            
        </atom:feed>
    </xsl:template>
    
    <xsl:template match="footballResult">
        
        <atom:entry>
            <atom:id>tag:bbc.co.uk,/syndication-manager/football/1</atom:id>
            <atom:category term="Sport"/>
            <atom:category term="Football"/>
            <atom:title>
                <xsl:text>Match Results</xsl:text>
            </atom:title>
            <atom:updated>
                <xsl:value-of select="@updateTime"/>
            </atom:updated>
            <atom:summary>
                <xsl:text>Match Results</xsl:text>
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
                                <xsl:value-of select="@date"/>
                            </td>
                        </tr>
                        <tr>
                            <td property="comment">The ground where the match was played.</td>
                            <td property="location">
                                <xsl:value-of select="@location"/>
                            </td>
                            <div property="match">
                                <table vocab="http://www.bbc.co.uk/2012/syndication-manager/" typeof="matchResult">
                                    <!-- Team Information goes here -->
                                </table>
                            </div>
                        </tr>
                    </table>
                </div>
            </atom:content>
        </atom:entry>
    </xsl:template>
    
    <xsl:template match="team">
        
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
                <xsl:value-of select="@name"/>
            </td>
        </tr>
        
    </xsl:template>
    
    
</xsl:stylesheet>