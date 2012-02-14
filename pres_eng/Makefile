all:  pres.pdf

%.pdf: %.ps
	ps2pdf $<

%.ps: %.dvi
	dvips $<
%.dvi: %.tex
	latex $<

pres.dvi: pres.tex aero.eps
	make -C images
	latex $<
clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.dvi *.eps

distclean: clean
	rm -f *.pdf

spell:
	ispell -d russian-lebedev pres.tex

aero.eps: aero.jpg
	convert $< $@