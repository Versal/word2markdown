# word2markdown example document

This document is used for testing different features and edge cases of the word2markdown conversion.

## Text

This is a sentence with some **bold**, *italic*, and <u>underlined</u> words. The spaces before and after this **bold** are also bold.

Same for this *italic* word. And this <u>underlined</u> word.

Thîs is sömé ùnïcø∂€, in the 21<sup>st</sup> century. Worth ≥ &#36;1,000.00. ¡But also &lt; 10\^3! And an ellipsis...

This sentence has a comment.</a>[[BB1]](#_msocom_1)

- This is a list

- With bullets

- Third list item

* * * * *

1. Numbered list

2. Second numbered list item

3. Third numbered list item

- Another list

- Yep

[Link to Versal.org](http://www.versal.org)

<table border="1" style="border-collapse:collapse;border:none;">
<tbody>
<tr style="height:17.4pt">
<td valign="top" style="width:103.75pt;border:solid windowtext 1.0pt; padding:0cm 5.4pt 0cm 5.4pt;height:17.4pt;">
Some table

</td>
<td valign="top" style="width:103.8pt;border-top:solid windowtext 1.0pt; border-left:none;border-bottom:none;border-right:solid windowtext 1.0pt; padding:0cm 5.4pt 0cm 5.4pt;height:17.4pt;">

</td>
<td valign="top" style="width:208.95pt;border-top:solid windowtext 1.0pt; border-left:none;border-bottom:dashed windowtext 1.0pt;border-right:solid windowtext 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:17.4pt;">

</td>
</tr>
<tr style="height:18.25pt">
<td valign="top" style="width:103.75pt;border-top:none;border-left: solid windowtext 1.0pt;border-bottom:solid windowtext 1.0pt;border-right: none;padding:0cm 5.4pt 0cm 5.4pt;height:18.25pt;">

</td>
<td valign="top" style="width:103.8pt;border:none;border-right:dotted windowtext 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.25pt;">
No borders here

</td>
<td valign="top" style="width:208.95pt;border-top:none;border-left: none;border-bottom:double windowtext 5.25pt;border-right:dashed windowtext 1.0pt; padding:0cm 5.4pt 0cm 5.4pt;height:18.25pt;">
Crazy borders here

</td>
</tr>
</tbody>
</table>

No lists here - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope - nope! J

## Pictures

TODO: We still need a picture that is saved as EMZ by Word...

![](public_files/image001.png)

![](public_files/image003.png)

![](public_files/image005.png)

Sorry, yet another kitty. Public domain.

![](public_files/image006.jpg)

***This image is bold and italic:***

***

![](public_files/image008.png)

bold and italic***

![Text Box: Word art!](public_files/image010.png)

## Math

Some default formulas:

<math display="block"> <mi>A</mi> <mo>=</mo> <mi>π</mi> <msup> <mrow> <mrow> <mi>r</mi> </mrow> </mrow> <mrow> <mrow> <mn>2</mn> </mrow> </mrow> </msup> </math>

<math display="block"> <msup> <mrow> <mrow> <mfenced separators="|"> <mrow> <mrow> <mi>x</mi> <mo>+</mo> <mi>a</mi> </mrow> </mrow> </mfenced> </mrow> </mrow> <mrow> <mrow> <mi>n</mi> </mrow> </mrow> </msup> <mo>=</mo> <munderover> <mo>∑</mo> <mrow> <mi>k</mi> <mo>=</mo> <mn>0</mn> </mrow> <mrow> <mi>n</mi> </mrow> </munderover> <mrow> <mrow> <mfenced separators="|"> <mrow> <mrow> <mfrac linethickness="0pt"> <mrow> <mrow> <mi>n</mi> </mrow> </mrow> <mrow> <mrow> <mi>k</mi> </mrow> </mrow> </mfrac> </mrow> </mrow> </mfenced> <msup> <mrow> <mrow> <mi>x</mi> </mrow> </mrow> <mrow> <mrow> <mi>k</mi> </mrow> </mrow> </msup> <msup> <mrow> <mrow> <mi>a</mi> </mrow> </mrow> <mrow> <mrow> <mi>n</mi> <mo>-</mo> <mi>k</mi> </mrow> </mrow> </msup> </mrow> </mrow> </math>

<math display="block"> <msup> <mrow> <mrow> <mfenced separators="|"> <mrow> <mrow> <mn>1</mn> <mo>+</mo> <mi>x</mi> </mrow> </mrow> </mfenced> </mrow> </mrow> <mrow> <mrow> <mi>n</mi> </mrow> </mrow> </msup> <mo>=</mo> <mn>1</mn> <mo>+</mo> <mfrac> <mrow> <mrow> <mi>n</mi> <mi>x</mi> </mrow> </mrow> <mrow> <mrow> <mn>1</mn> <mo>!</mo> </mrow> </mrow> </mfrac> <mo>+</mo> <mfrac> <mrow> <mrow> <mi>n</mi> <mfenced separators="|"> <mrow> <mrow> <mi>n</mi> <mo>-</mo> <mn>1</mn> </mrow> </mrow> </mfenced> <msup> <mrow> <mrow> <mi>x</mi> </mrow> </mrow> <mrow> <mrow> <mn>2</mn> </mrow> </mrow> </msup> </mrow> </mrow> <mrow> <mrow> <mn>2</mn> <mo>!</mo> </mrow> </mrow> </mfrac> <mo>+</mo> <mo>...</mo> </math>

<math display="block"> <msup> <mrow> <mrow> <mi>a</mi> </mrow> </mrow> <mrow> <mrow> <mn>2</mn> </mrow> </mrow> </msup> <mo>+</mo> <msup> <mrow> <mrow> <mi>b</mi> </mrow> </mrow> <mrow> <mrow> <mn>2</mn> </mrow> </mrow> </msup> <mo>=</mo> <msup> <mrow> <mrow> <mi>c</mi> </mrow> </mrow> <mrow> <mrow> <mn>2</mn> </mrow> </mrow> </msup> </math>

When ∠ABC = 90° and <math> <mi>∠</mi> <mi>&nbsp;</mi><mi>B</mi> <mi>C</mi> <mi>D</mi> <mo>=</mo> <mn>90</mn> <mo>°</mo> </math>, then <math> <mrow> <mover accent="true"> <mrow> <mrow> <mi>A</mi> <mi>B</mi> </mrow> </mrow> <mo>&#9472;</mo> </mover> </mrow> <mo>∥</mo> <mover accent="true"> <mrow> <mi>C</mi> <mi>D</mi> </mrow> <mo>¯</mo> </mover> </math>. Now find point <math> <mfenced> <mrow> <mi>a</mi> </mrow> <mrow> <mi>b</mi> </mrow> <mrow> <mi>c</mi> </mrow> </mfenced> </math> on your map, and see that <math> <mfenced separators="|"> <mrow> <mrow> <mi>P</mi> </mrow> </mrow> <mrow> <mrow> <mi>Q</mi> </mrow> </mrow> </mfenced> <mo>=</mo> <mfenced> <mrow> <mi>P</mi> <mo>|</mo> <mi>q</mi> <mo>⊂</mo> <mi>Q</mi> </mrow> </mfenced> </math>. Yeah, <math> <mn>0.9</mn> <mo>=</mo> <mn>.9</mn> <mo>≠</mo> <mn>000.000</mn> </math>.

Watch out for<math> <mi>&nbsp;</mi><mi>w</mi> <mi>h</mi> <mi>i</mi> <mi>t</mi> <mi>e</mi> <mi>s</mi> <mi>p</mi> <mi>a</mi> <mi>c</mi> <mi>e</mi> <mi>&nbsp;</mi><mi>a</mi> <mi>n</mi> <mi>d</mi> <mi>&nbsp;</mi><mi>t</mi> <mi>e</mi> <mi>x</mi> <mi>t</mi> <mi>&nbsp;</mi><mi>i</mi> <mi>n</mi> <mi>&nbsp;</mi></math>your equations. Even in <math> <mfrac> <mrow> <mrow> <mi>f</mi> <mi>r</mi> <mi>a</mi> <mi>c</mi> <mi>t</mi> <mi>i</mi> <mi>o</mi> <mi>n</mi> <mi>s</mi> <mi>&nbsp;</mi><mi>a</mi> <mi>n</mi> <mi>d</mi> <mi>&nbsp;</mi><mi>s</mi> <mi>u</mi> <mi>c</mi> <mi>h</mi> </mrow> </mrow> <mrow> <mrow> <mi>o</mi> <mi>r</mi> <mi>&nbsp;</mi><mi>w</mi> <mi>i</mi> <mi>t</mi> <mi>h</mi> <mi>&nbsp;</mi><mi mathvariant="bold">o</mi> <mi mathvariant="bold">t</mi> <mi mathvariant="bold">h</mi> <mi mathvariant="bold">e</mi> <mi mathvariant="bold">r</mi> <mi>&nbsp;</mi><mi mathvariant="bold">s</mi> <mi mathvariant="bold">t</mi> <mi mathvariant="bold">y</mi> <mi mathvariant="bold">l</mi> <mi mathvariant="bold">i</mi> <mi mathvariant="bold">n</mi> <mi mathvariant="bold">g</mi> </mrow> </mrow> </mfrac> </math>. Let's try a <math> <mrow> <mfrac> <mrow> <mrow> <mi>s</mi> <mi>m</mi> <mi>a</mi> <mi>l</mi> <mi>l</mi> </mrow> </mrow> <mrow> <mrow> <mi>f</mi> <mi>r</mi> <mi>a</mi> <mi>c</mi> <mi>t</mi> <mi>i</mi> <mi>o</mi> <mi>n</mi> </mrow> </mrow> </mfrac> </mrow> <mi>&nbsp;</mi><mi>a</mi> <mi>n</mi> <mi>d</mi> <mi>&nbsp;</mi><mi>s</mi> <mi>o</mi> <mi>m</mi> <mi>e</mi> <mi>&nbsp;</mi><mi>o</mi> <mi>t</mi> <mi>h</mi> <mi>e</mi> <mi>r</mi> <mi>&nbsp;</mi><mi mathvariant="normal">t</mi> <mi mathvariant="normal">e</mi> <mi mathvariant="normal">x</mi> <mi mathvariant="normal">t</mi> <mi>&nbsp;</mi><mi>i</mi> <mi>n</mi> <mi>&nbsp;</mi><mi>h</mi> <mi>e</mi> <mi>r</mi> <mi>e</mi> <mo>.</mo> </math>

<p><math> <mi>s</mi> <mi>t</mi> <mi>a</mi> <mi>r</mi> <mi>t</mi> <mi>&nbsp;</mi><mi>w</mi> <mi>i</mi> <mi>t</mi> <mi>h</mi> <mi>&nbsp;</mi><mi>s</mi> <mi>o</mi> <mi>m</mi> <mi>e</mi> <mi>&nbsp;</mi><mi>e</mi> <mi>q</mi> <mi>u</mi> <mi>a</mi> <mi>t</mi> <mi>i</mi> <mi>o</mi> <mi>n</mi> <mi>&nbsp;</mi></math>which is then followed by some other tekst.</p>

<math display="block"> <mrow> <mrow> <msup> <mrow> <mrow> <mi mathvariant="normal">sin</mi> </mrow> </mrow> <mrow> <mrow> <mo>-</mo> <mn>1</mn> </mrow> </mrow> </msup> </mrow> <mo>⁡</mo> <mrow> <msup> <mrow> <mrow> <mi>e</mi> </mrow> </mrow> <mrow> <mrow> <mo>-</mo> <mi>i</mi> <mi>ω</mi> <mi>t</mi> <mi>&nbsp;</mi><mroot> <mrow> <mrow> <mi>b</mi> </mrow> </mrow> <mrow> <mi>a</mi> </mrow> </mroot> </mrow> </mrow> </msup> <mi>&nbsp;</mi><mfrac bevelled="true"> <mrow> <mrow> <mn>1</mn> </mrow> </mrow> <mrow> <mrow> <mn>3</mn> </mrow> </mrow> </mfrac> </mrow> </mrow> </math>

<math display="block"> <mfenced open="⟨" close="⟩" separators="|"> <mrow> <mrow> <mi>s</mi> <mi>u</mi> <mi>p</mi> <mi>e</mi> <mi>r</mi> </mrow> </mrow> <mrow> <mrow> <mi>f</mi> <mi>u</mi> <mi>n</mi> <mi>k</mi> <mi>y</mi> </mrow> </mrow> <mrow> <mrow> <mi>t</mi> <mi>r</mi> <mi>i</mi> <mi>p</mi> <mi>l</mi> <mi>e</mi> </mrow> </mrow> </mfenced> </math>

<math display="block"> <mi>f</mi> <mfenced separators="|"> <mrow> <mrow> <mi>x</mi> </mrow> </mrow> </mfenced> <mo>=</mo> <mfenced open="{" close separators="|"> <mrow> <mrow> <mtable> <mtr> <mtd> <mrow> <maligngroup></maligngroup> <mo>-</mo> <mi>x</mi> <mo>,</mo> <mi>&nbsp;</mi><mo>&</mo> <mi>x</mi> <mo>&lt;</mo> <mn>0</mn> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <maligngroup></maligngroup> <mi>x</mi> <mo>,</mo> <mi>&nbsp;</mi><mo>&</mo> <mi>x</mi> <mo>≥</mo> <mn>0</mn> </mrow> </mtd> </mtr> </mtable> </mrow> </mrow> </mfenced> </math>

<math display="block"> <mfrac> <mrow> <mrow> <mo>-</mo> <mi>b</mi> <mo>±</mo> <msqrt> <mrow> <msup> <mrow> <mrow> <mi>b</mi> </mrow> </mrow> <mrow> <mrow> <mn>2</mn> </mrow> </mrow> </msup> <mo>-</mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> </msqrt> </mrow> </mrow> <mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow> </mrow> </mfrac> </math>

<math display="block"> <munder> <mo>∑</mo> <mrow> <mtable> <mtr> <mtd> <mrow> <maligngroup></maligngroup> <mn>0</mn> <mo>≤</mo> <mi>&nbsp;</mi><mi>i</mi> <mi>&nbsp;</mi><mo>≤</mo> <mi>&nbsp;</mi><mi>m</mi> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <maligngroup></maligngroup> <mn>0</mn> <mo>&lt;</mo> <mi>j</mi> <mo>&lt;</mo> <mi>n</mi> <mi>&nbsp;</mi></mrow> </mtd> </mtr> </mtable> </mrow> </munder> <mrow> <mrow> <mi>P</mi> <mfenced separators="|"> <mrow> <mrow> <mi>i</mi> <mo>,</mo> <mi>j</mi> </mrow> </mrow> </mfenced> </mrow> </mrow> </math>

Lets try some lists with math:

- <math> <mi>a</mi> <mo>+</mo> <mi>b</mi> <mo>=</mo> <mi>∞</mi> </math>

- And <math> <msup> <mrow> <mrow> <mi>e</mi> </mrow> </mrow> <mrow> <mrow> <mi>i</mi> <mi>π</mi> </mrow> </mrow> </msup> <mo>+</mo> <mn>1</mn> <mo>=</mo> <mn>0</mn> </math>, right?

* * * * *

[[BB1]](#_msoanchor_1)This is the comment. 


