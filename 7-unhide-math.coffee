input = require('fs').readFileSync('/dev/stdin').toString()

# Remove "<!--HIDDENMATH", taking into account preceding whitespace
input = input.replace /\s*<!--HIDDENMATH/g, ''

# Remove "HIDDENMATH-->", taking into account succeeding whitespace
input = input.replace /HIDDENMATH-->\s*/g, ''

# Strip span tags
input = input.replace /<span[^>]*>( *)\n/g, '$1 '
input = input.replace /<span[^>]*>( *)/g, '$1'
input = input.replace /<\/span>/g, ''

# Stip HTML tags
S = require('string')
input = S(input).stripTags('div').s

# Pandoc doesn't handle whitespace in <b> and <i> correctly
input = input.replace /\s+<\/b>/ig, ' </b> '
input = input.replace /\s+<\/i>/ig, ' </i> '
input = input.replace /<b( [^>]*)?>\s+/ig, ' <b> '
input = input.replace /<i( [^>]*)?>\s+/ig, ' <i> '

console.log input
