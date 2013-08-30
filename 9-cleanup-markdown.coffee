sanitizeParagraphs = (string) ->
  paragraphs = string.split(/\n\n+/)
  string = ''
  for paragraph in paragraphs
    if paragraph.length > 0
      lines = paragraph.split /[ ]*\n[ ]*/
      string += lines.join(' ') + '\n\n'
  string

text = require('fs').readFileSync('/dev/stdin').toString()

# Strip styles, classes, attributes
text = text.replace /\s*xmlns:mml="http:\/\/www.w3.org\/1998\/Math\/MathML"/gi, ''
text = text.replace /\s*align="left"/gi, ''
text = text.replace /\s*class="MsoTableGrid"/gi, ''
text = text.replace /\s*cellspacing="0"/gi, ''
text = text.replace /\s*cellpadding="0"/gi, ''
text = text.replace /\s*colspan="1"/gi, ''
text = text.replace /\s*rowspan="1"/gi, ''
text = text.replace /(mso-|text-width)[^;"']*(;[ ]*)?/gi, ''
text = text.replace /\s*style="[ ]*"/gi, ''

# Remove crazy unicode invisible characters
text = text.replace /[\u00AD\u200B-\u200D\uFEFF]/g, ''

# Replace \< , \> and \$ by HTML entities
text = text.replace /\\</g, '&lt;'
text = text.replace /\\>/g, '&gt;'
text = text.replace /\\\$/g, '&#36;'

# Make sure spaces in mi elements are preserved
text = text.replace /<mi[^>]*>[ \u00A0\n]+<\/mi>/g, '<mi>&nbsp;</mi>'

# But collapse multiple <mi>&nbsp;</mi> into one
text = text.replace /(<mi[^>]*>&nbsp;<\/mi>[ \n]*)+/g, '<mi>&nbsp;</mi>'

# Remove <a shape="rect">, usually found with comments
text = text.replace /<a shape="rect"[^>]*>(\s*<\/a>)?/gi, ''

# Convert single line breaks in new paragraphs
text = text.replace /\\\n/g, '\n\n'

# Replace ellipsis by "..."
text = text.replace /\u2026/g, '...'

# Replace no breaking character
text = text.replace /\u00A0/g, ''

# Replace no breaking character
text = text.replace /\u00A0/g, ''

# Intermediate paragraph sanitation
text = sanitizeParagraphs text

# Collapsing newlines before tags (but not if they start a paragraph)
text = text.replace /([^\n])\n</g, '$1 <'

# Collapse dotted lists
text = text.replace /^(\u00b7 (.+\n)+)\n*(?=\u00b7 )/mg, '$1'

# Convert dotted lists to Markdown lists
text = text.replace /^\u00b7 /mg, '- '

# Replace <mo>-</mo> with unicode line when used on top of an expression
text = text.replace /<mo>-<\/mo>(\s*<\/mover>)/g, '<mo>&#9472;</mo>$1'

# Replace <mo>.</mo> <mo>.</mo> by ellipsis
text = text.replace /<mo>\.<\/mo>(\s*<mo>\.<\/mo>)+/g, '<mo>&#8230;</mo>'

# Replace <mo>.</mo> <mn> by <mn>.
text = text.replace /<mo>\.<\/mo>\s*<mn>/g, '<mn>.'

# Replace <mo>\^</mo> by <mo>^</mo>
text = text.replace /<mo>\\\^<\/mo>/g, '<mo>^</mo>'

# Remove spaces after angles ∠
text = text.replace /<mi>\u2220<\/mi>\s*<mi>&nbsp<\/mi>/g, '<mi>&#8736;</mi>'

# Make standard "(a, b)"-like string (without using OfficeMath's "braces") into an mfenced
text = text.replace /<mo>\(<\/mo>([\s\S]*?)<mo>\)<\/mo>/g, (match, content) ->
  if content.indexOf('math') >= 0
    console.error 'Conversion into <mfenced> crossed <math> borders'
    return match

  contentWithRows = content.replace /(<mi>&nbsp;<\/mi>\s*)*<mo>,<\/mo>(\s*<mi>&nbsp;<\/mi>)*/g, '</mrow> <mrow>'

  '<mfenced> <mrow>' + contentWithRows + '</mrow> </mfenced>'


# Put block math in separate paragraphs
text = text.replace /^\s*<math\s+display="block"\s*>(.*?)<\/math>/mgi, '\n\n<math display="block">$1</math>\n\n'

# Put inline math at the start of a paragraph explicitly in a paragraph tag
text = text.replace /(^|\n\n)([ ]*<math>[\s\S]*?)(?=\n\n)/gi, '\n\n<p>$2</p>'

# Strip bold images
text = text.replace /^\*+\s*(!\[\]\([^)]+\))\s*\*+/mgi, '$1'
text = text.replace /\*+(!\[\]\([^)]+\))\*+/gi, '$1'

# Images on separate paragraphs if they are followed by content
text = text.replace /(!\[\]\([^)]+\))[ ]*(?!\n\n)/g, '\n\n$1\n\n'

# Put list items in separate paragraphs
text = text.replace /^(?=[ ]*(-|\+|\*|\d+\.))/mg, '\n\n'

text = sanitizeParagraphs text

# Format HTML a bit
text = text.replace /\n?[ ]*<table([^>]*)>[ ]*\n?/gi, '\n<table$1>\n'
text = text.replace /\n?[ ]*<\/table>[ ]*\n?/gi,      '\n</table>\n'
text = text.replace /\n?[ ]*<tbody([^>]*)>[ ]*\n?/gi, '\n<tbody$1>\n'
text = text.replace /\n?[ ]*<\/tbody>[ ]*\n?/gi,      '\n</tbody>\n'
text = text.replace /\n?[ ]*<tr([^>]*)>[ ]*\n?/gi,    '\n<tr$1>\n'
text = text.replace /\n?[ ]*<\/tr>[ ]*\n?/gi,         '\n</tr>\n'
text = text.replace /\n?[ ]*<td([^>]*)>[ ]*\n?/gi,    '\n<td$1>\n'
text = text.replace /\n?[ ]*<\/td>[ ]*\n?/gi,         '\n</td>\n'

console.log text
