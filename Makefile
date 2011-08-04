parts_diss=00_common 00_intro 01_he3 02_theor 03_num 04_tech 05_res 06_vyv
parts_auto=00_common

all: diss.pdf auto.pdf pres.pdf otz_ved.pdf

bib:
	latex diss
	bibtex diss
	latex diss
	latex diss

	latex auto
	bibtex auto
	bibtex my
	latex auto
	latex auto
%.pdf: %.ps
	ps2pdf $<
%.ps: %.dvi
	dvips $<
%.dvi: %.tex
	latex $<
diss.dvi: diss.tex ${parts_diss:=.tex}
	make -C images
	latex $<
auto.dvi: auto.tex ${parts_auto:=.tex}
	make -C images
	latex $<

clean:
	rm -f *.aux *.log

spell:
	ispell -d russian-lebedev ${parts_diss:=.tex} ${parts_auto:=.tex} otz_ved.tex auto.tex
