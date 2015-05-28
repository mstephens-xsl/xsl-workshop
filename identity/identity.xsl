<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="team">
        <footballTeam>
            <xsl:apply-templates select="@*|node()"/>
        </footballTeam>
    </xsl:template>
    
    <xsl:template match="@side"/>
</xsl:stylesheet>