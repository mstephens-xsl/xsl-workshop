<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:atom="http://www.w3.org/2005/Atom"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output indent="yes"/>
    
    <xsl:template match="/footballResults">
        <atom:feed>
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
            <xsl:for-each select="footballResult">
                <atom:entry>
                    <atom:content type="xhtml">
                        <div>
                            <table typeof="matchDetails">
                                <tr>
                                    <td property="comment">The date of the match</td>
                                    <td property="startDate"><xsl:value-of select="//@date"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td property="comment">The ground where the match was played.</td>
                                    <td property="location"><xsl:value-of select="//footballResults//@location"/></td>
                                    <div property="match">
                                        <table vocab="http://www.bbc.co.uk/2012/syndication-manager/"
                                            typeof="matchResult"/>
                                        <xsl:for-each select="team">
                                            <tr property="team">
                                                <td property="name">
                                                    <xsl:value-of select="//@name"/>
                                                </td>
                                                <td property="goals">
                                                    <xsl:value-of select="//footballResult//team//@goalsScored"/>
                                                </td>
                                                <td property="summary">
                                                    <xsl:value-of select="//footballResult//summary/text()"/>
                                                </td>
                                                <td property="homeOrAway">
                                                    <xsl:value-of select="//footballResult//team//@name"/>
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </div>
                                </tr>
                            </table>
                        </div>
                    </atom:content>
                </atom:entry>
            </xsl:for-each>
        </atom:feed>
    </xsl:template>
</xsl:stylesheet>