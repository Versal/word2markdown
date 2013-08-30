special = require('special-html')

input = require('fs').readFileSync('/dev/stdin').toString()

# Adding <m:d> delimiters
input = input.replace /<m:e>\(/g, '<m:e><m:d><m:e>'
input = input.replace /\)<\/m:e>/g, '</m:e></m:d></m:e>'

# Using VML images, as they are typically the "original"
# Note: o:title for caption?
# Do *not* use VML images when they are "unreadable" .emz files (see http://lxer.com/module/newswire/view/185924/)
input = input.replace /<!--\[if gte vml[^!]*?<v:imagedata src="([^\".!]*\.(png|gif|jpg|jpeg))"[\s\S]*?<!\[endif\]-->(<!\[if !vml\]>[\s\S]*?<!\[endif\]>)?/g, '<img src="$1">'

# Add <hr> after divs with border-bottom:solid
input = input.replace /<div[^>]*border-bottom:solid[^>]*>([\s\S]*?)<\/div>/ig, '<div>$1</div><hr>'

# Fix &nbsp; on which the XML parser chokes
input = input.replace /&nbsp;/gi, '&#160;'

console.log special(input)
