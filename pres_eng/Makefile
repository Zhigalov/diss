all:  img pres.pdf

img:
	make -C images

%.pdf: %.ps
	ps2pdf $<

%.ps: %.dvi
	dvips $<
%.dvi: %.tex
	latex $<

pres.dvi: pres.tex aero.eps images/st.txt
	latex $<
clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.dvi *.eps

distclean: clean
	rm -f *.pdf

spell:
	ispell -d russian-lebedev pres.tex

aero.eps: aero.jpg
	convert $< $@