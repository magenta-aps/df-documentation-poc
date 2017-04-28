#!/bin/bash
targets=$@
if [[ $targets == "all" ]] ; then targets="all clean javadoc eps doxygen javasphinx-api sphinx" ; fi
for i in $targets ; do
  case $i in
    all)
	echo "building all documentation"
	;;
    javadoc)
	echo "building javadoc in `pwd`"
	(mkdir -p javadoc_out ; cd javadoc_out ; javadoc `find ../.. -name '*.java'`)
	;;
    eps)
	(cd src ; for i in *.svg ; do inkscape "$i" --export-eps "${i%.svg}.eps" ; done)
	(cd src ; for i in *.jpg ; do convert "$i" eps2:"${i%.jpg}.eps" ; done)
	(cd src ; for i in *.png ; do convert "$i" eps2:"${i%.png}.eps" ; done)
	(cd source ; for i in *.svg ; do inkscape "$i" --export-pdf "${i%.svg}.pdf" ; done)
	;;
    doxygen)
	echo "building doxygen docs" 
	mkdir -p doxygen_out
	doxygen
	echo "copying images, because doxygen is dumb as a brick"
	cp src/*svg src/*jpg doxygen_out/html
	cp src/*eps doxygen_out/latex
	(cd doxygen_out/latex ; make)
	echo "did refman.pdf get made?"
	ls -l doxygen_out/latex/refman.pdf
	;;
    clean)
	echo "removing doxygen_out, javadoc_out, _cache, source/api and sphinx_out directories"
	rm -rf doxygen_out
	rm -rf javadoc_out
	rm -rf sphinx_out
	rm -rf source/api
	rm src/*.eps source/*.pdf
	rm -rf _cache
	;;
    javasphinx-api)
	echo "building reST files from Java API"
	mkdir -p source/api
	javasphinx-apidoc  -c _cache -o source/api -v -I ../core ../engine
	;;
    sphinx)
	echo "doing sphinx-build -M for html and pdflatex"
	mkdir -p sphinx_out
	sphinx-build -M html source sphinx_out 
	sphinx-build -M latexpdf source sphinx_out
  esac
done
