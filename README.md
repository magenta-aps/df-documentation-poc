DF-documentation-poc
====================

Proof of concept for a Documentation subsystem:
Scope:
* Using doxygen,
* generate API docs automatically from Java (Javadoc comments) or Python (docstrings),
* and include separately written documentation in simply marked up text files,
* allowing for images to be used as illustrations in the docs,
* with output as both HTML and as a combined PDF
* and the same as above, using Sphinx.

Requires:
Installation of
- Doxygen (APT)
- Doxypy (APT)
- Sphinx (PIP)
- Javasphinx (PIP)
- ImageMagick (APT)
- Inkscape (APT)
- TeX Live (APT)
(possibly more)

Also, core and engine submodules from GitHub are presumed to be in the parent directory.

The ./build.sh script uses directory 'src' for Doxygen source, and 'source' for Sphinx source.
An Inkscape SVG drawing 'drawing.svg' and a JPEG image are included as image examples.

Doxyfiles were generated using doxywizard, then modified.

For doxygen, the mainpage.md file is edited to link to the other.md file. The other.md file
includes the images. Also, custom header.html and footer.html have been generated with
'doxygen -w html' and modified, proving that there is a place to put customization of style etc. No
attempt has been made to do similar for the PDF output.

Additionally, the gladdrreg-Doxyfile has been added to a checkout of gladdrreg to perform
API doc generation from Python code using the doxypy Doxygen filter. An attempt to use the newer
Doxypypy filter failed.

For comparison, it was decided to try Sphinx and Javasphinx for the same tasks.

Sphinx was configured using sphinx-quickstart with reasonable default, and the javasphinx extension
added to conf.py. In sources, the skeleton index.rst was modified to link to api docs and a separate
page other.rst, the latter including the example images.  

To ensure easy use of images, build.sh has minimal support (no sizing etc) for conversion of JPEG
and SVG images to EPS or PDF for inclusion in TeX, ensuring that this can be automated in a
documentation generation workflow. For comparison, build.sh also builds plain Javadoc HTML output.

'./build.sh all' will put Doxygen output in doxygen_out/html and doxygen_out/latex/refman.pdf,
reST output from javasphinx-apidoc in source/api, Sphinx output in sphinx_out/html and
sphinx_out/latex/ddd.pdf, and Javadoc HTML output in javadoc_out.


CONCLUSIONS
-----------

Both Doxygen and Sphinx are reasonable tools for the defined tasks.

Doxygen seems to be a monolithic C++ system and especially the pdflatex target seems fragile,
with poor error reporting. It also appears rather inflexible and hard to customize or stylize.
The Doxypy filter is no longer in development, and the "replacement" Doxypypy didn't work when
tried. Java API documentation is not as "pretty" as standard Javadoc output.
Doxygen uses Markdown with proprietary extensions for some Doxygen specific things. An image has
to be included twice in a page to appear in both the HTML output and (as EPS) in the PDF output.

Sphinx is the standard documentation framework for Python and very flexible. It seems robust. The
javasphinx extension is under active development (latest commit in January 2017) and generates reST
files which are nice looking and offer flexibility. Sphinx reST files can include images with a .*
extension, so the optimal image format is picked for the chosen output format (HTML vs LaTex/PDF).

Sphinx seems to be the best match for the task, but Doxygen is workable. (Also, for Java only, Javadoc
is workable, maybe using PDF output through third party doclets. This was not investigated.)

/Lasse Hillerøe Petersen, 2017-04-28
