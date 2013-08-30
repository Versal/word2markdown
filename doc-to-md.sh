#!/bin/bash

set -e

# Setup
INPUT=$1
FILES_DIR=${2%/} # strips trailing slash
DOC_TO_MD_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LIBS="$DOC_TO_MD_DIR/libs"
TEMP="$DOC_TO_MD_DIR/tmp"
NODE_BIN="$DOC_TO_MD_DIR/node_modules/.bin"

if [ -f ~/doc_to_html.html ]; then
    echo "~/doc_to_html.html already exists" >&2
    exit 1
fi

# Remove temp dir
rm -rf $TEMP >&2

# Re-add temp dir
mkdir $TEMP >&2
cp $INPUT $TEMP

# Convert to HTML -> ~/doc_to_html.html
INPUT_FILE=`ls $TEMP/*.doc*`
echo "CONVERTING TO HTML: " $INPUT_FILE " -> " ~/doc_to_html.html >&2
automator -i $INPUT_FILE $DOC_TO_MD_DIR/doc-to-html.app >&2

# Move from home dir -> 1_doc_to_html.html
echo "MOVING FROM HOME DIR TO TEMP DIR " ~/doc_to_html.html " -> " $TEMP/1_doc_to_html.html >&2
mv ~/doc_to_html.html $TEMP/1_doc_to_html.html
mv ~/doc_to_html_files $TEMP

# Encode characters -> 2_document_encoded_and_with_delimiters_and_vml_images.html
echo "ENCODING UTF-8 CHARACTERS " $TEMP/1_doc_to_html.html " -> " $TEMP/2_document_encoded_and_with_delimiters_and_vml_images.html >&2
$NODE_BIN/coffee $DOC_TO_MD_DIR/2-encode-utf8-and-add-delimiters-and-vml-images.coffee < $TEMP/1_doc_to_html.html > $TEMP/2_document_encoded_and_with_delimiters_and_vml_images.html

# Convert to XML -> 3_document.xml
echo "CONVERTING TO XML " $TEMP/2_document_encoded_and_with_delimiters_and_vml_images.html " -> " $TEMP/3_document.xml >&2
java -jar $LIBS/tagsoup-1.2.1.jar --lexical $TEMP/2_document_encoded_and_with_delimiters_and_vml_images.html > $TEMP/3_document.xml

# Convert equations to MathML -> 4_document_with_equations.xml
echo "CONVERTING EQUATIONS TO MATHML" $TEMP/3_document.xml " -> " $TEMP/4_document_with_equations.xml >&2
java -jar $LIBS/saxon8.jar -o $TEMP/4_document_with_equations.xml $TEMP/3_document.xml $LIBS/xhtml-mathml.xsl >&2

# Hiding equations -> 5_document_with_hidden_equations_and_cleaned_breaks.xml
echo "HIDING EQUATIONS" $TEMP/4_document_with_equations.xml " -> " $TEMP/5_document_with_hidden_equations_and_cleaned_breaks.xml >&2
$NODE_BIN/coffee $DOC_TO_MD_DIR/5-hide-math-and-cleanup-breaks.coffee < $TEMP/4_document_with_equations.xml > $TEMP/5_document_with_hidden_equations_and_cleaned_breaks.xml

# Convert and tidy to HTML again -> 6_document.html
echo "CONVERTING TO TIDY HTML" $TEMP/5_document_with_hidden_equations_and_cleaned_breaks.xml " -> " $TEMP/6_document.html >&2
set +e
tidy -config $DOC_TO_MD_DIR/tidy-config.txt -output $TEMP/6_document.html $TEMP/5_document_with_hidden_equations_and_cleaned_breaks.xml >&2
if [ $? -eq 2 ]; then
    echo "Tidy failed" >&2
    exit 1
fi
set -e

# Unhiding equations -> 7_document_with_unhidden_equations.html
echo "UNHIDING EQUATIONS" $TEMP/6_document.html " -> " $TEMP/7_document_with_unhidden_equations.html >&2
$NODE_BIN/coffee $DOC_TO_MD_DIR/7-unhide-math.coffee < $TEMP/6_document.html > $TEMP/7_document_with_unhidden_equations.html

# Convert to markdown -> 8_document.md
echo "CONVERTING TO MARKDOWN" $TEMP/7_document_with_unhidden_equations.html " -> " $TEMP/8_document.md >&2
pandoc -f html -t markdown_strict --normalize -R --atx-headers -o $TEMP/8_document.md < $TEMP/7_document_with_unhidden_equations.html >&2

# Cleaning up markdown -> 9_document_clean.md
echo "CLEANING UP MARKDOWN" $TEMP/8_document.md " -> " $TEMP/9_document-clean.md >&2
$NODE_BIN/coffee $DOC_TO_MD_DIR/9-cleanup-markdown.coffee < $TEMP/8_document.md > $TEMP/9_document_clean.md

if [ $FILES_DIR ]; then
	echo "COPYING FILES TO " $FILES_DIR >&2
  rm -rf $FILES_DIR
  mkdir $FILES_DIR
	cp $TEMP/doc_to_html_files/* $FILES_DIR
fi

# Output
cat $TEMP/9_document_clean.md | sed s/doc_to_html_files/$FILES_DIR/g
