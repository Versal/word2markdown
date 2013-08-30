#!/bin/bash

set -e

# Setup
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEBUG_LOG=$DIR/html.log

echo "" > $DEBUG_LOG

for DOC_FILE in $DIR/*.doc*; do
	MD_FILE="${DOC_FILE%.*}.md"

	HTML_FILE="${DOC_FILE%.*}.html"
	echo '<!DOCTYPE html><html><head><meta charset="UTF-8">' > $HTML_FILE
	echo '<meta http-equiv="Content-type" content="text/html;charset=UTF-8">' >> $HTML_FILE
  echo '<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>' >> $HTML_FILE
  echo '<style>img { max-width: 100%; }</style>' >> $HTML_FILE
  echo '<body style="width: 900px; padding: 50px; margin: 0 auto">' >> $HTML_FILE
	$DIR/../node_modules/.bin/marked $MD_FILE >> $HTML_FILE 2>>$DEBUG_LOG
done
