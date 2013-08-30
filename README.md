# word2markdown

At Versal, we have created quite a few lessons for internal use, many of which were originally created as Word documents. Now that we've released the first version of our educational platform, we want to convert those lessons for online publication. We have an internal API that allows uploading of Markdown documents, which are then converted to courses with lessons and gadgets. So we only needed to convert our Word documents to Markdown. Sounds easy right?

Not so much. There are a [few](http://stackoverflow.com/questions/1043768/quickly-convert-rtf-doc-files-to-markdown-syntax-with-php) [solutions](http://gio.act.gov.au/2013/03/13/document-conversion-markdown/), but they only work for very basic text formatting. Our documents were a bit more complex, containing tables, images, and math -- which proved especially tricky! So using a number of existing tools we hacked together our own conversion script. It consists of 9 consecutive steps:

1. Exporting to HTML using Microsoft Word 2012. We automated this on OS X using Automator. Solutions for other platforms are welcome!
2. Extracting image types that we want to use. Keeps the original quality, unless that's a proprietary .emz file. In this step we also fix some math.
3. Converting HTML to XML using [tagsoup](http://ccil.org/~cowan/XML/tagsoup/).
4. Covert OOML (proprietary Word format) into MathML equations, using Microsoft's own conversion XSLT, and a custom version of [this XSLT](http://dpcarlisle.blogspot.nl/2007/04/xhtml-and-mathml-from-office-20007.html). Uses [Saxon 8](http://saxon.sourceforge.net/).
5. Some intermediate fixes for whitespace and math.
6. Conversion back into HTML using [Tidy](http://tidy.sourceforge.net/). Also strips a lot of stuff.
7. More intermediate fixes to deal with shortcomings of Tidy and Pandoc.
8. Conversion into Markdown using [Pandoc](http://johnmacfarlane.net/pandoc/installing.html).
9. Lots of cleanup and final fixes to the Markdown.

We've released this pipeline as an open source project (MIT License), although it should be noted that you will need to purchase Microsoft Word for this to work. Hopefully this can be a starting point for a more reliable conversion of Word documents!

## Requirements

- Mac OS X
- Microsoft Office 2011
- [Pandoc](http://johnmacfarlane.net/pandoc/installing.html)
- [HTML Tidy](http://tidy.sourceforge.net/)
- `npm install` in this directory
- Open Microsoft Office, File->Save As Webpage->Compatibility->Encoding->UTF-8. Save, exit, and now you're good to go!

## Usage

For Word-to-Markdown scripts, first navigate to this directory, using `cd doc-to-md`.

Calling `doc-to-md.sh sample.doc` outputs markdown to stdout. Calling `doc-to-md.sh sample.doc sample_files` will also copy images. Example:

```bash
doc-to-md.sh fixtures/public.docx | less
```

## Tests

Run './accept.sh' to generate new markdown, which you can compare to the original markdown using git.

## HTML preview

Run 'fixtures/html.sh' to generate HTML. The HTML uses Mathjax on an external server to display equations in broswers that don't support it (pretty much everything but Firefox).

## Disclaimer

Available under the MIT license (see LICENSE file). Built by @janpaul123 for @versal.
