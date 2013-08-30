input = require('fs').readFileSync('/dev/stdin').toString()

## HIDE MATH

# Replace "<mml:" by "<"
input = input.replace /<mml:/ig, '<'

# Replace "</mml:" by "</"
input = input.replace /<\/mml:/ig, '</'

# Replace "<math" by "<!--HIDDENMATH<math"
# Move whitespace before <math to the inside
input = input.replace /(\s*)<math/ig, '<!--HIDDENMATH$1<math'

# Replace "</math>" by "</math>HIDDENMATH-->"
# Move whitespace after </math> to the inside
input = input.replace /<\/math>(\s*)/ig, '</math>$1HIDDENMATH-->'

## CLEANUP BREAKS

# Replace "<br>" by "</p></p>"
input = input.replace /<br[^>]*>/ig, '</p><p>'

## PRESERVE WHITESPACE

# Replace " </span>" with "&#160;</span>"
input = input.replace /\s+<\/span>/g, '&#160;</span>'

console.log input
