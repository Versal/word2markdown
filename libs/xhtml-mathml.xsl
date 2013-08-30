<!--
    $Id: xhtml-mathml.xsl,v 1.4 2007/05/11 00:58:31 David Carlisle Exp $

Copyright David Carlisle 2007.

Use and distribution of this code are permitted under the terms of the <a
href="http://www.w3.org/Consortium/Legal/copyright-software-19980720"
>W3C Software Notice and License</a>.
-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:d="data:,dpc"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:h="http://www.w3.org/1999/xhtml"
		xmlns:saxon="http://saxon.sf.net/"
		xmlns:mml="http://www.w3.org/1998/Math/MathML"
		xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
		exclude-result-prefixes="d h xs saxon m">

  <xsl:import href="omml2mml.xsl"/>
<!--  <xsl:import href="OMML2MML.XSL"/> -->

  <xsl:param name="pmathml" select="'pmathml.xsl'"/>
  <xsl:param name="dtd" select="false()"/>
  <xsl:output method="xhtml" indent="yes" encoding="US-ASCII"/>


  <xsl:template match="/">
    <xsl:if test="$pmathml">
    <xsl:processing-instruction name="xml-stylesheet"
				>type="text/xsl" href="<xsl:value-of select="$pmathml"/>"</xsl:processing-instruction>
    </xsl:if>
    <xsl:if test="$dtd">
    <xsl:text disable-output-escaping="yes"><![CDATA[
<!DOCTYPE html SYSTEM "]]></xsl:text>
<xsl:value-of select="$dtd"/>
<xsl:text disable-output-escaping="yes"><![CDATA[" [
<!ENTITY % MATHML.prefixed      "INCLUDE" >
<!ENTITY % MATHML.prefix        "mml" >
]>
]]>
    </xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="h:*">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@*">
    <xsl:copy-of select=".[namespace-uri(.)=('')]"/>
  </xsl:template>


  <xsl:template match="comment()[matches(.,'^\[if gte msEquation 12\]>&lt;m:oMath(Para)?')]">
    <mml:math>
      <xsl:if test="matches(.,'^\[if gte msEquation 12\]>&lt;m:oMathPara')">
	<xsl:attribute name="display">block</xsl:attribute>
      </xsl:if>
      <xsl:variable name="mml" as="element()*">
      <xsl:apply-templates select="saxon:parse(
				   concat('&lt;x xmlns:m=''http://schemas.openxmlformats.org/officeDocument/2006/math''>',
				   substring-before(replace(.,'&lt;/?span[^&lt;&gt;]*>',''),'&lt;![endif]'),
				   '&lt;/x>'))/x"/>
      </xsl:variable>
      <xsl:copy-of select="$mml" copy-namespaces="no"/>
    </mml:math>
  </xsl:template>

  <xsl:template match="h:img[../preceding-sibling::node()[1]/self::comment()[matches(.,'^\[if gte msEquation 12\]>&lt;m:oMath(Para)?')]]"/>


<!-- that should be it but some bug fixes (reported to MS) in omml2mml.xsl -->

	<xsl:template match="m:e | m:den | m:num | m:lim | m:sup | m:sub">
		<xsl:choose>

			<!-- If there is no scriptLevel speified, just call through -->
			<xsl:when test="not(m:argPr[last()]/m:scrLvl/@m:val)">
				<!-- DPC make sure only one element returned -->
				<mml:mrow><xsl:apply-templates select="*" /></mml:mrow>
			</xsl:when>

			<!-- Otherwise, create an mstyle and set the script level -->
			<xsl:otherwise>
				<mml:mstyle>
					<xsl:attribute name="scriptlevel">
						<xsl:value-of select="m:argPr[last()]/m:scrLvl/@m:val" />
					</xsl:attribute>
					<xsl:apply-templates select="*" />
				</mml:mstyle>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- avoid printing fnames twice -->
	<xsl:template match="m:func">
		<mml:mrow>
			<mml:mrow>
			  <xsl:apply-templates select="m:fName[1]/*" />
			</mml:mrow>
			<mml:mo>&#x02061;</mml:mo>
			<xsl:apply-templates select="m:fName[1]/following-sibling::*" />
		</mml:mrow>
	</xsl:template>


<!-- m:r reconstituted from Word comments don't have character data in m:t it is directly i m:r (and style information is in interleaved span and i elements, weird but true -->

<!--
	Changed by Versal - Jan Paul Posma:
	This used to have a translate call, but that removed spaces that we didn't want to have removed.

	<xsl:template match="m:r[not(.//m:t)]">
				<xsl:for-each select=".//text()[translate(.,' &#10;&amp;','')]">
					<xsl:call-template name="ParseMt">
						<xsl:with-param name="sToParse" select="translate(.,' &#10;&amp;','')" />
						<xsl:with-param name="scr" select="../m:rPr[last()]/m:scr/@m:val" />
						<xsl:with-param name="sty" select="../m:rPr[last()]/m:sty/@m:val" />
						<xsl:with-param name="nor" select="../m:rPr[last()]/m:nor/@m:val" />
					</xsl:call-template>
				</xsl:for-each>
	</xsl:template>
-->

	<xsl:template match="m:r[not(.//m:t)]">
				<xsl:for-each select=".//text()[.]">
					<xsl:call-template name="ParseMt">
						<xsl:with-param name="sToParse" select="." />
						<xsl:with-param name="scr" select="../m:rPr[last()]/m:scr/@m:val" />
						<xsl:with-param name="sty" select="../m:rPr[last()]/m:sty/@m:val" />
						<xsl:with-param name="nor" select="../m:rPr[last()]/m:nor/@m:val" />
					</xsl:call-template>
				</xsl:for-each>
	</xsl:template>



<!--
MS stylesheet uses DOE which is (a) unevil, (b) non necessary, and (c) breaks the pass through a temporay tree to get rid of namespace nodes.
repeat the templates here without doe (and without double quoting amp)
-->
	<xsl:template match="m:nary">
		<xsl:variable name="sLowerCaseSubHide">
			<xsl:choose>
				<xsl:when test="count(m:naryPr[last()]/m:subHide) = 0">
					<xsl:text>off</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="translate(m:naryPr[last()]/m:subHide/@m:val,
	                                  'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
	                                  'abcdefghijklmnopqrstuvwxyz')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="sLowerCaseSupHide">
			<xsl:choose>
				<xsl:when test="count(m:naryPr[last()]/m:supHide) = 0">
					<xsl:text>off</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="translate(m:naryPr[last()]/m:supHide/@m:val,
	                                  'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
	                                  'abcdefghijklmnopqrstuvwxyz')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="not($sLowerCaseSupHide='off') and
			                not($sLowerCaseSubHide='off')">
				<mml:mo>
					<xsl:choose>
						<xsl:when test="not(m:naryPr[last()]/m:chr/@m:val) or
			                            m:naryPr[last()]/m:chr/@m:val=''">
						  <xsl:text disable-output-escaping="no">&#x222b;</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="m:naryPr[last()]/m:chr/@m:val" />
						</xsl:otherwise>
					</xsl:choose>
				</mml:mo>
			</xsl:when>
			<xsl:when test="not($sLowerCaseSubHide='off')">
				<xsl:choose>
					<xsl:when test="m:naryPr[last()]/m:limLoc/@m:val='subSup'">
						<mml:msup>
							<mml:mo>
								<xsl:choose>
									<xsl:when test="not(m:naryPr[last()]/m:chr/@m:val) or
			                                        m:naryPr[last()]/m:chr/@m:val=''">
										<xsl:text disable-output-escaping="no">&#x222b;</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="m:naryPr[last()]/m:chr/@m:val" />
									</xsl:otherwise>
								</xsl:choose>
							</mml:mo>
							<xsl:apply-templates select="m:sup[1]" />
						</mml:msup>
					</xsl:when>
					<xsl:otherwise>
						<mml:mover>
							<mml:mo>
								<xsl:choose>
									<xsl:when test="not(m:naryPr[last()]/m:chr/@m:val) or
			                                        m:naryPr[last()]/m:chr/@m:val=''">
										<xsl:text disable-output-escaping="no">&#x222b;</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="m:naryPr[last()]/m:chr/@m:val" />
									</xsl:otherwise>
								</xsl:choose>
							</mml:mo>
							<xsl:apply-templates select="m:sup[1]" />
						</mml:mover>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="not($sLowerCaseSupHide='off')">
				<xsl:choose>
					<xsl:when test="m:naryPr[last()]/m:limLoc/@m:val='subSup'">
						<mml:msub>
							<mml:mo>
								<xsl:choose>
									<xsl:when test="not(m:naryPr[last()]/m:chr/@m:val) or
			                                        m:naryPr[last()]/m:chr/@m:val=''">
										<xsl:text disable-output-escaping="no">&#x222b;</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="m:naryPr[last()]/m:chr/@m:val" />
									</xsl:otherwise>
								</xsl:choose>
							</mml:mo>
							<xsl:apply-templates select="m:sub[1]" />
						</mml:msub>
					</xsl:when>
					<xsl:otherwise>
						<mml:munder>
							<mml:mo>
								<xsl:choose>
									<xsl:when test="not(m:naryPr[last()]/m:chr/@m:val) or
			                        m:naryPr[last()]/m:chr/@m:val=''">
										<xsl:text disable-output-escaping="no">&#x222b;</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="m:naryPr[last()]/m:chr/@m:val" />
									</xsl:otherwise>
								</xsl:choose>
							</mml:mo>
							<xsl:apply-templates select="m:sub[1]" />
						</mml:munder>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="m:naryPr[last()]/m:limLoc/@m:val='subSup'">
						<mml:msubsup>
							<mml:mo>
								<xsl:choose>
									<xsl:when test="not(m:naryPr[last()]/m:chr/@m:val) or
			                                        m:naryPr[last()]/m:chr/@m:val=''">
										<xsl:text disable-output-escaping="no">&#x222b;</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="m:naryPr[last()]/m:chr/@m:val" />
									</xsl:otherwise>
								</xsl:choose>
							</mml:mo>
							<xsl:apply-templates select="m:sub[1]" />
							<xsl:apply-templates select="m:sup[1]" />
						</mml:msubsup>
					</xsl:when>
					<xsl:otherwise>
						<mml:munderover>
							<mml:mo>
								<xsl:choose>
									<xsl:when test="not(m:naryPr[last()]/m:chr/@m:val) or
			                                        m:naryPr[last()]/m:chr/@m:val=''">
										<xsl:text disable-output-escaping="no">&#x222b;</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="m:naryPr[last()]/m:chr/@m:val" />
									</xsl:otherwise>
								</xsl:choose>
							</mml:mo>
							<xsl:apply-templates select="m:sub[1]" />
							<xsl:apply-templates select="m:sup[1]" />
						</mml:munderover>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<mml:mrow>
			<xsl:apply-templates select="m:e[1]" />
		</mml:mrow>
	</xsl:template>


	<xsl:template name="CreateGroupChr">
		<xsl:variable name="sLowerCasePos" select="translate(m:groupChrPr[last()]/m:pos/@m:val,
		                                                     'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		                                                     'abcdefghijklmnopqrstuvwxyz')" />
		<xsl:choose>
			<xsl:when test="$sLowerCasePos!='top' or
	                    not(m:groupChrPr[last()]/m:pos/@m:val)   or
	                    m:groupChrPr[last()]/m:pos/@m:val=''">
				<mml:munder>
					<xsl:apply-templates select="m:e[1]" />
					<mml:mo>
						<xsl:choose>
							<xsl:when test="string-length(m:groupChrPr[last()]/m:chr/@m:val) &gt;= 1">
								<xsl:value-of select="substring(m:groupChrPr[last()]/m:chr/@m:val,1,1)" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:text disable-output-escaping="no">&#x023DF;</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</mml:mo>
				</mml:munder>
			</xsl:when>
			<xsl:otherwise>
				<mml:mover>
					<xsl:apply-templates select="m:e[1]" />
					<mml:mo>
						<xsl:choose>
							<xsl:when test="string-length(m:groupChrPr[last()]/m:chr/@m:val) &gt;= 1">
								<xsl:value-of select="substring(m:groupChrPr[last()]/m:chr/@m:val,1,1)" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:text disable-output-escaping="no">&#x023DF;</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</mml:mo>
				</mml:mover>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template match="m:bar">
		<xsl:variable name="sLowerCasePos" select="translate(m:barPr/m:pos/@m:val, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		                                                                       'abcdefghijklmnopqrstuvwxyz')" />
		<xsl:choose>
			<xsl:when test="$sLowerCasePos!='bot' or
	                        not($sLowerCasePos)   or
	                        $sLowerCasePos=''   ">
				<mml:mover>
					<xsl:attribute name="accent">true</xsl:attribute>
					<xsl:apply-templates select="m:e[1]" />
					<mml:mo>
						<xsl:text disable-output-escaping="no">&#x000AF;</xsl:text>
					</mml:mo>
				</mml:mover>
			</xsl:when>
			<xsl:otherwise>
				<mml:munder>
					<xsl:apply-templates select="m:e[1]" />
					<mml:mo>
						<xsl:text disable-output-escaping="no">&#x00332;</xsl:text>
					</mml:mo>
				</mml:munder>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


<!-- wrong name for (m)phantom -->

	<xsl:template match="m:phant">
		<xsl:variable name="sLowerCaseWidth" select="translate(m:phantPr[last()]/m:width/@m:val,
		                                                       'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		                                                       'abcdefghijklmnopqrstuvwxyz')" />
		<xsl:variable name="sLowerCaseAsc" select="translate(m:phantPr[last()]/m:asc/@m:val,
		                                                     'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		                                                     'abcdefghijklmnopqrstuvwxyz')" />
		<xsl:variable name="sLowerCaseDec" select="translate(m:phantPr[last()]/m:dec/@m:val,
		                                                     'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		                                                     'abcdefghijklmnopqrstuvwxyz')" />
		<xsl:if test="not($sLowerCaseWidth='off' and
	                      $sLowerCaseAsc='off'   and
	                      $sLowerCaseDec='off')">
			<mml:mphantom>
				<xsl:apply-templates select="m:e[1]" />
			</mml:mphantom>
		</xsl:if>
	</xsl:template>



<!-- html fixes -->
<xsl:template match="h:style">
  <style type="text/css">
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </style>
</xsl:template>

<xsl:template match="@lang">
  <xsl:attribute name="xml:lang" select="."/>
</xsl:template>

<xsl:template match="@style[../(@align|@width|@clear|@nowrap|@height)]" priority="2"/>
<xsl:template match="@align">
  <xsl:attribute name="style">
    <xsl:value-of select="../@style,concat('text-align: ',.)" separator=";"/>
  </xsl:attribute>
</xsl:template>


<xsl:template match="@width">
  <xsl:attribute name="style">
    <xsl:value-of select="../@style,concat('text-width: ',.)" separator=";"/>
  </xsl:attribute>
</xsl:template>

<xsl:template match="@height">
  <xsl:attribute name="style">
    <xsl:value-of select="../@style,concat('height: ',.)" separator=";"/>
  </xsl:attribute>
</xsl:template>


<xsl:template match="@clear">
  <xsl:attribute name="style">
    <xsl:value-of select="../@style,concat('clear: ',if(.='all') then 'both' else .)" separator=";"/>
  </xsl:attribute>
</xsl:template>

<xsl:template match="@nowrap">
  <xsl:attribute name="style">
    <xsl:value-of select="../@style,'white-space:nowrap'" separator=";"/>
  </xsl:attribute>
</xsl:template>

<xsl:template match="h:head[not(h:title)]">
  <head>
    <xsl:copy-of select="@*"/>
    <title><xsl:value-of select="../h:body/descendant::*[self::h:h1|self::h2][1]"/></title>
    <xsl:apply-templates/>
  </head>
</xsl:template>

<xsl:template match="h:link/@target"/>
<xsl:template match="h:table[h:tr and not(h:tbody)]">
  <table>
    <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="* except h:tr"/>
    <tbody>
      <xsl:apply-templates select="h:tr"/>
    </tbody>
  </table>
</xsl:template>

<!--
  Changed by Versal - Jan Paul Posma:
  This block removed <span>s, which was not good as it removed information about
  whitespace. We now explicitly wrap the <xsl:apply-templates/> in spans again.

<xsl:template match="h:span[not(node()[2])]" priority="2">
  <xsl:apply-templates/>
</xsl:template>
-->
<xsl:template match="h:span[not(node()[2])]" priority="2">
  <span><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="h:table[not(@*)]" priority="3"/>

<xsl:template match="h:tr" priority="3">
<xsl:message>
[<xsl:copy-of select="ancestor::h:table[1]/following-sibling::*[not(self::h:span[not(normalize-space())])][1]"/>]
</xsl:message>
<tr>
<xsl:copy-of select="@*"/>
<xsl:apply-templates select="h:td"/>
<xsl:apply-templates select="ancestor::h:table[1]/following-sibling::*[not(self::h:span[not(normalize-space())])][1]//h:tr[not(@style)]" mode="tr"/>
</tr>
<xsl:apply-templates select="ancestor::h:table[1]/following-sibling::*[not(self::h:span[not(normalize-space())])
			     and not(self::h:table/h:tbody/h:tr[not(@style)])][1]//h:tr[@style]"/>
</xsl:template>

<xsl:template match="h:tr" priority="3" mode="tr">
<xsl:apply-templates select="h:td"/>
<xsl:apply-templates select="ancestor::h:table[1]/following-sibling::*[not(self::h:span[not(normalize-space())])][1]//h:tr[not(@style)]" mode="tr"/>
</xsl:template>

</xsl:stylesheet>
